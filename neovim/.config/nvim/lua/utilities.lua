local M = {}

---@param opts table
M.make_modal = function(opts)
    if not opts then
        opts = {}
    end
    local width = vim.o.columns - 4
    local height = 19

    if opts.max_width then
        if (vim.o.columns > 85) then
            width = 80
        end
    end

    vim.api.nvim_open_win(
        vim.api.nvim_create_buf(false, true),
        true,
        {
            relative = 'editor',
            style = 'minimal',
            border = 'shadow',
            width = width,
            height = height,
            col = math.min((vim.o.columns - width) * 0.5),
            row = math.min((vim.o.lines - height) * 0.5 - 1),
            noautocmd = true,
        }
    )
end

---@param files_command string
---@param action string
M.fuzzy_search = function(files_command, action)
    M.make_modal({ max_width = true })

    local file = vim.fn.tempname()
    local shell_command = {
        '/bin/sh',
        '-c',
        files_command .. ' | fzy > ' .. file
    }
    local winid = vim.fn.win_getid()

    vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })

    vim.fn.jobstart(shell_command, {
        term = true,
        on_exit = function()
            vim.api.nvim_cmd(
                { cmd = 'bdelete', bang = true },
                { output = false }
            )
            vim.fn.win_gotoid(winid)
            local f = io.open(file, 'r')
            if f == nil then return end
            local stdout = f:read('*all')
            f:close()
            os.remove(file)
            vim.api.nvim_command(table.concat({ action, stdout }, ' '))
        end
    })
end

---@param nodes_active_in table
---@return string
M.autocomplete_html_attribute = function(nodes_active_in)
    -- The cursor location does not give us the correct node in this case, so
    -- we need to get the node to the left of the cursor.
    local cursor = vim.api.nvim_win_get_cursor(0)
    local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
    local node = vim.treesitter.get_node { pos = left_of_cursor_range, ignore_injections = false }
    if node and vim.tbl_contains(nodes_active_in, node:type()) then
        -- The cursor is not on an attribute node
        return '=""<left>'
    end
    return '='
end

---@param line string
---@return boolean
M.line_needs_comma = function(line)
    local trimmed = vim.trim(line)
    if trimmed == '' then return false end
    return not trimmed:match('[,{%[%]%}]$')
end

--- Tree-sitter-aware check for whether a closing delimiter is nested inside
--- a parent container and therefore needs a trailing comma.
---@param line string
---@param lnum integer
---@return boolean
M.closing_delimiter_needs_comma = function(line, lnum)
    local trimmed = vim.trim(line)
    if not trimmed:match('[%]%}]$') then
        return false
    end

    local ok, parser = pcall(vim.treesitter.get_parser)
    if not ok or not parser then
        return false
    end

    local col = #line - #line:match('%s*$') - 1
    local node = vim.treesitter.get_node({ pos = { lnum - 1, col } })
    if not node then return false end

    -- Walk up to find the object/array being closed
    ---@type TSNode?
    local container = node
    while container and not vim.tbl_contains({ 'object', 'array' }, container:type()) do
        container = container:parent()
    end
    if not container then return false end

    -- Check if this container is nested inside a parent container
    local ancestor = container:parent()
    while ancestor do
        if vim.tbl_contains({ 'object', 'array' }, ancestor:type()) then
            return true
        end
        ancestor = ancestor:parent()
    end
    return false
end

--- Combined check: text-based line_needs_comma, enhanced with tree-sitter
--- for closing delimiters of nested containers.
---@param line string
---@param lnum integer
---@return boolean
M.needs_comma = function(line, lnum)
    if M.line_needs_comma(line) then
        return true
    end
    return M.closing_delimiter_needs_comma(line, lnum)
end

--- Check if the cursor is inside an iterable structure (object, array, imports).
---@return boolean
M.is_inside_iterable = function()
    local node = vim.treesitter.get_node()
    local iterable_types = {
        'object',
        'array',
        'named_imports',
        'import_statement',
        'import_specifier',
        'import_clause',
    }
    while node do
        if vim.tbl_contains(iterable_types, node:type()) then
            return true
        end
        node = node:parent()
    end
    return false
end

---@param opts { direction: 'above'|'below' }
M.open_line_with_comma = function(opts)
    local key = opts.direction == 'above' and 'O' or 'o'

    if not M.is_inside_iterable() then
        vim.api.nvim_feedkeys(key, 'n', false)
        return
    end

    local target_lnum
    if opts.direction == 'below' then
        target_lnum = vim.fn.line('.')
    else
        target_lnum = vim.fn.line('.') - 1
    end

    if target_lnum >= 1 then
        local line = vim.fn.getline(target_lnum)
        if M.needs_comma(line, target_lnum) then
            local with_comma = line:gsub('%s*$', '') .. ','
            vim.fn.setline(target_lnum, with_comma)
        end
    end

    vim.api.nvim_feedkeys(key, 'n', false)
end

