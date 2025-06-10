-- ⸸ OCULUS VIM AUTOCMDS ⸸
-- The All-Seeing Eye's Automatic Behaviors

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ⛧ HIGHLIGHT ON YANK ⛧
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- ⛧ RESIZE SPLITS ⛧
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- ⛧ GO TO LAST LOCATION ⛧
augroup("LastPosition", { clear = true })
autocmd("BufReadPost", {
  group = "LastPosition",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ⛧ CLOSE WITH Q ⛧
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ⛧ CHECK IF FILE CHANGED ⛧
augroup("CheckTime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = "CheckTime",
  command = "checktime",
})

-- ⛧ AUTO CREATE DIRS ⛧
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoCreateDir",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ⛧ TERMINAL SETTINGS ⛧
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = "TerminalSettings",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    vim.cmd("startinsert")
  end,
})

-- ⛧ LARGE FILE HANDLING ⛧
augroup("LargeFile", { clear = true })
autocmd("BufReadPre", {
  group = "LargeFile",
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 1024 * 1024 then -- 1MB
      vim.b[args.buf].large_file = true
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
      vim.opt_local.breakindent = false
      vim.opt_local.colorcolumn = ""
      vim.opt_local.statuscolumn = ""
      vim.opt_local.signcolumn = "no"
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.winbar = ""
      autocmd("BufReadPost", {
        once = true,
        buffer = args.buf,
        callback = function()
          vim.opt_local.syntax = ""
          return true
        end,
      })
    end
  end,
})

-- ⛧ WRAP AND SPELL IN TEXT FILETYPES ⛧
augroup("WrapSpell", { clear = true })
autocmd("FileType", {
  group = "WrapSpell",
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- ⛧ FIX CONCEALLEVEL FOR JSON ⛧
augroup("JsonConceal", { clear = true })
autocmd("FileType", {
  group = "JsonConceal",
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- ⛧ AUTO SAVE ⛧
augroup("AutoSave", { clear = true })
autocmd({ "BufLeave", "FocusLost" }, {
  group = "AutoSave",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent update")
    end
  end,
})

-- ⛧ COLORSCHEME FIXES ⛧
augroup("ColorschemeOverrides", { clear = true })
autocmd("ColorScheme", {
  group = "ColorschemeOverrides",
  callback = function()
    -- Make sure diff colors are visible
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#26332c" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#273842" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#572E33" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#314753" })
  end,
})

-- ⛧ SMART PASTE ⛧
augroup("SmartPaste", { clear = true })
autocmd("InsertEnter", {
  group = "SmartPaste",
  callback = function()
    vim.opt.paste = false
  end,
})

-- ⛧ NEOTREE AUTO CLOSE ⛧
augroup("NeotreeAutoClose", { clear = true })
autocmd("BufEnter", {
  group = "NeotreeAutoClose",
  callback = function()
    if #vim.api.nvim_list_wins() == 1 then
      local buf = vim.api.nvim_get_current_buf()
      local buftype = vim.api.nvim_buf_get_option(buf, "filetype")
      if buftype == "neo-tree" then
        vim.cmd("quit")
      end
    end
  end,
})

-- ⛧ LSP ATTACH SETTINGS ⛧
augroup("LspAttach", { clear = true })
autocmd("LspAttach", {
  group = "LspAttach",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    
    -- Enable inlay hints if supported
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(event.buf, true)
    end
    
    -- Enable document highlight if supported
    if client and client.server_capabilities.documentHighlightProvider then
      local group = augroup("LspDocumentHighlight", { clear = false })
      autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- ⛧ FORMAT ON SAVE ⛧
augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = "FormatOnSave",
  callback = function(args)
    if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
      return
    end
    
    -- Format with conform if available
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ 
        bufnr = args.buf,
        lsp_fallback = true,
        quiet = true,
      })
    else
      -- Fallback to LSP formatting
      vim.lsp.buf.format({
        bufnr = args.buf,
        filter = function(client)
          return client.name ~= "tsserver" and client.name ~= "lua_ls"
        end,
      })
    end
  end,
})

-- ⛧ DIAGNOSTIC CONFIGURATION ⛧
augroup("DiagnosticConfig", { clear = true })
autocmd("VimEnter", {
  group = "DiagnosticConfig",
  once = true,
  callback = function()
    vim.diagnostic.config({
      virtual_text = {
        prefix = "⸸",
        source = "always",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
    
    -- Custom diagnostic signs
    local signs = { Error = "☠", Warn = "⛧", Hint = "⸸", Info = "👁" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
})

-- ⛧ QUICKFIX ENHANCEMENTS ⛧
augroup("QuickfixEnhancements", { clear = true })
autocmd("QuickFixCmdPost", {
  group = "QuickfixEnhancements",
  pattern = "[^l]*",
  command = "cwindow",
})
autocmd("QuickFixCmdPost", {
  group = "QuickfixEnhancements",
  pattern = "l*",
  command = "lwindow",
})

-- ⛧ STARTIFY ENHANCEMENT ⛧
augroup("StartifyEnhancement", { clear = true })
autocmd("User", {
  group = "StartifyEnhancement",
  pattern = "StartifyReady",
  callback = function()
    vim.cmd("silent! lcd " .. vim.fn.getcwd())
  end,
}) 