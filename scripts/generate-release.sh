#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RELEASE="$REPO_ROOT/dists/stable/Release"

cat > "$RELEASE" <<'EOF'
Origin: Charlesson
Label: Charlesson APT
Suite: stable
Codename: stable
Architectures: amd64 all
Components: main
Description: Charlesson APT Repository

EOF

cd "$REPO_ROOT/dists/stable"

{
    echo "MD5Sum:"
    find main -type f \( -name 'Packages' -o -name 'Packages.gz' \) -print0 |
        sort -z |
        while IFS= read -r -d '' file; do
            printf " %s %16d %s\n" \
                "$(md5sum "$file" | cut -d' ' -f1)" \
                "$(stat -c%s "$file")" \
                "$file"
        done

    echo "SHA256:"
    find main -type f \( -name 'Packages' -o -name 'Packages.gz' \) -print0 |
        sort -z |
        while IFS= read -r -d '' file; do
            printf " %s %16d %s\n" \
                "$(sha256sum "$file" | cut -d' ' -f1)" \
                "$(stat -c%s "$file")" \
                "$file"
        done
} >> "$RELEASE"
