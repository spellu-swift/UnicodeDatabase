// swift-tools-version: 6.0
import PackageDescription


let package = Package(
	name: "UnicodeDatabase",
	platforms: [
		.macOS(.v14),
		.iOS(.v17),
	],
	products: [
		.library(
			name: "UnicodeDatabase",
			targets: ["UnicodeGeneralCategory", "UnicodeBinaryProperty", "UnicodeCaseFolding"],
		),
		.executable(
			name: "UnicodePropertyGenerator",
			targets: ["UnicodePropertyGenerator"],
		),
	],

	dependencies: [
		.package(url: "https://github.com/spellu-swift/Basis", from: "0.10.0"),
	],

	targets: [
		.target(
			name: "UnicodeGeneralCategory",
			dependencies: ["Basis"],
		),
		.testTarget(
			name: "UnicodeGeneralCategoryTests",
			dependencies: [
				"Basis",
				"UnicodeGeneralCategory",
				.product(name: "Testing", package: "Basis"),
			],
		),

		.target(
			name: "UnicodeBinaryProperty",
			dependencies: ["Basis"],
		),
		.testTarget(
			name: "UnicodeBinaryPropertyTests",
			dependencies: [
				"Basis",
				"UnicodeBinaryProperty",
				.product(name: "Testing", package: "Basis"),
			],
		),

		.target(
			name: "UnicodeCaseFolding",
			dependencies: ["Basis"],
		),
		.testTarget(
			name: "UnicodeCaseFoldingTests",
			dependencies: [
				"Basis",
				"UnicodeCaseFolding",
				.product(name: "Testing", package: "Basis"),
			],
		),

		.executableTarget(
			name: "UnicodePropertyGenerator",
			dependencies: ["Basis"],
		),
	],
)
