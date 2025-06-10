-- ⸸ OCULUS VIM EXPLORER ⸸
-- The All-Seeing Eye's File Navigator

return {
  -- ⛧ NEO-TREE FILE EXPLORER ⛧
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<F7>", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
      { "<leader>e", "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
      { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal in Explorer" },
      { "<leader>be", "<cmd>Neotree buffers<cr>", desc = "Buffer Explorer" },
      { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git Explorer" },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    config = function()
      local icons = {
        diagnostics = {
          Error = "☠",
          Warn = "⛧",
          Hint = "⸸",
          Info = "👁",
        },
        git = {
          unstaged = "⛧",
          staged = "⸸",
          unmerged = "👁",
          renamed = "➜",
          untracked = "☠",
          deleted = "✖",
          ignored = "◌",
        },
        folder = {
          arrow_open = "👁",
          arrow_closed = "⸸",
          default = "📁",
          open = "📂",
          empty = "📁",
          empty_open = "📂",
          symlink = "🔗",
          symlink_open = "🔗",
        },
        default = "📄",
      }

      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = false,
        sort_function = nil,
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = nil,
            expander_collapsed = icons.folder.arrow_closed,
            expander_expanded = icons.folder.arrow_open,
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = icons.folder.default,
            folder_open = icons.folder.open,
            folder_empty = icons.folder.empty,
            default = icons.default,
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "⛧",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = icons.git,
          },
          file_size = {
            enabled = true,
            required_width = 64,
          },
          type = {
            enabled = true,
            required_width = 122,
          },
          last_modified = {
            enabled = true,
            required_width = 88,
          },
          created = {
            enabled = true,
            required_width = 110,
          },
          symlink_target = {
            enabled = false,
          },
        },
        commands = {
          -- ⸸ CUSTOM COMMANDS ⸸
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.api.nvim_command("silent !open -g " .. path)
          end,
          parent_or_close = function(state)
            local node = state.tree:get_node()
            if node:has_children() and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          child_or_open = function(state)
            local node = state.tree:get_node()
            if node:has_children() then
              if not node:is_expanded() then
                state.commands.toggle_node(state)
              else
                if node.type == "file" then
                  state.commands.open(state)
                else
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                end
              end
            else
              state.commands.open(state)
            end
          end,
          copy_selector = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ["BASENAME"] = modify(filename, ":r"),
              ["EXTENSION"] = modify(filename, ":e"),
              ["FILENAME"] = filename,
              ["PATH (CWD)"] = modify(filepath, ":."),
              ["PATH (HOME)"] = modify(filepath, ":~"),
              ["PATH"] = filepath,
              ["URI"] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ""
            end, vim.tbl_keys(vals))
            if vim.tbl_isempty(options) then
              vim.notify("No values to copy", vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = "Choose to copy to clipboard:",
              format_item = function(item)
                return ("%s: %s"):format(item, vals[item])
              end,
            }, function(choice)
              local result = vals[choice]
              if result then
                vim.notify(("Copied: `%s`"):format(result))
                vim.fn.setreg("+", result)
              end
            end)
          end,
          find_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files({
              cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
            })
          end,
        },
        window = {
          position = "left",
          width = 35,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"] = "child_or_open",
            ["h"] = "parent_or_close",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              config = {
                show_path = "none"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
            ["O"] = "system_open",
            ["Y"] = "copy_selector",
            ["F"] = "find_in_dir",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              ".DS_Store",
              "thumbs.db"
            },
            hide_by_pattern = {
              "*.meta",
              "*/src/*/tsconfig.json",
            },
            always_show = {
              ".gitignored"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
            never_show_by_pattern = {
              ".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = false,
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          },
          commands = {}
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          }
        }
      })

      -- ⸸ CUSTOM HIGHLIGHTS ⸸
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#d65d0e" })
      vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#d65d0e" })
      vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#689d6a" })
      vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#504945" })
      vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#fe8019", bold = true })
      vim.api.nvim_set_hl(0, "NeoTreeModified", { fg = "#d79921" })
    end,
  },

  -- ⛧ OIL FILE MANAGER ⛧
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil" },
      { "<leader>O", "<cmd>Oil --float<cr>", desc = "Open Oil (float)" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        default_file_explorer = false,
        restore_win_options = true,
        skip_confirm_for_simple_edits = false,
        delete_to_trash = false,
        trash_command = "trash-put",
        prompt_save_on_select_new_entry = true,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, bufnr)
            return false
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          override = function(conf)
            return conf
          end,
        },
        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
      })
    end,
  },

  -- ⛧ RANGER INTEGRATION ⛧
  {
    "kelly-lin/ranger.nvim",
    cmd = { "Ranger", "RangerCurrentFile" },
    keys = {
      { "<leader>rf", "<cmd>Ranger<cr>", desc = "Open Ranger" },
      { "<leader>rc", "<cmd>RangerCurrentFile<cr>", desc = "Ranger Current File" },
    },
    config = function()
      require("ranger-nvim").setup({
        enable_cmds = false,
        replace_netrw = false,
        keybinds = {
          ["ov"] = require("ranger-nvim").OPEN_MODE.vsplit,
          ["oh"] = require("ranger-nvim").OPEN_MODE.split,
          ["ot"] = require("ranger-nvim").OPEN_MODE.tabedit,
          ["or"] = require("ranger-nvim").OPEN_MODE.rifle,
        },
        ui = {
          border = "rounded",
          height = 1,
          width = 1,
          x = 0.5,
          y = 0.5,
        }
      })
    end,
  },
} 