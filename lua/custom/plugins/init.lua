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
  -- tailwind-tools.lua
  {
    'Jezda1337/nvim-html-css',
    dependencies = { 'hrsh7th/nvim-cmp', 'nvim-treesitter/nvim-treesitter' }, -- Use this if you're using nvim-cmp
    -- dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using blink.cmp
    opts = {
      enable_on = { -- Example file types
        'html',
        'htmldjango',
        'tsx',
        'jsx',
        'erb',
        'svelte',
        'vue',
        'blade',
        'php',
        'templ',
        'astro',
      },
      handlers = {
        definition = {
          bind = 'gd',
        },
        hover = {
          bind = 'K',
          wrap = true,
          border = 'none',
          position = 'cursor',
        },
      },
      documentation = {
        auto_show = true,
      },
      style_sheets = {},
    },
  },
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
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {},
  --   config = function()
  --     require('render-markdown').setup {
  --       completions = { lsp = { enabled = true } },
  --     }
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.files',
  --   version = false,
  --   config = function()
  --     require('mini.files').setup()
  --
  --     vim.keymap.set('n', '<leader>te', require('mini.files').open, { desc = '[T]oggele [e]xplorer', noremap = true, silent = true })
  --   end,
  -- },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
    config = function(_, opts)
      require('oil').setup(opts)

      vim.keymap.set('n', '<leader>te', '<CMD>Oil<CR>', { desc = '[T]oggele [e]xplorer', noremap = true, silent = true })
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
