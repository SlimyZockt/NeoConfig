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
vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { desc = 'toggels Markdown Preview', noremap = true, silent = true })

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart './godothost'
end

return {
  'lambdalisue/suda.vim',
}
