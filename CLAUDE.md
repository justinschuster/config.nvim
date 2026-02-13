# CLAUDE.md — Neovim Configuration

This is a personal Neovim configuration repository (Justin Schuster). It uses **lazy.nvim** as the plugin manager and is written entirely in Lua.

## Repository Structure

```
.
├── init.lua                  # Entry point: leader key, vim options, keymaps, autocmds, lazy.nvim bootstrap
├── lua/
│   ├── config/
│   │   └── lazy.lua          # lazy.nvim setup and plugin spec import
│   ├── health.lua            # :checkhealth module (checks nvim version, git, make, unzip, rg)
│   └── plugins/              # One file per plugin (lazy.nvim spec format)
│       ├── autopairs.lua     # nvim-autopairs — auto-close brackets/quotes
│       ├── blink.lua         # blink.cmp — completion engine (with LuaSnip)
│       ├── conform.lua       # conform.nvim — formatting (stylua for Lua)
│       ├── debug.lua         # nvim-dap — debugging (Go/Delve)
│       ├── fugitive.lua      # vim-fugitive — Git commands
│       ├── gitsigns.lua      # gitsigns.nvim — git gutter signs
│       ├── indent_line.lua   # indent-blankline.nvim — indentation guides
│       ├── lazydev.lua       # lazydev.nvim — Lua LSP config for Neovim dev
│       ├── lint.lua          # nvim-lint — linting (markdownlint for markdown)
│       ├── mini.lua          # mini.nvim — ai, surround, statusline
│       ├── neo-tree.lua      # neo-tree.nvim — file browser
│       ├── nvim-lspconfig.lua# nvim-lspconfig + Mason — LSP setup
│       ├── nvim-treesitter.lua# nvim-treesitter — syntax highlighting
│       ├── rose-pine.lua     # rose-pine colorscheme (active theme)
│       ├── telescope.lua     # telescope.nvim — fuzzy finder
│       ├── todo-comments.lua # todo-comments.nvim — highlight TODOs
│       ├── vim-slueth.lua    # vim-sleuth — auto-detect indentation
│       └── which-key.lua     # which-key.nvim — keymap hints
├── .gitignore
├── LICENSE.md                # MIT
└── README.md
```

## Key Conventions

### Plugin Configuration Pattern
Every plugin lives in its own file under `lua/plugins/`. Each file returns a lazy.nvim plugin spec table (or list of tables). The `lua/config/lazy.lua` file imports the entire `plugins` directory via `{ import = "plugins" }`.

### Adding a New Plugin
1. Create a new file in `lua/plugins/<plugin-name>.lua`
2. Return a lazy.nvim spec table with the plugin's GitHub short name, dependencies, config, and keymaps
3. lazy.nvim auto-discovers it on next startup — no manual registration needed

### Leader Key
- **Leader**: `<Space>` (set in `init.lua`)
- **Local leader**: `\` (set in `lua/config/lazy.lua`)

### Keymap Namespace Conventions
| Prefix | Purpose | Example |
|--------|---------|---------|
| `<leader>s` | Search (Telescope) | `<leader>sf` find files, `<leader>sg` live grep |
| `<leader>t` | Toggle | `<leader>th` toggle inlay hints |
| `<leader>h` | Git hunks | Used with gitsigns |
| `<leader>f` | Format | `<leader>f` format buffer (conform) |
| `<leader>q` | Quickfix | `<leader>q` open diagnostic list |
| `<leader>b` | Breakpoint | `<leader>b` toggle DAP breakpoint |
| `gr*` | LSP go-to | `grr` references, `grd` definition, `grn` rename |
| `<F1>`–`<F7>` | Debug | `<F5>` continue, `<F7>` toggle DAP UI |
| `<C-h/j/k/l>` | Window nav | Move focus between splits |
| `\` | File tree | Toggle neo-tree |

### Vim Options (set in init.lua)
- `shiftwidth = 4` — 4-space indentation
- `number = true` — line numbers
- `undofile = true` — persistent undo
- `ignorecase + smartcase` — case-insensitive search unless uppercase used
- `scrolloff = 10` — keep 10 lines visible above/below cursor
- `splitright / splitbelow` — new splits open right/below
- `clipboard = 'unnamedplus'` — syncs with system clipboard
- `have_nerd_font = true` — Nerd Font icons assumed available

## LSP Configuration

Currently configured language servers (via Mason + nvim-lspconfig):
- **lua_ls** — Lua language server with snippet completion

Mason auto-installs:
- **stylua** — Lua formatter (used by conform.nvim)

To add a new LSP server, edit `lua/plugins/nvim-lspconfig.lua` and add to the `servers` table inside the config function.

## Formatting & Linting

- **Formatting** (conform.nvim): Runs on save with LSP fallback. Lua files use `stylua`. Manual format: `<leader>f`.
- **Linting** (nvim-lint): Markdown files use `markdownlint`. Runs automatically on `BufReadPre`/`BufNewFile`.

## Colorscheme

Active theme: **rose-pine** (`lua/plugins/rose-pine.lua`). Fallback during plugin install: `habamax`.

## External Dependencies

Required (checked by `:checkhealth`):
- Neovim >= 0.10
- `git`
- `make` (for telescope-fzf-native, LuaSnip jsregexp)
- `unzip`
- `rg` (ripgrep — used by Telescope live grep)

## Development Notes

- The config is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) patterns (visible in autocmd group names like `kickstart-highlight-yank`)
- `lazy-lock.json` is gitignored — plugin versions are not pinned in version control
- No custom utility modules exist — all logic is in init.lua or inline plugin configs
- The `spell/` directory is gitignored
