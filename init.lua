-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Show line numbers.
-- See `:help vim.o` and `:help option-list`
vim.o.number = true
vim.o.relativenumber = true

-- Adjust the width of the left hand number line, 3 is quite small:
vim.o.numberwidth = 3

-- Don't show the mode, since it's already in the status line.
vim.o.showmode = false

-- Disable arrow keys and mouse.
vim.keymap.set('n', '<up>', '<nop>') -- equivalent to: nnoremap <up> <nop>
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>') -- equivalent to: inoremap <up> <nop>
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
vim.keymap.set('v', '<up>', '<nop>') -- equivalent to: vnoremap <up> <nop>
vim.keymap.set('v', '<down>', '<nop>')
vim.keymap.set('v', '<left>', '<nop>')
vim.keymap.set('v', '<right>', '<nop>')
vim.o.mouse = ''

vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- Turn on the ruler to show line and column position.
vim.o.ruler = true

-- Treat dash-separated words as a single word object.
vim.opt.iskeyword:append { '-' }

-- This enables horizontal spits in the interface to appear below the current window.
-- vim.o.splitbelow = true
vim.o.splitright = true

-- Enable smart and auto indentation for { }.
vim.o.smartindent = true
vim.o.autoindent = true

-- Always show the status line.
vim.o.laststatus = 2

-- Enable cursor line highlighting.
vim.o.cursorline = true

-- When multiple tabs are open, show the tabline at the top.
vim.o.showtabline = 1

-- Set case insensitive mode, searching for hello will find both hello and Hello.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable spelling suggestions during autocompletion.
vim.o.spelllang = 'en_gb'
vim.opt.complete:append { 'kspell' }

-- Spell checking for certain filetypes. To correct a word, move the cursor to it and press z=
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { '*.txt', '*.tex', '*.md' },
  command = [[ set spell! ]],
})
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = { '*.txt', '*.tex', '*.md' },
  command = [[ set spell! ]],
})
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { '*.yaml', '*.yml' },
  callback = function()
    -- In lua, `[[ ... ]]` is a literal string.
    if vim.fn.search([[hosts:\|tasks:]], 'nw') then
      vim.opt.filetype = 'yaml.ansible'
    end
  end,
})

-- Enable autocompletion to choose the longest match first.
vim.opt.completeopt:append { 'longest' }

-- See `:help vim.hl.on_yank()` and `:help lua-guide-autocommands` and `:help lua-guide-autocommand-create`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Perform git add and git commit when saving.',
  group = vim.api.nvim_create_augroup('auto-git', { clear = true }),
  pattern = '*',
  callback = function()
    -- See :help expand
    if vim.fn.isdirectory './.git' == 1 and os.execute 'git rev-parse --git-dir > /dev/null 2>&1' then
      os.execute 'git add %'
      os.execute 'git commit -m %'
    end
  end,
})

-- See `:help 'list'` and `:help 'listchars'`
-- listchars is set using `vim.opt`, which provides an interface for interacting with tables.
-- See `:help lua-options` and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars:append { eol = '↴', tab = '>·', trail = '·' }

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Preview substitutions live, as you type.
vim.o.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes (like `:q`),
-- open a dialog asking if you wish to save the current file(s). See `:help 'confirm'`
vim.o.confirm = true

