import Basis
import Testing
import UnicodeCaseFolding


@Suite struct SimpleCaseFoldingTests {

	@Test func 単一コードポイントをフォールドする() {
		#expect(UnicodeProperty.SimpleCaseFolding.folded(0x0041) == 0x0061)
		#expect(UnicodeProperty.SimpleCaseFolding.folded(0x00B5) == 0x03BC)
		#expect(UnicodeProperty.SimpleCaseFolding.folded(0x212A) == 0x006B)
		#expect(UnicodeProperty.SimpleCaseFolding.folded(0x03A3) == 0x03C3)
	}

	@Test func 単純マッピングのないコードポイントはそのまま返す() {
		for scalar: UInt32 in [0x00DF, 0x10FFFF] {
			#expect(UnicodeProperty.SimpleCaseFolding.folded(scalar) == scalar)
		}
	}

	@Test func 単純ケースフォールディングはCとSを使いFを除外する() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		#expect(folding.folded(0x1E9E) == 0x00DF)
		#expect(folding.folded(0x1F88) == 0x1F80)
		#expect(folding.folded(0x1F80) == 0x1F80)
		#expect(folding.variants(0x00DF) == [0x00DF, 0x1E9E])
	}

	@Test func Turkic専用マッピングを既定のフォールディングに使わない() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		#expect(folding.folded(0x0049) == 0x0069)
		#expect(folding.folded(0x0130) == 0x0130)
		#expect(folding.folded(0x0131) == 0x0131)
	}

	@Test func Cherokeeの小文字は大文字のフォールド先を使う() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		#expect(folding.folded(0xAB70) == 0x13A0)
		#expect(folding.folded(0x13A0) == 0x13A0)
		#expect(folding.variants(0xAB70) == [0x13A0, 0xAB70])
	}

	@Test func 補助平面の大文字をフォールドする() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		#expect(folding.folded(0x10400) == 0x10428)
		#expect(folding.folded(0x10428) == 0x10428)
		#expect(folding.variants(0x10400) == [0x10400, 0x10428])
	}

	@Test func 同じフォールド先を持つコードポイントを取得する() {
		#expect(UnicodeProperty.SimpleCaseFolding.variants(0x03A3) == [0x03A3, 0x03C2, 0x03C3])
		#expect(UnicodeProperty.SimpleCaseFolding.variants(0x03C2) == [0x03A3, 0x03C2, 0x03C3])
		#expect(UnicodeProperty.SimpleCaseFolding.variants(0x10FFFF) == [0x10FFFF])
	}

	@Test func テーブルとマッピングとバリアントが一致する() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		#expect(folding.table.count == folding.mapping.count)

		for (source, destination) in folding.table {
			#expect(folding.mapping[source] == destination)
			#expect(folding.folded(source) == destination)
			#expect(folding.variants[source]?.contains(destination) == true)
			#expect(folding.variants(source) == folding.variants[source])
		}

		for (scalar, variants) in folding.variants {
			#expect(variants == variants.sorted())
			#expect(variants.contains(scalar))
			#expect(folding.variants(scalar) == variants)
		}
	}

}
