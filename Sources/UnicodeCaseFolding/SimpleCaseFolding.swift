import Basis


extension UnicodeProperty.SimpleCaseFolding {

	/// scalar の fold 先を取得する
	@inlinable
	public static func folded(
		_ scalar: UInt32
	) -> UInt32 {
		mapping[scalar] ?? scalar
	}

	/// scalar の variants を取得する
	@inlinable
	public static func variants(
		_ scalar: UInt32
	) -> [UInt32] {
		variants[scalar] ?? [scalar]
	}

	public static let variants: [UInt32: [UInt32]] = {
		var groups: [UInt32: Set<UInt32>] = [:]

		for (source, folded) in table {
			groups[folded, default: []].formUnion([source, folded])
		}

		var result: [UInt32: [UInt32]] = [:]

		for group in groups.values {
			let variants = group.sorted()

			for scalar in variants {
				result[scalar] = variants
			}
		}

		return result
	}()

}


extension UnicodeProperty {
	
	public struct SimpleCaseFolding : Sendable {
	}
	
}
