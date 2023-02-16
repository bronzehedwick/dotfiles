local M = {}

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

M.fuzzy_search = function(files_command, action)
    M.make_modal()

    local file = vim.fn.tempname()
    local shell_command = {
        '/bin/sh',
        '-c',
        files_command .. ' | fzy > ' .. file
    }

    vim.api.nvim_command('startinsert')

    vim.fn.termopen(shell_command, {
        on_exit = function()
            vim.api.nvim_command('bdelete!')
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

return M

-- vim:fdm=marker ft=lua et sts=4 sw=4
