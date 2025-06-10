# ⸸ OCULUS VIM ⸸
## The All-Seeing Eye of Development
### *Enhanced Neovim Configuration Beyond vim.reaper*

---

> **⛧ May your code see through the darkness ⛧**

Oculus Vim is a comprehensive, modern Neovim configuration that surpasses vim.reaper with cutting-edge features, better performance, and an enhanced development experience. Built with Lua and featuring the latest plugins from the Neovim ecosystem.

## ⸸ Features

###  **Visual Excellence**
- **Multiple Premium Themes**: Gruvbox Material, Tokyonight, Catppuccin, Nord, and more
- **Enhanced UI**: Modern statusline with Lualine, beautiful dashboard with Alpha
- **Occult Aesthetic**: Custom icons and symbols throughout the interface
- **Rainbow Delimiters**: Color-coded bracket matching
- **Smooth Animations**: Transition effects and scrolling

### **Powerful Search & Navigation**
- **Telescope**: Advanced fuzzy finder with custom pickers
- **Flash**: Lightning-fast navigation and jumping
- **File Browser**: Multiple file managers (Neo-tree, Oil, Ranger)
- **Project Management**: Session management and workspace navigation

###  **Language Intelligence**
- **Native LSP**: Built-in Language Server Protocol support
- **Mason**: Automatic LSP server installation and management
- **Treesitter**: Advanced syntax highlighting and text objects
- **Completion**: Intelligent autocompletion with nvim-cmp
- **AI Integration**: Codeium for AI-powered code suggestions

###  **Git Integration**
- **LazyGit**: Full-featured Git interface
- **Neogit**: Modern Git porcelain
- **Diffview**: Advanced diff viewing and merging
- **Gitsigns**: Inline Git status and blame
- **Git Worktree**: Multi-branch development support

###  **Terminal & Development**
- **ToggleTerm**: Multiple terminal instances and configurations
- **Custom Terminals**: Specialized terminals for LazyGit, LazyDocker, Python, Node
- **Session Management**: Automatic session saving and restoration
- **Tmux Integration**: Seamless navigation between vim and tmux

###  **Enhanced Editing**
- **Smart Pairs**: Intelligent bracket and quote pairing
- **Surround**: Easy manipulation of surrounding characters
- **Comments**: Smart commenting with treesitter integration
- **Text Objects**: Advanced text object selection
- **Multi-cursor**: Multiple cursor editing support

###  **Developer Tools**
- **Trouble**: Beautiful diagnostics and quickfix lists
- **TODO Comments**: Highlight and navigate TODO/FIXME comments
- **Which-key**: Interactive keybinding help
- **Zen Mode**: Distraction-free writing environment
- **Debugging**: Built-in debugging support

##  Installation

### Prerequisites
- **Neovim 0.9+** (recommended: latest stable)
- **Git**
- **Node.js** (for LSP servers)
- **Python 3** (for Python development)
- **Ripgrep** (for searching)
- **fd** (for file finding)
- **LazyGit** (optional, for Git integration)
- **LazyDocker** (optional, for Docker management)

### Quick Install

```bash
# Backup existing Neovim configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Clone Oculus Vim
git clone https://github.com/your-username/oculus-vim ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

### Manual Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/oculus-vim ~/.config/oculus-vim
   ```

2. **Create a symlink or copy**:
   ```bash
   ln -s ~/.config/oculus-vim ~/.config/nvim
   # OR
   cp -r ~/.config/oculus-vim ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Install dependencies** (if needed):
   ```bash
   # Install language servers
   :Mason

   # Update all plugins
   :Lazy sync
   ```

##  Key Bindings

### Core Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | Leader | Primary leader key |
| `jk` / `kj` | `<Esc>` | Exit insert mode |
| `<Ctrl-h/j/k/l>` | Navigate | Window navigation |
| `<Tab>` / `<S-Tab>` | Buffer | Next/Previous buffer |

### File Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<F7>` | Neo-tree | Toggle file explorer |
| `<Leader>e` | Explorer | Focus file explorer |
| `<Leader>o` | Oil | Open Oil file manager |
| `<Leader>ff` | Find Files | Telescope file finder |
| `<Leader>fg` | Live Grep | Search in files |
| `<Leader>fb` | Buffers | Buffer picker |

