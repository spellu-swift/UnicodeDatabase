

func squash(
	_ list: [String : [ClosedRange<UInt32>]],
) -> [String : [ClosedRange<UInt32>]] {
	list.mapValues { ranges in
		squash(ranges)
	}
}


func squash(
	_ unflattened: [ClosedRange<UInt32>]
) -> [ClosedRange<UInt32>] {
	let list
	= unflattened.sorted{ $0.lowerBound < $1.lowerBound }
	
	var result: [ClosedRange<UInt32>] = [
		list.first!,
	]
	
	for range in list.dropFirst() {
		if range.lowerBound == result.last!.upperBound + 1 {
			result[result.count - 1] = result.last!.lowerBound ... range.upperBound
		}
		else {
			result.append(range)
		}
	}
	
	return result
}
