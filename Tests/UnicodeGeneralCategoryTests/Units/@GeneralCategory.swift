import Basis
import Testing
import UnicodeGeneralCategory


@Suite struct GeneralCategoryTests {

	@Test func 公開カテゴリと略称名対応が一意である() {
		let categories = UnicodeProperty.GeneralCategory.allCases

		#expect(categories.count == 37)
		#expect(Set(categories.map(\.abbr)).count == categories.count)
		#expect(Set(categories.map(\.name)).count == categories.count)
		#expect(categories.allSatisfy { UnicodeProperty.GeneralCategory.abbrMapping[$0.abbr] == $0 })
		#expect(categories.allSatisfy { UnicodeProperty.GeneralCategory.nameMapping[$0.name] == $0 })
	}

	@Test func 公式UCDの基本カテゴリと派生カテゴリ範囲に一致する() throws {
		let officialRanges = try loadOfficialGeneralCategoryRanges()
		let aggregateCategories: [String: [String]] = [
			"LC": ["Lu", "Ll", "Lt"],
			"L": ["Lu", "Ll", "Lt", "Lm", "Lo"],
			"M": ["Mn", "Mc", "Me"],
			"N": ["Nd", "Nl", "No"],
			"P": ["Pc", "Pd", "Ps", "Pe", "Pi", "Pf", "Po"],
			"S": ["Sm", "Sc", "Sk", "So"],
			"Z": ["Zs", "Zl", "Zp"],
			"C": ["Cc", "Cf", "Cs", "Co", "Cn"],
		]

		for category in UnicodeProperty.GeneralCategory.allCases {
			let ranges: [ClosedRange<UInt32>]
			if let components = aggregateCategories[category.abbr] {
				ranges = components
					.flatMap { officialRanges[$0] ?? [] }
					.sorted { $0.lowerBound < $1.lowerBound }
			}
			else {
				ranges = officialRanges[category.abbr] ?? []
			}

			#expect(!ranges.isEmpty)
			#expect(category.ranges == ranges)
			#expect(category.ranges == category.ranges.sorted { $0.lowerBound < $1.lowerBound })
			#expect(zip(category.ranges, category.ranges.dropFirst()).allSatisfy { $0.0.upperBound < $0.1.lowerBound })
		}
	}

	@Test func fromは略称と正式名を解決し未知の値を拒否する() {
		let generalCategory = UnicodeProperty.GeneralCategory.self

		for category in generalCategory.allCases {
			#expect(generalCategory.from(category.abbr) == category)
			#expect(generalCategory.from(category.name) == category)
			#expect(generalCategory.from(abbr: category.abbr) == category)
			#expect(generalCategory.from(name: category.name) == category)
		}

		#expect(generalCategory.from("Uppercase_Letter") == .uppercaseLetter)
		#expect(generalCategory.from("Lu") == .uppercaseLetter)
		#expect(generalCategory.from("Unknown_Category") == nil)
		#expect(generalCategory.from(abbr: "Unknown") == nil)
		#expect(generalCategory.from(name: "Unknown") == nil)
	}

	@Test func 初期化後も値を保持し略称で比較とハッシュを行う() {
		let category = UnicodeProperty.GeneralCategory(
			"Xx",
			name: "Test_Category",
			ranges: [0x0041...0x005A],
		)
		let sameAbbreviation = UnicodeProperty.GeneralCategory(
			"Xx",
			name: "Different_Name",
			ranges: [],
		)
		let differentAbbreviation = UnicodeProperty.GeneralCategory(
			"Yy",
			name: "Test_Category",
			ranges: [0x0041...0x005A],
		)

		#expect(category.abbr == "Xx")
		#expect(category.name == "Test_Category")
		#expect(category.ranges == [0x0041...0x005A])
		#expect(category.description == "Test_Category")
		#expect(category == sameAbbreviation)
		#expect(category != differentAbbreviation)
		#expect(Set([category, sameAbbreviation, differentAbbreviation]).count == 2)
	}

	@Test @available(macOS 15.0, iOS 18.0, *) func rangeSetは閉区間の両端を含む() {
		let uppercaseLetter = UnicodeProperty.GeneralCategory.uppercaseLetter.rangeSet

		#expect(uppercaseLetter.contains(0x0041))
		#expect(uppercaseLetter.contains(0x005A))
		#expect(!uppercaseLetter.contains(0x005B))
	}

}


private func loadOfficialGeneralCategoryRanges() throws -> [String: [ClosedRange<UInt32>]] {
	let fixturePath: FilePath
	= packageRoot["Fixtures/17.0/extracted/DerivedGeneralCategory.txt"]

	let content: String
	= try fixturePath.file.load().asString

	var properties: [String: [ClosedRange<UInt32>]]
	= [:]

	for line in content.split(separator: "\n") {
		let fields = line
			.split(separator: "#", maxSplits: 1, omittingEmptySubsequences: false)[0]
			.split(separator: ";")
		guard fields.count >= 2 else { continue }

		let scalarField = fields[0].trimmed
		let category = fields[1].trimmed
		let endpoints = scalarField.split(separator: ".")
		guard
			let lowerBound = UInt32(endpoints[0], radix: 16),
			let upperBound = UInt32(endpoints.last!, radix: 16)
		else { continue }

		properties[category, default: []].append(lowerBound...upperBound)
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
