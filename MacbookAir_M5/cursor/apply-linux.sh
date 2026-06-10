#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_DIR="$HOME/.cursor"
IDE_DIR="$HOME/.config/Cursor/User"

mkdir -p "$CURSOR_DIR" "$IDE_DIR" "$CURSOR_DIR/skills"

if [[ -f "$CURSOR_DIR/cli-config.json" ]]; then
  python3 - "$ROOT/cli-config.json" "$CURSOR_DIR/cli-config.json" <<'PY'
import json
import sys
from pathlib import Path

src = json.loads(Path(sys.argv[1]).read_text())
dst_path = Path(sys.argv[2])
dst = json.loads(dst_path.read_text()) if dst_path.exists() else {}
for key in ("authInfo", "privacyCache", "serverConfigCache"):
    if key in dst:
        src[key] = dst[key]
dst_path.write_text(json.dumps(src, indent=2) + "\n")
PY
else
  cp "$ROOT/cli-config.json" "$CURSOR_DIR/cli-config.json"
fi

python3 - "$ROOT/settings.json" "$IDE_DIR/settings.json" <<'PY'
import json
import sys
from pathlib import Path

src = json.loads(Path(sys.argv[1]).read_text())
dst_path = Path(sys.argv[2])
dst = json.loads(dst_path.read_text()) if dst_path.exists() else {}
dst.update(src)
dst_path.write_text(json.dumps(dst, indent=2, ensure_ascii=False) + "\n")
PY

rsync -a \
  --exclude='.sync-manifest.json' \
  "$ROOT/skills-cursor/" \
  "$CURSOR_DIR/skills-cursor/"

rsync -a \
  "$ROOT/skills/" \
  "$CURSOR_DIR/skills/"

echo "Applied Cursor config from $ROOT"
