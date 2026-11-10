# Reviewing RC 1.0

The implementation materials are inside the attached release asset
[Tekken-PS5-Game-v058.zip](https://github.com/PrimetimeFluff/tekken-tag-tournament2-ps5/releases/tag/RC1).
GitHub's automatically generated source archives contain this repository's files.
Download the attached game package to obtain the port patch and dependency archives.

## Source materials

| File inside the release package | Purpose |
|---|---|
| ps5-runtime-components.patch | Changes across 307 source, test and documentation files |
| vkd3d-store-index-source.tar.gz | Shader compiler source preceding the direct-lookup experiment |
| lookup-v056-source.tar.gz | Replacement compiler source for the v056 direct lookup |
| lookup-v056.patch | Direct-lookup change relative to the preceding compiler source |
| sdk-platform-source.tar.gz | Native platform source used for the allocator changes |
| v058-vs-v057.patch | Focused first-run UI and startup changes |
| lookup-v056-archive-proof.json | Compiler archive identity and changed object |

The port patch is based on upstream commit
`007c523fae876079d74bd9265fb04009e17c6514`.
Review additions under `port/src/runtime`, `port/src/setup`,
`port/tests/ps5` and `port/tools`.

## Inspect the port changes

After extracting the release package, clone the upstream project and check out
the recorded revision. Run these commands from a separate review checkout,
with the patch copied to its parent directory.

```sh
git clone https://github.com/shihabal3amri/tekken-tag-tournament-2-pc.git ttt2-review
cd ttt2-review
git checkout 007c523fae876079d74bd9265fb04009e17c6514
python3 - <<'PY'
from pathlib import Path
import subprocess
for name in subprocess.check_output(["git", "ls-files", "-z"]).split(b"\0"):
    if not name:
        continue
    path = Path(name.decode())
    raw = path.read_bytes()
    try:
        raw.decode("utf-8")
    except UnicodeError:
        continue
    if b"\0" not in raw and b"\r\n" in raw:
        path.write_bytes(raw.replace(b"\r\n", b"\n"))
PY
git apply --stat ../ps5-runtime-components.patch
git apply --check ../ps5-runtime-components.patch
git apply ../ps5-runtime-components.patch
git diff --stat
```

New files added by a patch are untracked until staged. Inspect them directly or
use `git status --short` alongside the tracked diff. Review the patch itself to
see all additions. These commands prepare a source review checkout. The normalization step is required because several upstream text files contain CRLF endings and the exported patch uses LF.

## Areas to inspect

- Installer input validation, extraction helper and completion records.
- Shader output ownership, cache persistence and failure handling.
- Guest import and indirect-call rejection gates.
- Save paths and on-screen keyboard integration.
- Compiler temporary-register indexing, store-group indexing and direct lookup.
- The completed-install fast path and preparation screen rendering.

The source patch includes focused tests. Consult each test's runner and
dependencies before executing it. [Recorded performance findings](ENGINEERING.md)
describe benchmark scope and observed results.

## Build and validation status

See [the build guide](BUILDING.md) for verified fresh-source host checks, pinned dependency references, native component commands and remaining full-build requirements. The browsable snapshot is prepared locally, with its bulk publication pending approval.

Development used WSL Ubuntu, LLVM 18 and the PS5 homebrew payload SDK, with native
graphics, compiler, media and recompiled CPU archives. The link script refers to
external build directories and archives from the development workspace. Source
availability does not establish a complete clean-machine build recipe.

A clean rebuild using only public materials has not yet been performed.
Dependency revisions, complete third-party source/notice coverage, portable
dependency build instructions and an independently verified rebuild remain
follow-up work. The current repository therefore supports source inspection,
while reproducibility still needs validation.

[Artifact hashes and build provenance](RC1-PROVENANCE.json) identify the inspected
release materials and executable. Existing benchmark results establish reference
output agreement for those tests. They do not establish every game mode or input
is covered.
