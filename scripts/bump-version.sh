#!/usr/bin/env bash
# Usage: ./scripts/bump-version.sh [patch|minor|major|<version>]
# Bumps [workspace.package].version in Cargo.toml, commits, tags v<version>,
# pushes master and the tag to origin.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CARGO_TOML="$ROOT/Cargo.toml"
BUMP="${1:-patch}"

# --- sanity checks -----------------------------------------------------------
if [[ -n "$(git -C "$ROOT" status --porcelain)" ]]; then
    echo "error: working tree is dirty, commit or stash changes first" >&2
    exit 1
fi

current="$(sed -n 's/^version = "\(.*\)"/\1/p' "$CARGO_TOML" | head -n1)"
if [[ -z "$current" ]]; then
    echo "error: could not read version from $CARGO_TOML" >&2
    exit 1
fi

# --- compute new version ------------------------------------------------------
IFS='.' read -r major minor patch <<< "$current"
case "$BUMP" in
    patch) patch=$((patch + 1)) ;;
    minor) minor=$((minor + 1)); patch=0 ;;
    major) major=$((major + 1)); minor=0; patch=0 ;;
    [0-9]*.[0-9]*.[0-9]*)
        major="${BUMP%%.*}"
        rest="${BUMP#*.}"
        minor="${rest%%.*}"
        patch="${rest#*.}" ;;
    *) echo "error: unknown bump type '$BUMP' (use patch|minor|major|X.Y.Z)" >&2; exit 1 ;;
esac
new="$major.$minor.$patch"

if [[ "$new" == "$current" ]]; then
    echo "error: version unchanged ($current)" >&2
    exit 1
fi

echo "bumping version: $current -> $new"

# --- update Cargo.toml + Cargo.lock -------------------------------------------
sed -i "0,/^version = \"$current\"/s//version = \"$new\"/" "$CARGO_TOML"
cargo -q check --manifest-path "$CARGO_TOML" 2>/dev/null || cargo -q metadata --format-version 1 --manifest-path "$CARGO_TOML" > /dev/null

# --- commit, tag, push ---------------------------------------------------------
git -C "$ROOT" add Cargo.toml
if git -C "$ROOT" ls-files --error-unmatch Cargo.lock >/dev/null 2>&1; then
    git -C "$ROOT" add Cargo.lock
fi
git -C "$ROOT" commit -m "Bump version to v$new"
git -C "$ROOT" tag "v$new"
git -C "$ROOT" push origin master
git -C "$ROOT" push origin "v$new"

echo "done: tagged and pushed v$new"
