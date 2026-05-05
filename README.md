# configs

Personal config files for the tools I use daily.

## What's here

- **`nvim/`** — Neovim config (LSP for Rust/Haskell/Lean, treesitter, telescope, gitsigns, lazygit, vague colorscheme, leap motion, surround, autopairs, trouble, persistence, which-key)
- **`zellij/`** — Zellij terminal multiplexer keybinds and config
- **`ghostty/`** — Ghostty terminal emulator config

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
| `make nvim` / `zellij` / `ghostty` | install one app's config only |

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
Makefile
```

Ghostty's config lives at `~/Library/Application Support/com.mitchellh.ghostty/config`
on macOS and `~/.config/ghostty/config` elsewhere — the Makefile detects which
to use via `uname`.
