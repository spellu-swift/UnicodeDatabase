import Basis
import Testing
import UnicodeCaseFolding


@Suite struct SimpleCaseFoldingVariantsTests {

	@Test func variantsの同値関係は対称的で推移的() {
		let folding = UnicodeProperty.SimpleCaseFolding.self

		for (scalar, equivalents) in folding.variants {
			for equivalent in equivalents {
				let equivalentVariants = folding.variants(equivalent)

				#expect(equivalentVariants.contains(scalar))

				for transitiveEquivalent in equivalentVariants {
					#expect(equivalents.contains(transitiveEquivalent))
				}
			}
		}
	}

}
