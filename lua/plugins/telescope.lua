-- ⸸ OCULUS VIM TELESCOPE ⸸
-- The All-Seeing Eye's Search Powers

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      telescope.setup({
        defaults = {
          prompt_prefix = "⸸ ",
          selection_caret = "👁 ",
          entry_prefix = "  ",
          multi_icon = "⛧",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.npm/",
            "__pycache__/",
            "%.pyc",
            "%.pyo",
            "%.pyd",
            "%.so",
            "%.dylib",
            "%.zip",
            "%.tar%.gz",
            "%.tar%.bz2",
            "%.rar",
            "%.tar%.xz",
            "%.o",
            "%.a",
            "%.class",
            "%.pdf",
            "%.mkv",
            "%.mp4",
            "%.zip"
          },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            only_sort_text = true,
            theme = "ivy",
          },
          grep_string = {
            only_sort_text = true,
            theme = "ivy",
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          planets = {
            show_pluto = true,
            show_moon = true,
          },
          colorscheme = {
            enable_preview = true,
          },
          lsp_references = {
            theme = "ivy",
            initial_mode = "normal",
          },
          lsp_definitions = {
            theme = "ivy",
            initial_mode = "normal",
          },
          lsp_declarations = {
            theme = "ivy",
            initial_mode = "normal",
          },
          lsp_implementations = {
            theme = "ivy",
            initial_mode = "normal",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              winblend = 10,
              border = true,
              previewer = false,
              shorten_path = false,
            }),
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<A-c>"] = require("telescope").extensions.file_browser.actions.create,
                ["<A-r>"] = require("telescope").extensions.file_browser.actions.rename,
                ["<A-m>"] = require("telescope").extensions.file_browser.actions.move,
                ["<A-y>"] = require("telescope").extensions.file_browser.actions.copy,
                ["<A-d>"] = require("telescope").extensions.file_browser.actions.remove,
                ["<C-o>"] = require("telescope").extensions.file_browser.actions.open,
                ["<C-g>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["<C-e>"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
                ["<C-w>"] = require("telescope").extensions.file_browser.actions.goto_cwd,
                ["<C-t>"] = require("telescope").extensions.file_browser.actions.change_cwd,
                ["<C-f>"] = require("telescope").extensions.file_browser.actions.toggle_browser,
                ["<C-h>"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
                ["<C-s>"] = require("telescope").extensions.file_browser.actions.toggle_all,
              },
              ["n"] = {
                ["c"] = require("telescope").extensions.file_browser.actions.create,
                ["r"] = require("telescope").extensions.file_browser.actions.rename,
                ["m"] = require("telescope").extensions.file_browser.actions.move,
                ["y"] = require("telescope").extensions.file_browser.actions.copy,
                ["d"] = require("telescope").extensions.file_browser.actions.remove,
                ["o"] = require("telescope").extensions.file_browser.actions.open,
                ["g"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
                ["e"] = require("telescope").extensions.file_browser.actions.goto_home_dir,
                ["w"] = require("telescope").extensions.file_browser.actions.goto_cwd,
                ["t"] = require("telescope").extensions.file_browser.actions.change_cwd,
                ["f"] = require("telescope").extensions.file_browser.actions.toggle_browser,
                ["h"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
                ["s"] = require("telescope").extensions.file_browser.actions.toggle_all,
              },
            },
          },
          project = {
            base_dirs = {
              "~/projects",
              "~/work",
              "~/.config",
            },
            hidden_files = true,
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true,
          },
        },
      })

      -- ⸸ LOAD EXTENSIONS ⸸
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("notify")

      -- ⸸ CUSTOM PICKERS ⸸
      local M = {}

      -- Oculus colorscheme picker
      M.colorscheme = function()
        local builtin = require("telescope.builtin")
        builtin.colorscheme(require("telescope.themes").get_dropdown({
          winblend = 10,
          border = true,
          previewer = false,
          shorten_path = false,
        }))
      end

      -- Enhanced grep with word boundaries
      M.grep_word = function()
        local builtin = require("telescope.builtin")
        builtin.grep_string({
          search = vim.fn.expand("<cword>"),
          use_regex = true,
          word_match = "-w",
        })
      end

      -- Search in current buffer
      M.current_buffer_fuzzy_find = function()
        local builtin = require("telescope.builtin")
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end

      -- Project-wide TODO/FIXME finder
      M.find_todos = function()
        local builtin = require("telescope.builtin")
        builtin.grep_string({
          prompt_title = "⸸ Find TODOs ⸸",
          search = "(TODO|FIXME|NOTE|HACK|BUG|XXX):",
          use_regex = true,
        })
      end

      -- Git status with custom actions
      M.git_status = function()
        local builtin = require("telescope.builtin")
        builtin.git_status(require("telescope.themes").get_ivy({
          layout_config = {
            height = 0.4,
          },
        }))
      end

      -- Expose custom pickers
      _G.telescope_oculus = M
    end,
    keys = {
      -- ⸸ FILE SEARCH ⸸
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word" },
      { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Search" },
      { "<leader>ft", "<cmd>lua telescope_oculus.find_todos()<cr>", desc = "Find TODOs" },
      
      -- ⸸ GIT SEARCH ⸸
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
      { "<leader>gs", "<cmd>lua telescope_oculus.git_status()<cr>", desc = "Git Status" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      
      -- ⸸ LSP SEARCH ⸸
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
      { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
      
      -- ⸸ UTILITIES ⸸
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
      { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>fz", "<cmd>lua telescope_oculus.colorscheme()<cr>", desc = "Colorschemes" },
      
      -- ⸸ EXTENSIONS ⸸
      { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      { "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
      { "<leader>sy", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
    },
  },
} 