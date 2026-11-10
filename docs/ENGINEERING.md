# RC 1.0 engineering findings

RC 1.0 promotes v058 without changing the tested executable.

## Compilation measurements

These measurements are native console compiler benchmarks. They compile into
RAM and verify outputs. Extraction, persistent cache saving and game startup are
outside their compile-time measurement.

| Build | Compile time | Change |
|---|---:|---|
| Earlier reference | 545.7443 s | Approximately nine-minute compiler run |
| v044 | 470.7628 s | Accepted native compiler baseline |
| v049 | 455.9287 s | Worker-local slowest-shader ranking |
| v050 | 359.7835 s | Indexed temporary register allocation |
| v051 | 357.6044 s | Indexed store-group searches |
| v054 | 353.7097 s | CPU sampling at stage boundaries |
| v055 | 354.2928 s | Cooperative yield after each input job |
| v056 | 354.2934 s | Direct copy-propagation tree lookup |

Runs were individual observations under development conditions. The direct
lookup change showed no measurable console improvement. Yielding greatly improved
progress visibility with essentially unchanged total compilation time.

Each completed reference benchmark processed 6,371 inputs, including 6,182
compiles, 125 deduplicated inputs and 64 reference unsupported translations, with
zero failures. It produced 11,814 outputs totaling 257,504,512 bytes with MD5
663d3ada0b41f9a21f7611a1f9f7212a. These 64 translations are a compiler benchmark
reference count. Runtime unsupported guest imports retain explicit stop gates.

## Findings

- Algorithmic indexing in compiler passes produced the largest measured gain.
- Extra compiler workers alone did not establish a speed improvement. Allocator
  configuration and benchmark environment matter when comparing worker counts.
- The compiler runs averaged approximately 12.89 busy logical CPUs with 16 workers.
- Worker-local RAM output batches removed shared cache-lock waiting in benchmarks.
- Compiler cleanup fixes addressed retained allocations.
- Thousands of cache-file operations made persistence a separate performance concern.
- A stalled status display did not reliably indicate stalled compilation.
- Boundary-only CPU sampling did not resolve the reporting stalls by itself.
- Yielding between jobs reduced the observed longest heartbeat gap from about
  334 seconds in v054 to about 32 seconds in v055.
- Rendering warmup and shader bytecode compilation are distinct stages. Finishing
  bytecode preparation does not establish that every rendering pipeline is ready.

## RC runtime configuration

The game uses the v056 compiler archive and the 32-arena native platform library.
Production preparation defaults to 16 compiler workers and eight cache writers.
It uses the production persistence path, with benchmark-only output hashing,
worker batches and diagnostics disabled. PS5 rendering warmup uses one worker.
Guest import and indirect-call checks remain active.

The installer validates extracted files and the versioned shader cache before
opening its display. A ready installation bypasses the setup UI and CPU
calibration. The first-run screen retains stage, overall progress, shader count,
status messages and failure guidance.

## Follow-up validation

Broader firmware and hardware coverage, cold-start performance samples, sustained
play sessions and fresh-install timing remain useful release-candidate tests.
No claim is made that every mode, fighter, stage or online feature is qualified.

