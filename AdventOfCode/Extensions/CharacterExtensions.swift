//
//  CharacterExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/21/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension Character {
    // For these color squares, visit this site and search for something like "fuchsia square":
    // https://emojipedia.org/

    static var blackSquare: Character { "⬛️" }
    static var redSquare: Character { "🟥" }
    static var yellowSquare: Character { "🟨" }
    static var blueSquare: Character { "🟦" }
    static var whiteSquare: Character { "⬜️" }
    static var greenSquare: Character { "🟩" }
    static var orangeSquare: Character { "🟧" }
    static var purpleSquare: Character { "🟪" }

    var asciiValue: UInt32? {
        String(self).unicodeScalars.first { $0.isASCII }?.value
    }

    var int: Int {
        guard let retval = Int(String(self)) else {
            return 0
        }
        return retval
    }

    static func asciiChar(v: Int) -> Character {
        Character(UnicodeScalar(v) ?? Unicode.Scalar(0))
    }

    static func asciiValue(c: Character) -> Int {
        let s = String(c).unicodeScalars
        return Int(s[s.startIndex].value)
    }
}
