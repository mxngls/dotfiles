-- open Dirvish buffer dir of current file
vim.keymap.set('n', '<leader>L', function()
    if vim.bo.filetype ~= 'dirvish' then
        vim.cmd('vert split')
        vim.cmd('Dirvish %:p:h')
    end
end, { noremap = true, silent = true })

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
