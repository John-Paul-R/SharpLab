#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTERNAL_DIR="$SCRIPT_DIR/#external"
WEBAPP_MODULES="$SCRIPT_DIR/WebApp/node_modules"

echo "Building mirrorsharp packages..."

# Build regular mirrorsharp
echo "→ Building mirrorsharp..."
cd "$EXTERNAL_DIR/mirrorsharp/WebAssets"
npm install
npm run build

# Build mirrorsharp-codemirror-6-preview
echo "→ Building mirrorsharp-codemirror-6-preview..."
cd "$EXTERNAL_DIR/mirrorsharp-codemirror-6-preview/WebAssets"
npm install
npm run build

echo "Creating symlinks..."
mkdir -p "$WEBAPP_MODULES"
cd "$WEBAPP_MODULES"

# Remove old symlinks if they exist
rm -f mirrorsharp mirrorsharp-codemirror-6-preview

# Create new symlinks to dist folders
ln -s ../../#external/mirrorsharp/WebAssets/dist mirrorsharp
ln -s ../../#external/mirrorsharp-codemirror-6-preview/WebAssets/dist mirrorsharp-codemirror-6-preview

echo "✓ Done! Symlinks created:"
ls -la "$WEBAPP_MODULES" | grep mirrorsharp
