import Basis


extension UnicodeProperty.GeneralCategory {
	
	public static let uppercaseLetter      : Self = .init("Lu", name: "Uppercase_Letter",      ranges: .Lu)
	public static let lowercaseLetter      : Self = .init("Ll", name: "Lowercase_Letter",      ranges: .Ll)
	public static let titlecaseLetter      : Self = .init("Lt", name: "Titlecase_Letter",      ranges: .Lt)
	public static let casedLetter          : Self = .init("LC", name: "Cased_Letter",          ranges: combine(.Lu, .Ll, .Lt))
	public static let modifierLetter       : Self = .init("Lm", name: "Modifier_Letter",       ranges: .Lm)
	public static let otherLetter          : Self = .init("Lo", name: "Other_Letter",          ranges: .Lo)
	public static let letter               : Self = .init("L",  name: "Letter",                ranges: combine(.Lu, .Ll, .Lt, .Lm, .Lo))

	public static let nonspacingMark       : Self = .init("Mn", name: "Nonspacing_Mark",       ranges: .Mn)
	public static let spacingMark          : Self = .init("Mc", name: "Spacing_Mark",          ranges: .Mc)
	public static let enclosingMark        : Self = .init("Me", name: "Enclosing_Mark",        ranges: .Me)
	public static let mark                 : Self = .init("M",  name: "Mark",                  ranges: combine(.Mn, .Mc, .Me))

	public static let decimalNumber        : Self = .init("Nd", name: "Decimal_Number",        ranges: .Nd)
	public static let letterNumber         : Self = .init("Nl", name: "Letter_Number",         ranges: .Nl)
	public static let otherNumber          : Self = .init("No", name: "Other_Number",          ranges: .No)
	public static let number               : Self = .init("N",  name: "Number",                ranges: combine(.Nd, .Nl, .No))

	public static let connectorPunctuation : Self = .init("Pc", name: "Connector_Punctuation", ranges: .Pc)
	public static let dashPunctuation      : Self = .init("Pd", name: "Dash_Punctuation",      ranges: .Pd)
	public static let openPunctuation      : Self = .init("Ps", name: "Open_Punctuation",      ranges: .Ps)
	public static let closePunctuation     : Self = .init("Pe", name: "Close_Punctuation",     ranges: .Pe)
	public static let initialPunctuation   : Self = .init("Pi", name: "Initial_Punctuation",   ranges: .Pi)
	public static let finalPunctuation     : Self = .init("Pf", name: "Final_Punctuation",     ranges: .Pf)
	public static let otherPunctuation     : Self = .init("Po", name: "Other_Punctuation",     ranges: .Po)
	public static let punctuation          : Self = .init("P",  name: "Punctuation",           ranges: combine(.Pc, .Pd, .Ps, .Pe, .Pi, .Pf, .Po))

	public static let mathSymbol           : Self = .init("Sm", name: "Math_Symbol",           ranges: .Sm)
	public static let currencySymbol       : Self = .init("Sc", name: "Currency_Symbol",       ranges: .Sc)
	public static let modifierSymbol       : Self = .init("Sk", name: "Modifier_Symbol",       ranges: .Sk)
	public static let otherSymbol          : Self = .init("So", name: "Other_Symbol",          ranges: .So)
	public static let symbol               : Self = .init("S",  name: "Symbol",                ranges: combine(.Sm, .Sc, .Sk, .So))

	public static let spaceSeparator       : Self = .init("Zs", name: "Space_Separator",       ranges: .Zs)
	public static let lineSeparator        : Self = .init("Zl", name: "Line_Separator",        ranges: .Zl)
	public static let paragraphSeparator   : Self = .init("Zp", name: "Paragraph_Separator",   ranges: .Zp)
	public static let separator            : Self = .init("Z",  name: "Separator",             ranges: combine(.Zs, .Zl, .Zp))

	public static let control              : Self = .init("Cc", name: "Control",               ranges: .Cc)
	public static let format               : Self = .init("Cf", name: "Format",                ranges: .Cf)
	public static let surrogate            : Self = .init("Cs", name: "Surrogate",             ranges: .Cs)
	public static let privateUse           : Self = .init("Co", name: "Private_Use",           ranges: .Co)
	public static let unassigned           : Self = .init("Cn", name: "Unassigned",            ranges: .Cn)
	public static let other                : Self = .init("C",  name: "Other",                 ranges: combine(.Cc, .Cf, .Cs, .Co, .Cn))
}


private func combine(
	_ rangesList: [ClosedRange<UInt32>]...,
) -> [ClosedRange<UInt32>] {
	rangesList.flatMap{$0}.sorted(by: \.lowerBound)
}


extension UnicodeProperty {
	
	public struct GeneralCategory : Sendable {
		
		public init(
			_ abbr: String,
			name: String,
			ranges: [ClosedRange<UInt32>],
		) {
			self.abbr = abbr
			self.name = name
			self.ranges = ranges
		}
		
		public let abbr: String
		
		public let name: String
		
		public let ranges: [ClosedRange<UInt32>]

		public var rangeSet: RangeSet<UInt32> {
			RangeSet(
				ranges.map {
					$0.lowerBound ..< $0.upperBound + 1
				},
			)
		}
		
	}
	
}


extension UnicodeProperty.GeneralCategory : CaseIterable {
	
	public static let allCases: [UnicodeProperty.GeneralCategory] = [
		.uppercaseLetter,
		.lowercaseLetter,
		.titlecaseLetter,
		.casedLetter,
		.modifierLetter,
		.otherLetter,
		.letter,
		.nonspacingMark,
		.spacingMark,
		.enclosingMark,
		.decimalNumber,
		.letterNumber,
		.otherNumber,
		.number,
		.connectorPunctuation,
		.dashPunctuation,
		.openPunctuation,
		.closePunctuation,
		.initialPunctuation,
		.finalPunctuation,
		.otherPunctuation,
		.punctuation,
		.mathSymbol,
		.currencySymbol,
		.modifierSymbol,
		.otherSymbol,
		.symbol,
		.spaceSeparator,
		.lineSeparator,
		.paragraphSeparator,
		.separator,
		.control,
		.format,
		.surrogate,
		.privateUse,
		.unassigned,
		.other,
	]
	
	public static let abbrMapping: [String : UnicodeProperty.GeneralCategory]
	= allCases.mapDictionary(key: \.abbr, value: \.self)
	
	public static let nameMapping: [String : UnicodeProperty.GeneralCategory]
	= allCases.mapDictionary(key: \.name, value: \.self)
	
	@inlinable
	public static func from(
		_ abbrOrName: String,
	) -> Self? {
		abbrMapping[abbrOrName] ?? nameMapping[abbrOrName]
	}
	
	@inlinable
	public static func from(
		abbr: String,
	) -> Self? {
		abbrMapping[abbr]
	}
	
	@inlinable
	public static func from(
		name: String,
	) -> Self? {
		nameMapping[name]
	}
	
}


extension UnicodeProperty.GeneralCategory : Equatable {
	
	@inlinable
	public static func == (
		lhs: Self,
		rhs: Self,
	) -> Bool {
		lhs.abbr == rhs.abbr
	}
	
}


extension UnicodeProperty.GeneralCategory : Hashable {

	public func hash(
		into hasher: inout Hasher,
	) {
		hasher.combine(abbr)
	}

}


extension UnicodeProperty.GeneralCategory : CustomStringConvertible {
	
	@inlinable
	public var description: String {
		name
	}
	
}


