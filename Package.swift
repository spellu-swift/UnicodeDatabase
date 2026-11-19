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
		.package(id: "spellu.Basis", from: "0.10.0"),
	],

	targets: [
		.target(
			name: "UnicodeGeneralCategory",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
			],
		),
		.testTarget(
			name: "UnicodeGeneralCategoryTests",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
				.product(name: "Testing", package: "spellu.Basis"),
				"UnicodeGeneralCategory",
			],
		),

		.target(
			name: "UnicodeBinaryProperty",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
			],
		),
		.testTarget(
			name: "UnicodeBinaryPropertyTests",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
				.product(name: "Testing", package: "spellu.Basis"),
				"UnicodeBinaryProperty",
			],
		),

		.target(
			name: "UnicodeCaseFolding",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
			],
		),
		.testTarget(
			name: "UnicodeCaseFoldingTests",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
				.product(name: "Testing", package: "spellu.Basis"),
				"UnicodeCaseFolding",
			],
		),

		.executableTarget(
			name: "UnicodePropertyGenerator",
			dependencies: [
				.product(name: "Basis", package: "spellu.Basis"),
			],
		),
	],
)
