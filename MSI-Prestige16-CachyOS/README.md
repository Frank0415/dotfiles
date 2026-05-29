# MSI Prestige 16 - CachyOS Dotfiles

**Host**: Stealth 16 AI+ B3WH / **WM**: niri 26.04 (Wayland) / **Terminal**: ghostty

## Methodology

Each app config is migrated into this repo as a **self-contained directory** under `MSI-Prestige16-CachyOS/`. Every app goes through:

1. **File size check** — reject files >1MB (large caches/binary blobs not in dotfiles)
2. **Secrets scan** — grep for API keys, tokens, passwords, private keys, credential patterns
3. **Path sanitization** — replace hardcoded `/home/xc/` with `$HOME`
4. **Hardware ID stripping** — remove machine-specific identifiers (display names, EDIDs)
5. **Binary trimming** — strip screenshots, built-in syntax files, plugin docs that ship with the app
6. **One app = one commit** — each config is independently versioned for clean history

## Migrated Apps (2026-05-30)

| App | Directory | Notes |
|-----|-----------|-------|
| alacritty | `alacritty/` | Terminal config + noctalia theme |
| btop | `btop/` | System monitor theme/colors |
| fish | `fish/` | Shell config (pure prompt theme, completions) |
| ghostty | `ghostty/` | Terminal config + dank/noctalia themes |
| niri | `niri/` | WM config (modular .kdl files) |
| niri.dms | `niri.dms/` | DMS shell config (outputs stripped → template) |
| nvim | `nvim/` | Neovim config (LazyVim + noctalia) |
| nwg-look | `nwg-look/` | GTK look settings export config |
| spicetify | `spicetify/` | Spotify spicetify config |
| tmux | `tmux/` | tmux config (oh-my-tmux bundled) |
| yazi | `yazi/` | File manager config + noctalia flavor |
| zed | `zed/` | Zed editor settings + noctalia theme |
| micro | `micro/` | Editor config + color schemes (trimmed: no syntax/backups/pics) |
| KDE configs | `kde/` | dolphinrc, kdeglobals, kiorc, konsolerc, okularrc, okularpartrc |

### Excluded (not suitable for dotfiles)

- **Browser profiles**: google-chrome, zen, mozilla — huge cache/auth data
- **IDE extensions**: Cursor, Code, JetBrains, Trae, CherryStudio — >100M each
- **Electron app data**: Ferdium (2.5G), LarkShell (1.7G) — login tokens
- **Machine-specific**: pulse, session, cachyos, cosmic — hardware IDs
- **Binary config**: dconf, cef_user_data — binary blobs
- **Contain secrets**: rclone, khal, evolution, github-copilot — auth tokens

## Restore Instructions

On a new machine, for each app you want to restore:

```bash
# 1. Clone this repo
git clone git@github.com:Frank0415/dotfiles.git ~/.config/dotfiles

# 2. Copy individual app configs (or use a symlink script)
for app in alacritty btop fish ghostty niri nvim tmux yazi zed micro; do
  cp -r ~/.config/dotfiles/MSI-Prestige16-CachyOS/$app ~/.config/
done

# 3. KDE config files
cp ~/.config/dotfiles/MSI-Prestige16-CachyOS/kde/* ~/.config/

# 4. Special steps for certain apps:
#    - niri.dms: configure display outputs first (run `niri msg outputs`)
#    - spicetify: install spicetify first, then copy config
#    - micro: install micro first, plugins install via micro -plugin install
```

### Prerequisites (install these first)

```bash
# From official repos (291 packages total - see pkglist-official.txt)
sudo pacman -S alacritty btop fish ghostty niri neovim tmux yazi zed micro

# From AUR (22 packages - see pkglist-aur.txt)
yay -S spicetify-cli nwg-look
```

## Package Lists

- `pkglist-official.txt` — packages from Arch/CachyOS official repos
- `pkglist-aur.txt` — packages from AUR (not in official repos)
