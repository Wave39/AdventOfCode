//
//  Puzzle_2019_16.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/18/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_16: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> String {
        solvePart1(str: Puzzle_2019_16_Input.puzzleInput, numberOfPhases: 100)
    }

    public func solvePart2() -> String {
        solvePart2(str: Puzzle_2019_16_Input.puzzleInput, numberOfPhases: 100)
    }

    private func getRepeatingList(n: Int) -> [Int] {
        var retval = Array(repeating: 0, count: n)
        retval.append(contentsOf: Array(repeating: 1, count: n))
        retval.append(contentsOf: Array(repeating: 0, count: n))
        retval.append(contentsOf: Array(repeating: -1, count: n))
        return retval
    }

    private func solvePart1(str: String, numberOfPhases: Int) -> String {
        var arr = Array(str)

        for _ in 1...numberOfPhases {
            var lineArray: [Character] = []
            for idx in 1...arr.count {
                let mult = getRepeatingList(n: idx)
                var total = 0
                for cIdx in 1...arr.count {
                    var multIdx = (cIdx - 1) % mult.count + 1
                    if multIdx >= mult.count {
                        multIdx = 0
                    }

                    total += (arr[cIdx - 1].int * mult[multIdx])
                }

                total = abs(total % 10)
                lineArray.append(Character(String(total)))
            }

            arr = lineArray
        }

        return String(arr[..<8])
    }

    // Part 2 code courtesy of https://github.com/XorZy/Aoc_2019_Day_16/blob/master/Program.cs

    private func solvePart2(str: String, numberOfPhases: Int) -> String {
        let arr0 = str.map { $0.int }
        var arr: [Int] = []
        for _ in 0..<10_000 {
            arr.append(contentsOf: arr0)
        }

        let messageOffset = str.prefix(7).int
        let inputCount = arr.count
        var currentInput = arr
        var nextInput = arr

        for _ in 0..<numberOfPhases {
            var currentIndex = inputCount - 2
            nextInput[currentIndex + 1] = currentInput[currentIndex + 1]
            while currentIndex >= messageOffset {
                nextInput[currentIndex] = (nextInput[currentIndex + 1] + currentInput[currentIndex]) % 10
                currentIndex -= 1
            }
            currentInput = nextInput
        }

        var finalString = ""
        for i in 0..<8 {
            finalString.append("\(currentInput[i + messageOffset])")
        }

        return finalString
    }
}

private class Puzzle_2019_16_Input: NSObject {
    static let puzzleInput_test1 = """
12345678
"""

    static let puzzleInput_test2 = """
80871224585914546619083218645595
"""

    static let puzzleInput_test3 = """
19617804207202209144916044189917
"""

    static let puzzleInput_test4 = """
69317163492948606335995924319873
"""

    static let puzzleInput_test5 = """
03036732577212944063491565474664
"""

    static let puzzleInput = """
59773590431003134109950482159532121838468306525505797662142691007448458436452137403459145576019785048254045936039878799638020917071079423147956648674703093863380284510436919245876322537671069460175238260758289779677758607156502756182541996384745654215348868695112673842866530637231316836104267038919188053623233285108493296024499405360652846822183647135517387211423427763892624558122564570237850906637522848547869679849388371816829143878671984148501319022974535527907573180852415741458991594556636064737179148159474282696777168978591036582175134257547127308402793359981996717609700381320355038224906967574434985293948149977643171410237960413164669930
"""
}
