import Basis


extension UnicodeProperty.BinaryProperty {
	
	public static let changesWhenCaseFolded       : Self = .init(rawValue: 1 &<<  0, name: "Changes_When_Casefolded", ranges: .Changes_When_Casefolded)
	public static let changesWhenCaseMapped       : Self = .init(rawValue: 1 &<<  1, name: "Changes_When_Casemapped", ranges: .Changes_When_Casemapped)
	public static let changesWhenLowercased       : Self = .init(rawValue: 1 &<<  2, name: "Changes_When_Lowercased", ranges: .Changes_When_Lowercased)
	public static let changesWhenNFKCCaseFolded   : Self = .init(rawValue: 1 &<<  3, name: "Changes_When_NFKC_Casefolded", ranges: .Changes_When_NFKC_Casefolded)
	public static let changesWhenTitlecased       : Self = .init(rawValue: 1 &<<  4, name: "Changes_When_Titlecased", ranges: .Changes_When_Titlecased)
	public static let changesWhenUppercased       : Self = .init(rawValue: 1 &<<  5, name: "Changes_When_Uppercased", ranges: .Changes_When_Uppercased)
	public static let asciiHexDigit               : Self = .init(rawValue: 1 &<<  6, name: "ASCII_Hex_Digit", ranges: .ASCII_Hex_Digit)
	public static let alphabetic                  : Self = .init(rawValue: 1 &<<  7, name: "Alphabetic", ranges: .Alphabetic)
	public static let bidiControl                 : Self = .init(rawValue: 1 &<<  8, name: "Bidi_Control", ranges: .Bidi_Control)
	public static let bidiMirrored                : Self = .init(rawValue: 1 &<<  9, name: "Bidi_Mirrored", ranges: .Bidi_Mirrored)
	public static let caseIgnorable               : Self = .init(rawValue: 1 &<< 10, name: "Case_Ignorable", ranges: .Case_Ignorable)
	public static let cased                       : Self = .init(rawValue: 1 &<< 11, name: "Cased", ranges: .Cased)
	public static let dash                        : Self = .init(rawValue: 1 &<< 12, name: "Dash", ranges: .Dash)
	public static let defaultIgnorableCodePoint   : Self = .init(rawValue: 1 &<< 13, name: "Default_Ignorable_Code_Point", ranges: .Default_Ignorable_Code_Point)
	public static let deprecated                  : Self = .init(rawValue: 1 &<< 14, name: "Deprecated", ranges: .Deprecated)
	public static let diacritic                   : Self = .init(rawValue: 1 &<< 15, name: "Diacritic", ranges: .Diacritic)
	public static let emoji                       : Self = .init(rawValue: 1 &<< 16, name: "Emoji", ranges: .Emoji)
	public static let emojiModifier               : Self = .init(rawValue: 1 &<< 17, name: "Emoji_Modifier", ranges: .Emoji_Modifier)
	public static let emojiModifierBase           : Self = .init(rawValue: 1 &<< 18, name: "Emoji_Modifier_Base", ranges: .Emoji_Modifier_Base)
	public static let emojiPresentation           : Self = .init(rawValue: 1 &<< 19, name: "Emoji_Presentation", ranges: .Emoji_Presentation)
	public static let extender                    : Self = .init(rawValue: 1 &<< 20, name: "Extender", ranges: .Extender)
	public static let fullCompositionExclusion    : Self = .init(rawValue: 1 &<< 21, name: "Full_Composition_Exclusion", ranges: .Full_Composition_Exclusion)
	public static let graphemeBase                : Self = .init(rawValue: 1 &<< 22, name: "Grapheme_Base", ranges: .Grapheme_Base)
	public static let graphemeExtend              : Self = .init(rawValue: 1 &<< 23, name: "Grapheme_Extend", ranges: .Grapheme_Extend)
	public static let hexDigit                    : Self = .init(rawValue: 1 &<< 24, name: "Hex_Digit", ranges: .Hex_Digit)
	public static let idContinue                  : Self = .init(rawValue: 1 &<< 25, name: "ID_Continue", ranges: .ID_Continue)
	public static let idsBinaryOperator           : Self = .init(rawValue: 1 &<< 26, name: "IDS_Binary_Operator", ranges: .IDS_Binary_Operator)
	public static let idsTrinaryOperator          : Self = .init(rawValue: 1 &<< 27, name: "IDS_Trinary_Operator", ranges: .IDS_Trinary_Operator)
	public static let idStart                     : Self = .init(rawValue: 1 &<< 28, name: "ID_Start", ranges: .ID_Start)
	public static let ideographic                 : Self = .init(rawValue: 1 &<< 29, name: "Ideographic", ranges: .Ideographic)
	public static let joinControl                 : Self = .init(rawValue: 1 &<< 30, name: "Join_Control", ranges: .Join_Control)
	public static let logicalOrderException       : Self = .init(rawValue: 1 &<< 31, name: "Logical_Order_Exception", ranges: .Logical_Order_Exception)
	public static let lowercase                   : Self = .init(rawValue: 1 &<< 32, name: "Lowercase", ranges: .Lowercase)
	public static let math                        : Self = .init(rawValue: 1 &<< 33, name: "Math", ranges: .Math)
	public static let noncharacterCodePoint       : Self = .init(rawValue: 1 &<< 34, name: "Noncharacter_Code_Point", ranges: .Noncharacter_Code_Point)
	public static let patternSyntax               : Self = .init(rawValue: 1 &<< 35, name: "Pattern_Syntax", ranges: .Pattern_Syntax)
	public static let patternWhitespace           : Self = .init(rawValue: 1 &<< 36, name: "Pattern_White_Space", ranges: .Pattern_White_Space)
	public static let quotationMark               : Self = .init(rawValue: 1 &<< 37, name: "Quotation_Mark", ranges: .Quotation_Mark)
	public static let radical                     : Self = .init(rawValue: 1 &<< 38, name: "Radical", ranges: .Radical)
	public static let sentenceTerminal            : Self = .init(rawValue: 1 &<< 39, name: "Sentence_Terminal", ranges: .Sentence_Terminal)
	public static let softDotted                  : Self = .init(rawValue: 1 &<< 40, name: "Soft_Dotted", ranges: .Soft_Dotted)
	public static let terminalPunctuation         : Self = .init(rawValue: 1 &<< 41, name: "Terminal_Punctuation", ranges: .Terminal_Punctuation)
	public static let unifiedIdeograph            : Self = .init(rawValue: 1 &<< 42, name: "Unified_Ideograph", ranges: .Unified_Ideograph)
	public static let uppercase                   : Self = .init(rawValue: 1 &<< 43, name: "Uppercase", ranges: .Uppercase)
	public static let variationSelector           : Self = .init(rawValue: 1 &<< 44, name: "Variation_Selector", ranges: .Variation_Selector)
	public static let whitespace                  : Self = .init(rawValue: 1 &<< 45, name: "White_Space", ranges: .White_Space)
	public static let xidContinue                 : Self = .init(rawValue: 1 &<< 46, name: "XID_Continue", ranges: .XID_Continue)
	public static let xidStart                    : Self = .init(rawValue: 1 &<< 47, name: "XID_Start", ranges: .XID_Start)
	
}


