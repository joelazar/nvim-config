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

- **Copilot Native** [`lazyvim.json`](./lazyvim.json) - GitHub Copilot inline completions via the native LSP extra, with Next Edit Suggestions through Sidekick.
- **Sidekick.nvim** [`lua/plugins/sidekick.lua`](./lua/plugins/sidekick.lua) - Tmux-backed Sidekick CLI bridge; `<D-r>` toggles the AI window (pi), `<D-e>` maximizes it.
- **Code review with tuicr** [`lua/config/keymaps.lua`](./lua/config/keymaps.lua) - `<leader>rr` / `<leader>rb` / `<leader>rf` / `<leader>rp` review the working tree, branch, file, or PR.

### 📝 Writing & Knowledge Management

- **Obsidian.nvim** [`lua/plugins/obsidian.lua`](./lua/plugins/obsidian.lua) - Multi-vault workflow with templates, weekly notes, checkboxes, and a full `<leader>z` command suite. Skipped on machines with a `.disable-obsidian` marker.
- **URL → Markdown helper** [`lua/plugins/url-to-markdown.lua`](./lua/plugins/url-to-markdown.lua) - Convert the URL under the cursor into a titled Markdown link with `<C-S-a>`.
- **Word count in Lualine** [`lua/plugins/lualine.lua`](./lua/plugins/lualine.lua) - Live word counts for Markdown, LaTeX, and other writing formats.

### 📂 File & Workspace Navigation

- **Yazi.nvim** [`lua/plugins/yazi.lua`](./lua/plugins/yazi.lua) - Toggle the Yazi terminal file manager (`<leader>y` / `<leader>Y`) without leaving Neovim.
- **Snacks.nvim** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - Dashboard, file picker with filename-first formatting, project-aware sources, explorer cut/paste, and a `<C-p>` shortcut.
- **Smart-splits.nvim** [`lua/plugins/smart-splits.lua`](./lua/plugins/smart-splits.lua) - `<C-h/j/k/l>` navigation that crosses over into herdr panes.
- **Grug-far.nvim** [`lua/plugins/grug.lua`](./lua/plugins/grug.lua) - `<leader>sr` search and replace, pre-filtered to the current file extension.

### 🧰 Development Tools

- **Blink.cmp** [`lua/plugins/blink.lua`](./lua/plugins/blink.lua) - Modern completion engine wired to Git history, dictionary, and a custom calculator source.
- **Mason.nvim** [`lua/plugins/mason.lua`](./lua/plugins/mason.lua) - Ensures `ruff`, `ty`, `sqlfluff`, `harper-ls`, `nginx-language-server`, `rust-analyzer`, and `debugpy` are ready to go.
- **Conform.nvim & nvim-lint** [`lua/plugins/conform.lua`](./lua/plugins/conform.lua), [`lua/plugins/nvim-lint.lua`](./lua/plugins/nvim-lint.lua) - Formatter and linter setup for SQL and Markdown; prettier yields to biome, and Markdown frontmatter is left untouched.
- **LSP tuning** [`lua/plugins/lspconfig.lua`](./lua/plugins/lspconfig.lua) - Refined keymaps, `gopls` tweaks, on-demand `harper_ls`, nginx LSP, inc-rename on `cd`, and `<leader>ca` code actions.
- **Neotest** [`lua/plugins/neotest.lua`](./lua/plugins/neotest.lua) - Go tests run through `gotestsum`.
- **vim-dadbod-ui & Edgy** [`lua/plugins/dadbod.lua`](./lua/plugins/dadbod.lua), [`lua/plugins/edgy.lua`](./lua/plugins/edgy.lua) - `<leader>D` database UI docked in an edgy sidebar, results at the bottom.
- **Treesitter** [`lua/plugins/treesitter.lua`](./lua/plugins/treesitter.lua) - Extra parsers for SQL, Go templates, LaTeX, CSS, and comment blocks.
- **Codediff.nvim** [`lua/plugins/codediff.lua`](./lua/plugins/codediff.lua) - VSCode-style side-by-side diffs via `:CodeDiff`.
- **Text-case.nvim** [`lua/plugins/text-case.lua`](./lua/plugins/text-case.lua) - Fast case conversions for symbols and selections.

### 🎨 UI & Insights

- **Catppuccin** [`lua/plugins/catppuccin.lua`](./lua/plugins/catppuccin.lua) - Mocha flavour, soothing pastel palette.
- **Bufferline** [`lua/plugins/bufferline.lua`](./lua/plugins/bufferline.lua) - Minimal tabline with sensible Alt-based navigation and pinning.
- **Snacks UI polish** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - Custom header, trimmed indent guides, and quiet scrolling defaults.
- **Which-key.nvim** [`lua/plugins/which-key.lua`](./lua/plugins/which-key.lua) - Helix-style key-hints with shortcuts for elevated writes.

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
- `<leader>ca` - Code actions menu (via LSP)

### Additional Features

- **Sudo Integration** [`lua/config/utils.lua`](./lua/config/utils.lua) - Write with sudo privileges (`<leader>fW`)
- **Wrapped Lines** [`lua/config/keymaps.lua`](./lua/config/keymaps.lua) - Comfortable navigation in wrapped text files
- **Custom Spell Checking** [`lua/config/autocmds.lua`](./lua/config/autocmds.lua) - Targeted spell checking and wrapping for text file types
- **Absolute Line Numbers** [`lua/config/options.lua`](./lua/config/options.lua) - Uses absolute instead of relative line numbers
- **Clipboard Handling** [`lua/config/options.lua`](./lua/config/options.lua) - Doesn't use system clipboard by default for better control
- **URL to Markdown command** [`lua/utils/url-to-markdown.lua`](./lua/utils/url-to-markdown.lua) - `:UrlToMarkdown` and `<C-S-a>` turn raw links into titled Markdown references
- **Snacks picker shortcut** [`lua/plugins/snacks.lua`](./lua/plugins/snacks.lua) - `<C-p>` launches a hidden-friendly file picker

## 📋 [LazyVim Extras](https://www.lazyvim.org/extras)

This configuration includes numerous LazyVim extras (see [`lazyvim.json`](./lazyvim.json)):

- **AI**: copilot-native, sidekick
- **Coding**: mini-surround, yanky
- **DAP**: core, nlua
- **Editor**: dial, inc-rename, snacks_explorer, snacks_picker
- **Formatting**: prettier
- **Languages**: ansible, docker, git, go, json, markdown, python, rust, tailwind, terraform, toml, typescript, yaml, zig
- **Linting**: eslint
- **Testing**: core
- **UI**: edgy
- **Utilities**: chezmoi, dot, mini-hipatterns

## 🔧 File Structure

- `init.lua` - Entry point that loads the configuration
- `lua/config/` - Core configuration files
- `lua/plugins/` - Custom plugin configurations
- `stylua.toml` - Formatting rules for Lua files

## 🎨 Theme

Using [Catppuccin](https://github.com/catppuccin/nvim) with the "mocha" flavour for a warm, modern look. See [`lua/plugins/catppuccin.lua`](./lua/plugins/catppuccin.lua) for configuration.
