-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
--
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
vim.keymap.set('n', '<leader>er', 'oif err != nil {<CR>}<Esc>Olog.Fatal(err)<Esc>')
vim.keymap.set('n', '<leader>o', ':Lexplore<CR>', { desc = 'toggels dir tree', noremap = true, silent = true })

return {
  'lambdalisue/suda.vim',
}
