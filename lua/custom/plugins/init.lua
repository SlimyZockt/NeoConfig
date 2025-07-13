-- You can add your own plugins here or in other files in this directory!cu
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
  -- {
  --   'nvim-java/nvim-java',
  --   config = function()
  --     require('java').setup()
  --   end,
  -- },
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
        'templ',
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
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          local m = name:match '^%.'
          return m ~= nil
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
        -- Sort file names with numbers in a more intuitive order for humans.
        -- Can be "fast", true, or false. "fast" will turn it off for large directories.
        natural_order = 'fast',
        -- Sort file and directory names case insensitive
        case_insensitive = false,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
        -- Customize the highlight group for the file name
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },
    },
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
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
}
