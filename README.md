## Vality Packages

Vality is a type-safe validation toolkit for Dart and Flutter. The workspace hosts the pure-Dart validation engine plus a Flutter-oriented package that will surface UI helpers and platform conveniences on top of the same validation primitives. Everything lives under a Melos workspace so shared tooling (tests, coverage, publishing) stays consistent.

## Packages

### `vality`

- Core validation library with composable schemas, fields, and rule builders.
- Covers strings, numbers, collections, and provides helpers for building custom validators.
- Ships translation utilities (`ValityTranslationsHelper`) so validation errors can be localized.
- Includes higher-level primitives like `ValityField` for managing value + schema state.

### `vality_flutter` (Coming Soon)

- Depends on `vality` and will expose Flutter-friendly components (widgets, controllers, hooks) that wrap the same validation engine.
- Intended to keep UI glue separate from the pure-Dart primitives so the core stays framework-agnostic.

## Repository Structure

- `packages/vality`: Core Dart package that provides Vality domain models, utilities, and pure-Dart services. Intended to be platform agnostic and reusable by server or CLI tooling.
- `packages/vality_flutter`: Flutter-specific widgets, platform channels, and integrations that build on `vality` to deliver UI-ready functionality.

## Getting Started

1. Install Flutter (with the matching channel defined under `.fvm/`) and make sure `dart` ≥ 3.10 is available.
2. Activate Melos globally: `dart pub global activate melos`.
3. Bootstrap dependencies from the repo root:
   ```
   melos bootstrap
   ```

## Development Workflow

- Run all package tests (with coverage):
  ```
  melos run test:coverage
  ```
- Generate HTML coverage reports (uses `lcov_fix.dart` and `genhtml`):
  ```
  melos run test:coverage_to_html
  ```
- Target a specific package by using the selective commands defined inside `pubspec.yaml`, e.g. `melos run test:selective`.

## Contributing

1. Make sure changes include tests and documentation updates per package.
2. Run the relevant `melos run test*` scripts locally.
3. Open a PR describing which package(s) your change touches (`vality`, `vality_flutter`, or both).

Future updates will expand each package README with feature-specific guidance.
