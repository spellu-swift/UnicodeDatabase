import Basis


extension String {

	/// Unicode Simple Case Foldingを使った文字列の比較
	public func equalsIgnoringCase<S : StringProtocol>(
		_ other: S,
	) -> Bool {
		let lhs = unicodeScalars
		let rhs = other.unicodeScalars

		guard lhs.count == rhs.count else {
			return false
		}

		return zip(lhs, rhs).allSatisfy { a, b in
			UnicodeProperty.SimpleCaseFolding.folded(a.value)
				== UnicodeProperty.SimpleCaseFolding.folded(b.value)
		}
	}

}
