import Basis


func generateGeneralCategories(
	unicodeVersion: String,
	inputDirectory: Directory,
	outputDirectory: Directory,
) throws {
	let files: [FilePath]
	= [
		"extracted/DerivedGeneralCategory.txt",
	].map {
		inputDirectory[path: unicodeVersion, $0]
	}
	
	let properties: [String : [ClosedRange<UInt32>]]
	= try loadGeneralCategory(
		files: files,
	)
	
	for (propertyName, ranges) in properties {
		let source: String
		= generateSource(propertyName, ranges)
		
		try outputDirectory[file: "\(propertyName).swift"]
			.save(source)
	}
}


func loadGeneralCategory(
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
