# dotfiles

Personal configs for **Omarchy** (Arch Linux + Hyprland), plus Zsh, Neovim (LazyVim) and Ghostty.

## Important: this is not a standalone Hyprland config

`.config/hypr/hyprland.conf` doesn't configure Hyprland from scratch — it **sources files from an Omarchy installation** (`~/.local/share/omarchy/...` and `~/.config/omarchy/current/theme/...`). This repo only overrides pieces on top of that base. If Omarchy isn't installed first, Hyprland will fail to start (missing `source` targets).

> **Get Omarchy first:** https://omarchy.org — it installs Arch + Hyprland + its own default configs, which this repo then overrides.

## What's inside

| Path | Purpose |
|---|---|
| `.config/hypr/` | Hyprland overrides (bindings, monitors, input, lock screen, GUI apps) |
| `.config/ghostty/` | Ghostty terminal config (font, keybinds, theme hook) |
| `.config/nvim/` | Neovim config, built on [LazyVim](https://lazyvim.github.io) |
| `.zshrc` | Zsh shell config (Oh My Zsh + Powerlevel10k) |
| `Wallpapers/` | Wallpaper set used by Hyprland/Omarchy theming |

## Requirements

### 1. Base system

| Tool | Why you need it |
|---|---|
| [Omarchy](https://omarchy.org) (Arch Linux + Hyprland) | Provides the base Hyprland config this repo overrides. Install this **before** copying any dotfiles. |
| `git` | To clone this repo and (optionally) Oh My Zsh / plugins. |

### 2. Zsh stack (`.zshrc`)

| Tool | Why | Install |
|---|---|---|
| `zsh` | The shell itself | `sudo pacman -S zsh` |
| [Oh My Zsh](https://ohmyz.sh) | Framework `.zshrc` sources (`$ZSH/oh-my-zsh.sh`) | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | `ZSH_THEME="powerlevel10k/powerlevel10k"` | `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k` |
| `zsh-autosuggestions` (system package) | Sourced from `/usr/share/zsh/plugins/...` | `sudo pacman -S zsh-autosuggestions` |
| `zsh-syntax-highlighting` (system package) | Sourced from `/usr/share/zsh/plugins/...` | `sudo pacman -S zsh-syntax-highlighting` |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` (`.zshrc` overrides `cd` with it) | `sudo pacman -S zoxide` |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` replacement (aliased as `ls`, `la`, `tree`) | `sudo pacman -S eza` |
| A [Nerd Font](https://www.nerdfonts.com/) | Powerlevel10k and `eza --icons` need glyph support | `sudo pacman -S ttf-jetbrains-mono-nerd` |

> **Package names above are for Arch (`pacman`).** Adjust for your distro's package manager if you're not on Arch/Omarchy (e.g. `apt install zsh-autosuggestions zsh-syntax-highlighting` on Debian/Ubuntu, though paths under `/usr/share/zsh/plugins/` may differ — check `dpkg -L zsh-autosuggestions`).

### 3. Neovim (`.config/nvim/`)

Built on **LazyVim** with the `neo-tree` extra enabled.

| Tool | Why |
|---|---|
| `neovim` >= 0.9 | The editor itself |
| `git` | LazyVim uses it to fetch plugins |
| `ripgrep` (`rg`) | Required by LazyVim's fuzzy finder/grep |
| `fd` | Required by LazyVim's file finder |
| A C compiler (`gcc`/`clang`) + `make` | Needed to build Treesitter parsers |
| A Nerd Font (see above) | LazyVim's UI relies on icon glyphs |
| `lazygit` (optional) | LazyVim's git UI integration, if you use it |
| `wl-clipboard` (`wl-copy` / `wl-paste`) | Used by the custom remote-clipboard module (`lua/config/remote_clipboard.lua`) to bridge Wayland clipboard over SSH/tmux via OSC52 |

Install on Arch:
```bash
sudo pacman -S neovim ripgrep fd gcc make lazygit wl-clipboard
```

### 4. Ghostty terminal

| Tool | Why |
|---|---|
| [Ghostty](https://ghostty.org) | The terminal emulator `.config/ghostty/config` configures |
| Omarchy theme system | Ghostty's config pulls colors from `~/.config/omarchy/current/theme/ghostty.conf` — only present if Omarchy is installed |

### 5. Optional

| Tool | Why |
|---|---|
| [spicetify-cli](https://spicetify.app) | `.zshrc` adds `~/.spicetify` to `PATH`; only needed if you theme Spotify |

## Installation

1. **Install Omarchy first** — this repo assumes its base Hyprland config already exists.
2. Clone the repo:
   ```bash
   git clone https://github.com/JairPB/dotfiles.git ~/dotfiles
   ```
3. Symlink (recommended over copying, so `git pull` keeps things updated):
   ```bash
   ln -sf ~/dotfiles/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/.config/hypr ~/.config/hypr
   ln -sf ~/dotfiles/.config/ghostty ~/.config/ghostty
   ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
   ```
4. Install the Zsh/Neovim dependencies listed above.
5. Restart your shell, then run `p10k configure` if you want to redo the Powerlevel10k prompt wizard (a `~/.p10k.zsh` is expected but not tracked in this repo).
6. Reload Hyprland (`hyprctl reload`) or re-login to pick up the Hypr config.

## Known gotchas

- **Hardcoded username path**: `.config/hypr/hyprland.conf` sources `/home/jair/.config/hypr/hyprland-gui.conf` with an absolute path. If your username isn't `jair`, either rename your user, symlink `/home/jair` won't work generically — better to edit that line to `~/.config/hypr/hyprland-gui.conf`.
- **First line of `.zshrc`** is a bare `nitchjair` command with no guard. This looks like a system-info fetch tool/alias run on shell start — if it's not on your `PATH`, every new shell will throw a "command not found." Remove or guard it (`command -v nitchjair &>/dev/null && nitchjair`) if you don't have it installed.
- **No `~/.p10k.zsh`** is tracked in the repo (it's user-specific/gitignored by convention) — you'll need to generate your own with `p10k configure`.
