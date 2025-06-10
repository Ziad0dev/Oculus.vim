-- ⸸ OCULUS VIM KEYMAPS ⸸
-- The All-Seeing Eye's Bindings - Enhanced Beyond vim.reaper

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ⛧ BASIC ESCAPES ⛧
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })
keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("t", "kj", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ⛧ CLEAR HIGHLIGHTS ⛧
keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })

-- ⛧ BETTER DEFAULTS ⛧
keymap.set("n", "x", '"_x', { desc = "Delete without copying" })
keymap.set("v", "p", '"_dP', { desc = "Paste without copying" })
keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- ⛧ NAVIGATION - ENHANCED ⛧
-- Window navigation (same as vim.reaper but enhanced)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Smart window resizing
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Smart splits (enhanced from vim.reaper)
keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- ⛧ BUFFER MANAGEMENT - ENHANCED ⛧
keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bb", ":e #<CR>", { desc = "Switch to last buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })
keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New buffer" })
keymap.set("n", "<leader>ba", ":%bd|e#<CR>", { desc = "Delete all buffers but current" })

-- ⛧ BETTER TEXT MANIPULATION ⛧
-- Move lines up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Center screen on navigation
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- ⛧ FILE OPERATIONS ⛧
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>W", ":wa<CR>", { desc = "Save all files" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })
keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- ⛧ SEARCH AND REPLACE ⛧
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })
keymap.set("v", "<leader>s", ":s/\\%V", { desc = "Replace in selection" })

-- ⛧ FILE EXPLORER ⛧
keymap.set("n", "<F7>", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus file explorer" })
keymap.set("n", "<leader>E", ":Neotree reveal<CR>", { desc = "Reveal current file" })

-- ⛧ TELESCOPE - ENHANCED BEYOND VIM.REAPER ⛧
-- File finding
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Find help" })
keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Find word under cursor" })
keymap.set("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Find commands" })
keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Find keymaps" })
keymap.set("n", "<leader>fs", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })

-- Git telescope
keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })
keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status" })

-- LSP telescope
keymap.set("n", "gr", ":Telescope lsp_references<CR>", { desc = "LSP references" })
keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
keymap.set("n", "gi", ":Telescope lsp_implementations<CR>", { desc = "LSP implementations" })
keymap.set("n", "gt", ":Telescope lsp_type_definitions<CR>", { desc = "LSP type definitions" })

-- ⛧ GIT - ENHANCED BEYOND VIM.REAPER ⛧
keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
keymap.set("n", "<leader>gl", ":LazyGitCurrentFile<CR>", { desc = "LazyGit current file" })
keymap.set("n", "<leader>gn", ":Neogit<CR>", { desc = "Neogit" })
keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open diffview" })
keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = "Close diffview" })
keymap.set("n", "<leader>gh", ":DiffviewFileHistory<CR>", { desc = "File history" })

-- Git hunks
keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>", { desc = "Blame line" })

-- ⛧ DOCKER ⛧
keymap.set("n", "<leader>ld", function() require("lazydocker").toggle() end, { desc = "LazyDocker" })

-- ⛧ LSP - ENHANCED ⛧
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

-- ⛧ TERMINAL - ENHANCED ⛧
keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle terminal" })
keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Float terminal" })
keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Horizontal terminal" })
keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", { desc = "Vertical terminal" })

-- ⛧ DEBUGGING ⛧
keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dc", ":DapContinue<CR>", { desc = "Debug continue" })
keymap.set("n", "<leader>di", ":DapStepInto<CR>", { desc = "Debug step into" })
keymap.set("n", "<leader>do", ":DapStepOver<CR>", { desc = "Debug step over" })
keymap.set("n", "<leader>dO", ":DapStepOut<CR>", { desc = "Debug step out" })
keymap.set("n", "<leader>dr", ":DapRepl<CR>", { desc = "Debug REPL" })
keymap.set("n", "<leader>du", ":DapUiToggle<CR>", { desc = "Debug UI toggle" })

-- ⛧ EXTRAS - OCULUS ENHANCEMENTS ⛧
-- Quick fix list
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix" })
keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
keymap.set("n", "[q", ":cprev<CR>", { desc = "Previous quickfix" })

-- Location list
keymap.set("n", "<leader>lo", ":lopen<CR>", { desc = "Open location list" })
keymap.set("n", "<leader>lc", ":lclose<CR>", { desc = "Close location list" })
keymap.set("n", "]l", ":lnext<CR>", { desc = "Next location" })
keymap.set("n", "[l", ":lprev<CR>", { desc = "Previous location" })

-- Zen mode
keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Toggle zen mode" })

-- Format
keymap.set("n", "<leader>mp", function() require("conform").format() end, { desc = "Format buffer" })

-- Trouble
keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Toggle trouble" })
keymap.set("n", "<leader>xd", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Document diagnostics" })
keymap.set("n", "<leader>xs", ":Trouble symbols toggle<CR>", { desc = "Symbols trouble" })

-- Sessions
keymap.set("n", "<leader>Ss", ":SessionSave<CR>", { desc = "Save session" })
keymap.set("n", "<leader>Sr", ":SessionRestore<CR>", { desc = "Restore session" })

-- Comments (enhanced)
keymap.set("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- Multiple cursors
keymap.set("n", "<C-n>", "<Plug>(VM-Find-Under)", { desc = "Multi cursor find under" })
keymap.set("v", "<C-n>", "<Plug>(VM-Find-Subword-Under)", { desc = "Multi cursor find subword" })

-- Markdown preview (enhanced)
keymap.set("n", "<leader>md", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })

-- Table mode
keymap.set("n", "<leader>tm", ":TableModeToggle<CR>", { desc = "Toggle table mode" })

-- Translate
keymap.set("n", "<leader>tr", ":Translate<CR>", { desc = "Translate" })
keymap.set("v", "<leader>tr", ":Translate<CR>", { desc = "Translate selection" }) 