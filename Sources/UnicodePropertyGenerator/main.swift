import Basis


let targetUnicodeVersion: String
= "17.0"

var fixturesDirectory : Directory {
	FilePath(#filePath, "../../../Fixtures").normalized.directory
}

var outputsDirectory : Directory {
	FilePath(#filePath, "../../../Outputs").normalized.directory
}

do {
	try generateGeneralCategories(
		unicodeVersion: targetUnicodeVersion,
		inputDirectory: fixturesDirectory,
		outputDirectory: outputsDirectory["GeneralCategory/Ranges"],
	)
	try generateBinaryProperties(
		unicodeVersion: targetUnicodeVersion,
		inputDirectory: fixturesDirectory,
		outputDirectory: outputsDirectory["BinaryProperty/Ranges"],
	)
	try generateCaseFolding(
		unicodeVersion: targetUnicodeVersion,
		inputDirectory: fixturesDirectory,
		outputDirectory: outputsDirectory["CaseFolding"],
	)
}
catch {
	print(error.readableMessage)
}
