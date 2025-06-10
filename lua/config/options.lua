-- ⸸ OCULUS VIM OPTIONS ⸸
-- Enhanced beyond vim.reaper defaults

local opt = vim.opt

-- ⛧ APPEARANCE ⛧
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true     -- Highlight current line
opt.termguicolors = true  -- Enable 24-bit colors
opt.background = "dark"   -- Dark background
opt.signcolumn = "yes"    -- Always show sign column
opt.colorcolumn = "80"    -- Show column at 80 chars
opt.cmdheight = 1         -- Command line height
opt.pumheight = 10        -- Popup menu height
opt.showmode = false      -- Don't show mode (we have statusline)
opt.conceallevel = 0      -- Don't hide characters
opt.wrap = false          -- Don't wrap lines
opt.scrolloff = 8         -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- ⛧ INDENTATION ⛧
opt.tabstop = 2           -- Tab width
opt.shiftwidth = 2        -- Indent width
opt.expandtab = true      -- Use spaces instead of tabs
opt.smartindent = true    -- Smart indentation
opt.autoindent = true     -- Auto indentation
opt.breakindent = true    -- Indent wrapped lines

-- ⛧ SEARCH ⛧
opt.hlsearch = true       -- Highlight search matches
opt.incsearch = true      -- Incremental search
opt.ignorecase = true     -- Ignore case in search
opt.smartcase = true      -- Unless uppercase is used

-- ⛧ EDITING ⛧
opt.mouse = "a"           -- Enable mouse in all modes
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true       -- Persistent undo
opt.undolevels = 10000    -- Maximum undo levels
opt.backup = false        -- No backup files
opt.writebackup = false   -- No backup during write
opt.swapfile = false      -- No swap files
opt.timeoutlen = 300      -- Key timeout
opt.updatetime = 250      -- Faster completion

-- ⛧ SPLITS ⛧
opt.splitbelow = true     -- Split below
opt.splitright = true     -- Split right

-- ⛧ COMPLETION ⛧
opt.completeopt = "menu,menuone,noselect" -- Better completion
opt.shortmess:append("c") -- Don't show completion messages

-- ⛧ PERFORMANCE ⛧
opt.lazyredraw = false    -- Don't lazy redraw
opt.synmaxcol = 300      -- Max syntax highlight column
opt.ttyfast = true       -- Fast terminal

-- ⛧ FOLDING ⛧
opt.foldmethod = "expr"   -- Use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false    -- Don't fold by default
opt.foldlevel = 99        -- High fold level

-- ⛧ WILDMENU ⛧
opt.wildmode = "longest:full,full" -- Better tab completion
opt.wildignore:append { "*.o", "*.obj", "*.pyc", "*.class" }

-- ⛧ SESSION ⛧
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- ⛧ SPECIAL CHARACTERS ⛧
opt.list = true
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  trail = "⸸",
  extends = "⛧",
  precedes = "☠",
  nbsp = "·"
}

-- ⛧ GREP ⛧
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case --follow"
end

-- ⛧ SPELLING ⛧
opt.spell = false         -- Disable spell check by default
opt.spelllang = "en_us"   -- English US

-- ⛧ DIFF ⛧
opt.diffopt:append("vertical,filler,internal,algorithm:histogram,indent-heuristic")

-- ⛧ DISABLE PROVIDERS (Performance) ⛧
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0 