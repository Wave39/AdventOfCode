//
//  Puzzle_2015_04.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import CommonCrypto
import CryptoKit
import Foundation

public class Puzzle_2015_04: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    private func md5StartsWithZeros(_ str: String) -> Bool {
        if let data = str.data(using: .utf8) {
            let computed = Insecure.MD5.hash(data: data)
            return computed.starts(with: [0, 0])
        }

        return false
    }

    public func solveBothParts() -> (Int, Int) {
        var counter = 1
        var fiveZeroCounter = 0
        var sixZeroCounter = 0

        while fiveZeroCounter == 0 || sixZeroCounter == 0 {
            let stringToTry = "\(PuzzleInput.final)\(counter)"
            if md5StartsWithZeros(stringToTry) {
                let md5String = stringToTry.md5
                if md5String.hasPrefix("00000") {
                    if fiveZeroCounter == 0 {
                        fiveZeroCounter = counter
                    }

                    if md5String.hasPrefix("000000") {
                        if sixZeroCounter == 0 {
                            sixZeroCounter = counter
                        }
                    }
                }
            }

            counter += 1
        }

        return (fiveZeroCounter, sixZeroCounter)
    }
}

private class PuzzleInput: NSObject {
    static let final = "ckczppom"
}
