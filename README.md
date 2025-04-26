# nvim-config 🚀

My Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim) with additional plugins and customizations for enhanced productivity.

## 📦 Install

```sh
git clone https://github.com/joelazar/nvim-config.git ~/.config/nvim
nvim
```

At first run, Neovim will install all necessary plugins, LSPs, formatters, and DAP adapters.

And you are done! 🎉

## ✨ Features

### 🧠 AI Integration

- **Copilot Integration** [`lua/plugins/copilot.lua`](./lua/plugins/copilot.lua) - GitHub Copilot for code suggestions with custom key bindings (`<leader>aT` to toggle)
- **CopilotChat.nvim** [`lua/plugins/copilot-chat.lua`](./lua/plugins/copilot-chat.lua) - Interactive chat interface with Copilot using Claude model (`<leader>ac` prefix)
- **Avante.nvim** [`lua/plugins/avante.lua`](./lua/plugins/avante.lua) - AI assistant for Neovim with multiple LLM providers and chat interface

### 📝 Note Taking & Knowledge Management

- **Obsidian.nvim** [`lua/plugins/obsidian.lua`](./lua/plugins/obsidian.lua) - First-class support for [Obsidian](https://obsidian.md/) vaults (`<leader>z` prefix)

### 📂 File Management

- **Yazi.nvim** [`lua/plugins/yazi.lua`](./lua/plugins/yazi.lua) - Terminal file browser integration (`<leader>y` to toggle)
- **Orphans.nvim** [`lua/plugins/orphans.lua`](./lua/plugins/orphans.lua) - Find orphaned plugins in your configuration
- **Project.nvim** [`lua/plugins/project.lua`](./lua/plugins/project.lua) - Smart project detection for multiple workspaces

### 🧰 Development Tools

- **Go.nvim** [`lua/plugins/go.lua`](./lua/plugins/go.lua) - Enhanced Go development experience
- **SQL Tools** [`lua/plugins/conform.lua`](./lua/plugins/conform.lua) & [`lua/plugins/lint-sql.lua`](./lua/plugins/lint-sql.lua) - SQL formatting and linting with sqlfluff
- **Rust Tools** - Rustaceanvim for Rust development
- **Git Enhancements**:
  - **Diffview** [`lua/plugins/diffview.lua`](./lua/plugins/diffview.lua) - Enhanced diff viewing
  - **Git blame** [`lua/plugins/blame.lua`](./lua/plugins/blame.lua) - Inline git blame information
- **Text-case.nvim** [`lua/plugins/text-case.lua`](./lua/plugins/text-case.lua) - Case conversion utilities
- **Blink.cmp** [`lua/plugins/blink.lua`](./lua/plugins/blink.lua) - Enhanced auto-completion with multiple sources
- **Snacks.nvim** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - Clean dashboard, file picker, and workspace management

### 🎨 UI Enhancements

- **Tokyo Night** [`lua/plugins/tokyonight.lua`](./lua/plugins/tokyonight.lua) - Modern dark theme with customizations
- **Bufferline** [`lua/plugins/bufferline.lua`](./lua/plugins/bufferline.lua) - Stylish buffer management with custom keymaps
- **Lualine Customizations**:
  - **Copilot Status** [`lua/plugins/lualine-copilot.lua`](./lua/plugins/lualine-copilot.lua) - Shows Copilot status in statusline
  - **Word Count** [`lua/plugins/lualine-wordcount.lua`](./lua/plugins/lualine-wordcount.lua) - Displays word count in text files

## ⚙️ Custom Configuration

### Core Files

- **Main Neovim options** [`lua/config/options.lua`](./lua/config/options.lua) - Sets up Neovim behavior
- **Key mappings** [`lua/config/keymaps.lua`](./lua/config/keymaps.lua) - Custom keyboard shortcuts
- **Auto commands** [`lua/config/autocmds.lua`](./lua/config/autocmds.lua) - Custom automated behaviors
- **Lazy plugin manager** [`lua/config/lazy.lua`](./lua/config/lazy.lua) - Plugin setup and management
- **Utility functions** [`lua/config/utils.lua`](./lua/config/utils.lua) - Helper functions including sudo write

### Key Customizations

This config modifies several LazyVim defaults (see [`lua/config/keymaps.lua`](./lua/config/keymaps.lua)):

- `Q` - Close window instead of entering Ex mode
- `gy`, `gp` - System clipboard operations
- `<C-S>` - Save file
- `<C-d>`, `<C-u>` - Better page navigation with centering
- Smart `dd` that preserves your last yank when deleting empty lines
- `<CMD>+j` - Toggle terminal in current directory

### Additional Features

- **Sudo Integration** [`lua/config/utils.lua`](./lua/config/utils.lua) - Write with sudo privileges (`<leader>W`)
- **Wrapped Lines** [`lua/config/keymaps.lua`](./lua/config/keymaps.lua) - Comfortable navigation in wrapped text files
- **Custom Spell Checking** [`lua/config/autocmds.lua`](./lua/config/autocmds.lua) - Targeted spell checking for specific file types
- **Absolute Line Numbers** [`lua/config/options.lua`](./lua/config/options.lua) - Uses absolute instead of relative line numbers
- **Clipboard Handling** [`lua/config/options.lua`](./lua/config/options.lua) - Doesn't use system clipboard by default for better control

## 📋 [LazyVim Extras](https://www.lazyvim.org/extras)

This configuration includes numerous LazyVim extras (see [`lazyvim.json`](./lazyvim.json)):

- **AI**: copilot, copilot-chat
- **Coding**: mini-surround, yanky
- **DAP**: core, nlua
- **Editor**: dial, inc-rename, overseer, snacks_explorer, snacks_picker
- **Formatting**: black, prettier
- **Languages**: ansible, docker, git, go, json, markdown, python, rust, tailwind, terraform, toml, typescript, yaml, zig
- **Linting**: eslint
- **Testing**: core
- **Utilities**: chezmoi, dot, mini-hipatterns, octo, project, rest, vscode

## 🔧 File Structure

- `init.lua` - Entry point that loads the configuration
- `lua/config/` - Core configuration files
- `lua/plugins/` - Custom plugin configurations
- `stylua.toml` - Formatting rules for Lua files

## 🎨 Theme

Using [Tokyo Night](https://github.com/folke/tokyonight.nvim) with the "night" style for a clean, modern look. See [`lua/plugins/tokyonight.lua`](./lua/plugins/tokyonight.lua) for configuration.
