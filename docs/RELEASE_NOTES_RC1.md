## RC 1.0

First public release candidate, based on the tested **v058** build. Internal app version **01.000.058**, app ID **PPSA99536**.

### Included

- Automatic extraction from your own Xbox 360 ISO and Title Update 3.
- On-console shader preparation and persistent cache.
- Redesigned preparation screen with stage, percentage, shader counts and status.
- Subsequent launches skip preparation when the installed files and shader cache are current.
- Controller support and on-screen keyboard for profile renaming.
- One rendering warmup worker to reduce startup contention.

### Installation

Place the required inputs at these exact paths.

```text
/data/ttt2/tekken.iso
/data/ttt2/TU_174Q22P_0000008000000.00000000000O2
```

Extract **Tekken-PS5-Game-v058.zip**, close Tekken, copy its **PPSA99536** folder into your homebrew directory, rescan ShadowMount and launch **Tekken Tag Tournament 2**. Keep the app open through preparation. The game starts automatically.

For updates, retain installed data, shaders, saves and settings.

### Validation and performance

The tester completed CPU matches and confirmed persistent saves and renamed profiles after restarting. Testing covers one PS5 homebrew setup. Broader firmware coverage and comprehensive mode/fighter/stage testing remain pending. First-use rendering stutter may still occur.

The final compiler benchmark took approximately **5m 54s**. Full installation additionally includes extraction, cache saving and renderer startup.

### Verify your download

```text
SHA-256  Tekken-PS5-Game-v058.zip
6e51c6298ae818cd091c312a6d78920fccce018dfb16eec2ff29bd1af54b51e9
```

The uploaded ZIP matches the tested local package.

[Installation instructions](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5#install) · [Engineering findings](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/blob/main/docs/ENGINEERING.md)

Report issues with the app version, current screen and relevant excerpts from **/data/ttt2/runtime-maxspeed.log**. Remove personal details before posting.
