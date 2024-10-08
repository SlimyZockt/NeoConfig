-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
--
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')

return {
  'lambdalisue/suda.vim',
  -- {
  --   'pocco81/auto-save.nvim',
  --   config = {
  --     enabled = true,
  --   },
  -- },
}
