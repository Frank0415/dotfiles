#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

python3 - "$ROOT/cli-config.json" <<'PY'
import json
import sys
from pathlib import Path

out = Path(sys.argv[1])
data = json.loads((Path.home() / ".cursor/cli-config.json").read_text())
for key in ("authInfo", "privacyCache", "serverConfigCache"):
    data.pop(key, None)
out.write_text(json.dumps(data, indent=2) + "\n")
PY

rsync -a \
  "$HOME/Library/Application Support/Cursor/User/settings.json" \
  "$ROOT/settings.json"

rsync -a --delete \
  --exclude='.sync-manifest.json' \
  "$HOME/.cursor/skills-cursor/" \
  "$ROOT/skills-cursor/"

rsync -aL --delete \
  "$HOME/.agents/skills/" \
  "$ROOT/skills/"

echo "Collected Cursor config into $ROOT"
