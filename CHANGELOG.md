# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added [`mini.Exception`](https://github.com/Hackx2/hxmini/blob/7b18b08538a5f72445bb2dd7b0f74b5df70fc752/mini/Exception.hx) & [`mini.types.ExceptionKind`](https://github.com/Hackx2/hxmini/blob/05a4698b7f296542219c4c62ca4d90f74db3293a/mini/types/ExceptionKind.hx).
- Added the following [`Exception`](https://github.com/Hackx2/hxmini/blob/7b18b08538a5f72445bb2dd7b0f74b5df70fc752/mini/Exception.hx)'s: [`EUnterminatedMultilineValue`](https://github.com/Hackx2/hxmini/blob/7b18b08538a5f72445bb2dd7b0f74b5df70fc752/mini/Parser.hx#L78), [`EUnknownLine`](https://github.com/Hackx2/hxmini/blob/7b18b08538a5f72445bb2dd7b0f74b5df70fc752/mini/Parser.hx#L90), and [`EMalformedSection`](https://github.com/Hackx2/hxmini/blob/7b18b08538a5f72445bb2dd7b0f74b5df70fc752/mini/Parser.hx#L41) exceptions to the [`Parser`](https://github.com/Hackx2/hxmini/blob/commit/mini/Parser.hx#LXX).
-  Added [`stringify`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx#L6) method to [`Printer`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx), this method redirects itself to [`Printer.serialize(v1)`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Printer.hx#L10).

### Changed

- Moved [`mini.EntryType`](https://github.com/Hackx2/hxmini/blob/05a4698b7f296542219c4c62ca4d90f74db3293a/mini/EntryType.hx) to [`mini.types.EntryType`](https://github.com/Hackx2/hxmini/blob/05a4698b7f296542219c4c62ca4d90f74db3293a/mini/types/EntryType.hx).
- Changed `static` method [`Utils.fixMultiline`](https://github.com/Hackx2/hxmini/blob/1f4e06f6e5ec8d19fffa69761bc69676ee1b0e39/mini/Utils.hx#L21) to [`Utils.wrapMultiline`](https://github.com/Hackx2/hxmini/blob/3d4986f79fe008df86dc63ce95343a3947da51b8/mini/Utils.hx#L26).
- Kept method [`Utils.fixMultiline`](https://github.com/Hackx2/hxmini/blob/3d4986f79fe008df86dc63ce95343a3947da51b8/mini/Utils.hx#L22) for backwards compatibility.
- Used [`StringTools.rtrim`](https://api.haxe.org/StringTools.html#rtrim) in [`mini.Parser.parse(v1)`](https://github.com/Hackx2/hxmini/blob/8f33ff8c85054055d07aee33c84f47fe2976f424/mini/Parser.hx#L48) instead of the `deprecated` method [`Utils.trim_right`](https://github.com/Hackx2/hxmini/blob/eaa04f6f49f45a75a0597e899fa591cf15a58b7e/mini/Utils.hx#L37)

### Deprecated
- [`Utils.fixMultiline`](https://github.com/Hackx2/hxmini/blob/3d4986f79fe008df86dc63ce95343a3947da51b8/mini/Utils.hx#L22).
- [`Utils.trim_right`]()
- [`Utils.isWhitespace`]()

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
