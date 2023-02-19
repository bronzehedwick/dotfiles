local M = {}

-- Make a modal {{{
M.make_modal = function()
    local width = vim.o.columns - 4
    local height = 11
    local winid = vim.fn.win_getid()

    if (vim.o.columns > 85) then
        width = 80
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
-- }}}

M.fuzzy_search = function(files_command, action)
    M.make_modal()

    local file = nil
    local shell_command = {
        '/bin/sh',
        '-c',
        files_command .. ' | fzy'
    }

    vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })

    vim.fn.termopen(shell_command, {
        stdout_buffered = true,
        on_stdout = function(chan_id, data, name)
            local stdout = data[table.maxn(data) - 1]
            print(vim.inspect(string.gsub(stdout, "\27\[K\27\[10A", "")))
            -- \27[K\27[10Acompiler/screenplain.vim\r
        end,
        on_exit = function()
            vim.api.nvim_cmd(
                { cmd = 'bdelete', bang = true },
                { output = false }
            )
            vim.fn.win_gotoid(winid)
            -- vim.api.nvim_command(table.concat({ action, file }, ' '))
        end
    })
end

return M

-- vim:fdm=marker ft=lua et sts=4 sw=4
