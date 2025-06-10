-- ⸸ OCULUS VIM ⸸
-- The All-Seeing Eye of Development
-- Enhanced Neovim Configuration Beyond vim.reaper
-- ⛧ May your code see through the darkness ⛧

-- Bootstrap lazy.nvim (modern plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core configurations
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Initialize plugins with lazy.nvim
require("lazy").setup({
  spec = {
    -- Import all plugin specs
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "gruvbox", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}) 