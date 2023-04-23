local M = {}

M.make_modal = function(opts)
    if not opts then
        opts = {}
    end
    local width = vim.o.columns - 4
    local height = 11
    local winid = vim.fn.win_getid()

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

M.fuzzy_search = function(files_command, action)
    M.make_modal({max_width = true})

    local file = vim.fn.tempname()
    local shell_command = {
        '/bin/sh',
        '-c',
        files_command .. ' | fzy > ' .. file
    }

    vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })

    vim.fn.termopen(shell_command, {
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

M.autocomplete_html_attribute = function()
    -- The cursor location does not give us the correct node in this case, so
    -- we need to get the node to the left of the cursor.
    local cursor = vim.api.nvim_win_get_cursor(0)
    local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

    local node = vim.treesitter.get_node { pos = left_of_cursor_range }
    local nodes_active_in = {
        'attribute_name',
        'directive_argument',
        'directive_name',
    }
    if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
        -- The cursor is not on an attribute node
        return '='
    end

    return '=""<left>'
end

return M

-- vim:fdm=marker ft=lua et sts=4 sw=4
