-- ⸸ OCULUS VIM UTILS ⸸
-- The All-Seeing Eye's Utility Arsenal

return {
  -- ⛧ WHICH-KEY ⛧
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
            operators = false,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        operators = { gc = "Comments" },
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
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
          padding = { 1, 2, 1, 2 },
          winblend = 0,
          zindex = 1000,
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
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      })

      -- ⸸ GROUP MAPPINGS ⸸
      wk.register({
        ["<leader>f"] = { name = "⸸ Find" },
        ["<leader>g"] = { name = "👁 Git" },
        ["<leader>t"] = { name = "⛧ Terminal" },
        ["<leader>w"] = { name = "☠ Workspace" },
        ["<leader>b"] = { name = "📄 Buffer" },
        ["<leader>h"] = { name = "⚡ Hunk" },
        ["<leader>s"] = { name = "🔍 Search" },
        ["<leader>l"] = { name = "🔧 LSP" },
        ["<leader>d"] = { name = "🐛 Debug" },
        ["<leader>u"] = { name = "🎛️ UI/Toggle" },
        ["<leader>c"] = { name = "💻 Code" },
        ["<leader>x"] = { name = "💥 Trouble" },
        ["<leader>n"] = { name = "📝 Notes" },
        ["<leader>r"] = { name = "🔄 Refactor" },
        ["<leader>S"] = { name = "💾 Session" },
        ["<leader>p"] = { name = "📦 Package" },
      })
    end,
  },

  -- ⛧ NOTIFICATIONS ⛧
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#1d2021",
        fps = 30,
        icons = {
          DEBUG = "🐛",
          ERROR = "☠",
          INFO = "👁",
          TRACE = "✎",
          WARN = "⛧"
        },
        level = 2,
        minimum_width = 50,
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 5000,
        top_down = true
      })
      vim.notify = notify
      
      -- Add telescope extension
      require("telescope").load_extension("notify")
    end,
  },

  -- ⛧ INDENT BLANKLINE ⛧
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          injected_languages = false,
          highlight = { "Function", "Label" },
          priority = 500,
        },
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
      })
    end,
  },

  -- ⛧ MINI UTILITIES ⛧
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      -- Mini.ai (enhanced text objects)
      require("mini.ai").setup({
        n_lines = 500,
        custom_textobjects = {
          o = require("mini.ai").gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      })

      -- Mini.move (move lines and selections)
      require("mini.move").setup({
        mappings = {
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
        options = {
          reindent_linewise = true,
        },
      })

      -- Mini.comment (commenting)
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      })

      -- Mini.pairs (auto pairs)
      require("mini.pairs").setup()

      -- Mini.splitjoin (split/join lines)
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "gS",
          split = "",
          join = "",
        },
      })

      -- Mini.bracketed (bracketed mappings)
      require("mini.bracketed").setup()
    end,
  },

  -- ⛧ TROUBLE ⛧
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix" },
      { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References" },
    },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        severity = nil,
        fold_open = "👁",
        fold_closed = "⸸",
        group = true,
        padding = true,
        cycle_results = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>", "<2-leftmouse>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          switch_severity = "s",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          open_code_href = "c",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j"
        },
        multiline = true,
        indent_lines = true,
        win_config = { border = "rounded" },
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },
        signs = {
          error = "☠",
          warning = "⛧",
          hint = "⸸",
          information = "👁",
          other = "🔮"
        },
        use_diagnostic_signs = false
      })
    end,
  },

  -- ⛧ TODO COMMENTS ⛧
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = "☠",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = "⸸", color = "info" },
          HACK = { icon = "⛧", color = "warning" },
          WARN = { icon = "⚡", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "👁", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "📝", color = "hint", alt = { "INFO" } },
          TEST = { icon = "🧪", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true,
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#cc241d" },
          warning = { "DiagnosticWarn", "WarningMsg", "#d79921" },
          info = { "DiagnosticInfo", "#458588" },
          hint = { "DiagnosticHint", "#689d6a" },
          default = { "Identifier", "#b16286" },
          test = { "Identifier", "#fe8019" }
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      })
    end,
  },

  -- ⛧ FOCUS MODE ⛧
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    config = function()
      require("zen-mode").setup({
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
            laststatus = 0,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          kitty = {
            enabled = false,
            font = "+4",
          },
        },
      })
    end,
  },

  -- ⛧ TWILIGHT ⛧
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#928374" },
          term_bg = "#1d2021",
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {},
      })
    end,
  },

  -- ⛧ FLASH (Enhanced Navigation) ⛧
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
        mode = "exact",
        incremental = false,
      },
      jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
      },
      label = {
        uppercase = true,
        exclude = "",
        current = true,
        after = true,
        before = false,
        style = "overlay",
        reuse = "lowercase",
        distance = true,
        min_pattern_length = 0,
        rainbow = {
          enabled = false,
          shade = 5,
        },
      },
      highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      action = nil,
      pattern = "",
      continue = false,
      config = nil,
      prompt = {
        enabled = true,
        prefix = { { "⸸", "FlashPromptIcon" } },
        win_config = {
          relative = "editor",
          width = 1,
          height = 1,
          row = -1,
          col = 0,
          zindex = 1000,
        },
      },
      remote_op = {
        restore = false,
        motion = false,
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- ⛧ PERSISTENCE (Session Management) ⛧
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
        pre_save = nil,
        save_empty = false,
      })

      -- Restore session
      vim.keymap.set("n", "<leader>Ss", function() require("persistence").load() end, { desc = "Restore Session" })
      vim.keymap.set("n", "<leader>Sl", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
      vim.keymap.set("n", "<leader>Sq", function() require("persistence").stop() end, { desc = "Quit Without Session Save" })
    end,
  },
} 