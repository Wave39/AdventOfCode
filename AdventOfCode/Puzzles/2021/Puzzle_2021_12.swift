//
//  Puzzle_2021_12.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/12

import Foundation

public class Puzzle_2021_12: PuzzleBaseClass {
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

    private func processInput(str: String, allowSingleSmallCaveVisit: Bool) -> Int {
        let arr = str.parseIntoStringArray()
        var caveDict: [String: [String]] = [:]
        for line in arr {
            let components = line.capturedGroups(withRegex: "(.*)-(.*)", trimResults: true)
            if caveDict[components[0]] == nil {
                caveDict[components[0]] = []
            }

            caveDict[components[0]]?.append(components[1])

            if caveDict[components[1]] == nil {
                caveDict[components[1]] = []
            }

            caveDict[components[1]]?.append(components[0])
        }

        var routes: [[String]] = []

        func buildRoute(startingAt: String, array: [String]) {
            if startingAt == "end" {
                var newArray = array
                newArray.append(startingAt)
                routes.append(newArray)
                return
            }

            var continueRoute = true
            if startingAt == startingAt.lowercased() && array.contains(startingAt) {
                if allowSingleSmallCaveVisit {
                    var lowerArray: [String] = []
                    var lowerSet: Set<String> = Set()
                    for entry in array.filter({ $0 != "start" && $0 == $0.lowercased() }) {
                        lowerArray.append(entry)
                        lowerSet.insert(entry)
                    }

                    continueRoute = (lowerArray.count == lowerSet.count)
                } else {
                    continueRoute = false
                }
            }

            if continueRoute {
                var newArray = array
                newArray.append(startingAt)
                if let linkArray = caveDict[startingAt] {
                    for link in linkArray {
                        if link != "start" {
                            buildRoute(startingAt: link, array: newArray)
                        }
                    }
                }
            }
        }

        buildRoute(startingAt: "start", array: [])

        return routes.count
    }

    private func solvePart1(str: String) -> Int {
        processInput(str: str, allowSingleSmallCaveVisit: false)
    }

    private func solvePart2(str: String) -> Int {
        processInput(str: str, allowSingleSmallCaveVisit: true)
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
start-A
start-b
A-c
A-b
b-d
A-end
b-end
"""

    static let test2 = """
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
"""

    static let test3 = """
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
"""

    static let final = """
pf-pk
ZQ-iz
iz-NY
ZQ-end
pf-gx
pk-ZQ
ZQ-dc
NY-start
NY-pf
NY-gx
ag-ZQ
pf-start
start-gx
BN-ag
iz-pf
ag-FD
pk-NY
gx-pk
end-BN
ag-pf
iz-pk
pk-ag
iz-end
iz-BN
"""
}
