# Bump patch version, tag v<version>, push master + tag (master branch only)
release:
    #!/usr/bin/env bash
    set -euo pipefail
    branch="$(git rev-parse --abbrev-ref HEAD)"
    if [ "$branch" != "master" ]; then
        echo "error: release must be run on master (current: $branch)" >&2
        exit 1
    fi
    ./scripts/bump-version.sh patch
