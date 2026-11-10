# Building the PS5 port

The prepared RC1 source snapshot uses `source/`. The bulk source upload is currently pending publication approval.
It combines upstream revision `007c523fae876079d74bd9265fb04009e17c6514`
with the RC1 port changes. Compiler changes are under `compiler/`.
Private workstation paths and LAN examples are normalized. Historical session
notes and game-derived generated files are excluded.

## Validation status

| Stage | Status |
|---|---|
| Upstream snapshot plus release patch | Applied successfully after CRLF normalization |
| Release patch coverage | All 307 patched text files matched the development checkout before metadata normalization |
| Host progress, keyboard and heartbeat tests | Passed from the reconstructed source, including sanitizer checks |
| Fresh public-checkout PS5 component build | Requires the dependencies and generated inputs below |
| Full clean-machine native link and signed package | Pending complete graphics-workspace provenance and dependency rebuild validation |

The host checks below are a verified clean-source procedure. The native section
records actual build inputs and commands. It is not yet an independently
validated clean-machine production recipe.

## Host environment

Development used Ubuntu through WSL, LLVM/Clang 18, CMake, Ninja, Python 3 and
Git. Native homebrew compilation additionally needs the PS5 SDK and dependencies.
On Ubuntu, install the following development packages if absent.

```sh
sudo apt-get update
sudo apt-get install git cmake ninja-build clang-18 llvm-18-dev g++ python3 pkg-config libssl-dev
```

These commands install system packages and require administrator permission.

## Fresh checkout and portable tests

```sh
git clone https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5.git
cd tekken-tag-tournament2-ps5
bash tools/check-source.sh
```

The runner gives the existing tests a fresh temporary HOME so previous test
objects cannot be reused. It runs the real progress gate, keyboard integration
and independent heartbeat tests. Fixtures remain in that temporary directory
for inspection. These tests use synthetic inputs and do not require game data.

## Dependency revisions

| Dependency | RC1 reference |
|---|---|
| Upstream game port | 007c523fae876079d74bd9265fb04009e17c6514 |
| XenonRecomp | ddd128bcca99fe8bfbb99bea583c972351fa6ace |
| PS5 payload SDK fork | b83202be73e930050e00de0f1b4d9ec46c0391bf |
| PS5 Mesa fork | 1ba9874f478657ccf6da72ce55f0260164cc0bd0 |
| DXVK | 9d6f54a1ade20d1d27dd421024717a636f3d8c68, v2.6.2 |
| vkd3d shader compiler | 1.17 with PS5 ABI, cleanup, register/store indexes and v056 direct lookup |
| FFmpeg | 7.1, configured for the XMA-only static build |
| OpenSSL | PS5 build described by the included port tools and patch |
| PS5_Vulkan integration workspace | Exact checkout revision unavailable in the RC1 development copy |

The SDK commit alone does not describe the modified 32-arena platform archive.
The release contains corresponding platform source. The compiler release source
contains the v051 base, with the final v056 `hlsl_codegen.c` and indexed `ir.c`
available directly under `compiler/`.

References

- [XenonRecomp](https://github.com/hedge-dev/XenonRecomp)
- [PS5 payload SDK fork](https://github.com/mihawk-99/PS5_PayloadSDK)
- [PS5 Mesa fork](https://github.com/mihawk-99/PS5_Mesa)
- [PS5 Vulkan integration](https://github.com/mihawk-99/PS5_Vulkan)
- [DXVK](https://github.com/doitsujin/dxvk)

## Generate game-derived inputs

Use your own supported Xbox 360 disc dump and TU3. The upstream regeneration
procedure is preserved in `source/BUILDING.md`. It describes extracting
`Default.xex`, applying TU3, building the pinned/patched XenonRecomp,
generating `source/re/ppc`, applying generated-code fixes and checking acceptance.
Review that procedure before running its Windows-specific commands.

Clone XenonRecomp into `source/tools/XenonRecomp`, check out the pinned revision,
initialize its submodules and apply `source/tools/patches/XenonRecomp.patch`.
Its dependencies include SIMDe, TinySHA1, libmspack and tiny-AES-c. The PS5 runtime
also uses these headers and importer components.

The generated C++ and CPU archive come from game inputs and are not checked in.
The native compile requires both the generated headers in `source/re/ppc` and
a PS5 CPU archive produced from them.

## Native component compilation

Keep this workspace layout when using the existing native link/helper scripts.

```text
tekken-tag-tournament2-ps5/
  source/
  compiler/
  graphics-build/
    PS5_Vulkan/
      .deps/native/ps5-payload-sdk/
      .deps/native/radv-release/
    dxvk-v2.6.2/
    openssl-ps5/
    vkd3d-1.17/
    tekken-display-title/obj/
    tekken-runtime-graphics/stubs/
    tekken-gpu-display/
    tekken-full-game/
  build-ps5-cpu-check/
```

Set paths to the dependencies you built, then configure a new output directory.
Use absolute paths for these environment variables.

```sh
export PS5_SDK="/absolute/path/to/ps5-payload-sdk"
export PS5_PPC_ARCHIVE="/absolute/path/to/libtekken_ppc.ps5.a"
export DXVK_SOURCE="/absolute/path/to/dxvk-v2.6.2"
export OPENSSL_PS5_ROOT="/absolute/path/to/openssl-ps5"
export VKD3D_SOURCE="/absolute/path/to/vkd3d-1.17"
export FFMPEG_SOURCE="/absolute/path/to/ffmpeg-7.1"
export FFMPEG_PS5_BUILD="/absolute/path/to/configured-ffmpeg-ps5"
bash tools/build-components.sh
```

This builds the native components and full-game object targets with the
compiler benchmark disabled. Supplying an existing CPU archive and dependency
builds is an explicit prerequisite of this step. The script refuses an existing
component output directory to ensure a fresh configuration.

The current CMake also expects RADV headers beneath
`graphics-build/PS5_Vulkan/.deps/native/radv-release/include`.
FFmpeg configuration and generated headers must match its XMA-only build.

## Final linking and packaging

`source/port/tools/link_ps5_full_game.sh` records the RC1 native link recipe.
Its required inputs include the CPU archive, component objects, RADV and platform
archives, OpenSSL, the modified vkd3d shader compiler, the PS5 DXVK display archive,
native CRT/C++ runtime objects, AGC import stubs and a generated weak-import
response file. The strict startup gate is enabled with `TTT2_PS5_STARTUP_GATE=1`.
Preserve the explicit unsupported-import and indirect-call rejection behavior.

The linked ELF is converted and signed using PS5_Vulkan's `ps5-native-tool`.
The native package additionally includes the installer and cache-writer payloads,
`libc.prx`, icon and app metadata. The payload build scripts are in
`source/port/tools`.

Before claiming a full clean build, finish pinning and publishing the graphics
integration recipe, reproduce its CRT/display/stub/weak-import inputs, rebuild
the modified compiler and platform archives, and validate a signed package made
from a checkout on a machine without the development build tree. Do not substitute
success stubs for unresolved imports.

## Verification

The RC1 package and source hashes are recorded in `docs/RC1-PROVENANCE.json`.
The source publication manifest records the normalized browsable files.
Compare runtime behavior and benchmark output against the engineering notes.
A later source build can differ from RC1's package bytes because of toolchain,
path and timestamp differences. No bit-for-bit rebuild claim has been established.

