#!/bin/bash
# SessionStart hook for Claude Code on the web.
#
# Builds and installs the bundled src/shared/libosmocore for the host, so the
# host tools (osmocon, gsmmap, ...) can be configured and built via pkg-config.
set -euo pipefail

# Only needed in the remote (web) environment.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
LIBOSMO="$REPO/src/shared/libosmocore"
export DEBIAN_FRONTEND=noninteractive

# Build prerequisites (usually preinstalled; install only what is missing).
missing=()
for p in build-essential autoconf automake libtool pkg-config; do
  dpkg -s "$p" >/dev/null 2>&1 || missing+=("$p")
done
if [ ${#missing[@]} -gt 0 ]; then
  apt-get update -qq
  apt-get install -y -qq --no-install-recommends "${missing[@]}"
fi

# Make the /usr/local install visible to configure scripts in this session.
if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  {
    echo 'export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"'
    echo 'export LD_LIBRARY_PATH="/usr/local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"'
  } >> "$CLAUDE_ENV_FILE"
fi
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

# Idempotent: skip the build when a cached container already has it installed.
if pkg-config --exists libosmocore libosmovty libosmogsm libosmocodec; then
  echo "libosmocore already installed; nothing to do"
  exit 0
fi

cd "$LIBOSMO"
autoreconf -fi
mkdir -p build-host
cd build-host
../configure --prefix=/usr/local --disable-pcsc

# Work around a bug in include/Makefile.am: it lists a bare
# 'osmocom/core/crcgen.h' that the crc%gen.h pattern rule cannot generate
# (nothing in the tree includes that header). Patch the *generated* Makefile
# so the tracked libosmocore sources stay untouched.
sed -i 's# osmocom/core/crcgen.h##g' include/Makefile

make -j"$(nproc)"
make install
ldconfig

echo "libosmocore (host) built and installed to /usr/local"
