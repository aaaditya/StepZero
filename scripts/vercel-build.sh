#!/usr/bin/env bash
# Vercel / CI build for StepZero Flutter web.
# Usage: bash scripts/vercel-build.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ ! -f pubspec.yaml ]]; then
  echo "error: pubspec.yaml not found in $ROOT"
  echo "Deploy from a branch that contains the Flutter app (not an empty main)."
  exit 1
fi

FLUTTER_DIR="${FLUTTER_HOME:-$HOME/flutter}"
if [[ ! -x "$FLUTTER_DIR/bin/flutter" ]]; then
  echo "→ Cloning Flutter stable into $FLUTTER_DIR"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --no-analytics --enable-web
flutter pub get
flutter build web --release --no-tree-shake-icons

echo "→ Output: $ROOT/build/web"
