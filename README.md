# nvim-config 🚀

My Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim) with additional plugins and customizations for enhanced productivity.

![dashboard](https://github.com/user-attachments/assets/12d0997a-9869-4825-8b4c-7e399b1d4728)

![which-key](https://github.com/user-attachments/assets/506ccb08-70c1-442e-bed5-a2bd7eeca19f)

![ai](https://github.com/user-attachments/assets/b35889ee-685f-40d5-8fc7-edab76df48c5)

![grep](https://github.com/user-attachments/assets/01e22664-290a-4f6b-a369-365244d15b3e)

## 📦 Install

```sh
git clone https://github.com/joelazar/nvim-config.git ~/.config/nvim
nvim
```

At first run, Neovim will install all necessary plugins, LSPs, formatters, and DAP adapters.

And you are done! 🎉

## ✨ Features

### 🧠 AI & Assistance

- **Copilot Native** [`lazyvim.json`](./lazyvim.json) - GitHub Copilot completions via the LazyVim extra, automatically paused in Markdown buffers for distraction-free writing.
- **Sidekick.nvim** [`lua/plugins/sidekick.lua`](./lua/plugins/sidekick.lua) - Tmux-backed Sidekick CLI bridge with ready-to-use Claude, Copilot, Gemini, and Crush adapters.

### 📝 Writing & Knowledge Management

- **Obsidian.nvim** [`lua/plugins/obsidian.lua`](./lua/plugins/obsidian.lua) - Dual-vault workflow with Blink completion, templates, checkboxes, and a full `<leader>z` command suite.
- **URL → Markdown helper** [`lua/plugins/url-to-markdown.lua`](./lua/plugins/url-to-markdown.lua) - Convert the URL under the cursor into a titled Markdown link with `<D-S-a>`.
- **Word count in Lualine** [`lua/plugins/lualine.lua`](./lua/plugins/lualine.lua) - Live word counts for Markdown, LaTeX, and other writing formats.

### 📂 File & Workspace Navigation

- **Yazi.nvim** [`lua/plugins/yazi.lua`](./lua/plugins/yazi.lua) - Toggle the Yazi terminal file manager (`<leader>y` / `<leader>Y`) without leaving Neovim.
- **Snacks.nvim** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - Dashboard, file picker with filename-first formatting, project-aware sources, and a `<C-p>` shortcut.
- **Project.nvim** [`lua/plugins/project.lua`](./lua/plugins/project.lua) - Automatically switch roots based on Go modules, Git repos, and Obsidian vaults.
- **Orphans.nvim** [`lua/plugins/orphans.lua`](./lua/plugins/orphans.lua) - Spot orphaned files and dead code paths with a single `:Orphans` command.

### 🧰 Development Tools

- **Blink.cmp** [`lua/plugins/blink.lua`](./lua/plugins/blink.lua) - Modern completion engine wired to Git history, dictionary, and a custom calculator source.
- **Go.nvim** [`lua/plugins/go.lua`](./lua/plugins/go.lua) - Extra Go tooling, syntax, and LSP helpers.
- **Mason.nvim** [`lua/plugins/mason.lua`](./lua/plugins/mason.lua) - Ensures `ruff`, `sqlfluff`, and `harper-ls` are ready to go.
- **Conform.nvim & nvim-lint** [`lua/plugins/conform.lua`](./lua/plugins/conform.lua), [`lua/plugins/nvim-lint.lua`](./lua/plugins/nvim-lint.lua) - Formatter and linter setup for SQL, Mojo, Markdown, and more.
- **LSP tuning** [`lua/plugins/lspconfig.lua`](./lua/plugins/lspconfig.lua) - Refined keymaps, enriched `gopls` defaults, optional `harper_ls`, and inc-rename integration.
- **Treesitter** [`lua/plugins/treesitter.lua`](./lua/plugins/treesitter.lua) - Extra parsers for SQL, Go templates, LaTeX, CSS, and comment blocks.
- **Diffview** [`lua/plugins/diffview.lua`](./lua/plugins/diffview.lua) - Merge-ready diff layouts and history views on demand.
- **Blame.nvim** [`lua/plugins/blame.lua`](./lua/plugins/blame.lua) - Toggle inline Git blame annotations with `:BlameToggle`.
- **Text-case.nvim** [`lua/plugins/text-case.lua`](./lua/plugins/text-case.lua) - Fast case conversions for symbols and selections.

### 🎨 UI & Insights

- **Tokyo Night** [`lua/plugins/tokyonight.lua`](./lua/plugins/tokyonight.lua) - Sleek "night" palette tuned for long sessions.
- **Bufferline** [`lua/plugins/bufferline.lua`](./lua/plugins/bufferline.lua) - Minimal tabline with sensible Alt-based navigation and pinning.
- **Snacks UI polish** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - Custom header, trimmed indent guides, and quiet scrolling defaults.
- **Which-key.nvim** [`lua/plugins/which-key.lua`](./lua/plugins/which-key.lua) - Helix-style key-hints with shortcuts for elevated writes.
- **WakaTime** [`lua/plugins/wakatime.lua`](./lua/plugins/wakatime.lua) - Automatic coding activity tracking.

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
- `<leader>us` - Toggle the `harper_ls` grammar assistant

### Additional Features

- **Sudo Integration** [`lua/config/utils.lua`](./lua/config/utils.lua) - Write with sudo privileges (`<leader>W`)
- **Wrapped Lines** [`lua/config/keymaps.lua`](./lua/config/keymaps.lua) - Comfortable navigation in wrapped text files
- **Custom Spell Checking** [`lua/config/autocmds.lua`](./lua/config/autocmds.lua) - Targeted spell checking for specific file types (and auto-pauses Copilot in Markdown)
- **Absolute Line Numbers** [`lua/config/options.lua`](./lua/config/options.lua) - Uses absolute instead of relative line numbers
- **Clipboard Handling** [`lua/config/options.lua`](./lua/config/options.lua) - Doesn't use system clipboard by default for better control
- **URL to Markdown command** [`lua/utils/url-to-markdown.lua`](./lua/utils/url-to-markdown.lua) - `:UrlToMarkdown` and `<D-S-a>` turn raw links into titled Markdown references
- **Snacks picker shortcut** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - `<C-p>` launches a hidden-friendly file picker

## 📋 [LazyVim Extras](https://www.lazyvim.org/extras)

This configuration includes numerous LazyVim extras (see [`lazyvim.json`](./lazyvim.json)):

- **AI**: copilot-native, sidekick
- **Coding**: mini-surround, yanky
- **DAP**: core, nlua
- **Editor**: dial, inc-rename, snacks_explorer, snacks_picker
- **Formatting**: black, prettier
- **Languages**: ansible, docker, git, go, json, markdown, python, rust, tailwind, terraform, toml, typescript, yaml, zig
- **Linting**: eslint
- **Testing**: core
- **UI**: edgy
- **Utilities**: chezmoi, dot, mini-hipatterns
- **Interoperability**: vscode

## 🔧 File Structure

- `init.lua` - Entry point that loads the configuration
- `lua/config/` - Core configuration files
- `lua/plugins/` - Custom plugin configurations
- `stylua.toml` - Formatting rules for Lua files

## 🎨 Theme

Using [Tokyo Night](https://github.com/folke/tokyonight.nvim) with the "night" style for a clean, modern look. See [`lua/plugins/tokyonight.lua`](./lua/plugins/tokyonight.lua) for configuration.
