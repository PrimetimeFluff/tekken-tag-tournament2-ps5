#!/usr/bin/env bash
# Configure a fresh PS5 component build using explicit caller-built dependencies.
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
: "${PS5_SDK:?Set PS5_SDK to the built SDK prefix}"
: "${PS5_PPC_ARCHIVE:?Set PS5_PPC_ARCHIVE to your generated PS5 CPU archive}"
: "${DXVK_SOURCE:?Set DXVK_SOURCE}"
: "${OPENSSL_PS5_ROOT:?Set OPENSSL_PS5_ROOT}"
: "${VKD3D_SOURCE:?Set VKD3D_SOURCE}"
: "${FFMPEG_SOURCE:?Set FFMPEG_SOURCE}"
: "${FFMPEG_PS5_BUILD:?Set FFMPEG_PS5_BUILD}"
build="$repo/source/port/build-ps5-components"
if [[ -e "$build" ]]; then
    printf 'Fresh output required. An existing directory is present at %s\n' "$build" >&2
    exit 2
fi
test -f "$PS5_SDK/toolchain/prospero.cmake"
test -f "$PS5_PPC_ARCHIVE"
test -f "$repo/source/re/ppc/ppc_recomp_shared.h"
cmake -S "$repo/source/port" -B "$build" -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE="$PS5_SDK/toolchain/prospero.cmake" \
    -DCMAKE_BUILD_TYPE=Release -DTTT2_PS5=ON -DTTT2_PS5_FULL_GAME=ON \
    -DTTT2_PS5_COMPILER_BENCHMARK=OFF \
    -DTTT2_PS5_PPC_ARCHIVE="$PS5_PPC_ARCHIVE" \
    -DTTT2_PS5_DXVK_SOURCE="$DXVK_SOURCE" \
    -DTTT2_PS5_OPENSSL_ROOT="$OPENSSL_PS5_ROOT" \
    -DTTT2_PS5_VKD3D_SOURCE="$VKD3D_SOURCE" \
    -DFFMPEG_SRC="$FFMPEG_SOURCE" -DFFMPEG_BUILD="$FFMPEG_PS5_BUILD" \
    -DPython3_EXECUTABLE="$(command -v python3)"
cmake --build "$build" --target \
    ttt2_ps5_entry ttt2_ps5_game_support ttt2_ps5_renderer \
    ttt2_ps5_kernel_audit ttt2_ps5_import ttt2_ffmpeg \
    ttt2_ps5_files ttt2_ps5_storage ttt2_ps5_random ttt2_ps5_vm \
    ttt2_ps5_mirror ttt2_ps5_threads ttt2_ps5_window ttt2_ps5_input \
    ttt2_ps5_display ttt2_ps5_audio ttt2_ps5_settings ttt2_ps5_kernel_core \
    -j "${BUILD_JOBS:-4}"

