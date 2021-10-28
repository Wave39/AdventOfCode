//
//  Puzzle_2017_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/26/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_21: PuzzleBaseClass {

    func getCharacterAt(arr: [[Character]], x: Int, y: Int) -> Character {
        return arr[y][x]
    }

    func getPixelCount(arr: [[Character]]) -> Int {
        var retval = 0
        for y in 0..<arr.count {
            for x in 0..<arr[y].count {
                if arr[y][x] == "#" {
                    retval += 1
                }
            }
        }

        return retval
    }

    func printArray(arr: [[Character]]) {
        for line in arr {
            var s = ""
            for c in line {
                s += String(c)
            }

            print(s)
        }
    }

    func getArray(str: String) -> [[Character]] {
        var arr: [[Character]] = []
        let lines = str.split(separator: "/")
        for line in lines {
            var lineArray: [Character] = []
            for c in line {
                lineArray.append(c)
            }

            arr.append(lineArray)
        }

        return arr
    }

    func getString(arr: [[Character]]) -> String {
        var retval = ""
        for y in 0..<arr.count {
            for x in 0..<arr[y].count {
                retval += String(getCharacterAt(arr: arr, x: x, y: y))
            }

            if y != (arr.count - 1) {
                retval += "/"
            }
        }

        return retval.trim()
    }

    func getSubArray(arr: [[Character]], x: Int, y: Int, size: Int) -> [[Character]] {
        var subArray: [[Character]] = []
        for yIndex in y..<(y + size) {
            var lineArray: [Character] = []
            for xIndex in x..<(x + size) {
                lineArray.append(getCharacterAt(arr: arr, x: xIndex, y: yIndex))
            }

            subArray.append(lineArray)
        }

        return subArray
    }

    func rotateArrayClockwise(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for x in 0..<size {
            var lineArray: [Character] = []
            for y in stride(from: size - 1, through: 0, by: -1) {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }

            arr.append(lineArray)
        }

        return arr
    }

    func flipArrayVertical(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for y in 0..<size {
            var lineArray: [Character] = []
            for x in stride(from: size - 1, through: 0, by: -1) {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }

            arr.append(lineArray)
        }

        return arr
    }

    func flipArrayHorizontal(original: [[Character]]) -> [[Character]] {
        var arr: [[Character]] = []
        let size = original.count
        for y in stride(from: size - 1, through: 0, by: -1) {
            var lineArray: [Character] = []
            for x in 0..<size {
                lineArray.append(getCharacterAt(arr: original, x: x, y: y))
            }

            arr.append(lineArray)
        }

        return arr
    }

    func inputPatternRotations(arr: [[Character]]) -> Set<String> {
        var inputPatterns: Set<String> = Set()
        var tempArr: [[Character]] = arr
        for _ in 0..<4 {
            inputPatterns.insert(getString(arr: tempArr))
            inputPatterns.insert(getString(arr: flipArrayHorizontal(original: tempArr)))
            inputPatterns.insert(getString(arr: flipArrayVertical(original: tempArr)))
            tempArr = rotateArrayClockwise(original: tempArr)
        }

        return inputPatterns
    }

    func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    func solveBothParts() -> (Int, Int) {
        var rules: Dictionary<String, String> = [:]
        for line in PuzzleInput.final.split(separator: "\n") {
            let arr = line.split(separator: "=")
            let leftArr = getArray(str: String(arr[0]))
            let rightStr = String(arr[1]).removeCharacters(startIdx: 0, charLength: 2)
            rules[getString(arr: leftArr)] = rightStr
        }

        var part1Solution = 0
        var pattern = getArray(str: PuzzleInput.startingPattern)
        for iteration in 0..<18 {
            let patternSize = pattern.count
            var patternStep = 3
            if patternSize % 2 == 0 {
                patternStep = 2
            }

            var replacementStrings: [String] = []
            var x = 0
            var y = 0
            while y < patternSize {
                x = 0
                while x < patternSize {
                    let subArray = getSubArray(arr: pattern, x: x, y: y, size: patternStep)
                    let rotations = inputPatternRotations(arr: subArray)
                    var replacementKey: String = ""
                    for k in rules.keys {
                        if rotations.contains(k) {
                            replacementKey = k
                        }
                    }

                    let replacementString = rules[replacementKey]!
                    replacementStrings.append(replacementString)
                    x += patternStep
                }

                y += patternStep
            }

            let firstReplacementArray = getArray(str: replacementStrings[0])
            let sqr = Int(sqrt(Double(replacementStrings.count)))
            let newSize = firstReplacementArray.count * sqr

            var newPattern: [[Character]] = []
            for _ in 0..<newSize {
                var lineArray: [Character] = []
                for _ in 0..<newSize {
                    lineArray.append(".")
                }

                newPattern.append(lineArray)
            }

            x = 0
            y = 0
            for replacement in replacementStrings {
                let rArr = getArray(str: replacement)
                for y0 in 0..<rArr.count {
                    for x0 in 0..<rArr.count {
                        newPattern[y + y0][x + x0] = getCharacterAt(arr: rArr, x: x0, y: y0)
                    }
                }

                x += rArr.count
                if x >= newSize {
                    x = 0
                    y += rArr.count
                }
            }

            pattern = newPattern
            if iteration == 4 {
                part1Solution = getPixelCount(arr: pattern)
            }
        }

        let part2Solution = getPixelCount(arr: pattern)

        return (part1Solution, part2Solution)
    }

}

private class PuzzleInput: NSObject {

    static let startingPattern =

"""
.#./..#/###
"""

    static let test1 =

"""
../.# => ##./#../...
.#./#../### => #..#/..../..../#..#
"""