-- Clear highlights on search when pressing <Esc> in normal mode see `:help hlsearch`
-- See `:help vim.keymap.set()`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode with a shortcut. Escape twice is equivalent to ctrl+\ ctrl+n.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Change the behaviour of line numbers in the terminal.
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Change line behaviour in the built-in terminal.',
  group = vim.api.nvim_create_autocmd('term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- Use CTRL+<hjkl> to navigate between windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
-- vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
-- vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
-- vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- See `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- @type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  -- Plugins are added using a table, the first argument is the link then the keys to configure plugin behavior.
  -- Use `opts = {}` to pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  -- Alternatively, use `config = function() ... end` for full control over the configuration. E.g.
  --    {
  --        'project/plugin_name',
  --        config = function()
  --            require('plugin_name').setup({
  --                -- configuration
  --            })
  --        end,
  --    }
  -- Help: `<space>sh` then `lazy.nvim-plugin`, `<space>sr` resumes the last telescope search.
  {
    'let-def/texpresso.vim', -- install neovim TeXpresso plugin.
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  -- Plugins can be configured to run Lua code when they are loaded using event = 'VimEnter',
  -- this loads the plugin before the UI elements are loaded. Events can be normal
  -- autocommands events (`:help autocmd-events`).
  --  {
  --    'tpope/vim-sensible',
  --  },
  {
    'tpope/vim-commentary', -- use `gcc` to comment out a line or `gcap` to comment out a paragraph.
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 10, -- delay between pressing a key and opening which-key (milliseconds)
      icons = {
        mappings = false,
        -- keys = {} -- enable for nerd font keys.
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- build runs command when the plugin is installed or updated.
        cond = function() -- cond is a condition to determine if this plugin should be installed.
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      -- Start telescope by:
      -- :Telescope help_tags
      --
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout:
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 0,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      -- It is possible to pass additional configuration options.
      -- See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep of Open Files',
        }
      end, { desc = '[S]earch [/] Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim configuration files' })
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP stands for Language Server Protocol. Mason automatically install LSPs and related tools to stdpath.
      -- `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSPs.
      'saghen/blink.cmp',
    },
    config = function()
      -- See `:help lsp-vs-treesitter`
      -- This function is run when an LSP attaches to a particular buffer. Every time
      -- a file is opened that is associated with an lsp this function will be executed.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- The following creates a function that maps specific key combinations
          -- for LSP items. It sets the mode, buffer and description.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under the cursor.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- Go to a code action, the cursor needs to be on top of an error
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          -- Find references for the word under the cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- Jump to the implementation of the word under the cursor.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- Jump to the definition of the word under the cursor. To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- Jump to the type of the word under the cursor.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
          --  Go to declaration, e.g. in C this would go to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- Fuzzy find the symbols in the document. Symbols are variables, functions, types, etc.
          map('gS', require('telescope.builtin').lsp_document_symbols, 'Open Document [S]ymbols')

          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end
          -- The following two autocommands are used to highlight references of the
          -- word under the cursor when the cursor rests there for a while.
          -- See `:help CursorHold`.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end
          -- The following creates a keymap to toggle inlay hints, if the LSP supports them.
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
      -- Neovim doesn't support everything in the LSP specification.
      -- When you add blink.cmp and luasnip Neovim has more capabilities.
      -- Create new capabilities with blink.cmp, then broadcast that to the servers:
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- Enable the following language servers
      local servers = {
        -- Additional configuration in the following tables.
        --  cmd (table): Override the default command used to start the server
        --  filetypes (table): Override the default list of associated filetypes for the server
        --  capabilities (table): Override fields in capabilities.
        --  settings (table): Override the default settings passed when initializing the server.
        -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
        ts_ls = {}, -- typescript
        texlab = {}, -- TeX
        bashls = {}, -- bash script
        gopls = {}, -- go
        yamlls = {}, -- yaml
        ansiblels = {}, -- ansible
        lua_ls = { -- lua_ls: https://luals.github.io/wiki/settings/
          -- cmd = { ... },
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- To ignore `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      -- To check the status of installed tools, run
      -- :Mason
      -- Press `g?` for help in this menu.
      --
      -- You can add other tools for Mason to install.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table, installs via mason-tool-installer.
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding values explicitly passed by the server configuration above.
            -- Useful when disabling certain features of an LSP (e.g. turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true } -- disable for specific file types without conform style guides.
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially e.g.
        -- python = { 'isort', 'black' },
        --
        -- Uuse 'stop_after_first' to run the first available formatter from the list
        -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          return 'make install_jsregexp' -- Build step is needed for regex support in snippets.
        end)(),
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' for mappings similar to built-in completions
        --   <c-y> to accept the completion.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        -- `:help ins-completion`
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- For more advanced Luasnip keymaps:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 }, -- Set true to show the documentation after delay.
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true }, -- Shows a signature help window while you type arguments for a function
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  --  {
  -- 'echasnovski/mini.nvim',
  -- config = function()
  -- va)  - [V]isually select [A]round [)]paren
  -- yinq - [Y]ank [I]nside [N]ext [Q]uote
  -- ci'  - [C]hange [I]nside [']quote
  -- require('mini.ai').setup { n_lines = 500 }
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- sd'   - [S]urround [D]elete [']quotes
  -- sr)'  - [S]urround [R]eplace [)] [']
  -- require('mini.surround').setup()
  -- end,
  --  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    -- See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'latex', 'bibtex' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      -- Add the language to the list additional_vim_regex_highlighting to disable indenting.
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules:
    --  Incremental selection, see `:help nvim-treesitter-incremental-selection-mod`
    --  Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --  Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  -- {
  -- 'bluz71/vim-moonfly-colors', -- alternative colour scheme, if needed
  -- name = 'moonfly',
  -- lazy = false,
  -- priority = 1000,
  -- },
  -- Uncomment to add custom plugins (for programming) in `lua/custom/plugins/*.lua`:
  -- { import = 'custom.plugins' },
}, {
  ui = {
    icons = {}, -- set to empty table.
  },
})

-- vim.g.moonflyItalics = false
vim.cmd [[colorscheme default]]

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
