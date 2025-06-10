-- ⸸ OCULUS VIM UI ⸸
-- The All-Seeing Eye's Interface - Enhanced Beyond vim.reaper

return {
  -- ⛧ ENHANCED STATUSLINE ⛧
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local function oculus_theme()
        return {
          normal = {
            a = { bg = '#d65d0e', fg = '#1d2021', gui = 'bold' },
            b = { bg = '#504945', fg = '#fbf1c7' },
            c = { bg = '#3c3836', fg = '#a89984' },
          },
          insert = {
            a = { bg = '#689d6a', fg = '#1d2021', gui = 'bold' },
            b = { bg = '#504945', fg = '#fbf1c7' },
            c = { bg = '#3c3836', fg = '#a89984' },
          },
          visual = {
            a = { bg = '#fe8019', fg = '#1d2021', gui = 'bold' },
            b = { bg = '#504945', fg = '#fbf1c7' },
            c = { bg = '#3c3836', fg = '#a89984' },
          },
          replace = {
            a = { bg = '#cc241d', fg = '#1d2021', gui = 'bold' },
            b = { bg = '#504945', fg = '#fbf1c7' },
            c = { bg = '#3c3836', fg = '#a89984' },
          },
          command = {
            a = { bg = '#d79921', fg = '#1d2021', gui = 'bold' },
            b = { bg = '#504945', fg = '#fbf1c7' },
            c = { bg = '#3c3836', fg = '#a89984' },
          },
          inactive = {
            a = { bg = '#3c3836', fg = '#928374' },
            b = { bg = '#3c3836', fg = '#928374' },
            c = { bg = '#3c3836', fg = '#928374' },
          },
        }
      end

      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end

      require("lualine").setup({
        options = {
          theme = oculus_theme(),
          component_separators = { left = '⸸', right = '⛧' },
          section_separators = { left = '👁', right = '☠' },
          disabled_filetypes = { 'neo-tree', 'alpha' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { 
            {
              'mode',
              fmt = function(str)
                return '⸸ ' .. str:sub(1,1) .. ' ⸸'
              end
            }
          },
          lualine_b = { 
            'branch',
            { 'diff', source = diff_source },
            'diagnostics'
          },
          lualine_c = { 
            {
              'filename',
              path = 1,
              symbols = {
                modified = '⛧',
                readonly = '☠',
                unnamed = '👁',
                newfile = '⸸',
              }
            }
          },
          lualine_x = { 
            'encoding', 
            'fileformat', 
            {
              'filetype',
              icons_enabled = true,
              icon_only = false,
            }
          },
          lualine_y = { 
            'progress',
            {
              'location',
              fmt = function(str)
                return '👁 ' .. str
              end
            }
          },
          lualine_z = { 
            {
              'datetime',
              style = '%H:%M',
              fmt = function(str)
                return '⸸ ' .. str .. ' ⸸'
              end
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'neo-tree', 'lazy', 'trouble' }
      })
    end,
  },

  -- ⛧ ENHANCED DASHBOARD ⛧
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ⸸ OCULUS ASCII ART ⸸
      dashboard.section.header.val = {
        "                                                                   ",
        "  ███████╗ ██████╗██╗   ██╗██╗     ██╗   ██╗███████╗    ██╗   ██╗██╗███╗   ███╗",
        "  ██╔═══██╗██╔════╝██║   ██║██║     ██║   ██║██╔════╝    ██║   ██║██║████╗ ████║",
        "  ██║   ██║██║     ██║   ██║██║     ██║   ██║███████╗    ██║   ██║██║██╔████╔██║",
        "  ██║   ██║██║     ██║   ██║██║     ██║   ██║╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║",
        "  ╚██████╔╝╚██████╗╚██████╔╝███████╗╚██████╔╝███████║     ╚████╔╝ ██║██║ ╚═╝ ██║",
        "   ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                                   ",
        "                          ⸸ THE ALL-SEEING EYE OF DEVELOPMENT ⸸                ",
        "                               ⛧ ENHANCED BEYOND VIM.REAPER ⛧                   ",
        "                                                                   ",
      }

      -- ⸸ MENU ITEMS ⸸
      dashboard.section.buttons.val = {
        dashboard.button("f", "⸸  Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", "👁  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "⛧  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "☠  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "⚙️  Configuration", ":e ~/.config/oculus-vim/init.lua <CR>"),
        dashboard.button("s", "💾  Session restore", ":SessionRestore <CR>"),
        dashboard.button("l", "🔌  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "🚪  Quit Neovim", ":qa<CR>"),
      }

      -- ⸸ FOOTER ⸸
      local function footer()
        local total_plugins = #vim.tbl_keys(require("lazy").plugins())
        local datetime = os.date("%d-%m-%Y %H:%M:%S")
        local version = vim.version()
        local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch

        return {
          "⸸ " .. total_plugins .. " plugins loaded in " .. datetime .. " ⸸",
          "👁 Neovim" .. nvim_version_info .. " - The All-Seeing Eye Watches 👁",
          "⛧ May your code compile without errors and your bugs be shallow ⛧"
        }
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      -- ⸸ LAYOUT ⸸
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- ⸸ DISABLE STATUSLINE IN ALPHA ⸸
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        desc = "disable statusline for alpha",
        callback = function()
          local old_laststatus = vim.opt.laststatus
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
              vim.opt.laststatus = old_laststatus
            end,
          })
          vim.opt.laststatus = 0
        end,
      })
    end,
  },

  -- ⛧ INDENTATION GUIDES ⛧
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- ⛧ BUFFER TABS ⛧
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        offsets = {
          {
            filetype = "neo-tree",
            text = "⸸ File Explorer ⸸",
            highlight = "Directory",
            text_align = "center",
          },
        },
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and "☠" or "⸸"
          return " " .. icon .. count
        end,
        separator_style = "slope",
        indicator = {
          icon = '👁',
          style = 'icon',
        },
        buffer_close_icon = '☠',
        modified_icon = '⛧',
        close_icon = '⸸',
        left_trunc_marker = '⸸',
        right_trunc_marker = '⛧',
      },
    },
  },

  -- ⛧ WHICH-KEY ENHANCEMENTS ⛧
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        icons = {
          breadcrumb = "⛧",
          separator = "👁",
          group = "⸸ ",
        },
        popup_mappings = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
        ignore_missing = true,
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
        show_help = true,
        triggers = "auto",
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
      })

      -- ⸸ GROUP DEFINITIONS ⸸
      wk.register({
        ["<leader>"] = {
          f = { name = "⸸ Find" },
          g = { name = "⛧ Git" },
          b = { name = "👁 Buffer" },
          s = { name = "☠ Split" },
          l = { name = "🐳 Lazy" },
          x = { name = "⚡ Trouble" },
          h = { name = "🔧 Hunk" },
          d = { name = "🐛 Debug" },
          t = { name = "💻 Terminal" },
          m = { name = "🎨 Format" },
          S = { name = "💾 Session" },
          q = { name = "📋 Quickfix" },
          r = { name = "🔄 Rename" },
          c = { name = "💡 Code" },
        },
      })
    end,
  },

  -- ⛧ NOTIFICATIONS ⛧
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      icons = {
        ERROR = "☠",
        WARN = "⛧",
        INFO = "👁",
        DEBUG = "⸸",
        TRACE = "✨",
      },
    },
    init = function()
      vim.notify = require("notify")
    end,
  },

  -- ⛧ ZEN MODE ⛧
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        kitty = {
          enabled = false,
          font = "+4",
        },
      },
    },
  },

  -- ⛧ SCROLLBAR ⛧
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        handle = {
          text = " ",
          color = "#928374",
          cterm = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Search = {
            text = { "⸸", "⛧" },
            priority = 0,
            color = "#fe8019",
            cterm = nil,
            highlight = "Search",
          },
          Error = {
            text = { "☠", "☠" },
            priority = 1,
            color = "#cc241d",
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "⛧", "⛧" },
            priority = 2,
            color = "#d79921",
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "👁", "👁" },
            priority = 3,
            color = "#458588",
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "⸸", "⸸" },
            priority = 4,
            color = "#689d6a",
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text = { "⸸", "⛧" },
            priority = 5,
            color = "#b16286",
            cterm = nil,
            highlight = "Normal",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "alpha",
          "neo-tree",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = false,
        },
      })
    end,
  },
} 