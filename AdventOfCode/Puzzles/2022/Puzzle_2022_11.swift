//
//  Puzzle_2022_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_11: PuzzleBaseClass {
    private struct Monkey {
        var items: [Int] = []
        var operation = " "
        var factor: Int?
        var divisor = 0
        var trueMonkey = 0
        var falseMonkey = 0
        var inspectionCount = 0
    }

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

    private func parseMonkeyArray(str: String) -> [Monkey] {
        let lines = str.parseIntoStringArray()
        var currentMonkey = 0
        var monkeyArray: [Monkey] = []
        for line in lines {
            let arr = line.parseIntoStringArray(separator: " ")
            if arr[0] == "Monkey" {
                currentMonkey = arr[1].digitsOnly.int
                monkeyArray.append(Monkey())
            } else if arr[0] == "Starting" {
                let arr2 = arr[2...]
                for item in arr2 {
                    monkeyArray[currentMonkey].items.append(item.digitsOnly.int)
                }
            } else if arr[0] == "Operation:" {
                monkeyArray[currentMonkey].operation = arr[4]
                if arr[5] != "old" {
                    monkeyArray[currentMonkey].factor = arr[5].int
                }
            } else if arr[0] == "Test:" {
                monkeyArray[currentMonkey].divisor = arr[3].int
            } else if arr[1] == "true:" {
                monkeyArray[currentMonkey].trueMonkey = arr[5].int
            } else if arr[1] == "false:" {
                monkeyArray[currentMonkey].falseMonkey = arr[5].int
            } else {
                print("Parse error")
            }
        }

        return monkeyArray
    }

    private func getInspectionCounts(array: [Monkey], part1: Bool) -> [Int] {
        var monkeyArray = array
        let modulus = monkeyArray.map { $0.divisor }.reduce(1, *)
        for _ in 1...(part1 ? 20 : 10_000) {
            for idx in 0..<monkeyArray.count {
                if !monkeyArray[idx].items.isEmpty {
                    let itemsToInspect = monkeyArray[idx].items
                    monkeyArray[idx].items = []
                    monkeyArray[idx].inspectionCount += itemsToInspect.count
                    for item in itemsToInspect {
                        var worry = item % modulus
                        let factor = monkeyArray[idx].factor ?? item
                        if monkeyArray[idx].operation == "+" {
                            worry += factor
                        } else {
                            worry *= factor
                        }

                        if part1 {
                            worry /= 3
                        }

                        if worry % monkeyArray[idx].divisor == 0 {
                            monkeyArray[monkeyArray[idx].trueMonkey].items.append(worry)
                        } else {
                            monkeyArray[monkeyArray[idx].falseMonkey].items.append(worry)
                        }
                    }
                }
            }
        }

        let inspectionCounts = Array(monkeyArray.map { $0.inspectionCount }.sorted().reversed())
        return inspectionCounts
    }

    private func solvePart1(str: String) -> Int {
        let monkeyArray = parseMonkeyArray(str: str)
        let inspectionCounts = getInspectionCounts(array: monkeyArray, part1: true)
        return inspectionCounts[0] * inspectionCounts[1]
    }

    private func solvePart2(str: String) -> Int {
        let monkeyArray = parseMonkeyArray(str: str)
        let inspectionCounts = getInspectionCounts(array: monkeyArray, part1: false)
        return inspectionCounts[0] * inspectionCounts[1]
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""

    static let final = """
Monkey 0:
  Starting items: 89, 95, 92, 64, 87, 68
  Operation: new = old * 11
  Test: divisible by 2
    If true: throw to monkey 7
    If false: throw to monkey 4

Monkey 1:
  Starting items: 87, 67
  Operation: new = old + 1
  Test: divisible by 13
    If true: throw to monkey 3
    If false: throw to monkey 6

Monkey 2:
  Starting items: 95, 79, 92, 82, 60
  Operation: new = old + 6
  Test: divisible by 3
    If true: throw to monkey 1
    If false: throw to monkey 6

Monkey 3:
  Starting items: 67, 97, 56
  Operation: new = old * old
  Test: divisible by 17
    If true: throw to monkey 7
    If false: throw to monkey 0

Monkey 4:
  Starting items: 80, 68, 87, 94, 61, 59, 50, 68
  Operation: new = old * 7
  Test: divisible by 19
    If true: throw to monkey 5
    If false: throw to monkey 2

Monkey 5:
  Starting items: 73, 51, 76, 59
  Operation: new = old + 8
  Test: divisible by 7
    If true: throw to monkey 2
    If false: throw to monkey 1

Monkey 6:
  Starting items: 92
  Operation: new = old + 5
  Test: divisible by 11
    If true: throw to monkey 3
    If false: throw to monkey 0

Monkey 7:
  Starting items: 99, 76, 78, 76, 79, 90, 89
  Operation: new = old + 7
  Test: divisible by 5
    If true: throw to monkey 4
    If false: throw to monkey 5
"""
}