extension UnicodeProperty {
	
	public struct BinaryProperty : Sendable {
		
		public init(
			rawValue: UInt64,
			name: String,
			ranges: [ClosedRange<UInt32>],
		) {
			self.rawValue = rawValue
			self.name = name
			self.ranges = ranges
		}
		
		public let rawValue: UInt64
		
		public let name: String
		
		public let ranges: [ClosedRange<UInt32>]
		
#if swift(>=6)
		public var rangeSet: RangeSet<UInt32> {
			RangeSet(
				ranges.map {
					$0.lowerBound ..< $0.upperBound + 1
				},
			)
		}
#endif
		
	}
	
}


extension UnicodeProperty.BinaryProperty : CaseIterable {
	
	public static let allCases: [UnicodeProperty.BinaryProperty] = [
		.alphabetic,
		.asciiHexDigit,
		.bidiControl,
		.bidiMirrored,
		.cased,
		.caseIgnorable,
		.changesWhenCaseFolded,
		.changesWhenCaseMapped,
		.changesWhenLowercased,
		.changesWhenNFKCCaseFolded,
		.changesWhenTitlecased,
		.changesWhenUppercased,
		.dash,
		.defaultIgnorableCodePoint,
		.deprecated,
		.diacritic,
		.emoji,
		.emojiModifier,
		.emojiModifierBase,
		.emojiPresentation,
		.extender,
		.fullCompositionExclusion,
		.graphemeBase,
		.graphemeExtend,
		.hexDigit,
		.idContinue,
		.idStart,
		.ideographic,
		.idsBinaryOperator,
		.idsTrinaryOperator,
		.joinControl,
		.logicalOrderException,
		.lowercase,
		.math,
		.noncharacterCodePoint,
		.patternSyntax,
		.patternWhitespace,
		.quotationMark,
		.radical,
		.sentenceTerminal,
		.softDotted,
		.terminalPunctuation,
		.unifiedIdeograph,
		.uppercase,
		.variationSelector,
		.whitespace,
		.xidContinue,
		.xidStart,
	]
	
