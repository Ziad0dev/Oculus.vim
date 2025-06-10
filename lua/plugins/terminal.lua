-- ⸸ OCULUS VIM TERMINAL ⸸
-- The All-Seeing Eye's Command Interface

return {
  -- ⛧ TOGGLETERM ⛧
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical Terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab Terminal" },
      { "<leader>tg", function() _LAZYGIT_TOGGLE() end, desc = "LazyGit Terminal" },
      { "<leader>td", function() _LAZYDOCKER_TOGGLE() end, desc = "LazyDocker Terminal" },
      { "<leader>tp", function() _PYTHON_TOGGLE() end, desc = "Python Terminal" },
      { "<leader>tn", function() _NODE_TOGGLE() end, desc = "Node Terminal" },
      { "<leader>tr", function() _RANGER_TOGGLE() end, desc = "Ranger Terminal" },
      { "<leader>to", function() _HTOP_TOGGLE() end, desc = "Htop Terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
          width = function()
            return math.ceil(vim.o.columns * 0.8)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.8)
          end,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      })

      -- ⸸ TERMINAL KEYMAPS ⸸
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- Apply terminal keymaps
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      -- ⸸ CUSTOM TERMINALS ⸸
      local Terminal = require("toggleterm.terminal").Terminal

      -- LazyGit Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
          width = function()
            return math.ceil(vim.o.columns * 0.9)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- LazyDocker Terminal
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        direction = "float",
        float_opts = {
          border = "double",
          width = function()
            return math.ceil(vim.o.columns * 0.9)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.9)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      function _LAZYDOCKER_TOGGLE()
        lazydocker:toggle()
      end

      -- Python Terminal
      local python = Terminal:new({
        cmd = "python3",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _PYTHON_TOGGLE()
        python:toggle()
      end

      -- Node Terminal
      local node = Terminal:new({
        cmd = "node",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _NODE_TOGGLE()
        node:toggle()
      end

      -- Ranger Terminal
      local ranger = Terminal:new({
        cmd = "ranger",
        direction = "float",
        float_opts = {
          border = "curved",
          width = function()
            return math.ceil(vim.o.columns * 0.8)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.8)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _RANGER_TOGGLE()
        ranger:toggle()
      end

      -- Htop Terminal
      local htop = Terminal:new({
        cmd = "htop",
        direction = "float",
        float_opts = {
          border = "curved",
          width = function()
            return math.ceil(vim.o.columns * 0.8)
          end,
          height = function()
            return math.ceil(vim.o.lines * 0.8)
          end,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      function _HTOP_TOGGLE()
        htop:toggle()
      end

      -- ⸸ TERMINAL HIGHLIGHTS ⸸
      vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = "#d65d0e" })
      vim.api.nvim_set_hl(0, "ToggleTermFloat", { bg = "#1d2021" })
    end,
  },

  -- ⛧ TERMINAL SESSIONS ⛧
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>Ss", "<cmd>SearchSession<cr>", desc = "Search Sessions" },
      { "<leader>Sd", "<cmd>DeleteSession<cr>", desc = "Delete Session" },
    },
    config = function()
      require("session-lens").setup({
        path_display = { "shorten" },
        theme_conf = { border = true },
        previewer = false,
      })
      require("telescope").load_extension("session-lens")
    end,
  },

  -- ⛧ AUTO SESSION ⛧
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = false,
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = nil,
        auto_session_create_enabled = nil,
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      })
    end,
  },

  -- ⛧ TMUX INTEGRATION ⛧
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- ⛧ TERMINAL ENHANCEMENTS ⛧
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
} 