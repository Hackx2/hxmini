# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added [`stringify`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx#L6) method to [`Printer`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx), this method redirects itself to [`Printer.serialize(v1)`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx#L10) - **2025/09/23**.

## [1.0.1] - 2025-09-20

### Added

- Added `@:from` meta to `static` method [`EntryType.fromString`](https://github.com/Hackx2/hxmini/blob/338c809d5d26471e9c7b175caca0abbc1a085350/mini/EntryType.hx#L42).

### Changed

- Turned `instance` method [`EntryType.fromString`](https://github.com/Hackx2/hxmini/blob/338c809d5d26471e9c7b175caca0abbc1a085350/mini/EntryType.hx#L42) into a `static` method.
- Inlined the following `static` methods [`Utils.isWhitespace`](https://github.com/Hackx2/hxmini/blob/1b59bbcacdf3fc07e78cafc539b2a4b5b4bf21f9/mini/Utils.hx#L7), [`Utils.trim_right`](https://github.com/Hackx2/hxmini/blob/1b59bbcacdf3fc07e78cafc539b2a4b5b4bf21f9/mini/Utils.hx#L15) and [`Utils.fixMultiline`](https://github.com/Hackx2/hxmini/blob/1b59bbcacdf3fc07e78cafc539b2a4b5b4bf21f9/mini/Utils.hx#21).

## [1.0.0] - 2025-09-18

### Added

Initial Release.

<!-- should i even include these??? -->

- Added the following classes: [`mini.Ini`](https://github.com/Hackx2/hxmini/blob/3d22408c8c275a4fd7df25085249a915dac2ca91/mini/Ini.hx), [`mini.EntryType`](https://github.com/Hackx2/hxmini/blob/3d22408c8c275a4fd7df25085249a915dac2ca91/mini/EntryType.hx), [`mini.Parser`](https://github.com/Hackx2/hxmini/blob/3d22408c8c275a4fd7df25085249a915dac2ca91/mini/Parser.hx), [`mini.Printer`](https://github.com/Hackx2/hxmini/blob/3d22408c8c275a4fd7df25085249a915dac2ca91/mini/Printer.hx) and [`mini.Utils`](https://github.com/Hackx2/hxmini/blob/3d22408c8c275a4fd7df25085249a915dac2ca91/mini/Utils.hx).

[unreleased]: https://github.com/hackx2/hxmini/compare/1.0.1...main
[1.0.1]: https://github.com/hackx2/hxmini/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/hackx2/hxmini/releases/tag/1.0.0
