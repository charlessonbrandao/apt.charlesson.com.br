#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$REPO_ROOT/dists/stable"
RELEASE="$DIST/Release"
TMP_RELEASE="$DIST/Release.tmp"

cat > "$TMP_RELEASE" <<EOM
Origin: Charlesson
Label: Charlesson APT
Suite: stable
Codename: stable
Architectures: amd64 all
Components: main
Description: Charlesson APT Repository

EOM

apt-ftparchive release "$DIST" >> "$TMP_RELEASE"

mv "$TMP_RELEASE" "$RELEASE"
