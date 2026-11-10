# Tekken Tag Tournament 2 for PS5

**RC 1.0** brings the native port to PS5 homebrew with automatic installation, on-console shader preparation, controller support and profile renaming through the on-screen keyboard.

[Download RC 1.0](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/releases/tag/RC1) · [Engineering notes](docs/ENGINEERING.md) · [Report an issue](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/issues)

Based on the upstream native PC port by shihabal3amri. [Upstream project](https://github.com/shihabal3amri/tekken-tag-tournament-2-pc)

## Requirements

- A PS5 homebrew environment capable of launching native apps through ShadowMount.
- Your own supported Xbox 360 Tekken Tag Tournament 2 ISO dump.
- Title Update 3 matching the supported game version.
- Available console storage for the ISO, update, extracted game and shader cache.

Testing has covered one homebrew PS5 setup. Compatibility across other firmware versions and game revisions remains to be established.

## Install

Place your game dump and update at these exact paths.

```text
/data/ttt2/tekken.iso
/data/ttt2/TU_174Q22P_0000008000000.00000000000O2
```

1. Download and extract `Tekken-PS5-Game-v058.zip`.
2. Close any running Tekken app.
3. Copy the package's single `PPSA99536` folder into your homebrew directory. Replace that app folder when updating.
4. Rescan and install through ShadowMount.
5. Launch **Tekken Tag Tournament 2** and keep the app open until preparation finishes.

The installer extracts game data, applies TU3, prepares shaders on the console and saves the cache. A progress screen shows the current stage, percentage, shader counts and status. The game starts automatically afterward.

Later launches validate the installation and shader cache. A current installation proceeds directly to the game. Preparation returns when required data or shaders are missing or stale.

## Updating

RC 1.0 uses the tested v058 executable, internal version `01.000.058`, app ID `PPSA99536`.

Replace the app folder and rescan ShadowMount. Retain installed game data, shaders, saves and settings. Back up saves before experimenting with installation cleanup.

## Tested features

- Matches against the CPU.
- App restarts and persistent save data.
- Profile renaming with the on-screen keyboard.
- Automatic first-run extraction and shader preparation.
- Subsequent launches that skip the preparation screen when setup is current.

RC 1.0 is a release candidate. Online features, every game mode, and every fighter/stage combination have yet to receive comprehensive testing. Opening movies, menus and character selection may still exhibit stutter on a fresh setup.

## Performance and first launch

The final compiler benchmark completed in approximately **5 minutes 54 seconds**. That measurement covers compilation into RAM and output verification. A fresh installation additionally extracts game files, saves the cache and starts the renderer.

The runtime uses the v056 compiler, 16 preparation workers and eight cache writers. Rendering warmup uses one worker to reduce startup contention. Compiler indexing changes produced the largest measured improvement. [Measurements and findings](docs/ENGINEERING.md)

## Files and troubleshooting

| Purpose | Console path |
|---|---|
| Extracted game | `/data/ttt2/installed-game-maxspeed` |
| Shader cache | `/data/ttt2/shadercache-maxspeed-v1` |
| Saves | `/data/ttt2/experimental-runtime-maxspeed/saves` |
| Settings | `/data/ttt2/experimental-runtime-maxspeed/settings.ini` |
| Runtime log | `/data/ttt2/runtime-maxspeed.log` |

For an installation error, retain the displayed message and runtime log before retrying. For a crash or slowdown, report the app version, whether this was a fresh installation, and what was on screen. Include relevant log excerpts after removing personal information.

## Package verification

Asset `Tekken-PS5-Game-v058.zip` has this SHA-256.

```text
6e51c6298ae818cd091c312a6d78920fccce018dfb16eec2ff29bd1af54b51e9
```

GitHub's uploaded asset digest matches the tested local package.

## Build and review

[Build guide and verification status](docs/BUILDING.md) · [Source review guide](docs/REVIEWING.md)

The build guide distinguishes verified host source tests from PS5 dependency preparation and final packaging. A browsable source snapshot has been prepared, but its bulk upload remains pending approval. RC1 source remains available in the attached release ZIP.

## Credits and source

[Review the implementation](docs/REVIEWING.md) · [RC1 source and executable hashes](docs/RC1-PROVENANCE.json)
Based on the upstream native PC port by shihabal3amri.
The PS5 port was developed by **(OpenAI Codex)** including implementation, debugging, build preparation, shader compiler optimization, installer development and documentation.

PrimetimeFluff directed the project, provided the hardware and game dumps, performed console testing, reported issues and validated the release. The port builds on the work of the upstream developers and PS5 homebrew community.

Credit belongs to the upstream PC port and the authors of the PS5 homebrew SDK, graphics stack and shader compiler. Game artwork and trademarks belong to their respective owners.

The release package includes the port source patch and compiler/SDK source archives. The repository's automatic source ZIP contains the repository documents. The release asset contains the port materials.

A top-level upstream license was absent in the inspected checkout. Upstream distribution terms and the complete dependency notice/source inventory remain unresolved. Preserve applicable third-party notices and license obligations.
