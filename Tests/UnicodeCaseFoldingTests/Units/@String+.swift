import Testing
import UnicodeCaseFolding


// 対象API: String.equalsIgnoringCase(StringProtocol)。
// 双方向の照合、Substring、空文字、長さの違い、単純ケースフォールディング、
// 複数文字への展開とUnicode正規化を行わないことを確認する。
@Suite struct StringTests {

	@Test(arguments: [
		("if", "IF", true),
		("Σ", "ς", true),
		("K", "k", true),
		("É", "é", true),
		("日本🙂", "日本🙂", true),
		("ß", "ss", false),
		("İ", "i", false),
		("", "", true),
		("", "a", false),
		("abc", "ab", false),
		("abc", "abd", false),
		("e\u{301}", "É", false),
	])
	func 単純ケースフォールディングで比較する(
		_ sample: (String, String, Bool),
	) {
		let (lhs, rhs, expected) = sample
		#expect(lhs.equalsIgnoringCase(rhs) == expected)
		#expect(rhs.equalsIgnoringCase(lhs) == expected)
		let surrounded: String = "[" + rhs + "]"
		let substring: Substring = surrounded.dropFirst().dropLast()
		#expect(lhs.equalsIgnoringCase(substring) == expected)
	}

}