	public static let nameMapping: [String : UnicodeProperty.BinaryProperty] = [
		"Alphabetic": .alphabetic,
		"ASCII_Hex_Digit": .asciiHexDigit,
		"Bidi_Control": .bidiControl,
		"Bidi_Mirrored": .bidiMirrored,
		"Case_Ignorable": .caseIgnorable,
		"Cased": .cased,
		"Changes_When_Casefolded": .changesWhenCaseFolded,
		"Changes_When_Casemapped": .changesWhenCaseMapped,
		"Changes_When_Lowercased": .changesWhenLowercased,
		"Changes_When_NFKC_Casefolded": .changesWhenNFKCCaseFolded,
		"Changes_When_Titlecased": .changesWhenTitlecased,
		"Changes_When_Uppercased": .changesWhenUppercased,
		//		case compositionExclusion = "Composition_Exclusion"
		"Dash": .dash,
		"Default_Ignorable_Code_Point": .defaultIgnorableCodePoint,
		"Deprecated": .deprecated,
		"Diacritic": .diacritic,
		"Emoji": .emoji,
		//		case emojiComponent = "Emoji_Component"
		"Emoji_Modifier": .emojiModifier,
		"Emoji_Modifier_Base": .emojiModifierBase,
		"Emoji_Presentation": .emojiPresentation,
		//		case expandsOnNFC = "Expands_On_NFC"
		//		case expandsOnNFD = "Expands_On_NFD"
		//		case expandsOnNFKC = "Expands_On_NFKC"
		//		case expandsOnNFKD = "Expands_On_NFKD"
		//		case extendedPictographic = "Extended_Pictographic"
		"Extender": .extender,
		// v15:FC_NFKC
		"Full_Composition_Exclusion": .fullCompositionExclusion,
		"Grapheme_Base": .graphemeBase,
		"Grapheme_Extend": .graphemeExtend,
		//		case graphemeLink = "Grapheme_Link"
		"Hex_Digit": .hexDigit,
		//		case hyphen = "Hyphen"
		"ID_Continue": .idContinue,
		"ID_Start": .idStart,
		"Ideographic": .ideographic,
		"IDS_Binary_Operator": .idsBinaryOperator,
		"IDS_Trinary_Operator": .idsTrinaryOperator,
		"Join_Control": .joinControl,
		"Logical_Order_Exception": .logicalOrderException,
		"Lowercase": .lowercase,
		"Math": .math,
		// v15:FC_NFC_QC
		// v15:FC_NFD_QC
		// v15:FC_NFKC_CF
		// v15:FC_NFKC_QC
		// v15:FC_NFKD_QC
		"Noncharacter_Code_Point": .noncharacterCodePoint,
		"Other_Alphabetic": .alphabetic,
		"Other_Default_Ignorable_Code_Point": .defaultIgnorableCodePoint,
		"Other_Grapheme_Extend": .graphemeExtend,
		"Other_ID_Continue": .idContinue,
		"Other_ID_Start": .idStart,
		"Other_Lowercase": .lowercase,
		"Other_Math": .math,
		"Other_Uppercase": .uppercase,
		"Pattern_Syntax": .patternSyntax,
		"Pattern_White_Space": .patternWhitespace,
		//		case prependedConcatenationMark = "Prepended_Concatenation_Mark"
		"Quotation_Mark": .quotationMark,
		"Radical": .radical,
		//		case regionalIndicator = "Regional_Indicator"
		"Sentence_Terminal": .sentenceTerminal,
		"Soft_Dotted": .softDotted,
		"Terminal_Punctuation": .terminalPunctuation,
		"Unified_Ideograph": .unifiedIdeograph,
		"Uppercase": .uppercase,
		"Variation_Selector": .variationSelector,
		"White_Space": .whitespace,
		"XID_Continue": .xidContinue,
		"XID_Start": .xidStart,
	]
	
	@inlinable
	public static func from(
		_ name: String,
	) -> Self? {
		if name.hasPrefix("Other_") {
			nameMapping[String(name.trimmingPrefix("Other_"))]
		}
		else {
			nameMapping[name]
		}
	}
	
}


extension UnicodeProperty.BinaryProperty : Equatable {
	
	@inlinable
	public static func == (
		lhs: Self,
		rhs: Self,
	) -> Bool {
		lhs.rawValue == rhs.rawValue
	}
	
}


extension UnicodeProperty.BinaryProperty : Hashable {

	public func hash(
		into hasher: inout Hasher,
	) {
		hasher.combine(rawValue)
	}

}


extension UnicodeProperty.BinaryProperty : CustomStringConvertible {
	
	@inlinable
	public var description: String {
		name
	}
	
}
