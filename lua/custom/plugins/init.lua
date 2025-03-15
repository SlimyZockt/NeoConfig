-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
--
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
vim.keymap.set('n', '<leader>er', 'oif err != nil {<CR>}<Esc>Olog.Fatal(err)<Esc>')
vim.keymap.set('n', '<leader>oo', ':Lexplore<CR>', { desc = 'toggels dir tree', noremap = true, silent = true })
vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', { desc = 'toggels Markdown Preview', noremap = true, silent = true })
vim.keymap.set('n', '<leader>ou', ':UndotreeToggle<CR>')

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart './godothost'
end

return {
  'lambdalisue/suda.vim',
  'christoomey/vim-tmux-navigator',
  'mbbill/undotree',
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mfussenegger/nvim-dap', -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
}
