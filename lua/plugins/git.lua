-- ⸸ OCULUS VIM GIT ⸸
-- The All-Seeing Eye's Version Control

return {
  -- ⛧ GITSIGNS ⛧
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "⸸" },
          change = { text = "⛧" },
          delete = { text = "☠" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1
        },
        yadm = { enable = false },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next Hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Prev Hunk" })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage Hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset Hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame Line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff This ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
        end,
      })
    end,
  },

  -- ⛧ LAZYGIT ⛧
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gl", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
      { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Filter" },
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1
      vim.g.lazygit_use_custom_config_file_path = 0
    end,
  },

  -- ⛧ NEOGIT ⛧
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Git Pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git Push" },
    },
    config = function()
      require("neogit").setup({
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        disable_builtin_notifications = false,
        auto_refresh = true,
        disable_insert_on_commit = "auto",
        use_magit_keybindings = false,
        commit_popup = {
          kind = "split",
        },
        popup = {
          kind = "split",
        },
        signs = {
          section = { "⸸", "👁" },
          item = { "▸", "▾" },
          hunk = { "⛧", "☠" },
        },
        integrations = {
          telescope = true,
          diffview = true,
        },
        sections = {
          untracked = {
            folded = false
          },
          unstaged = {
            folded = false
          },
          staged = {
            folded = false
          },
          stashes = {
            folded = true
          },
          unpulled = {
            folded = true
          },
          unmerged = {
            folded = false
          },
          recent = {
            folded = true
          },
        },
        mappings = {
          status = {
            ["q"] = "Close",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["<tab>"] = "Toggle",
            ["x"] = "Discard",
            ["s"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["u"] = "Unstage",
            ["U"] = "UnstageStaged",
            ["d"] = "DiffAtFile",
            ["$"] = "CommandHistory",
            ["#"] = "Console",
            ["<c-r>"] = "RefreshBuffer",
            ["<enter>"] = "GoToFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["?"] = "HelpPopup",
          }
        }
      })
    end,
  },

  -- ⛧ DIFFVIEW ⛧
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView Current File History" },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        use_icons = true,
        watch_index = true,
        icons = {
          folder_closed = "⸸",
          folder_open = "👁",
        },
        signs = {
          fold_closed = "⸸",
          fold_open = "👁",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
          },
          file_history = {
            layout = "diff2_horizontal",
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
          },
        },
        commit_log_panel = {
          win_config = {
            position = "bottom",
            height = 16,
          }
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          file_panel = {
            ["j"] = "next_entry",
            ["<down>"] = "next_entry",
            ["k"] = "prev_entry",
            ["<up>"] = "prev_entry",
            ["<cr>"] = "select_entry",
            ["o"] = "select_entry",
            ["<2-LeftMouse>"] = "select_entry",
            ["-"] = "toggle_stage_entry",
            ["S"] = "stage_all",
            ["U"] = "unstage_all",
            ["X"] = "restore_entry",
            ["R"] = "refresh_files",
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["i"] = "listing_style",
            ["f"] = "toggle_flatten_dirs",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          file_history_panel = {
            ["g!"] = "options",
            ["<C-A-d>"] = "open_in_diffview",
            ["y"] = "copy_hash",
            ["L"] = "open_commit_log",
            ["zR"] = "open_all_folds",
            ["zM"] = "close_all_folds",
            ["j"] = "next_entry",
            ["<down>"] = "next_entry",
            ["k"] = "prev_entry",
            ["<up>"] = "prev_entry",
            ["<cr>"] = "select_entry",
            ["o"] = "select_entry",
            ["<2-LeftMouse>"] = "select_entry",
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          option_panel = {
            ["<tab>"] = "select_entry",
            ["q"] = "close",
          },
        },
      })
    end,
  },

  -- ⛧ GIT WORKTREE ⛧
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      { "<leader>gwc", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create Worktree" },
      { "<leader>gws", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "Switch Worktree" },
    },
    config = function()
      require("git-worktree").setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        autopush = false,
      })
      require("telescope").load_extension("git_worktree")
    end,
  },

  -- ⛧ FUGITIVE ⛧
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" },
    keys = {
      { "<leader>gG", "<cmd>Git<cr>", desc = "Git Status" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git Read" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git Write" },
      { "<leader>gq", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },

  -- ⛧ CONVENTIONAL COMMITS ⛧
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },

  -- ⛧ GITLINKER ⛧
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("n") end, desc = "Git Link" },
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("v") end, mode = "v", desc = "Git Link" },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          remote = nil,
          add_current_line_on_normal_mode = true,
          action_callback = require("gitlinker.actions").copy_to_clipboard,
          print_url = true,
        },
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
          ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
          ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
          ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
          ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
          ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
          ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
          ["repo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
          ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
          ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
        },
        mappings = "<leader>gy"
      })
    end,
  },
} 