### Git Operations
| Key | Action | Description |
|-----|--------|-------------|
| `<Leader>gg` | LazyGit | Open LazyGit |
| `<Leader>gn` | Neogit | Open Neogit |
| `<Leader>gd` | Diff View | Open diff view |
| `<Leader>gh` | File History | Git file history |
| `<Leader>gs` | Git Status | Git status in Telescope |

### Terminal
| Key | Action | Description |
|-----|--------|-------------|
| `<Ctrl-\>` | Terminal | Toggle floating terminal |
| `<Leader>tf` | Float | Floating terminal |
| `<Leader>th` | Horizontal | Horizontal terminal |
| `<Leader>tv` | Vertical | Vertical terminal |
| `<Leader>tg` | LazyGit | LazyGit terminal |
| `<Leader>tp` | Python | Python REPL |

### LSP & Development
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Definition | Go to definition |
| `gr` | References | Find references |
| `K` | Hover | Show documentation |
| `<Leader>ca` | Code Action | Code actions |
| `<Leader>rn` | Rename | Rename symbol |
| `<Leader>f` | Format | Format buffer |

### Utility
| Key | Action | Description |
|-----|--------|-------------|
| `s` | Flash | Flash jump |
| `<Leader>z` | Zen Mode | Distraction-free mode |
| `<Leader>xx` | Trouble | Toggle diagnostics |
| `<Leader>ft` | TODOs | Find TODO comments |
| `<Leader>` | Which Key | Show keybinding help |

##  Customization

### Changing Themes
Edit `lua/plugins/colorscheme.lua`:

```lua
-- Change the default theme
vim.cmd.colorscheme("tokyonight-night")  -- or gruvbox-material, catppuccin, etc.
```

### Adding Custom Keybindings
Edit `lua/config/keymaps.lua`:

```lua
-- Add your custom keybindings
vim.keymap.set("n", "<leader>custom", ":YourCommand<CR>", { desc = "Your Description" })
```

### Plugin Configuration
Each plugin is configured in its respective file under `lua/plugins/`. Modify these files to customize behavior:

- `lua/plugins/telescope.lua` - Search and navigation
- `lua/plugins/lsp.lua` - Language server configuration
- `lua/plugins/git.lua` - Git integration
- `lua/plugins/ui.lua` - User interface
- `lua/plugins/terminal.lua` - Terminal configuration

##  Advanced Configuration

### LSP Servers
Add new language servers in `lua/plugins/lsp.lua`:

```lua
-- Add to the servers table
your_language_server = {
  settings = {
    -- Server-specific settings
  }
}
```

### Custom Snippets
Add snippets in `lua/plugins/completion.lua`:

```lua
luasnip.add_snippets("your_language", {
  s("trigger", {
    t("Your snippet content")
  })
})
```

### Git Configuration
Customize Git integration in `lua/plugins/git.lua` and set up LazyGit with your preferred settings.

##  Performance

Oculus Vim is optimized for performance with:
- **Lazy Loading**: Plugins load only when needed
- **Startup Time**: ~30-50ms typical startup
- **Memory Usage**: Efficient memory management
- **Async Operations**: Non-blocking file operations

##  Troubleshooting

### Common Issues

1. **Plugins not loading**:
   ```bash
   :Lazy sync
   :Lazy check
   ```

2. **LSP not working**:
   ```bash
   :Mason
   :LspInfo
   :checkhealth
   ```

3. **Treesitter errors**:
   ```bash
   :TSUpdate
   :TSInstall all
   ```

### Getting Help
- Check `:checkhealth` for system diagnostics
- Use `:Lazy` to manage plugins
- Use `:Mason` for LSP servers
- Open an issue on the repository

##  Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)
- [Telescope Guide](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)

##  Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

##  Acknowledgments

- **vim.reaper** - Original inspiration
- **LazyVim** - Modern Neovim configuration patterns
- **Neovim Community** - Amazing plugin ecosystem
- **Gruvbox Material** - Beautiful color scheme

---

## ⸸ The All-Seeing Eye Sees All ⸸

*"In the darkness of code, let Oculus be your guiding light"*

**⛧ Happy Coding from the Abyss ⛧** 
