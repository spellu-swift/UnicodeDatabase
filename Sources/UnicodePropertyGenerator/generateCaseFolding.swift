import Basis


struct CaseFoldingData {
	var common: OrderedDictionary<UInt32, UInt32> = [:]
	var simple: OrderedDictionary<UInt32, UInt32> = [:]
	var full: OrderedDictionary<UInt32, [UInt32]> = [:]
	var turkic: OrderedDictionary<UInt32, [UInt32]> = [:]
}


func generateCaseFolding(
	unicodeVersion: String,
	inputDirectory: Directory,
	outputDirectory: Directory,
) throws {
	let files: [FilePath]
	= [
		"CaseFolding.txt",
	].map {
		inputDirectory[path: unicodeVersion, $0]
	}

	let properties: CaseFoldingData
	= try loadCaseFolding(
		files: files,
	)

	let source: String
	= generateSource(properties)

	try outputDirectory[file: "SimpleCaseFolding+mapping.swift"]
		.save(source)
}


private func loadCaseFolding(
	files: [FilePath],
) throws -> CaseFoldingData {
	var properties: CaseFoldingData = .init()
	
	for path in files {
		print("Load \(path.fileName)...")
		getCaseFoldings(
			from: try path.file.text,
			into: &properties,
		)
		print("OK  \(path.fileName)")
	}
	
	return properties
}


private func getCaseFoldings(
	from data: String,
	into result: inout CaseFoldingData,
) {
	for line in data.split(separator: "\n") {
		// Skip comments
		guard
			!line.hasPrefix("#")
		else { continue }
		
		let info = line.split(separator: "#")
		let components = info[0].split(separator: ";")
			.map{ $0.trimmed }
			.filter{ $0.isNotEmpty }
		
		// コード
		let code = UInt32(components[0], radix: 16)!
		
		// 分類
		let category: String = components[1]

		// マッピング
		let mappings: [UInt32]
		= components[2].split(separator: " ")
			.map{	UInt32($0, radix: 16)! }

		// 追加
		switch category {
		case "C":
			result.common[code] = mappings[0]
		case "S":
			result.simple[code] = mappings[0]
		case "F":
			result.full[code] = mappings
		case "T":
			result.turkic[code] = mappings
		default:break
		}
	}
}


private func generateSource(
	_ data: CaseFoldingData,
) -> String {
"""
import Basis


extension UnicodeProperty.SimpleCaseFolding {

	public static let table: [(UInt32, UInt32)] = [
		// C: \(data.common.count)
\(generateTable(data.common))
		// S: \(data.simple.count)
\(generateTable(data.simple))
	]

	public static let mapping: [UInt32 : UInt32] = [
		// C: \(data.common.count)
\(generateSimpleMapping(data.common))
		// S: \(data.simple.count)
\(generateSimpleMapping(data.simple))
	]

}
"""
}


private func generateTable(
	_ mappings: OrderedDictionary<UInt32, UInt32>,
) -> String {
	mappings.map { code, mapping in
		POSIX.format("\t\t(0x%04X, 0x%04X),", code, mapping)
	}
	.joined(terminator: "\n")
}


private func generateSimpleMapping(
	_ mappings: OrderedDictionary<UInt32, UInt32>,
) -> String {
	mappings.map { code, mapping in
		POSIX.format("\t\t0x%04X : 0x%04X,", code, mapping)
	}
	.joined(terminator: "\n")
}
