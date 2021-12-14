//
//  Puzzle_2021_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/14

// Special thanks to Gereon Steffens for pointing me in the right direction, namely away from strings
// https://github.com/gereons/AoC2021/blob/main/Sources/AdventOfCode/puzzle14.swift

import Foundation

public class Puzzle_2021_14: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    private func processInput(str: String, iterations: Int) -> Int {
        var arr = str.parseIntoStringArray()
        let originalString = arr.removeFirst()
        var exchangeDict: [String: String] = [:]
        for line in arr {
            let components = line.capturedGroups(withRegex: "(..) -> (.)", trimResults: true)
            exchangeDict[components[0]] = components[1]
        }

        var pairDict = [String: Int]()
        let template = originalString.map { String($0) }
        for idx in 0..<(template.count - 1) {
            let pair = template[idx] + template[idx + 1]
            pairDict[pair, default: 0] += 1
        }

        for _ in 1...iterations {
            let keys = pairDict.keys
            var newPairDict = [String: Int]()
            for key in keys.map({ String($0) }) {
                if let substitution = exchangeDict[key] {
                    let key1 = String(key[0]) + substitution
                    newPairDict[key1, default: 0] += pairDict[key] ?? 0
                    let key2 = substitution + String(key[1])
                    newPairDict[key2, default: 0] += pairDict[key] ?? 0
                }
            }
            pairDict = newPairDict
        }

        var letterCounts = [String: Int]()
        for key in pairDict.keys.map({ String($0) }) {
            letterCounts[String(key[0]), default: 0] += pairDict[key] ?? 0
            letterCounts[String(key[1]), default: 0] += pairDict[key] ?? 0
        }

        let min = letterCounts.map { $1 }.min() ?? 0
        let max = letterCounts.map { $1 }.max() ?? 0

        return (max + 1) / 2 - (min + 1) / 2
    }

    private func solvePart1(str: String) -> Int {
        processInput(str: str, iterations: 10)
    }

    private func solvePart2(str: String) -> Int {
        processInput(str: str, iterations: 40)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""

    static let final = """
PKHOVVOSCNVHHCVVCBOH

NO -> B
PV -> P
OC -> K
SC -> K
FK -> P
PO -> P
FC -> V
KN -> V
CN -> O
CB -> K
NF -> K
CO -> F
SK -> F
VO -> B
SF -> F
PB -> F
FF -> C
HC -> P
PF -> B
OP -> B
OO -> V
OK -> N
KB -> H
PN -> V
PP -> N
FV -> S
BO -> O
HN -> C
FP -> F
BP -> B
HB -> N
VC -> F
PC -> V
FO -> O
OH -> S
FH -> B
HK -> B
BC -> F
ON -> K
FN -> N
NN -> O
PH -> P
KS -> H
HV -> F
BK -> O
NP -> S
CC -> H
KV -> V
NB -> C
NS -> S
KO -> V
NK -> H
HO -> C
KC -> P
VH -> C
VK -> O
CP -> K
BS -> N
BB -> F
VV -> K
SH -> O
SO -> N
VF -> K
NV -> K
SV -> O
NH -> C
VS -> N
OF -> N
SP -> C
HP -> O
NC -> V
KP -> B
KH -> O
SN -> S
CS -> N
FB -> P
OB -> H
VP -> B
CH -> O
BF -> B
PK -> S
CF -> V
CV -> S
VB -> P
CK -> H
PS -> N
SS -> C
OS -> P
OV -> F
VN -> V
BV -> V
HF -> B
FS -> O
BN -> K
SB -> N
HH -> S
BH -> S
KK -> H
HS -> K
KF -> V
"""
}
