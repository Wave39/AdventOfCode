//
//  Puzzle_2022_05.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/5/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_05: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> String {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> String {
        solvePart2(str: Puzzle_Input.final)
    }

    private func solve(str: String, part1: Bool) -> String {
        let lines = str.parseIntoStringArray()
        var stackArray = Array(repeating: Array<Character>(), count: 9)
        for line in lines {
            if line.contains("[") {
                var str = line
                var idx = 0
                while !str.isEmpty {
                    let str0 = str.prefix(3)
                    if str0 != "   " {
                        if stackArray[idx].isEmpty {
                            stackArray[idx].append(str0[1])
                        } else {
                            stackArray[idx].insert(str0[1], at: 0)
                        }
                    }

                    str.removeFirst(3)
                    if !str.isEmpty {
                        str.removeFirst()
                    }

                    idx += 1
                }
            } else if line.contains("move") {
                let components = line.capturedGroups(withRegex: "move (.*) from (.*) to (.*)", trimResults: true).map { $0.int }
                let fromIdx = components[1] - 1
                let toIdx = components[2] - 1
                var cratesToMove = Array(stackArray[fromIdx].suffix(components[0]))
                for _ in 1...cratesToMove.count {
                    let char: Character
                    if part1 {
                        char = cratesToMove.removeLast()
                    } else {
                        char = cratesToMove.removeFirst()
                    }

                    stackArray[toIdx].append(char)
                    stackArray[fromIdx].removeLast()
                }
            }
        }

        var retval = ""
        for stack in stackArray {
            if !stack.isEmpty {
                retval += "\(stack.last ?? Character(""))"
            }
        }

        return retval
    }

    private func solvePart1(str: String) -> String {
        solve(str: str, part1: true)
    }

    private func solvePart2(str: String) -> String {
        solve(str: str, part1: false)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""

    static let final = """
        [H]     [W] [B]
    [D] [B]     [L] [G] [N]
[P] [J] [T]     [M] [R] [D]
[V] [F] [V]     [F] [Z] [B]     [C]
[Z] [V] [S]     [G] [H] [C] [Q] [R]
[W] [W] [L] [J] [B] [V] [P] [B] [Z]
[D] [S] [M] [S] [Z] [W] [J] [T] [G]
[T] [L] [Z] [R] [C] [Q] [V] [P] [H]
 1   2   3   4   5   6   7   8   9

move 3 from 2 to 9
move 1 from 1 to 6
move 6 from 6 to 7
move 13 from 7 to 6
move 2 from 4 to 5
move 1 from 4 to 3
move 5 from 9 to 8
move 1 from 8 to 5
move 3 from 1 to 6
move 2 from 1 to 8
move 1 from 2 to 1
move 1 from 9 to 3
move 2 from 9 to 8
move 2 from 5 to 9
move 4 from 5 to 4
move 10 from 8 to 4
move 5 from 6 to 2
move 5 from 5 to 9
move 7 from 3 to 7
move 1 from 9 to 8
move 1 from 1 to 9
move 1 from 7 to 3
move 3 from 8 to 9
move 8 from 6 to 7
move 3 from 9 to 4
move 3 from 2 to 6
move 6 from 6 to 3
move 10 from 7 to 9
move 1 from 7 to 5
move 1 from 5 to 7
move 2 from 3 to 6
move 8 from 4 to 2
move 7 from 4 to 3
move 5 from 2 to 3
move 2 from 4 to 6
move 6 from 2 to 8
move 14 from 9 to 1
move 6 from 3 to 2
move 7 from 3 to 7
move 4 from 2 to 3
move 1 from 6 to 5
move 3 from 6 to 5
move 2 from 2 to 4
move 3 from 1 to 2
move 2 from 4 to 1
move 3 from 5 to 6
move 1 from 9 to 6
move 1 from 2 to 6
move 7 from 7 to 4
move 5 from 8 to 1
move 11 from 3 to 5
move 2 from 2 to 5
move 8 from 5 to 1
move 4 from 7 to 2
move 2 from 6 to 8
move 3 from 2 to 4
move 1 from 8 to 3
move 1 from 3 to 2
move 11 from 1 to 8
move 4 from 6 to 5
move 1 from 4 to 1
move 2 from 6 to 4
move 14 from 1 to 9
move 1 from 1 to 6
move 1 from 1 to 9
move 10 from 4 to 3
move 3 from 3 to 2
move 8 from 8 to 9
move 1 from 4 to 5
move 8 from 5 to 8
move 10 from 9 to 5
move 5 from 3 to 2
move 1 from 3 to 7
move 1 from 2 to 5
move 6 from 2 to 3
move 7 from 3 to 5
move 1 from 6 to 9
move 2 from 5 to 9
move 4 from 2 to 9
move 1 from 2 to 1
move 1 from 1 to 5
move 1 from 7 to 4
move 17 from 9 to 1
move 4 from 1 to 5
move 9 from 5 to 8
move 21 from 8 to 6
move 1 from 4 to 6
move 3 from 5 to 1
move 10 from 1 to 5
move 12 from 5 to 3
move 3 from 3 to 6
move 5 from 5 to 7
move 5 from 5 to 9
move 5 from 7 to 5
move 2 from 5 to 7
move 1 from 8 to 5
move 1 from 7 to 3
move 3 from 1 to 7
move 11 from 6 to 5
move 1 from 7 to 3
move 5 from 9 to 7
move 8 from 3 to 6
move 4 from 9 to 6
move 3 from 1 to 6
move 1 from 9 to 5
move 6 from 5 to 1
move 1 from 1 to 6
move 3 from 1 to 3
move 2 from 1 to 2
move 19 from 6 to 1
move 2 from 5 to 9
move 5 from 3 to 1
move 1 from 5 to 6
move 5 from 6 to 7
move 3 from 7 to 9
move 6 from 5 to 9
move 1 from 5 to 6
move 4 from 6 to 9
move 2 from 2 to 1
move 1 from 3 to 2
move 1 from 2 to 7
move 7 from 7 to 6
move 21 from 1 to 3
move 2 from 7 to 8
move 7 from 3 to 2
move 2 from 7 to 9
move 8 from 3 to 8
move 4 from 3 to 1
move 6 from 1 to 9
move 7 from 2 to 9
move 1 from 3 to 6
move 1 from 8 to 7
move 1 from 1 to 6
move 12 from 6 to 9
move 1 from 3 to 6
move 1 from 7 to 5
move 1 from 1 to 9
move 1 from 5 to 9
move 39 from 9 to 4
move 3 from 9 to 6
move 1 from 9 to 6
move 7 from 8 to 4
move 1 from 9 to 8
move 44 from 4 to 1
move 1 from 6 to 3
move 28 from 1 to 8
move 15 from 8 to 1
move 1 from 3 to 2
move 11 from 1 to 5
move 1 from 4 to 7
move 1 from 4 to 5
move 16 from 1 to 6
move 1 from 2 to 6
move 12 from 8 to 2
move 1 from 7 to 4
move 3 from 2 to 4
move 7 from 2 to 4
move 4 from 1 to 6
move 10 from 5 to 6
move 1 from 1 to 5
move 3 from 5 to 9
move 3 from 8 to 7
move 1 from 2 to 3
move 1 from 2 to 4
move 3 from 7 to 4
move 30 from 6 to 8
move 1 from 3 to 7
move 20 from 8 to 4
move 1 from 7 to 3
move 1 from 9 to 8
move 25 from 4 to 6
move 1 from 3 to 5
move 8 from 8 to 5
move 3 from 8 to 4
move 2 from 9 to 5
move 2 from 5 to 2
move 21 from 6 to 4
move 2 from 2 to 6
move 28 from 4 to 5
move 1 from 8 to 6
move 5 from 4 to 8
move 3 from 6 to 7
move 15 from 5 to 2
move 3 from 7 to 6
move 1 from 4 to 3
move 17 from 5 to 1
move 1 from 3 to 4
move 1 from 4 to 8
move 4 from 2 to 4
move 4 from 4 to 1
move 5 from 6 to 8
move 11 from 8 to 3
move 4 from 6 to 7
move 5 from 3 to 2
move 4 from 3 to 1
move 25 from 1 to 7
move 3 from 6 to 7
move 8 from 2 to 3
move 11 from 7 to 2
move 2 from 2 to 7
move 16 from 2 to 6
move 1 from 2 to 8
move 1 from 7 to 6
move 1 from 5 to 2
move 16 from 6 to 2
move 3 from 5 to 7
move 6 from 2 to 8
move 1 from 5 to 4
move 1 from 4 to 3
move 4 from 8 to 9
move 4 from 3 to 9
move 2 from 6 to 2
move 6 from 2 to 4
move 1 from 9 to 7
move 1 from 2 to 8
move 7 from 3 to 6
move 4 from 2 to 6
move 2 from 9 to 5
move 1 from 2 to 4
move 6 from 6 to 9
move 2 from 5 to 1
move 1 from 1 to 4
move 1 from 9 to 4
move 2 from 7 to 6
move 1 from 2 to 5
move 1 from 5 to 9
move 4 from 8 to 1
move 7 from 9 to 8
move 3 from 1 to 7
move 1 from 8 to 3
move 4 from 9 to 6
move 6 from 8 to 1
move 6 from 1 to 2
move 1 from 1 to 9
move 1 from 1 to 7
move 21 from 7 to 5
move 11 from 5 to 3
move 1 from 9 to 5
move 1 from 2 to 8
move 5 from 7 to 5
move 10 from 3 to 9
move 1 from 8 to 5
move 8 from 4 to 2
move 1 from 3 to 4
move 2 from 7 to 3
move 5 from 5 to 3
move 5 from 9 to 8
move 10 from 6 to 2
move 1 from 6 to 4
move 1 from 9 to 4
move 4 from 9 to 3
move 19 from 2 to 5
move 2 from 4 to 5
move 11 from 5 to 1
move 15 from 5 to 2
move 4 from 8 to 1
move 12 from 1 to 5
move 1 from 8 to 1
move 1 from 4 to 8
move 3 from 1 to 3
move 8 from 5 to 4
move 7 from 3 to 9
move 4 from 3 to 5
move 4 from 4 to 1
move 3 from 9 to 3
move 2 from 4 to 1
move 4 from 3 to 8
move 4 from 2 to 3
move 1 from 9 to 5
move 4 from 8 to 6
move 2 from 4 to 3
move 1 from 4 to 5
move 5 from 3 to 4
move 3 from 3 to 6
move 5 from 1 to 6
move 2 from 4 to 6
move 1 from 9 to 2
move 7 from 6 to 3
move 1 from 8 to 9
move 2 from 1 to 4
move 2 from 4 to 7
move 4 from 6 to 4
move 5 from 3 to 7
move 1 from 7 to 2
move 3 from 6 to 7
move 1 from 4 to 5
move 4 from 2 to 6
move 3 from 6 to 9
move 1 from 6 to 5
move 1 from 9 to 2
move 5 from 9 to 3
move 11 from 5 to 1
move 3 from 7 to 8
move 2 from 8 to 9
move 4 from 5 to 1
move 10 from 2 to 7
move 5 from 3 to 7
move 1 from 9 to 3
move 6 from 1 to 7
move 22 from 7 to 9
move 3 from 2 to 4
move 4 from 5 to 3
move 1 from 8 to 4
move 5 from 4 to 7
move 19 from 9 to 8
move 2 from 1 to 5
move 2 from 4 to 5
move 2 from 4 to 9
move 4 from 9 to 2
move 4 from 7 to 3
move 5 from 7 to 5
move 7 from 3 to 7
move 2 from 8 to 4
move 3 from 4 to 7
move 12 from 8 to 1
move 4 from 3 to 7
move 1 from 3 to 6
move 1 from 6 to 1
move 1 from 5 to 9
move 3 from 9 to 3
move 2 from 2 to 4
move 3 from 8 to 3
move 2 from 4 to 7
move 7 from 5 to 1
move 2 from 8 to 3
move 8 from 7 to 9
move 2 from 9 to 7
move 3 from 9 to 5
move 11 from 1 to 2
move 5 from 3 to 8
move 16 from 1 to 5
move 1 from 9 to 8
move 3 from 3 to 2
move 6 from 2 to 6
move 6 from 7 to 4
move 2 from 5 to 2
move 6 from 4 to 9
move 11 from 5 to 7
move 2 from 6 to 5
move 9 from 5 to 1
move 2 from 8 to 5
move 13 from 7 to 4
move 6 from 1 to 5
move 10 from 2 to 9
move 1 from 4 to 5
move 4 from 6 to 9
move 3 from 2 to 4
move 2 from 8 to 2
move 15 from 4 to 5
move 1 from 2 to 8
move 1 from 2 to 3
move 2 from 8 to 7
move 3 from 7 to 1
move 1 from 7 to 8
move 3 from 5 to 9
move 1 from 7 to 1
move 21 from 5 to 2
move 3 from 9 to 1
move 5 from 1 to 4
move 1 from 3 to 4
move 1 from 8 to 5
move 1 from 8 to 9
move 1 from 5 to 3
move 5 from 2 to 5
move 5 from 5 to 3
move 7 from 9 to 2
move 3 from 3 to 6
move 2 from 1 to 4
move 1 from 3 to 4
move 2 from 3 to 2
move 25 from 2 to 1
move 11 from 9 to 2
move 9 from 2 to 8
move 4 from 9 to 5
move 6 from 4 to 3
move 3 from 3 to 5
move 9 from 8 to 2
move 3 from 4 to 3
move 1 from 9 to 4
move 4 from 3 to 8
move 2 from 8 to 1
move 3 from 5 to 9
move 2 from 8 to 1
move 4 from 2 to 9
move 6 from 9 to 4
move 1 from 9 to 2
move 1 from 6 to 4
move 3 from 4 to 3
move 2 from 3 to 9
move 3 from 1 to 9
move 2 from 2 to 7
move 2 from 7 to 2
move 2 from 3 to 2
move 5 from 9 to 7
move 2 from 7 to 2
move 28 from 1 to 7
move 1 from 1 to 9
move 10 from 2 to 5
move 1 from 9 to 5
move 14 from 7 to 1
move 6 from 1 to 6
move 12 from 7 to 9
move 6 from 1 to 5
move 1 from 3 to 8
move 4 from 7 to 1
move 4 from 4 to 8
move 4 from 6 to 1
move 1 from 2 to 8
move 1 from 2 to 1
move 1 from 6 to 1
move 5 from 9 to 8
move 16 from 5 to 7
move 2 from 7 to 1
move 6 from 8 to 1
move 2 from 9 to 4
move 2 from 1 to 3
move 1 from 6 to 8
move 2 from 5 to 3
move 3 from 5 to 7
move 4 from 8 to 7
move 4 from 9 to 8
move 6 from 8 to 6
move 10 from 7 to 8
move 1 from 9 to 1
move 11 from 7 to 6
move 2 from 3 to 9
move 1 from 3 to 4
move 4 from 1 to 2
move 3 from 2 to 3
move 1 from 9 to 1
move 3 from 4 to 2
move 9 from 6 to 4
move 2 from 3 to 5
move 8 from 4 to 9
move 4 from 1 to 8
move 3 from 8 to 2
move 2 from 2 to 6
move 1 from 7 to 2
move 11 from 6 to 5
move 7 from 8 to 6
move 7 from 5 to 8
move 5 from 8 to 5
move 1 from 2 to 5
move 3 from 5 to 7
move 8 from 5 to 6
move 2 from 4 to 5
move 1 from 7 to 9
move 2 from 3 to 8
move 3 from 8 to 5
move 13 from 6 to 2
move 2 from 8 to 5
move 5 from 1 to 9
move 3 from 6 to 4
move 5 from 5 to 8
move 1 from 5 to 4
move 4 from 1 to 4
move 1 from 7 to 2
move 12 from 9 to 7
move 2 from 9 to 1
move 3 from 8 to 3
move 1 from 5 to 4
move 3 from 8 to 9
move 2 from 4 to 7
move 4 from 9 to 5
move 5 from 4 to 9
move 3 from 9 to 2
move 1 from 9 to 4
move 1 from 9 to 3
move 12 from 7 to 4
move 1 from 4 to 8
move 1 from 8 to 1
move 1 from 5 to 4
move 2 from 3 to 5
move 11 from 2 to 3
move 4 from 5 to 7
move 7 from 7 to 2
move 1 from 1 to 9
move 1 from 8 to 3
move 1 from 9 to 1
move 2 from 1 to 5
move 2 from 5 to 4
move 1 from 8 to 1
move 2 from 5 to 8
move 5 from 1 to 9
move 11 from 3 to 9
move 1 from 3 to 6
move 1 from 6 to 3
move 3 from 3 to 6
move 3 from 2 to 6
move 13 from 9 to 7
move 2 from 6 to 1
move 8 from 4 to 9
move 7 from 4 to 2
move 2 from 8 to 6
move 1 from 1 to 9
move 5 from 2 to 1
move 2 from 1 to 3
move 10 from 2 to 8
move 3 from 9 to 3
move 1 from 7 to 4
move 6 from 7 to 5
"""
}
