-- ⸸ OCULUS VIM TREESITTER ⸸
-- The All-Seeing Eye's Syntax Powers

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        -- ⸸ CORE SETTINGS ⸸
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "dockerfile",
          "fish",
          "gitignore",
          "go",
          "graphql",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "scss",
          "sql",
          "svelte",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},

        -- ⸸ SYNTAX HIGHLIGHTING ⸸
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        -- ⸸ INDENTATION ⸸
        indent = {
          enable = true,
          disable = { "python", "css" },
        },

        -- ⸸ INCREMENTAL SELECTION ⸸
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },

        -- ⸸ TEXT OBJECTS ⸸
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ao"] = "@conditional.outer",
              ["io"] = "@conditional.inner",
              ["ak"] = "@comment.outer",
              ["ik"] = "@comment.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
              ["]o"] = "@conditional.outer",
              ["]l"] = "@loop.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.inner",
              ["]O"] = "@conditional.outer",
              ["]L"] = "@loop.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
              ["[o"] = "@conditional.outer",
              ["[l"] = "@loop.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.inner",
              ["[O"] = "@conditional.outer",
              ["[L"] = "@loop.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        },

        -- ⸸ FOLDING ⸸
        fold = {
          enable = true,
          disable = {},
        },

        -- ⸸ AUTOTAG ⸸
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "astro",
            "glimmer",
            "handlebars",
            "hbs"
          },
        },

        -- ⸸ CONTEXT COMMENTSTRING ⸸
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },

        -- ⸸ RAINBOW DELIMITERS ⸸
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
          colors = {
            "#d65d0e", -- orange
            "#689d6a", -- green
            "#458588", -- blue
            "#b16286", -- purple
            "#cc241d", -- red
            "#d79921", -- yellow
            "#fe8019", -- bright orange
          },
        },
      })

      -- ⸸ FOLDING SETUP ⸸
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- Don't fold by default
    end,
  },

  -- ⸸ TREESITTER CONTEXT ⸸
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = "outer",
      mode = "cursor",
      separator = "⸸",
      zindex = 20,
      on_attach = nil,
    },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },

  -- ⸸ RAINBOW DELIMITERS ⸸
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      -- ⸸ CUSTOM HIGHLIGHT GROUPS ⸸
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#cc241d" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#d79921" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#458588" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#d65d0e" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#689d6a" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#b16286" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#8ec07c" })
    end,
  },

  -- ⸸ SMART SPLIT/JOIN ⸸
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
        check_syntax_error = true,
        max_join_length = 120,
        cursor_behavior = "hold",
        notify = true,
        langs = {
          lua = {
            table_constructor = {
              both = {
                omit = { "trailing_comma" },
              },
            },
          },
          javascript = {
            object = {
              both = {
                omit = { "trailing_comma" },
              },
            },
            array = {
              both = {
                omit = { "trailing_comma" },
              },
            },
          },
        },
      })
    end,
  },

  -- ⸸ ENHANCED SURROUND WITH TREESITTER ⸸
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
        aliases = {
          ["a"] = ">",
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = { '"', "'", "`" },
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
        },
        highlight = {
          duration = 200,
        },
        move_cursor = "begin",
        indent_lines = function(start, stop)
          local b = vim.bo
          -- Only re-indent the selection if a formatter is set up already
          if start < stop and (b.equalprg ~= "" or b.indentexpr ~= "" or b.cindent or b.smartindent or b.lisp) then
            vim.cmd(string.format("silent normal! %dG=%dG", start, stop))
          end
        end,
      })
    end,
  },
} 