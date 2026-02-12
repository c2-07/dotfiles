# fff.nvim Build & Installation Troubleshooting Guide

This document summarizes the issues encountered while installing `fff.nvim` and the solutions applied to resolve them.

## 1. Rust Nightly Incompatibility
**Error:** `unresolved imports std::simd::LaneCount`
**Cause:** The plugin depends on `neo_frizbee`, which uses unstable `portable-simd` features. Recent changes in Rust Nightly (early 2025) broke the API used by the plugin.
**Solution:**
*   Pinned the toolchain to `nightly-2025-01-01`.
*   Patched `neo_frizbee` and `fff.nvim` source code to explicitly enable the `#![feature(let_chains)]` feature gate, which is now required for the "if let ... && let ..." syntax used in the code.

## 2. Cargo Edition Mismatch
**Error:** `feature 'edition2024' is required`
**Cause:** We attempted to use an older nightly (Feb 2024) to avoid the SIMD breakage, but the `Cargo.toml` files in the dependency tree already specified `edition = "2024"`. The older compiler did not recognize this edition.
**Solution:** Used `nightly-2025-01-01`, which is new enough to understand `edition = "2024"` but old enough (or close enough) to work with our manual patches.

## 3. OpenSSL Build Failure (Environment Poisoning)
**Error:** `error: call to undeclared function 'asm'; ISO C99 and later do not support implicit function declarations`
**Cause:** The environment variable `CFLAGS` was set to `-std=c99 -Werror`.
*   `-std=c99`: Forced strict C99 compliance, which rejects the `asm` keyword (a GNU extension) used by OpenSSL.
*   `-Werror`: Treated the resulting warning as a fatal error, halting the build.
**Solution:** Relaxed `CFLAGS` in the build command:
```bash
export CFLAGS="-Wno-error=unused-but-set-variable -Wno-error=unused-variable -Wno-error=unknown-warning-option"
```
This allowed the OpenSSL compilation to proceed despite non-standard extensions and warnings.

## 4. Missing Shared Library Artifact
**Error:** Plugin loaded successfully in Neovim but failed to find the C module (`fff.so`).
**Cause:** `cargo build` placed the final library (`libfff_nvim.dylib`) in the global cargo target directory (`~/.cargo-target/release/`) instead of the plugin's directory.
**Solution:**
*   Added a post-build step to locate the artifact using `cargo metadata`.
*   Copied `libfff_nvim.dylib` to `lua/fff.so` inside the plugin directory.

## 5. Technical Glossary & Context

*   **OpenSSL**: A core cryptography library. `fff.nvim` uses `libgit2` to show Git status (modified/ignored files) in the file picker. `libgit2` requires OpenSSL to handle secure network operations (like HTTPS cloning). On macOS, system headers for OpenSSL are often missing or incompatible, necessitating the use of Homebrew's version.
*   **SIMD (Single Instruction, Multiple Data)**: A CPU capability that allows processing multiple data points with a single instruction. The plugin's core engine, `neo_frizbee`, relies on Rust's unstable `portable-simd` feature to achieve extreme speed in fuzzy finding. This is why a **Rust Nightly** compiler is strictly required.
*   **Let Chains**: An unstable Rust syntax feature (`if let A = x && let B = y`) used in the plugin's code. This allows combining multiple pattern matches in a single `if` statement. Recent compiler updates made the requirements for enabling this feature stricter.
*   **CFLAGS**: Flags passed to the C compiler. The build failed because your environment enforced strict "standard C99" compliance (`-std=c99`) and "treat warnings as errors" (`-Werror`). This broke the OpenSSL build, which relies on non-standard GNU extensions (like inline assembly) that are technically warnings in strict C99 mode.
*   **Shared Object (.so / .dylib)**: The compiled binary result of the Rust code. Neovim loads this dynamically to run the heavy computation (searching files) in native machine code rather than slower Lua script.

## Final Build Command
The robust build command now used in `lua/nesscar/plugins/fff.lua` is:

```bash
export OPENSSL_DIR=$(/opt/homebrew/bin/brew --prefix openssl@3) && \
export OPENSSL_LIB_DIR=$OPENSSL_DIR/lib && \
export OPENSSL_INCLUDE_DIR=$OPENSSL_DIR/include && \
export LIBRARY_PATH=$OPENSSL_LIB_DIR && \
export INCLUDE_PATH=$OPENSSL_INCLUDE_DIR && \
export CFLAGS="-Wno-error=unused-but-set-variable -Wno-error=unused-variable -Wno-error=unknown-warning-option" && \
rustup run nightly-2025-01-01 cargo build --release --lib && \
cp "$(rustup run nightly-2025-01-01 cargo metadata --format-version 1 | grep -o '"target_directory":"[^"]*"' | head -1 | cut -d'"' -f4)/release/libfff_nvim.dylib" lua/fff.so
```