    static let final =

"""
../.. => .../.../###
#./.. => .../.#./.##
##/.. => .#./.#./...
.#/#. => ###/..#/.##
##/#. => ..#/###/#..
##/## => ..#/#../##.
.../.../... => .##./##../..##/.##.
#../.../... => ##../.#.#/..#./###.
.#./.../... => ##.#/#.#./.#../..##
##./.../... => ...#/##.#/.#.#/#.##
#.#/.../... => ..#./#.../###./...#
###/.../... => #.#./...#/#.#./###.
.#./#../... => ...#/###./.##./...#
##./#../... => ###./####/###./..##
..#/#../... => ####/#.../####/#.##
#.#/#../... => #.##/.#.#/##.#/###.
.##/#../... => ..../.#../.#.#/.##.
###/#../... => ..##/##.#/..##/.###
.../.#./... => ###./..##/.#../#..#
#../.#./... => ###./.#../#.../#...
.#./.#./... => ####/..#./.##./##..
##./.#./... => .#../#.#./###./###.
#.#/.#./... => ####/.##./##.#/.###
###/.#./... => #.#./..##/.##./#...
.#./##./... => ####/#.##/####/..#.
##./##./... => #.../.#../..../#.##
..#/##./... => #..#/..##/#.../####
#.#/##./... => ###./##../..##/#...
.##/##./... => ..../#.##/.###/#.#.
###/##./... => .#../##.#/.#../##..
.../#.#/... => ...#/.###/.##./###.
#../#.#/... => ###./##../#.#./.##.
.#./#.#/... => ..#./.#../.##./.###
##./#.#/... => #.../#.../.##./.#..
#.#/#.#/... => .##./..##/.###/#...
###/#.#/... => ..../####/###./....
.../###/... => #.##/.#.#/#.##/...#
#../###/... => #.../#.#./.#../#...
.#./###/... => ...#/###./.##./.#.#
##./###/... => ##../####/###./#.##
#.#/###/... => ...#/###./##.#/.#.#
###/###/... => #.#./##.#/..../.##.
..#/.../#.. => ...#/..#./..#./##..
#.#/.../#.. => ..#./#.##/#.#./#.##
.##/.../#.. => ####/####/#.##/#...
###/.../#.. => ###./..#./###./.#..
.##/#../#.. => ...#/####/..../###.
###/#../#.. => ##.#/.#../##.#/...#
..#/.#./#.. => ###./#.##/...#/##..
#.#/.#./#.. => #.../..#./..#./#.##
.##/.#./#.. => ##.#/...#/#.#./.###
###/.#./#.. => .#../..##/#.#./..#.
.##/##./#.. => #.../#.#./.###/#...
###/##./#.. => .##./.#../.#.#/.###
#../..#/#.. => ###./#..#/#.../##.#
.#./..#/#.. => #.#./#..#/#.../.###
##./..#/#.. => ...#/..##/..#./####
#.#/..#/#.. => ####/#..#/###./#.#.
.##/..#/#.. => ..#./..#./..../.##.
###/..#/#.. => ...#/#..#/#.#./....
#../#.#/#.. => ..##/.#.#/.###/.##.
.#./#.#/#.. => ..../##.#/..##/#..#
##./#.#/#.. => ..#./..##/#..#/#..#
..#/#.#/#.. => ..#./#.../#.#./##..
#.#/#.#/#.. => ##.#/..##/.###/...#
.##/#.#/#.. => #.##/.##./##../#.#.
###/#.#/#.. => ####/##.#/#..#/#.#.
#../.##/#.. => ..##/#.#./####/####
.#./.##/#.. => ##../###./####/....
##./.##/#.. => .###/####/..#./...#
#.#/.##/#.. => ###./##../##../#.##
.##/.##/#.. => ##../.###/####/.#.#
###/.##/#.. => ##../.##./#.../..#.
#../###/#.. => #.#./.#.#/#.../....
.#./###/#.. => .##./##../...#/##..
##./###/#.. => #.#./..../.##./##.#
..#/###/#.. => ...#/...#/##.#/...#
#.#/###/#.. => .##./.###/#..#/.##.
.##/###/#.. => ####/..##/#.../####
###/###/#.. => ...#/####/..#./.###
.#./#.#/.#. => .##./#.##/.##./.###
##./#.#/.#. => ..##/.#../##.#/###.
#.#/#.#/.#. => .#../..../.#.#/#...
###/#.#/.#. => ###./..#./..../#.#.
.#./###/.#. => #..#/.#../#.../..##
##./###/.#. => .##./...#/.###/....
#.#/###/.#. => .###/###./#.#./.#.#
###/###/.#. => #.##/.#.#/#.#./.##.
#.#/..#/##. => .###/..../####/####
###/..#/##. => #.##/###./..##/.##.
.##/#.#/##. => ..../...#/#..#/..##
###/#.#/##. => #.##/.#../.#../....
#.#/.##/##. => ..##/..##/#.../#..#
###/.##/##. => ##.#/#.../#.##/..##
.##/###/##. => ...#/..#./##../#.##
###/###/##. => #.##/#..#/..#./...#
#.#/.../#.# => ##.#/.#../##.#/.##.
###/.../#.# => #.#./..##/.#.#/##.#
###/#../#.# => ..#./#.##/...#/.###
#.#/.#./#.# => .###/#.##/#..#/#.##
###/.#./#.# => ..../..#./###./..#.
###/##./#.# => .###/##../..##/####
#.#/#.#/#.# => #.#./####/.#../.##.
###/#.#/#.# => ####/..../..##/#...
#.#/###/#.# => #.../.##./#.../...#
###/###/#.# => .#.#/...#/..../..##
###/#.#/### => .#../#.##/#.##/.###
###/###/### => #.../.#.#/#..#/#.##
"""

}
