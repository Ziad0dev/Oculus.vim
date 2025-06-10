-- ⸸ OCULUS VIM COMPLETION ⸸
-- The All-Seeing Eye's Intelligence Engine

return {
  -- ⛧ COMPLETION ENGINE ⛧
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "ray-x/cmp-treesitter",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- ⸸ HELPER FUNCTIONS ⸸
      local function has_words_before()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local function feedkey(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      -- ⸸ KIND ICONS ⸸
      local kind_icons = {
        Text = "📄",
        Method = "⸸",
        Function = "👁",
        Constructor = "🏗️",
        Field = "⛧",
        Variable = "💀",
        Class = "🎭",
        Interface = "🔮",
        Module = "📦",
        Property = "🔧",
        Unit = "📏",
        Value = "💎",
        Enum = "📊",
        Keyword = "🔑",
        Snippet = "✂️",
        Color = "🎨",
        File = "📁",
        Reference = "📖",
        Folder = "📂",
        EnumMember = "🏷️",
        Constant = "⚡",
        Struct = "🏛️",
        Event = "⚡",
        Operator = "⚙️",
        TypeParameter = "📝",
      }

      -- ⸸ COMPLETION SETUP ⸸
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            
            -- Source names
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              emoji = "[Emoji]",
              spell = "[Spell]",
              calc = "[Calc]",
              treesitter = "[TS]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "nvim_lua", priority = 500 },
          { name = "treesitter", priority = 300 },
        }, {
          { name = "buffer", priority = 250, keyword_length = 3 },
          { name = "path", priority = 200 },
          { name = "emoji", priority = 100 },
          { name = "calc", priority = 50 },
          { name = "spell", priority = 10, keyword_length = 4 },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
          }),
        },
      })

      -- ⸸ COMMAND LINE COMPLETION ⸸
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- ⸸ CUSTOM HIGHLIGHTS ⸸
      vim.api.nvim_set_hl(0, "CmpGhostText", { fg = "#928374", italic = true })
      vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "#1d2021" })
      vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#d65d0e" })
      vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#1d2021" })
      vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#689d6a" })
    end,
  },

  -- ⛧ SNIPPETS ⛧
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      -- ⸸ CUSTOM SNIPPETS ⸸
      local s = luasnip.snippet
      local t = luasnip.text_node
      local i = luasnip.insert_node
      local f = luasnip.function_node

      -- Lua snippets
      luasnip.add_snippets("lua", {
        s("oculus", {
          t("-- ⸸ OCULUS VIM ⸸"),
          t({"", "-- "}), i(1, "Description"),
          t({"", "", ""}), i(0)
        }),
        s("fn", {
          t("local function "), i(1, "name"), t("("), i(2), t(")"),
          t({"", "  "}), i(0),
          t({"", "end"})
        }),
      })

      -- JavaScript/TypeScript snippets
      luasnip.add_snippets("javascript", {
        s("oculus", {
          t("// ⸸ OCULUS VIM ⸸"),
          t({"", "// "}), i(1, "Description"),
          t({"", "", ""}), i(0)
        }),
        s("afn", {
          t("const "), i(1, "name"), t(" = async ("), i(2), t(") => {"),
          t({"", "  "}), i(0),
          t({"", "};"})
        }),
      })

      luasnip.add_snippets("typescript", {
        s("oculus", {
          t("// ⸸ OCULUS VIM ⸸"),
          t({"", "// "}), i(1, "Description"),
          t({"", "", ""}), i(0)
        }),
      })

      -- Python snippets
      luasnip.add_snippets("python", {
        s("oculus", {
          t("# ⸸ OCULUS VIM ⸸"),
          t({"", "# "}), i(1, "Description"),
          t({"", "", ""}), i(0)
        }),
        s("main", {
          t("def main():"),
          t({"", "    "}), i(1, "pass"),
          t({"", "", "", "if __name__ == '__main__':"}),
          t({"", "    main()"})
        }),
      })

      -- HTML snippets
      luasnip.add_snippets("html", {
        s("html5", {
          t("<!DOCTYPE html>"),
          t({"", "<html lang=\"en\">"}),
          t({"", "<head>"}),
          t({"", "    <meta charset=\"UTF-8\">"}),
          t({"", "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"}),
          t({"", "    <title>"}), i(1, "Document"), t("</title>"),
          t({"", "</head>"}),
          t({"", "<body>"}),
          t({"", "    "}), i(0),
          t({"", "</body>"}),
          t({"", "</html>"})
        }),
      })

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- ⛧ AUTOPAIRS ⛧
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      -- Integration with nvim-cmp
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ⛧ AI COMPLETION ⛧
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.g.codeium_disable_bindings = 1
      
      -- ⸸ CUSTOM KEYMAPS ⸸
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
      
      -- ⸸ TOGGLE COMMAND ⸸
      vim.keymap.set("n", "<leader>ua", function()
        if vim.g.codeium_enabled == false then
          vim.cmd("CodeiumEnable")
          vim.notify("Codeium enabled", vim.log.levels.INFO)
        else
          vim.cmd("CodeiumDisable")
          vim.notify("Codeium disabled", vim.log.levels.INFO)
        end
      end, { desc = "Toggle Codeium" })
    end,
  },
} 