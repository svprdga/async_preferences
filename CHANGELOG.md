# Change log

## [1.1.0] - 2025-09-11

### Changed

- Updated Android build toolchain (Kotlin 2.1.0, AGP 8.1.1, Gradle 8.14.3, compileSdk 35, JVM target 11)

### Fixed

- Moved calls containing the Preferences API to background operations to prevent potential UI freezes (ANRs)

## [1.0.2] - 2025-02-19

### Fixed

- [#37] - Adapt to Flutter 3.29

## [1.0.1] - 2024-10-16

### Fixed

- Upgrade native android dependencies

## [1.0.0] - 2024-06-29

### Added

- Update Gradle project to adapt it to the latest version
- Updated example project

## [0.9.0] - 2024-03-16

### Changed

- Update dependencies

## [0.8.0] - 2023-09-09

### Added

- Instructions in the README.md file

### Changed

- Update dependencies
- Project license

## [0.7.0] - 2022-10-06

### Changed

- Update dependencies

## [0.6.0] - 2021-12-03

### Added

- Add support for native Long type

## [0.5.0] - 2021-04-18

### Added

- Option to specify the target preference file (Android only)

## [0.4.0] - 2021-04-14

### Added

- Option to remove a preference

## [0.3.0] - 2021-03-17

### Changed

- Migrate to null safety

## [0.2.0] - 2021-01-12

### Added

- iOS support

## [0.1.0] - 2020-11-07

### Added

- Persist and retrieve strings, booleans and ints in Android
