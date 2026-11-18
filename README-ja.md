# UnicodeDatabase

Swift向けのUnicode Character Database（UCD）プロパティとマッピングを提供するパッケージです。`General Category`、`Binary Property`、`Simple Case Folding`のデータを利用できます。

## Unicodeのバージョン

収録データはUnicode 17.0.0に基づいています。元のUCDデータは[Unicode 17.0.0 UCDアーカイブ](https://www.unicode.org/Public/17.0.0/ucd/)から確認できます。

## 提供するプロダクトとモジュール

ライブラリプロダクト`UnicodeDatabase`には、次のモジュールが含まれます。

- `UnicodeGeneralCategory`は、`Lu`（大文字）や`L`（文字）など、個別および集約された`General Category`を提供します。
- `UnicodeBinaryProperty`は、`Alphabetic`、`White_Space`、`Emoji`などの`Binary Property`を提供します。
- `UnicodeCaseFolding`は、`Simple Case Folding`のマッピングと、同じフォールド先を持つコードポイントを提供します。

公開型の名前空間`UnicodeProperty`は、依存パッケージ`Basis`で定義されています。

## 動作要件

- Swift 6.2以降
- macOS 14以降
- iOS 17以降

`rangeSet`プロパティはmacOS 15、iOS 18以降で利用できます。

## パッケージへの追加

`Basis`と`UnicodeDatabase`をパッケージ依存関係に追加します。

```swift
dependencies: [
	.package(url: "git://git.orion/swift/Basis", branch: "develop"),
	.package(url: "git://git.orion/swift/UnicodeDatabase", branch: "develop"),
]
```

利用するターゲットに、両方のプロダクトを追加します。

```swift
dependencies: [
	.product(name: "Basis", package: "Basis"),
	.product(name: "UnicodeDatabase", package: "UnicodeDatabase"),
]
```

## 使用例

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

`General Category`と`Binary Property`は、`UInt32`の閉区間を昇順に並べた配列として範囲を公開します。それぞれの`from`メソッドで、公式の略称または名前から値を取得できます。`Simple Case Folding`はコードポイントを1つのコードポイントにマップします。Unicode標準に従い、`CaseFolding.txt`の`C`と`S`のマッピングを使い、Full（`F`）およびTurkic（`T`）のマッピングは含みません。

## ライセンス

パッケージのソースコードは[MIT License](LICENSE.txt)の下で提供されます。Unicodeデータには[Unicode License](Licenses/UnicodeLicense.txt)が適用されます。サードパーティの告知は[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)を参照してください。
