# Tekken Tag Tournament 2 for PS5

**RC 1.0.059 — Native PS5 Homebrew Port**

Tekken Tag Tournament 2 for PS5 is a native homebrew port featuring automatic game-data installation, on-console shader preparation, controller support, persistent saves, and profile renaming through the on-screen keyboard.

**[Download the latest release](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/releases/tag/01.000.059)** · [Engineering notes](docs/ENGINEERING.md) · [Report an issue](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/issues)

Based on the upstream native PC port by shihabal3amri.

[Upstream project](https://github.com/shihabal3amri/tekken-tag-tournament-2-pc)

## Requirements

- A PS5 homebrew environment capable of launching native applications through ShadowMount.
- **Tekken Tag Tournament 2 (USA, Europe)** — Xbox 360 disc image (ISO).
- **Title Update 3 (TU3)** matching the supported Xbox 360 game version.
- Sufficient console storage for the ISO, title update, extracted game data, and shader cache.

**Important:** The supported disc image is specifically the Xbox 360 release identified as **Tekken Tag Tournament 2 (USA, Europe)**.

Other regional revisions, modified disc images, and PS3 or Wii U versions have not been verified for compatibility.

Commercial game files are not included. Users must provide their own legally obtained Xbox 360 game dump and matching title update.

Testing has covered one homebrew PS5 setup. Compatibility across other firmware versions and game revisions remains to be established.

## Installation

### Step 1 — Prepare your Xbox 360 game files

Obtain a disc image from your own copy of:

**Tekken Tag Tournament 2 (USA, Europe) — Xbox 360**

Rename the ISO file to exactly:

`tekken.iso`

Place it on your PS5 at:

`/data/ttt2/tekken.iso`

Do not extract the ISO or modify its contents. Only rename the file.

Next, place the matching Xbox 360 **Title Update 3 (TU3)** file at:

`/data/ttt2/TU_174Q22P_0000008000000.00000000000O2`

Your PS5 should now contain both files at these exact paths:

```text
/data/ttt2/tekken.iso
/data/ttt2/TU_174Q22P_0000008000000.00000000000O2
```

File names and paths are case-sensitive.

### Step 2 — Install the PS5 application

1. Download `PPSA99536.zip` from the [latest GitHub release](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/releases/tag/01.000.059).
2. Extract the ZIP archive.
3. Close any running Tekken Tag Tournament 2 application.
4. Copy the extracted `PPSA99536` folder into your PS5 homebrew application directory.
5. Rescan and install the application through ShadowMount.
6. Launch **Tekken Tag Tournament 2**.

### Step 3 — First launch and automatic preparation

On the first launch, the application automatically:

- Extracts the required game data from your supplied Xbox 360 ISO.
- Applies the matching Title Update 3.
- Prepares and compiles shaders directly on the PS5.
- Saves the shader cache for future launches.
- Starts the game after preparation completes.

A progress screen displays the current stage, percentage, shader counts, and installation status.

**Do not close the application while first-run preparation is in progress.**

Subsequent launches validate the installed game data and shader cache. If everything is current, the game launches without repeating the full preparation process.

Preparation runs again when required files or cached shaders are missing or outdated.

## Updating

**Current GitHub release:** `01.000.059`

**Current internal PS5 contentVersion:** `01.000.058`

**PS5 Title ID:** `PPSA99536`

The `01.000.059` GitHub release currently packages the tested v058 executable, which reports `contentVersion` `01.000.058` in `sce_sys/param.json`.

These version numbers are intentionally documented separately to reflect the published artifact accurately. Future releases should increment the internal content version so consoles can recognize updates.

To update:

1. Download the newer release ZIP.
2. Close the running application.
3. Replace the existing `PPSA99536` application folder.
4. Rescan and reinstall through ShadowMount.
5. Launch the updated application.

Retain your installed game data, shader cache, saves, and settings.

Back up save files before experimenting with installation cleanup.

## Tested features

The following features have been tested:

- Matches against the CPU.
- Controller input.
- Application restarts.
- Persistent save data.
- Profile renaming using the on-screen keyboard.
- Automatic first-run game-data extraction.
- Automatic shader preparation and caching.
- Subsequent launches that skip preparation when the installation is current.

This is a release candidate.

Online features, every game mode, and every fighter/stage combination have not received comprehensive testing.

Opening movies, menus, and character selection may exhibit stutter during a fresh installation.

## Performance and first launch

The final compiler benchmark completed in approximately **5 minutes 54 seconds**.

This measurement covers compilation into RAM and output verification. A fresh installation additionally extracts game files, saves the cache, and initializes the renderer.

The runtime uses the v056 compiler, 16 preparation workers, and eight cache writers. Rendering warmup uses one worker to reduce startup contention.

Compiler indexing changes produced the largest measured improvement.

[Measurements and engineering findings](docs/ENGINEERING.md)

## Files and troubleshooting

| Purpose | Console path |
|---|---|
| Xbox 360 ISO | `/data/ttt2/tekken.iso` |
| Title Update 3 | `/data/ttt2/TU_174Q22P_0000008000000.00000000000O2` |
| Extracted game | `/data/ttt2/installed-game-maxspeed` |
| Shader cache | `/data/ttt2/shadercache-maxspeed-v1` |
| Saves | `/data/ttt2/experimental-runtime-maxspeed/saves` |
| Settings | `/data/ttt2/experimental-runtime-maxspeed/settings.ini` |
| Runtime log | `/data/ttt2/runtime-maxspeed.log` |

### Installation problems

If installation fails:

1. Verify that the ISO is the supported **Tekken Tag Tournament 2 (USA, Europe)** Xbox 360 disc image.
2. Confirm that the ISO is named `tekken.iso`.
3. Verify that the ISO and TU3 file are in their required locations.
4. Confirm that the title update matches the supported game revision.
5. Record any displayed error message.
6. Preserve the runtime log before retrying.

For crashes or performance issues, include the application version, whether this was a fresh installation, and what was happening when the issue occurred.

Remove personal information from logs before submitting a bug report.

[Report an issue](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/issues)

## Package verification

**Current release asset:** `PPSA99536.zip`

**Release tag:** `01.000.059`

**SHA-256:**

```text
95962deb9a6833747d0fb5dd7b5faeab89de21405e1a663cf11f3943ed4cffd8
```

This checksum matches the published GitHub release asset.

The archive contains:

```text
PPSA99536/
PPSA99536/eboot.bin
PPSA99536/sce_sys/param.json
```

The included `param.json` reports:

```json
{
  "titleId": "PPSA99536",
  "contentVersion": "01.000.058",
  "masterVersion": "01.00"
}
```

These are the relevant metadata fields from the packaged file.

Do not install a package if its checksum differs unexpectedly from the published release.

## Build and review

[Build guide and verification status](docs/BUILDING.md) · [Source review guide](docs/REVIEWING.md)

The build guide distinguishes verified host source tests from PS5 dependency preparation and final packaging.

A browsable source snapshot has been prepared, but its bulk upload remains pending approval.

RC1 source materials remain available in the attached release archive.

## Credits and source

[Review the implementation](docs/REVIEWING.md) · [RC1 source and executable hashes](docs/RC1-PROVENANCE.json)

This project builds on the upstream native PC port by **shihabal3amri**.

The PS5 port was developed with **OpenAI Codex**, including implementation, debugging, build preparation, shader compiler optimization, installer development, and documentation.

**PrimetimeFluff** directed the project, supplied the hardware and game dumps, performed console testing, reported issues, and validated the release.

Credit belongs to the upstream PC port developers and the authors of the PS5 homebrew SDK, graphics stack, shader compiler, and other dependencies.

Game artwork, names, and trademarks belong to their respective owners.

The release package includes port source patches and compiler/SDK source archives. The repository's automatically generated source ZIP contains the repository documents.

### Licensing and distribution

The repository currently declares an MIT license, but a top-level license was absent in the inspected upstream checkout. Upstream distribution terms and the complete third-party dependency notice/source inventory remain unresolved.

The MIT declaration should not be interpreted as granting rights to upstream code or third-party components whose licensing has not been verified.

Applicable third-party notices and license obligations must be preserved and resolved before broader redistribution.

Commercial Tekken Tag Tournament 2 game data is not included. Users must supply their own legally obtained game files.
