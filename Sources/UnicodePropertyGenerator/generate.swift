import Basis


func generateSource(
	_ propertyName: String,
	_ ranges: [ClosedRange<UInt32>]
) -> String {
"""


extension [ClosedRange<UInt32>] {

\tstatic let \(propertyName): [ClosedRange<UInt32>]
\t= [
\(generateRangeList(ranges))
\t]

}
"""
}


func generateRangeList(
	_ ranges: [ClosedRange<UInt32>]
) -> String {
	return ranges
		.map { range in
			POSIX.format("\t\t0x%04X...0x%04X,", range.lowerBound, range.upperBound)
		}
		.joined(separator: "\n")
}
