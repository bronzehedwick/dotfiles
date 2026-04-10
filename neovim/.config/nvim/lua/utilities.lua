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

---@param opts { direction: 'above'|'below', guard: (fun(): boolean)? }
M.open_line_with_comma = function(opts)
    local key = opts.direction == 'above' and 'O' or 'o'

    if opts.guard and not opts.guard() then
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

---@param guard (fun(): boolean)?
M.dd_with_comma_removal = function(guard)
    if guard and not guard() then
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

return M

-- vim:ft=lua et sts=4 sw=4 foldminlines=1
