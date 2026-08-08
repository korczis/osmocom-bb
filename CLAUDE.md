# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this is

OsmocomBB — a Free Software GSM baseband implementation (snapshot of
git://git.osmocom.org/osmocom-bb.git, circa 2012). It contains:

- `src/host/` — PC-side tools: `osmocon` (RAM loader for Calypso phones),
  `layer23` (GSM L2/L3 apps incl. `mobile`), `gsmmap`, `calypso_pll`,
  `rita_pll`, `fb_tools`
- `src/target/firmware/` — bare-metal ARM firmware for TI Calypso phones
  (Motorola C1xx family and others)
- `src/target_dsp/calypso/` — DSP assembly code
- `src/shared/libosmocore/` — bundled copy of libosmocore.
  **Do not commit changes to this subtree** — it is maintained upstream in
  git://git.osmocom.org/libosmocore.git and synchronized here (see
  `src/README.development`).

## Building

The SessionStart hook (`.claude/hooks/session-start.sh`) builds and installs
the bundled libosmocore for the host into `/usr/local` in remote (web)
sessions, and exports `PKG_CONFIG_PATH`/`LD_LIBRARY_PATH` accordingly.

Working host builds (from `src/`):

```sh
make osmocon    # works
make gsmmap     # works
```

Known-broken in this snapshot (pre-existing issues, not environment issues):

- `make layer23` — fails in `src/host/layer23/src/mobile/gsm411_sms.c`:
  it calls `gsm411_smc_init()`/`gsm411_smr_init()` with more arguments than
  the bundled libosmocore headers declare. The layer23 sources are newer than
  the bundled libosmocore copy.
- `make firmware` / `make libosmocore-target` — the firmware's private
  `src/target/firmware/include/stdint.h` conflicts with modern
  `arm-none-eabi` newlib headers (`int32_t` typedef mismatch). The firmware
  was written for a ~2010 `arm-elf` bare-metal toolchain.
- libosmocore's `include/Makefile.am` lists a bare `osmocom/core/crcgen.h`
  that its `crc%gen.h` pattern rule cannot generate. The session hook patches
  the *generated* Makefile at build time; the tracked subtree stays pristine.

## Testing

libosmocore unit tests live in `src/shared/libosmocore/tests/`. With the
host build present in `src/shared/libosmocore/build-host/`:

```sh
cd src/shared/libosmocore/build-host/tests
make bits/bitrev_test a5/a5_test && ./bits/bitrev_test && ./a5/a5_test
```

(`make check` as a whole does not pass: `timer_test` includes
`../../config.h` with a path that breaks in out-of-tree builds.)

## Coding style

Linux kernel coding style (tabs, K&R braces) — see `src/README.development`.
No linter is bundled; keep new code warning-clean instead.
