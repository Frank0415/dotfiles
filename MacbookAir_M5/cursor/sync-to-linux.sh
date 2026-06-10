#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="$(cd "$ROOT/../.." && pwd)"
LINUX_HOST="${LINUX_HOST:-linux_local}"
REMOTE_CURSOR_DIR='~/.config/dotfiles/MacbookAir_M5/cursor'

"$ROOT/collect-mac.sh"

cd "$DOTFILES"
if ! git diff --quiet -- MacbookAir_M5/cursor || [[ -n "$(git ls-files --others --exclude-standard MacbookAir_M5/cursor)" ]]; then
  git add MacbookAir_M5/cursor
  git commit -m "sync: cursor config from Mac"
  git push origin main
else
  echo "No cursor config changes to commit"
fi

ssh "$LINUX_HOST" "cd ~/.config/dotfiles && git pull origin main && bash $REMOTE_CURSOR_DIR/apply-linux.sh"

echo "Synced Cursor config to Linux via $LINUX_HOST"
