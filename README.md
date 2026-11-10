# Tekken Tag Tournament 2 for PS5 — RC 1.0

An experimental PS5 homebrew port based on
[shihabal3amri/tekken-tag-tournament-2-pc](https://github.com/shihabal3amri/tekken-tag-tournament-2-pc).
RC 1.0 uses the tested v058 binary, with internal app version 01.000.058.

[Download RC 1.0](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/releases/tag/RC1)

The release asset is `Tekken-PS5-Game-v058.zip`. Its SHA-256 is

```text
6e51c6298ae818cd091c312a6d78920fccce018dfb16eec2ff29bd1af54b51e9
```

[Engineering findings and compiler measurements](docs/ENGINEERING.md)

## Installation

Use your own supported Xbox 360 game dump and Title Update 3.
Place the inputs at these exact paths.

```text
/data/ttt2/tekken.iso
/data/ttt2/TU_174Q22P_0000008000000.00000000000O2
```

1. Close the running game.
2. Extract the release ZIP on your computer.
3. Copy its single PPSA99536 folder into your homebrew directory.
4. Rescan and install using ShadowMount, then launch Tekken Tag Tournament 2.
5. Keep the app open while it extracts game data, compiles shaders and saves the cache.

The game launches automatically when preparation completes. Later launches
validate the installed files and shader cache and skip the preparation screen
when both are current. Missing or stale shaders trigger preparation again.
Updates retain saves and settings. A normal app update does not require deleting
installed game files or shaders.

## Tested behavior

The tester reported successful matches, app restarts, persistent save data and
renamed profiles. Controller-driven profile renaming uses the on-screen keyboard.
The tester also reported v057 ran perfectly and accepted v058 as RC 1.0.
Testing was performed on one homebrew PS5 environment using ShadowMount.
Compatibility with additional consoles, firmware versions and game dump variants
requires further testing. Online functionality has not been qualified for this release.

## Installation and runtime paths

| Purpose | Path |
|---|---|
| Extracted game | /data/ttt2/installed-game-maxspeed |
| Compiled shader cache | /data/ttt2/shadercache-maxspeed-v1 |
| Saves | /data/ttt2/experimental-runtime-maxspeed/saves |
| Settings | /data/ttt2/experimental-runtime-maxspeed/settings.ini |
| Runtime log | /data/ttt2/runtime-maxspeed.log |

## Troubleshooting

If installation stops, retain the message and runtime log before retrying.
For crashes, record what was on screen, the app version, whether this was the
first launch, and any available kernel fault report.
For stuttering, report whether it occurs in the opening movie, menus, character
selection or an active match. Include the runtime log from that session.
Avoid posting save data or personal network details in public issue reports.

## Attribution and distribution status

The upstream PC port, PS5 payload SDK, graphics stack and shader compiler retain
their authorship and applicable licenses. Preserve their notices and source
requirements when distributing binaries. Game artwork and trademarks belong to
their respective owners.

Publication preparation found no top-level license file in the upstream checkout.
Confirm the applicable upstream distribution terms and complete a dependency
license/source inventory before publishing a binary release. Source changes and
compiler/SDK source archives are included in the existing v058 package, but their
presence alone does not establish complete license compliance.

