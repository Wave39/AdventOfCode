//
//  CharacterExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/21/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Character {
    // For these color squares, visit this site and search for something like "fuchsia square":
    // https://emojipedia.org/

    public static var blackSquare: Character { "⬛️" }
    public static var redSquare: Character { "🟥" }
    public static var yellowSquare: Character { "🟨" }
    public static var blueSquare: Character { "🟦" }
    public static var whiteSquare: Character { "⬜️" }
    public static var greenSquare: Character { "🟩" }
    public static var orangeSquare: Character { "🟧" }
    public static var purpleSquare: Character { "🟪" }

    public var asciiValue: UInt32? {
        String(self).unicodeScalars.first { $0.isASCII }?.value
    }

    public var int: Int {
        guard let retval = Int(String(self)) else {
            return 0
        }
        return retval
    }

    public static func asciiChar(v: Int) -> Character {
        Character(UnicodeScalar(v) ?? Unicode.Scalar(0))
    }

    public static func asciiValue(c: Character) -> Int {
        let s = String(c).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}
