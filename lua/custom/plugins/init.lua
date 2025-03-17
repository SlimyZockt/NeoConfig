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
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  -- {
  --   'mfussenegger/nvim-jdtls',
  --   dependencies = { 'mfussenegger/nvim-dap' },
  --   config = function()
  --     local function jdtls_cmd()
  --       if vim.loop.os_uname().sysname == 'Linux' then
  --         return '/run/current-system/sw/bin/jdtls'
  --       end
  --       return ''
  --     end
  --
  --     require('jdtls').start_or_attach {
  --       cmd = { jdtls_cmd() },
  --       root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  --     }
  --   end,
  -- },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    ---@type gopher.Config
    opts = {},
    config = function(_, opts)
      require('gopher').setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
