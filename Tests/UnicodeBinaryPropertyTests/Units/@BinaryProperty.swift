import Basis
import Testing
import UnicodeBinaryProperty


@Suite struct BinaryPropertyTests {

	@Test func 公開プロパティと名前対応が一意である() {
		let properties = UnicodeProperty.BinaryProperty.allCases
		let names = properties.compactMap { property in
			UnicodeProperty.BinaryProperty.nameMapping
				.first { $0.value == property && !$0.key.hasPrefix("Other_") }?.key
		}

		#expect(properties.count == 48)
		#expect(Set(properties.map(\.rawValue)).count == properties.count)
		#expect(properties.allSatisfy { $0.rawValue.nonzeroBitCount == 1 })
		#expect(names.count == properties.count)
		#expect(Set(names).count == names.count)

		for (property, name) in zip(properties, names) {
			#expect(property.name == name)
			#expect(property.description == name)
			#expect(UnicodeProperty.BinaryProperty.from(name) == property)
		}
	}

	@Test func 公式UCDの全公開バイナリプロパティ範囲と一致する() throws {
		let officialRanges = try loadOfficialBinaryPropertyRanges()

		for property in UnicodeProperty.BinaryProperty.allCases {
			let officialName = UnicodeProperty.BinaryProperty.nameMapping
				.first { $0.value == property && !$0.key.hasPrefix("Other_") }?.key

			#expect(officialName != nil)
			guard let officialName else { continue }

			let ranges = officialRanges[officialName]
			#expect(ranges != nil)
			#expect(property.ranges == ranges)
			#expect(property.ranges == property.ranges.sorted { $0.lowerBound < $1.lowerBound })
			#expect(zip(property.ranges, property.ranges.dropFirst()).allSatisfy { $0.0.upperBound < $0.1.lowerBound })
		}
	}

	@Test func fromは正式名とOther別名を解決し未知の名前を拒否する() {
		let binaryProperty = UnicodeProperty.BinaryProperty.self

		for (name, property) in binaryProperty.nameMapping {
			#expect(binaryProperty.from(name) == property)
		}

		#expect(binaryProperty.from("Other_Alphabetic") == .alphabetic)
		#expect(binaryProperty.from("Other_ID_Start") == .idStart)
		#expect(binaryProperty.from("Unknown_Property") == nil)
	}

	@Test func 初期化後も値を保持しrawValueで比較とハッシュを行う() {
		let property = UnicodeProperty.BinaryProperty(
			rawValue: 0x8000,
			name: "Test_Property",
			ranges: [0x0041...0x005A],
		)
		let sameRawValue = UnicodeProperty.BinaryProperty(
			rawValue: 0x8000,
			name: "Different_Name",
			ranges: [],
		)
		let differentRawValue = UnicodeProperty.BinaryProperty(
			rawValue: 0x4000,
			name: "Test_Property",
			ranges: [0x0041...0x005A],
		)

		#expect(property.rawValue == 0x8000)
		#expect(property.name == "Test_Property")
		#expect(property.ranges == [0x0041...0x005A])
		#expect(property.description == "Test_Property")
		#expect(property == sameRawValue)
		#expect(property != differentRawValue)
		#expect(Set([property, sameRawValue, differentRawValue]).count == 2)
	}

	@Test @available(macOS 15.0, iOS 18.0, *) func rangeSetは閉区間の両端を含む() {
		let whitespace = UnicodeProperty.BinaryProperty.whitespace.rangeSet

		#expect(whitespace.contains(0x0009))
		#expect(whitespace.contains(0x000D))
		#expect(!whitespace.contains(0x000E))
		#expect(whitespace.contains(0x3000))
		#expect(!whitespace.contains(0x3001))
	}

}


private func loadOfficialBinaryPropertyRanges() throws -> [String: [ClosedRange<UInt32>]] {
	let fixtureRoot = packageRoot["Fixtures/17.0"]

	let paths = [
		"DerivedCoreProperties.txt",
		"DerivedNormalizationProps.txt",
		"extracted/DerivedBinaryProperties.txt",
		"emoji/emoji-data.txt",
		"PropList.txt",
	]
	var properties: [String: [ClosedRange<UInt32>]] = [:]

	for path in paths {
		let content = try fixtureRoot[path].file.load().asString

		for line in content.split(separator: "\n") {
			let fields = line
				.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: false)[0]
				.split(separator: ";")
			guard fields.count >= 2 else { continue }

			let scalarField = fields[0].trimmed
			let propertyName = fields[1].trimmed
			let endpoints = scalarField.split(separator: ".")
			guard
				let lowerBound = UInt32(endpoints[0], radix: 16),
				let upperBound = UInt32(endpoints.last!, radix: 16)
			else { continue }

			properties[propertyName, default: []].append(lowerBound...upperBound)
		}
	}

	return properties.mapValues(mergeRanges)
}


private func mergeRanges(
	_ ranges: [ClosedRange<UInt32>],
) -> [ClosedRange<UInt32>] {
	let sortedRanges = ranges.sorted { $0.lowerBound < $1.lowerBound }
	var merged: [ClosedRange<UInt32>] = []

	for range in sortedRanges {
		guard let last = merged.last else {
			merged.append(range)
			continue
		}

		if range.lowerBound <= last.upperBound + 1 {
			merged[merged.count - 1] = last.lowerBound...max(last.upperBound, range.upperBound)
		}
		else {
			merged.append(range)
		}
	}

	return merged
}


private var packageRoot: FilePath {
	FilePath(#filePath).parent.parent.parent.parent
}
