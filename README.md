# configs

Personal config files for the tools I use daily.

## What's here

- **`nvim/`** — Neovim config (LSP for Rust/Haskell/Lean, treesitter, telescope, gitsigns, lazygit, vague colorscheme, leap motion, surround, autopairs, trouble, persistence, which-key)
- **`zellij/`** — Zellij terminal multiplexer keybinds and config
- **`ghostty/`** — Ghostty terminal emulator config
- **`lazygit/`** — lazygit config (sets `editPreset: nvim-remote` so `e` on a file inside lazygit-in-nvim opens it as a tab in the host nvim via `nvr`)

Shell is [oh-my-zsh](https://ohmyz.sh/) with the stock `gnzh` theme (`ZSH_THEME="gnzh"` in `~/.zshrc`) and the `git` plugin. Nothing custom to track — install omz and set the theme.

## Setup on a fresh machine

```sh
git clone https://github.com/<you>/configs ~/repos/configs
cd ~/repos/configs
make install
brew install neovim zellij stylua taplo prettier lazygit ripgrep fd
brew install --cask ghostty font-jetbrains-mono-nerd-font
xcode-select --install   # C compiler — treesitter parsers and LuaSnip jsregexp build from source
```

Run `make install` **before** installing the apps — symlinks don't need their
targets to exist, and doing this order avoids Ghostty's first-launch auto-config
from racing against the symlink.

After Ghostty is installed, set the font to a Nerd Font (e.g. `JetBrainsMono Nerd Font`)
so neo-tree, web-devicons, and render-markdown icons render correctly.

### Language toolchains (install only the ones you use)

The nvim config wires up LSPs for Rust, Haskell, and Lean. Each needs its own toolchain — none are installed by `make install`:

| Language | Install |
|---|---|
| Rust | `rustup` → `rustup component add rust-analyzer rustfmt clippy` |
| Haskell | `ghcup install hls` |
| Lean | `elan` (installs `lean` + `lake`) |

If a toolchain isn't installed, the corresponding LSP just stays silent — nothing breaks.

## Makefile targets

| Target | Effect |
|---|---|
| `make install` | symlink all configs into place |
| `make uninstall` | remove symlinks pointing into this repo (foreign links are left alone) |
| `make status` | print the current link state for each managed path |
| `make nvim` / `zellij` / `ghostty` / `lazygit` | install one app's config only |

The Makefile refuses to overwrite a real file at the destination — if a path
already has a regular file there, move it aside (e.g. `mv path path.bak`) and
re-run.

## Layout

```
nvim/
  init.lua
  lua/mukesh/
    init.lua, options.lua, mappings.lua, lazy_init.lua
    lazy/<one file per plugin spec>
zellij/config.kdl
ghostty/config
lazygit/config.yml
Makefile
```

On macOS, both Ghostty and lazygit read from `~/Library/Application Support/<app>/`
rather than `~/.config/<app>/` (lazygit follows Apple's directory conventions
unless `XDG_CONFIG_HOME` is exported). The Makefile detects the platform via
`uname` and picks the right destination for each. Everything else uses
`~/.config/<app>/` on both platforms.

### `nvr` for lazygit ↔ nvim handoff

The lazygit config sets `editPreset: nvim-remote`, which tells lazygit to invoke
[`nvr`](https://github.com/mhinz/neovim-remote) when you press `e` on a file.
`nvr` finds the host nvim via the `$NVIM` socket env var that nvim sets in its
`:terminal` jobs and opens the file as a new tab there — no nested vim.

```sh
brew install neovim-remote
```

Without `nvr` installed (or if the config isn't loaded), lazygit falls through
to `$EDITOR` and ends up spawning plain `vi`/`vim` inside the lazygit pane.
