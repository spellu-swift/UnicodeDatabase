# UnicodeDatabase

Unicode Character Database (UCD) properties and mappings for Swift. This package provides `General Category`, `Binary Property`, and `Simple Case Folding` data.

## Unicode version

The data in this package is based on Unicode 17.0.0. The original UCD data is available from the [Unicode 17.0.0 UCD archive](https://www.unicode.org/Public/17.0.0/ucd/).

## Products and modules

The `UnicodeDatabase` library product contains these modules:

- `UnicodeGeneralCategory` provides individual and aggregate `General Category` values, such as `Lu` (uppercase letter) and `L` (letter).
- `UnicodeBinaryProperty` provides `Binary Property` values, such as `Alphabetic`, `White_Space`, and `Emoji`.
- `UnicodeCaseFolding` provides `Simple Case Folding` mappings and equivalent code points.

The public types are declared under `UnicodeProperty`, which is defined by the `Basis` package.

## Requirements

- Swift 6.2 or later
- macOS 14 or later
- iOS 17 or later

The `rangeSet` properties are available on macOS 15, iOS 18, and later.

## Add the package

Add both `Basis` and `UnicodeDatabase` to your package dependencies:

```swift
dependencies: [
	.package(url: "git://git.orion/swift/Basis", branch: "develop"),
	.package(url: "git://git.orion/swift/UnicodeDatabase", branch: "develop"),
]
```

Add their products to the target that uses the database:

```swift
dependencies: [
	.product(name: "Basis", package: "Basis"),
	.product(name: "UnicodeDatabase", package: "UnicodeDatabase"),
]
```

## Usage

```swift
import Basis
import UnicodeBinaryProperty
import UnicodeCaseFolding
import UnicodeGeneralCategory

let category = UnicodeProperty.GeneralCategory.from("Lu")
let isWhitespace = UnicodeProperty.BinaryProperty.whitespace.ranges
	.contains { $0.contains(0x0020) }

let folded = UnicodeProperty.SimpleCaseFolding.folded(0x0041)
// 0x0061

let equivalents = UnicodeProperty.SimpleCaseFolding.variants(0x03A3)
// [0x03A3, 0x03C2, 0x03C3]
```

`General Category` and `Binary Property` values expose their data as sorted arrays of closed `UInt32` ranges. Their `from` methods resolve official abbreviations or names. `Simple Case Folding` maps one code point to one code point; it uses the `C` and `S` mappings from `CaseFolding.txt` and excludes full (`F`) and Turkic (`T`) mappings, as specified by the Unicode Standard.

## License

The package source code is available under the [MIT License](LICENSE.txt). The Unicode data is subject to the [Unicode License](Licenses/UnicodeLicense.txt). See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party notices.
