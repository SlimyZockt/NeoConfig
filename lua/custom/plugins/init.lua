-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  'lambdalisue/suda.vim',
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'tab',
      hide_numbers = true,
      open_mapping = [[<C-q>]],
    },
  },
}
