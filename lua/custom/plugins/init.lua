-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
--
--
vim.keymap.set('n', '<leader>ee', 'oif err != nil {<CR>}<Esc>Oreturn err<Esc>')
vim.keymap.set('n', '<leader>er', 'oif err != nil {<CR>}<Esc>Olog.Fatal(err)<Esc>')

local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
if gdproject then
  io.close(gdproject)
  vim.fn.serverstart './godothost'
end

return {
  'lambdalisue/suda.vim',
  'christoomey/vim-tmux-navigator',
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = '[T]oggele [U]ndotree', noremap = true, silent = true })
    end,
  },
  {
    'MysticalDevil/inlay-hints.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('inlay-hints').setup()
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    config = function()
      vim.keymap.set('n', '<leader>tm', vim.cmd.MarkdownPreviewToggle, { desc = '[T]oggele [M]arkdown Preview', noremap = true, silent = true })
    end,
  },
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require('mini.files').setup()

      vim.keymap.set('n', '<leader>te', require('mini.files').open, { desc = '[T]oggele [e]xplorer', noremap = true, silent = true })
    end,
  },
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    ---@type gopher.Config
    opts = {
      -- log level, you might consider using DEBUG or TRACE for debugging the plugin
      log_level = vim.log.levels.INFO,

      -- timeout for running internal commands
      timeout = 2000,
      installer_timeout = 2000,
      commands = {
        go = 'go',
        gomodifytags = 'gomodifytags',
        gotests = 'gotests',
        impl = 'impl',
        iferr = 'iferr',
      },
      gotests = {
        -- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
        template = 'default',
        -- path to a directory containing custom test code templates
        template_dir = nil,
        -- switch table tests from using slice to map (with test name for the key)
        named = false,
      },
      gotag = {
        transform = 'snakecase',
        -- default tags to add to struct fields
        default_tag = 'json',
      },
      iferr = {
        -- choose a custom error message
        message = nil,
      },
    },
    config = function(_, opts)
      require('gopher').setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
