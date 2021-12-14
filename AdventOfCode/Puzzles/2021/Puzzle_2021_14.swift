//
//  Puzzle_2021_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/14

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
        solvePart2(str: Puzzle_Input.test)
    }

    private func solvePart1(str: String) -> Int {
        var arr = str.parseIntoStringArray()
        let originalString = arr.removeFirst()
        var exchangeDict: [String: String] = [:]
        for line in arr {
            let components = line.capturedGroups(withRegex: "(..) -> (.)", trimResults: true)
            exchangeDict[components[0]] = components[1]
        }

        var str = originalString.map { String($0) }
        for _ in 1...10 {
            var newStr = ""
            for idx in 0..<(str.count - 1) {
                let pair = str[idx] + str[idx + 1]
                newStr += str[idx]
                if let exchange = exchangeDict[pair] {
                    newStr += exchange
                }
            }

            newStr += str.last ?? ""
            str = newStr.map { String($0) }
        }

        let counts = str.lazy.joined().characterCounts().map { $0.value }.sorted()
        guard let countsMax = counts.last, let countsMin = counts.first else {
            return -1
        }

        return countsMax - countsMin
    }

    private func solvePart2(str: String) -> Int {
        var arr = str.parseIntoStringArray()
        let originalString = arr.removeFirst()
        var exchangeDict: [String: String] = [:]
        for line in arr {
            let components = line.capturedGroups(withRegex: "(..) -> (.)", trimResults: true)
            exchangeDict[components[0]] = components[1]
        }

        var str = originalString.map { String($0) }
        for step in 1...40 {
            print(step)
            var newStr = ""
            for idx in 0..<(str.count - 1) {
                let pair = str[idx] + str[idx + 1]
                newStr += str[idx]
                if let exchange = exchangeDict[pair] {
                    newStr += exchange
                }
            }

            newStr += str.last ?? ""
            str = newStr.map { String($0) }
        }

        let counts = str.lazy.joined().characterCounts().map { $0.value }.sorted()
        guard let countsMax = counts.last, let countsMin = counts.first else {
            return -1
        }

        print(counts, countsMax, countsMin)
        return countsMax - countsMin
    }

    private func solvePart2_alt(str: String) -> Int {
        var arr = str.parseIntoStringArray()
        let originalString = arr.removeFirst()
        var exchangeDict: [String: String] = [:]
        for line in arr {
            let components = line.capturedGroups(withRegex: "(..) -> (.)", trimResults: true)
            exchangeDict[components[0]] = components[1]
        }

        print(originalString)
        print(exchangeDict)

        for idx in 0..<(str.count - 1) {
            let originalPair = String(str[idx]) + String(str[idx + 1])
            var str = originalPair.map { String($0) }
            for step in 1...40 {
                print(step)
                var newStr = ""
                for idx in 0..<(str.count - 1) {
                    let pair = str[idx] + str[idx + 1]
                    newStr += str[idx]
                    if let exchange = exchangeDict[pair] {
                        newStr += exchange
                    }
                }
                newStr += str.last ?? ""
                str = newStr.map { String($0) }
                print(str.count)
            }

            print(originalPair, str)
        }

        let counts = str.characterCounts().map { $0.value }.sorted()
        guard let countsMax = counts.last, let countsMin = counts.first else {
            return -1
        }

        print(counts, countsMax, countsMin)
        return countsMax - countsMin
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