M.dd_with_comma_removal = function()
    if not M.is_inside_iterable() then
        vim.cmd('normal! dd')
        return
    end

    local lnum = vim.fn.line('.')
    local line = vim.api.nvim_get_current_line()

    if not M.needs_comma(line, lnum) then
        vim.cmd('normal! dd')
        return
    end

    if lnum > 1 then
        local line_above = vim.fn.getline(lnum - 1)
        if line_above:match(',%s*$') then
            vim.cmd('normal! dd')
            local cleaned = line_above:gsub(',%s*$', '')
            vim.fn.setline(lnum - 1, cleaned)
            return
        end
    end

    vim.cmd('normal! dd')
end

--- formatexpr-compatible function that runs prettier with range support.
--- Passes the full buffer to prettier with --range-start/--range-end so
--- prettier sees the full file context and produces correct indentation.
---@return integer 0 on success, 1 to fall back to internal formatting
M.prettier_formatexpr = function()
    if vim.v.count == 0 then
        return 1
    end

    local start_line = vim.v.lnum
    local end_line = start_line + vim.v.count - 1
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local full_text = table.concat(lines, '\n') .. '\n'

    -- Calculate byte offsets for the range.
    local range_start = 0
    for i = 1, start_line - 1 do
        range_start = range_start + #lines[i] + 1
    end

    local range_end = range_start
    for i = start_line, end_line do
        range_end = range_end + #lines[i] + 1
    end

    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local result = vim.system({
        'prettier',
        '--stdin-filepath', filepath,
        '--range-start', tostring(range_start),
        '--range-end', tostring(range_end),
    }, { stdin = full_text }):wait()

    if result.code ~= 0 then
        return 1
    end

    local formatted_lines = vim.split(result.stdout, '\n', { trimempty = false })
    if formatted_lines[#formatted_lines] == '' then
        table.remove(formatted_lines)
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
    return 0
end

--- Find and return the closing token for the last unclosed pair before the
--- cursor. Handles (), [], {}, quotes, template literal interpolation, and
--- comments. Use as an expr mapping in insert mode.
---@return string The closing token, or '' if nothing is unclosed
M.close_last_unclosed_pair = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]
    local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
    lines[#lines] = lines[#lines]:sub(1, col)

    local openers = { ['('] = ')', ['['] = ']', ['{'] = '}' }
    local closers = { [')'] = true, [']'] = true, ['}'] = true }
    local quotes = { ["'"] = true, ['"'] = true, ['`'] = true }
    local stack = {}

    for _, line in ipairs(lines) do
        local i = 1
        while i <= #line do
            local ch = line:sub(i, i)

            -- Skip escaped characters inside strings/template literals.
            if ch == '\\' and #stack > 0 and quotes[stack[#stack]] then
                i = i + 2
            -- Template literal interpolation: ${ opens an expression.
            elseif ch == '$' and i < #line and line:sub(i + 1, i + 1) == '{'
                and #stack > 0 and stack[#stack] == '`' then
                table.insert(stack, '{')
                i = i + 2
            elseif quotes[ch] then
                if #stack > 0 and stack[#stack] == ch then
                    table.remove(stack)
                else
                    table.insert(stack, ch)
                end
                i = i + 1
            elseif #stack > 0 and quotes[stack[#stack]] then
                -- Inside a string, skip everything else.
                i = i + 1
            elseif openers[ch] then
                table.insert(stack, ch)
                i = i + 1
            elseif closers[ch] then
                if #stack > 0 and openers[stack[#stack]] == ch then
                    table.remove(stack)
                end
                i = i + 1
            -- Skip single-line comments.
            elseif ch == '/' and i < #line and line:sub(i + 1, i + 1) == '/' then
                break
            -- Track block comments: /* */, <!-- -->, {# #}
            elseif ch == '/' and i < #line and line:sub(i + 1, i + 1) == '*' then
                table.insert(stack, '/*')
                i = i + 2
            elseif ch == '*' and i < #line and line:sub(i + 1, i + 1) == '/'
                and #stack > 0 and stack[#stack] == '/*' then
                table.remove(stack)
                i = i + 2
            elseif ch == '<' and i + 2 < #line and line:sub(i + 1, i + 3) == '!--' then
                table.insert(stack, '<!--')
                i = i + 4
            elseif ch == '-' and i + 1 < #line and line:sub(i + 1, i + 2) == '->'
                and #stack > 0 and stack[#stack] == '<!--' then
                table.remove(stack)
                i = i + 3
            elseif ch == '{' and i < #line and line:sub(i + 1, i + 1) == '#' then
                table.insert(stack, '{#')
                i = i + 2
            elseif ch == '#' and i < #line and line:sub(i + 1, i + 1) == '}'
                and #stack > 0 and stack[#stack] == '{#' then
                table.remove(stack)
                i = i + 2
            elseif #stack > 0 and (stack[#stack] == '/*' or stack[#stack] == '<!--' or stack[#stack] == '{#') then
                -- Inside a block comment, skip.
                i = i + 1
            else
                i = i + 1
            end
        end
    end

    for i = #stack, 1, -1 do
        local open = stack[i]
        if openers[open] then
            return openers[open]
        elseif quotes[open] then
            return open
        end
    end
    return ''
end

return M

-- vim:ft=lua et sts=4 sw=4 foldminlines=1
