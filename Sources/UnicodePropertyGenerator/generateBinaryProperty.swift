import Basis


func generateBinaryProperties(
	unicodeVersion: String,
	inputDirectory: Directory,
	outputDirectory: Directory,
) throws {
	let files: [FilePath]
	= [
		"DerivedCoreProperties.txt",
		"DerivedNormalizationProps.txt",
		"extracted/DerivedBinaryProperties.txt",
		"emoji/emoji-data.txt",
		"PropList.txt",
	].map {
		inputDirectory[path: unicodeVersion, $0]
	}
	
	let properties: [String : [ClosedRange<UInt32>]]
	= try loadBinaryProperties(
		files: files,
	)
	
	for (propertyName, ranges) in properties {
		let source: String
		= generateSource(propertyName, ranges)
		
		try outputDirectory[file: "\(propertyName).swift"]
			.save(source)
	}
}


func loadBinaryProperties(
	files: [FilePath],
) throws -> [String : [ClosedRange<UInt32>]] {
	var properties: [String : [ClosedRange<UInt32>]] = [:]
	
	for path in files {
		print("Load \(path.fileName)...")
		getBinaryProperties(
			from: try path.file.text,
			into: &properties,
		)
		print("OK  \(path.fileName)")
	}
	
	return squash(properties)
}


func getBinaryProperties(
	from data: String,
	into result: inout [String : [ClosedRange<UInt32>]],
) {
	for line in data.split(separator: "\n") {
		// Skip comments
		guard
			!line.hasPrefix("#")
		else { continue }
		
		let info = line.split(separator: "#")
		let components = info[0].split(separator: ";")
		
		// プロパティ名
		let propertyName: String = components[1]
			.filter { !$0.isWhitespace }

		// Unicode値の範囲
		let scalars: ClosedRange<UInt32>
		
		let scalarString: Substring = components[0]
			.filter { !$0.isWhitespace }
		
		// If we have . appear, it means we have a legitimate range. Otherwe,
		// it's a singular scalar.
		if scalarString.contains(".") {
			let range: [Substring] = scalarString.split(separator: ".")
			
			scalars = UInt32(range[0], radix: 16)! ... UInt32(range[1], radix: 16)!
		}
		else {
			let scalar = UInt32(scalarString, radix: 16)!
			
			scalars = scalar ... scalar
		}

		// 追加
		result[propertyName, default: []]
			.insert(scalars)
	}
}


