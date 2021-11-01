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

    static var blackSquare: Character { return "⬛️" }
    static var redSquare: Character { return "🟥" }
    static var yellowSquare: Character { return "🟨" }
    static var blueSquare: Character { return "🟦" }
    static var whiteSquare: Character { return "⬜️" }
    static var greenSquare: Character { return "🟩" }
    static var orangeSquare: Character { return "🟧" }
    static var purpleSquare: Character { return "🟪" }

    var asciiValue: UInt32? {
        return String(self).unicodeScalars.first(where: { $0.isASCII })?.value
    }

    static func asciiChar(v: Int) -> Character {
        return Character(UnicodeScalar(v)!)
    }

    static func asciiValue(c: Character) -> Int {
        let s = String(c).unicodeScalars
        return Int(s[s.startIndex].value)
    }

}
