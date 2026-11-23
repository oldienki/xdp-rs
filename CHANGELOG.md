# Changelog

## Version History

---

### 0.1.7

- **Release tooling**: create annotated release tags with an explicit message, so `git tag` no longer opens an editor (`dd289ae`).

### 0.1.6

- **Release tooling**: add `scripts/bump-version.sh` to bump the workspace version, commit, tag `v<version>`, and push `master` plus the tag (`7064af9`).
- **Release tooling**: add a `Justfile` with a `release` target that runs the version bump on `master` only (`7064af9`).
- **Build**: ignore `Cargo.lock` in this library workspace and make the bump script handle an untracked lockfile (`954de47`).

### 0.1.5

- **API**: implement `AsRawFd` for `Socket` to allow direct file descriptor access (`084496d`).
- **API**: add timeout support and error checks to `poll_wait` (`0855d7f`).
- **Fixes**: correct `seek` logic (`81717a6`).
- **Fixes**: correct socket initialization and bitmask usage (`e53c828`).
- **CI**: add a `release.yml` workflow that publishes to crates.io on `v*` tag push using OIDC authentication (`fa8f857`).

### 0.1.4

- **API**: refactor `poll_wait`, `send`, and `send_blocking` as traits (`803eb7e`).
- **Docs**: update the README and crate-level documentation (`670b1e5`, `15ef0ef`).
- Refactoring and cleanup (`5762fd9`, `6fe5507`, `6f6977c`, `920eded`, `6d54b06`, `eecd40a`).

### 0.1.3

- Version bump only (`ec148dd`).

### 0.1.2

- **Docs**: update the README (`5e23baf`, `79c6b8b`).
- **Packaging**: add MIT and Apache-2.0 license files (`79c6b8b`).

### 0.1.1

- Version bump only (`083a96f`).

### 0.1.0

- **API**: initial AF_XDP socket implementation with `TxSocket` and `RxSocket` (`4bf065f`, `2dc8914`, `6f5d640`).
- **API**: redesign the core API around a `seek`/`peek`/`commit` workflow instead of `send`/`recv` (`3794ca5`).
- **Fixes**: correct ring logic (`1543b54`).
- **Testing**: add a test suite that sets capabilities on start when required (`3b4d435`, `6952abd`).
- **Docs**: add brief comments and descriptions, and update the documentation (`376bfb3`, `332cc66`, `277637c`).
