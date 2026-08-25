#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$REPO_ROOT/dists/stable"

DATE="$(date -Ru)"
VALID_UNTIL="$(date -Ru -d '+7 days')"

cat > "$DIST/Release.header" <<EOF
Origin: Charlesson
Label: Charlesson APT
Suite: stable
Codename: stable
Date: $DATE
Valid-Until: $VALID_UNTIL
Architectures: amd64 all
Components: main
Description: Charlesson APT Repository
EOF

apt-ftparchive release "$DIST" \
    | sed '/^Date:/d' \
    > "$DIST/Release.hashes"


sed -i '/[[:space:]]Release$/d' "$DIST/Release.hashes"

cat "$DIST/Release.header" "$DIST/Release.hashes" > "$DIST/Release"

rm "$DIST/Release.header" "$DIST/Release.hashes"
