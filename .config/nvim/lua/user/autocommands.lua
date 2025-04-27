-- go to the last cursor position
vim.api.nvim_create_augroup("restore_cursor", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
    group = "restore_cursor",
    callback = function()
        local line = vim.fn.line("'\"")
        local last_line = vim.fn.line("$")
        local filetype = vim.bo.filetype

        if line >= 1 and line <= last_line
            and filetype ~= "commit"
            and filetype ~= "xxd"
            and filetype ~= "gitrebase" then
            vim.cmd("normal! g`\"")
        end
    end,
})
