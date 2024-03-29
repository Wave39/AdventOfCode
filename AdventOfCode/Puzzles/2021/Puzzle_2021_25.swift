//
//  Puzzle_2021_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/25

import Foundation

public class Puzzle_2021_25: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    private func solvePart1(str: String) -> Int {
        var matrix = str.parseIntoCharacterMatrix()
        let rows = matrix.count
        let columns = matrix[0].count
        var step = 1
        while true {
            var eastMatrix = matrix

            for point in matrix.getAllPoints() {
                if matrix.characterAtPoint(point) == ">" {
                    let eastPoint = Point2D(x: (point.x + 1) % columns, y: point.y)
                    if matrix.characterAtPoint(eastPoint) == "." {
                        eastMatrix[point.y][point.x] = "."
                        eastMatrix[eastPoint.y][eastPoint.x] = ">"
                    }
                }
            }

            var southMatrix = eastMatrix
            for point in eastMatrix.getAllPoints() {
                if eastMatrix.characterAtPoint(point) == "v" {
                    let southPoint = Point2D(x: point.x, y: (point.y + 1) % rows)
                    if eastMatrix.characterAtPoint(southPoint) == "." {
                        southMatrix[point.y][point.x] = "."
                        southMatrix[southPoint.y][southPoint.x] = "v"
                    }
                }
            }

            if matrix == southMatrix {
                return step
            } else {
                matrix = southMatrix
                step += 1
            }
        }
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>
"""

    static let final = """
v.>v.>>>vv...v..vvv.>.....>..>....vvv..vvv..>v..v......>>vvv>v....>..>.>>.v>..v>......v...>v...>.v>v.>...v..>vv..>.>>>v..v.>v...v.>.v.vv>..
.>.>...vv..>>>v>v..>....>.vv....v........>.v>...vv>vvv.>..vv.v..>v..vv.v.v..vv>.>.v...v....>v>...>.v>>vv>.>.>v...v>vv.>>...v..>..>>.>..vvv.
..>.>>>.v>vv>...vv.vv..>..v>>.v...>....>.>>v...v>vv..v>...v....>....>...>>vv.>vv>>.vvv>...v.v.>vv.v..v..v.v....>vv>>..>>.v>.v.v>>....v.>v>v
>>>..vv....>.>...v>v..v..v>>>vv..>>vvv..>>v>>...>.v.>>v.....>vvv>>.....v.>.v.v....>v.v....>.>v.>...>v>>>....v>..>v>...v.>..>>.>.v>.>vv.vv.v
...vv..v>v.>v>>.....v>.>.>>...v>vv.>.>.>>>..>.v..v...v.v>.......v.v......>.>...v>v>.>.v.vv..>.v.v.v.>>.>>vv>.>>v.v>>.v..>v..v.>...v>..>...v
>.v>v>..>>v..vv>v>.>....>>v....>v..v.>>v.>v>>....v>>..v>....vvv>.>>>>.v....v..>..v.......vvv>>vv...v.vvv..v...>v.>..vv...v>v>>.>>...v>.v.>.
>vvv.v>.>.>.>..vv>>..>....v>v..>v.>..v>.vv>..v>v..>>v.>.>.>>.vvv>>vvvv.v>>.vv>vv>v.v...v.vvvv..>.>v.>>.vv>>.>>>.....>>>>...v...>.>.v.>.>>v.
.>v.v>..>.vv.v.v.>.v..>>v>>..v>v>>>>.>...>..>vv..>>.>v....>......>......>.>v.>..>...v..>>v>...>>.>........vv.>..v.v.vv.>.v>vv...v..v>..>>vv
..v>>.v.v>.>vv>.vv>>>.>vv...v.vv>>.v>..v..v.>>.vv>.v..vv..>>...>v>>.>v>.v.vvv....v.v..vv.vv...>v.v.v..>...>>v>..vv>..>v>>.>v.....v..v.>v...
>>.v...>..>...>..vv..v.v>.>>.vvvv.......>.>>...v.>.v..>v.v..vv>...v.v..v.v.....v..v.>>.v..>.v.>.....vv.......>..v..v..v....v>...>v...v.>.v>
v>...>..v.v.v>v.vv..>..>v....>.>...v.vv.....v.v>v.>>...>>.vv.vvv...>....>v....vvvv>....v...v..v..vv...>>v..........>..>...>v...>>>.>..>.>>>
.....vvvv..>>>>vv......>>...>..v...>.....>.vv.>v..>>vvv....>.vvv.v....>>......v..>..>vv...>v.v>v...v>..>.>..vv>v..v..vvv.v.v.>v>>>v>...>...
>>v..v.v...>>vvv.>>.>>.>.....v......v>..v.>v........>>v.v.vv.v..>vv.v....>v.>.v>.vvv.>>>>.....vv>v.v..v.v>v.vv>v...>v.>>.v>v.>.v......>>v.>
>>>v....v.......>.>>>v>.v>.v>....>v>..v.v...>.>.>.>vv.v.........v.v.vvv>..>.v.....v>v.v>..v>.v>.>....v>..v>v>>.>.>>.>v>.>>.v....vvv>.vv.>.>
>...v.v.>>.>v>..v.>..vv>.>..>>v.v>>...v.v>v>v....>...vv.>.vv.v.v.v.v.>v.vv.vv>.v..v..>.v...>..v.vv>..v>v.vv....v>.>>v>v>>.v>.>.v....v>v>.v.
...>vv...>..v>vv>.v...v.vv>v...>...vv..v>.>.>.>........>v>.vv>.>v.v.>..>....v>.vv>.>...>v.>.v..v..>v...v>v...>..>>>...>.>>>.v.v.......v>v.v
.>..v...vvv....v..>..vv...>.v>.>>..>v..>v............>>.>.v.>.>vvv.v>...>...v.v..vv.v.>v>>.v...>..v>v.v>.>...vv..>.>.>...v...>>>.>>v.>..v.>
.v>.>>.>v.>>>v>.v.v....>>....>.v>......v.....v.v>...>vv>..vvv>v>v...v>....v.......>>....v..vv....v>v>..>.>.vv.>.>v>>v...>...>>..v..vv.>.v..
.>v>>>v..v.v.>v..>vvv...v>.v.vvvvvvvv...>vv>>.v>..>......vv.>>.>....>>vv.>.v...>..>..>>.v>v.v..v..>..v..>..v>..v..v>.>v...v..>.>.>..vv.....
v...>>>>.v....vv...v..v.v>>v..........vv>v...v.>v...v>v.vvv.>.v...>..v>v.vv>.v.>.>>>v.....vv.>>v>v..v..>....v..>.v>...v....>..>.v>..v......
>v.vvvv.>>.v>>.vv..>>..>>..>>.v>.v.>...>>v..vvv.v.v.v....v.>.v.v>v.>..v..v.v>..v.v>vv.>vvv...>>.v....vv.>>v>v...v>.>vv>.v>v>.>..>>v..>>>vvv
....>vv>vvvvv.v.v.v....>.>.v.v.......>>..v.>>.v.>v...vv>>>.>>.....>v.v>...>.>.....v.v...>>v...>v>>vv>..v>v..>....v..v.>.>.>.v>vv.>>>.vvv>>v
.v.v...>>v>..>.>.v..>v>.v>..>.v..v.vvv..>vvvv..v.>>..vv.>>>.>.>.>.v....>...>>vv.v>v>>v.>..>.vv..vvv.>.vvv.v.v.vv....>>v.....>..vv.vv>..v.v.
.>.>>..>..v.>>>.>vv.....>.v..>>..vv....vv..>.vv.v.v>...>..v>......v>..vvv>>v..vv>...vv.>..>>...v.>..>>.>v...v.vv.>>.>..>.v.v>.vv...>>v.....
.>v.>v>>>>>>.>v......>v..>..v.>v.>..v.v.v.v....>.>...>.v.>.v>.>.v..>vv>>...v..>..>>vv>.>>>>v.v..v..>>vvv..vv..v>v>....vvv.v.>.v...>.v.>v.>v
.v...>.v..vv>v.>..>.v>vv>..v.>.>v>.v>.>.v.....>..v.>..v...vv..>v>vvv...>v..v>..v.vvv.v...>v.v.v.>.>>v>>..>>>.vvv.>...v.vv....vvvv>...>>..v.
.>>.v>...>..v>..>v....>.v.>v.vvv.vv>>.>......vv.>v>v..>vvv...v...v..>>.>..>..>..v>v>>.......vv.>vv>>.>.....>..>....>>>.v.>..>>..>.>v.>>..>.
..v..>vv>>.vv.....v>..>v.v.v.....>>>v>v>.v>v.>...v..vv>...v>>....>v.>.v>>..v..>.>>.>...>.>.v.>..>.>vvvv>...>.>.v..vv.>v...>..v.v..>>.v.....
vv..v..>>>.>.>.>...>.vv.v...>>.vvv>.>..>v.v..>>v.>.v>v.>v.....>.>...vv.v>...>v>vv.>>v.....>v>>.....v.>.>.>v>>>.v.v..>v>v....v...>v.v>.>>>>>
>v..v.>.v.>.>>...vv>v....>>.....vvv......v...>v.>v.vv..vv.v>>..v>>vv...>...>v.>v.>vv>vv>vvv..>v.v>>vvv.>v.>.>>>.vv...v>.>>vv>>.>v>.>.>>.v>v
.....v..vv.>.v>vvv>>...>v>>.>..v.v.v.>>...v.v...v.>v>.v.v.v..>.>v>..v..>v..>vv.>..v..>...>>.vvv...>v..v...>.>.>>.....>.>.....vv..>vvv>v...>
.>.v>>>...v.>.v..v>....v..vv>>v.>.v.>...v.>vvvvvv.>.v.>...v..>>..vvv>.v>.>vv.>vv>.>..v....v..>>>>v..v.>.v.>v.v..>.v>v.v>v.v...v.....>.>v...
>..v>vv>.>.>...>....>>vv..v.vv.v..>..vv...>..v>....>.v........v>..v.>.>.>>.>....v.v>..>v....v>.v..v>...vv>.>...v>>.v.>..>vvv.>..>...v>..v.v
.>.>...>>vvvv..>.>v.vv>.>...v.v..>v......v..>.>....v.>.vvv>v..>v.>>v..>..vv>v.v.vv.v>.>...>>..>.v>.>>..vv>..>vv>v.....>.....vvv...vvv...v..
v.>>.>.>....>...>>.v.vvvv......v.>....v>v>..>vvvv>.>....v.vv>..>>...vv..v......v..v......>...>v.v.>>.>.>.>...>.....>.>.>.>...v.>vv.v.....v.
vv>>.......v..>vv>.>v..>vv..>>>....vv.>.>.....vv.>>vvvv..>.>.>..v.v>..>.vv....>...>....vvv>.>v..v.v>.>v>>....>v......>...v>.v>v>v..v..v.>.>
>.v.v>..vv...v..>vv.>.>.v....v.>>v.v....>.>...>.>>>.v..v.v.>...>.>..>...>.v>>..>>.>>>vv.>>>..v...>>.v.....v....vvv...>..vv.>....v......>>.v
..v>..>>..v.>...v..v>.>...>v>>v....>.>v...v.>v>.v>.>.v.v>v.v...v..v>>......vvv..v.>.>>v..vv..v>v.vvvv>>>vv.>.>.v.v.v...>v>>..>v>>>....vv..v
>vvv>v.>>v>v.v.v..vv.......>.>vv..>...>...>>>>>>.>.v....>...v.>>.>..v.vv.>v..v>>vv>....>...v>v.v.>..>.>v.v.v>....vv..>.v>vv..>v>>vv.>.v>>..
v>.v>v>.>.v....>.v...v>v..v>>.vvvvvv>v..>..>vv....>v..>v>..>>..v.v.>vv.v>.v>v.>v>>vv.vvv.....>.v>v...>>..v>..vvv.v..>.>.v...v>..>vvv>.v...>
>vvvv.vv>.v>v.v>..>.vv.v>>v>>>vv>..v..>.>..vv>.vvv>v.>>>vv>>v.>>...>.>v.v..vv..>.>v..>...>...>...v>..v>>>......>>.v>..>.v.>.>vv.>....v..vv.
v>...v>v..>>.....v..>.....>.>.>.v..v.v..vv....>.>.v.>v..v.v...>.>.v>v>>.....v..v>.v.....v>v..>.>.v.v..v...v>.vv..>.>v>.v>..>...>.>v.>v.>..>
.>vv>>.>.v>.....v..v>....v...v>.>.>....vv>...>.v.v>v>.>.>..v.v..>..v..v.>...v>...vv>v>...>.>...>>..v.>.>>v.>.v...>.>>>.>>v>.v.v>....v.vv.v.
v....v.....vv>..v..>.>...v..>.>..>..>.>v..v>.>.v.>vv...v>.....>vv>v...vv>.>......v...v.vv.....>>.v..v....>>v>>...v>v.>.v.v..vv>.v..>.>..vv.
>vv..v>v>....v>.>>.>vv....v.v>..v.v>.vv...v>....>....v>>....>.v..vv...>v>.vv.>.v.>.>>v..v>>vv>>..v...v>>v.>v....v>>>v>....>v.>>..>...>>v...
v...>...vv..>v.>....>.>v>.v..v.v>.>v.>v..v.>.....vv>......vv..v..>vvv.....v>v>..>.>vv.>.>.>.vv.>>.v>>>.>v......vv.vvv..vvv.v..>.v.v......v.
...>>.>..vvvvv.>.>>>>v.vv>v....>>.>v>v>.>.>>v>>>....>>vv...>.>.>.>.>vv..>.vv>>>>>.>v.v.v.....>>v>.v.>..v..vv..v..v.>>..>....v....>v>v>v....
........>v..>vv...vv>.v...>v.v.vv>v.>>>>.>.>v..v.v..>>>>>.v...>.>v....v....>.v.>>v.>v...vv>..vv.v..>vv>.v.v...>>.>v.>vvv.vvvvv.......>.>.>>
.............vv.>>v..>..v>.v..v.v>.>.>..>>>....v...>.>vv.>v>>.>..v.....v.>...v>.>>.>...v>v....>.>>v.>.>.>>v..>.v....v>vv.>.v..v...v.>..>..v
.v..vv.v......>...v>v>>..v...v..v.>vv.>>.....>........vv>.v.>v.>>.vv>.>.vv>>v>.>.v.v>vvv.v.>.>.v..v>>...>..>.v....>.>vv..vv..v...v.>>v..>v.
>.v>.v..v...v>>..>>....>vv>.>v.v.....v..v>>.v>.v>..>...>>.v....>v.>>v....>...>>v.>.vv.vv.>>.v.....>vv.>>...vvv..>.v.>vv.>.>.v.>.>..>.v>....
>v.vv>>...>....>.vv.>.>..v>v.>.vv.>.vv...v...>..>.>.>>>...>v..>>>v...>>.>>....vv.v.v.v..vv.>.v>...>......v..v.>...v..v>>.v.vv.>.>.>.>..>v>>
.>>.>v>.>vv.v>.>..>>.>.>....v...v.>..v>....>...v...>.>.>.>..>.v.>>..v.......v..>v>>v..v..>>>v.>.v..v.>>>v>>.>.>...v..>.v>>v>.>>.vv.>v.>>..>
....>>v>vv..v.vv.>..>.>v....v>vv..v..>v......>.v.v...>...v>.....v..v..v...v>v..v>v.>v>..>>v..>.>.>>>v..vv.>vvv.v..>v>>..vv>>v.>.>>..v..vvv>
>..>...>.v>vv..>.>>......>..>...v.....v>>...>...vv>v>.vvvv...>>..vv.v.vv...v..v.>.vv.>.v......>..v>.>v..>...>..>...v....v.vv.v...>>>......>
..vv.>>vvv>>........vv.....>..v..v>v>.v.>>>v.>.>.>...>v.>.>>vv.>..v..v.>.>vv>>..v.>.>>vv....vv..v>.......>..>v>..>...v.v>v..>.v.>>vv..v>.>>
..>.>>.v>.v.v>v.>>>.v>v>>.v.vv>v..v.>>v...v....v>..>>>.>>.>..>>...>v.v>.v....v.>...vv>>>.vv..v>.v>.......>.>..v.vv>.vvvv.vvv.>.vvvv>....vv.
..>.v....vvvv.....>..v>.......>..v.vv...v.>v.>>v.v..>.v..>..v>.v.>v.>vvv..>..v..v..v.v..v>>vv..vv>>.v.v.....>>.>v.>>>...v.v....>v.>v...>..v
.vv..v.vv>vv...vv>v.>>>..>.>.>..>>.....v....v.v>>...>v>.v..>..>.>..>>..v.vvvv...vv>>.v...>>v...>v>.>v...>...v......v...>.v..v>>vvvv..>v>...
.v.v>..v.>...v.v..v.v..v.>>....>>v.v>>.>v...v>>.>>v...>.>.>>.>>v.vvv>>.>v..>.v..v..>>...v.>vv>.vv.>>...v>>>.v...>vv..>vv>..v.>v.v.v>.v.>...
.v....v>..v>v>vv>>.v....>......v>v.v>.......>.vv>v..>..>v...vv>.>v.>.v>..>>.>>.v.v.>v..>>vv.v>.>v..vv..>v.>>vv>>>.>>..v>..>>...>v.....>...v
>>..vv>>..>v..vv>.>....vv>.vv>..v>vv.>>v>...v..>.v>>..>.v.>>>v>.v.....vv...>v>....>v>.v.vvv..vv>.v.>.v..v..>.v>>>..>>...vv...>>....>>v..v>v
v>>>..>>v>v...>>...>v..>>.>..v.>>v>v.vv>.vv.>v..>........v>...v..v..vvv>..>.>vv>..>>>.>vv>.vv>v.v>.v>>v.v..>.v.vv.v>>v.v>v>.v>>.vv..v>.>..>
....vvv.vv.....v>.>.v>>.>.>..>.vv...vv.>.v..>>v>vv.vv>.v.v.>.vv..>>.v.v..>.v...v>.v.v.vv.>>v>...>v....vv.>.>v>.>..>>..vvv>>.v..v...v>>.v.>.
.vvv>.vvvv>.>.....v.>..vvv>v.>.>vv.v>>vv..>v...vv>vv>.>v>....>v.v.>..>>v...>>vv....>.v...>...v...>>>>>v>.>.vv>v..v>>..v.>.>>vvv.vv...>..>.v
v>>v..v.>vv.vv>.v.......>.vv...>>..>.>.v>v.v.>>>.>>.>vv.>>..>>.>vv....>.>.>vv.v>>>...v>vv.v>.>>vv.>..>.v>>..>>>v....v.....vv.>..>.>v>v>>.>.
v..>>vvv.v>>>..v.v.v..>v..>>...v..v.>>v..>...v.>.>..>v>...v.vvv>>v.>>.v..>..>.>..v..>v..vv...>......>>..v..>v>v>>..v>>.....>.>v>v.>.v>..>..
...>>v>>v.>...v>v.>.v.>v>......vv.v.v...>..>.v...>>>v.....v>>..>...>..>vvv...>....>.v..>..>.vv..>.>>>v..vv..>.>vv....>>.>v>..>v..vv.>.v>v.>
>........>v>......v..>..v>....>.>v>>vv..v..>.v.v>.>>.v>.>.>.>v..>v....>....v>..>>vv.v.....v..v>.>>.>.v.v.vv..v>..v.>.>>..>.......>.vv...>.v
..v.v.>.>v>>v.....>>.>..>.>...>.v.>.v>>>..v..>..>v..vv>...vv...>>..vv.>v..>....>v>>v.vv>.>.>v>.v>.v.>>v.>v.v.....v>>.>....v>>..v>>v...vv.vv
...v....v.vv.v.>>.>vvv>.>.>>.v.v....>>v>.v.....v>>.>v...v.>..>v>>.v..>.......vv..>vvv.vv.>.v..>v>v>>..vv>v>....>...vv...v>.>>v>v>v>.v......
.>>.>...>...v..>.>..vv....>v.....>..vvv>...v>vvvv>.>v>>..>vvv.>..v.>v...v>.>>.v.......>..v>vvv>vvv..>.v..v>.v.>......>..v.>..vv......>..>..
...>.>..v.v>...v>>...>v.>...v>v.v.>.vv>..v.v.v>v.>.vv>.>...>.>>>>..v>..>...vv>.v..>...>....>.>.>>..>.>>.>....vv...v.v....v>v>.v.....v>..v.v
v...v..>...>>>.>.>v.v........>.vvv.>>..vv>.>>v>>v>..>v..........v..vv......>.>>..v...v...>>.>v.v.vv...v..v>vvv..>vv.....>>v.>>.>.>.......>.
>vv.>...v.>.......>vv..v>>...>.v..>.v..>...>v......vvv....v>>v..v>.v..v..v>v.>>.v..>..vv>..>.>.>v.>..>v.>.v.vv...>...>v......>>.v>.>.>>v..v
v.>>>.>v>>.v.>v..v.>..v...>>>v...>.>..v.v>.>....v>...v>.>v>.>v...>v..>..v.v.>.>.vvv..>.>.>v...v....vvv..>.vvv.>..>>v>.v..v..v..v.>.>..>.v..
v..>.vvv..v..v.>vvv..>.>.v...v.>>v>.>....vv....>......>.>v.vv.....v.>vv........v.vv>..vv>v>.vv..v>....>v>..v>..vv>...>..vv...v.>.>...v.>v..
v>>.....v>.v.v..>.>....v>v...>..>.>.>v.>v..>.v.>.vvv.....v..v>vv..v>..>v.>v>v.vv..vvv...v...>.v...v>.vv....>...>.>.>.>>.v..vv>>v.>>>.>>>.>v
..v...v>.>>vv.....vv>.>...v.>.vv>.>v...>.v.>.>.>>..>.v>v.>.v>..v>..>..>......>>....>....vv..v.v>.>.v>.>v.....>............vv.>..v..v>.>>..v
vvv..>..>..>>vv.v>v>>..v.....>..>vv.vv>.v.v.>...>vv...vv..>v>.>.v...>>..>v.>vv....>.>..vv.vv>.v.>>..v>...v.v.>>..v...v.v.vvv...v>>v>v..>...
.v>....>..v.vvv.>.v>.>.v.vv.v.vv>v.v.>..>>v..v....>v..v.v..v>>........v..v>>.....>>>v.v.......>.>.v.>.>>v>..v>..v.vv.vvvvvvv>>.>v...>.>>v.v
>..vvv..v.>>...v.>...>....>>.....>v..v.>>vv.v....v..>.v>v>v>>.v.v.v.v>..v>..v>...v>v>>....>v>.....>>.>..v.>>>....v.>>.>v>.>.>>vvv........v>
.v..v>...>v>>>v.>>v...>..>..vv..vv....>..v>.v..v.>.v.v.>>...v.v>.>vvv...v>.vv..vvv....v.>>.>.>.vv.vv.>..>>..>>...vvv.vv>....v......v..>v...
...>v>...>vv..>vv>v..>.>>>>v>v.>v.>.>..v..v.vv>>>>v>.v>v>.>>>vv....>v.v.....vv.>...v.vv..>..vv.vv......v..>.>..>v>.>>>>>>...>>....>>>v.vv.>
v>..v...v...>>>>.v.v>.>.vv>..v.>vvv..v.>vvv..>>.v......v.vv>>>...>v>.v..>>..>...>>.>>.......v.>.v>>..>..vv.........vv..>>>..>..v>..v>v..>..
..v...>.>.v>....v..>.>..>v>>>v>....v>>>v>...>v>.vv.v....>.v..>>>>>>...>v>..>v..>.>...v.>>.>>vv.v.v>>.>v.>>v..v..>>>...>vv...v..>v.....v.>>.
...>vv>.>>>..v>..>>v.>....v>vv..>.v.>....>v.v.v>>.v...>v..>..v>.vv...>.>.....>.>...vvvv.>.>vvv.vv.v.v.>....>>v..>.>v...>>.....v..>v.>>.v>>.
..v.>.vv.....>.vv.>>>v>v.>>>.v..>>..>.>.vvv....v>v.>.v>>>v>v>.v>>v>>.>.>.>>v.v.vvv>.>>.>.........v>..v......vvv.v..>>..v..>v...>...v>.>vvv.
v>.v>>....>>>.>.vvvv.v..v.>v.vv>>v.v>.>>v.>.vvv>vv.>vv.v...v.>...v>v>vv>>.v......vv...>v...>>..>...v.>>...v.vv>v....vv>v.>>.>v.>vv>>>.....>
v.>v.v.>.v.>>>>v>...v...>.v>v.v>.>>>.>vv..v.v.vv..vv.>..>...vv>.v..vvv>>vvvvv>.v>.v>.>>vv..>>v.>.v>>.vv...v.v.v....>>.v...vv>..v>v.v.v.>v.>
>..>>.v.......>...v...>v>.v>>>>v.>..vvvvv.>v...>....v>>v...v>v>v>.....>...vv..>v.v..v......>..v>vv>v>>..>.v.>v.v.....v..>v.v.v>....>>..>vv.
.>.v>.v>v..vv>>..>>...vv..vv>...v..v..>..vvv.vv>...v>..v.v..v...>.v..>..>..v....>.>..v..>>vv.v>...>v.>.>>....>...>v.>v>>..>vvv.>vv>>v.>>vv.
>v>.v>...>v.vv....>.>v...v...>.vv.>.>v.>v.>>..>..>.v.v.v...>v.>v>v.>.>.....>>....>.>vv.......v>.v.>.vvvv..>..v..>...>v.>>>.......>..>...>.>
>v.v>>..vvv.....v....vv>>..v>.vv>vvv>v.v>v......>>>v...>.v.v.>>vv>....>v.>.>...v>.>.v....>v.v.>.v>..vv.......>>>..>>...v>..>>..>>>vv..v>v.>
v..>>>>vv..vv...>>v...>....v.v....>>..v..v.>..>.vv>>.v>>>..>.v>.>>..v.vv.........>.....>>v...vvv.v.>....>>>...>>....>.>v>.>..>>.>.v...>>v>>
.v.v.>>>>.>vvv>.>.v>>>.>....>v.>>v.vv.vv....>>.v.>>>..>v..v>v........v>....>.vv..>...>>..v>>.>>.v.>>>.v...v.v.>.v.>.v.vv...>>vvv>>..>>.v>v.
..>v.....>...>vv.>..>v.......v>..>..v..v..v..>>>vv.vv.v>...>..v.....vv..v..>>....>.v>.........v.v>..>>....>.v>v.....>.>>>.>.v....>.......vv
>v.>>>>.....vv...v.>v>..>.>>>..v>.>.....v>.v.>.>....>>>>>.v.vv..vvv>.v...v..v...>v.vvv..v..>.v.>..v.>...>....v>.v.>.v>..v.v....>>>v>...>vv.
....>....>>>....v>.>...>.>>vv>....vvvvvv>.vvv>......>>...v>.>v.vv>....>.>...v...>..>.>>..v>..vvvvv...>...>.>.>v.v..>..>.>.>vv.>...v...>...v
vv>>.>v.>.v>.>v..>>vv>.>..>vvvvvv.>v>..v>>>.>..vv.>v..>...vv...>vv>....v>v.>v>.......v.>v.>>.>v>....>........>>v..v>..v.v......>.....v..>.v
v.v.>>.>.>.....>>v.>>.>.>vv>v>v>..v...>vv.v>.vv.v>v.>>v>.>v>..v..>.v>.>..>>..v.>...>>.v.v.v.>v..>.vv>..>...>...>>..v>..v...>..>.v....v.vv.v
...>..v....v>..>.>>.v..>.v.v..>v>....v>..v....v..>.v>.v.v.v>..>>v>.>.v>...>....v.>>..v...v....v.v..v.>.>v..v...>.>v.>vv..>>v..>.v>vv..v.>>.
...v.>vv>v.v>v...v>>v>v>v>.v...vv.vv....>v.v....>>....>.v.v.vv.v>.v.....>vv>.v..>...>..v.vv...>v>>..>.v>...>>..>vv>>.vv.vv>.>..>.v..>..>..>
>v>...v>..vv.v..>>.v............>>>v.>...>>vvv.vvv.>>v..>v.>.v>.v>>..>.v.>.>.vv>.v.v>v...vv..v.>.v...v>.v>v.v..v.>vv...vv>..>v.v>......>>vv
>>.vv>.v>.>v.v>>v..vv>.>v.v...>v>>.vv..v>>v.v>.>.....v.v>.>..v.v>vv...v>.v...>v.v.>v.>>..>>..vv..v......vv..>..>>>.vv..vv..>>>>v.....>...>.
..>>vv.>v>v.....vv>>..>...vv>v>v.....>vv.v.>vv.>...vv.....v>v..>.>>vv.v>.vvv>...vv.>vvvv..v......v>v.>.>...v>.v.>>.>v>.vv>v>.vv>.>.vv>>vv>>
...vv..v.vv>.v>....>..v>.v..v.>.vv.>.v..>v>vv.>.v>..v>vv.vv>>v...>.v....vvv.>vv..>..v...vv...>....v>>..>v>>.v>vv...>..>>v.v..>>..>vv..>v..>
.>..v....>v............>.vv.>>...>.>>.>....vv>>.>.....v.>v>..v.....>..........>>..>v..vvv.>v.>.v>.v.v>....>.v>v>vv.>.v.vv....>.>v..v>..>...
>v>..>.>v.v>....v..........>..vv>v...v..v.v.v>.v>..v>vvv>>v.vv....>>>>v..v>.vvv.vv..>......>.v.>>>>.v..>..v.v>.>...v....>v>.v>v..>..v.v.v.v
..>>..v..v..v.>v.v.v.>>v..>v>.....vv...v.>.vv>>.v.v.>>.....>...>v>.>.vv.vv.v.vv...>....>>.>..vv.>v.>...........>.>..>v.>..>>.v>..v>>..>...>
.>v....v>..>.>>..>..>v>>..>>.v..v>.v>...>.>v.v..>>v.v>...>....>>>>....v.v.>.....v>.......v>vv>.>..v>.v>vv>>>>.vv>.vv>v.>>...v>.v>...v>>...>
...v.....v>v...>.>..v.>v..>>>v..v.>.>vv.v>v..v..>vvv..>.vv...v>>v.>v.vv.....vv>..v...............>vvv...v>.v....>.>>.......>.v.>v>.>v...>>>
>v>.vvv.v.v..v......>>..v.>>>..vvv>..>.v.>.>>vv....>..>...>.v>.>>.v.>.....vv.v.>.v...vv.>v..>v>.v.v..>..v.>v...>>>.vvv.>v.>v.>...v..>..v>..
vv>.v....>..v.>.v..v.>>v>>v..v....vv.>..>.>v.>vv>v>.v....>.v>.v>>.>.>...>v.v..v.v>.>.>v..>>v>..>.>v>....v..v....>..>>>v..>....vv...>......>
v.>..>....>.vv.>>.>v..v.....v.v.v......v.>..>....>>vv.v..>.>v..vv.v>.v>vvv>.v.vv.....vv.v>..>v>..v.v.>.v.v>.v.>>>v...>.v.>.>v>>.>.>..>>.v>.
>.v..>v.v.vvv.>>v>.v.v...>.vv..v..>...>.v...v.v>>..>...vv..v...v...vv>.v>...>v>>v...v.v.....>v..v..v>v...>.v..v.>...v>>.>..>v......vv..>.v.
>.....>.>v..vv..v.>.>>vv>..v..>.>>.>...v>..v.v>>.v.>..>v>..vv..>v.v..vv..v.v..>.v.>.>v.v>.>>>v..v......>>v>..v>..>>>vv>>..>.>.>.>..>..>....
.....v>..>.>...v.v.v..v.>v>.>vv>.>.v.>.>>..>>..>.>.>vvv>vv..v..vvv.>>v..vv.v>..v>.v>.>.>>>>>>.>v.vv>v..>..>>>vv..>..>v.....v.....>.>vv.v.>.
>..>.vv....vv.v>>>v..v.>>>>v>.v>v.>>.v>..>>>>.vv.>v.v..>>>v.v.vv.>....>...v...v>>>v.....vv..>.v...vv>>.v>.vvv>>v.v>.>.......>.>v>..vv.vv..v
....v..>..>...>>.v>.>.v>.>v>v.......v.v.v...vv>.>vv..>..>>..>.v.vv.v>......vv>.>..v.>.vv..>>.v>..>..>..v>v..vvv>.v..>.v..vv..v.>>..v..v...>
vvvv.v...vv..v.>..v>...v.>v>>v.>..>v.>.>vvv>.....>vv>.v>vv...vvv>v>..>>v>>>vv...>...>v>.>.>.>v..v.v>>>.....v>.vvv...v>.>v....>v......v..>>.
>v...>>v..v>.....>>v.v..>>...>.>v....>.>.>..>>>.v.vv.>.v.>>>.>.>...>..v.>v.v>>>>>....>...v.vv....>v.>>.v>vvvv.v..vvvv.v....vvv>v.>.vv>....v
>>v>...>..>>..>..>.>v.v...>.v.>.>vv>.v...>>v>>vvv.>vvv..v..>v..>vv.....v....>.v..>>>v.vvv.vv.>..>>>>v..vv>..vv.v.v.v.v.>...vvv...>.>.>.v>.v
vv..v...>v.>.>v.v.vv.>.>.....>>v....>.>..>>v.v..>.v..v>>>.vv..>v>.v.>.>v..>>.v.>.>>..>>...>.v>....v>v..v>.v>>>.>>>.vv.>v.....>vvv>..v...v>.
>v.>vv..v>v...v...>...>>vv..v.>v.....v...v.>>>.>..>.v>...v>vv....v>>>.>..>v>..>...>>v>.v..vv...v>v..>.>..>>.>>>>.>...>.....>.>v.v.>.>..>...
...>v.>>.v>v..v.v>..>>...>>.vv>>v.>..>v.>.>.v>.....v..>..v...>.>v..v.>v..>v.>>.>v>v>...>.vv.v>.>.>.v.v.v.v.vv>>vv>vv>.>v>>>v>...>..>..>.>..
>vv.>>>.>v...v..>vv.>v>v>.>>.>.v.vv>v>vvv....>.....vv.>..v>.v....v>v.v....v...>>>....>>..vv.......>...>.......v.>.....v.vvv>v.>v>>..>......
..v..>vv.v..>>>>>>>>>v.v>.>>..v.>vv.v..vvv....>>....>v....v.....v..v>.v.vv>v.v.>...v>>.v...>.>...v>..v.v.>.>vv...>.>...v.vv.>..>v.>>......>
v>.>v.vv.v.>v.v>v>>>v.>..v>>.v.>.>v>.vv.vvv..>v>.v.v..v...v..>..v.>v...>>>vvvv.>vv>vvvv.v>v...>...>.>..>...v..v..>.>vv.>v>v.v..v>.v....v>v>
vv.vvv.v.>v.vvv..>.>>v.v.......>v.v>.....v>v>>.>>.v...>..>v...>...vv....>.>.>vvv..>v.>..>>>....>.vv...>..v..>v.v>..v......v...>>.>..>.>>>.v
vv..v...>>....>vv..v.v...v.>v.v..vv.v.>.>v..>v.v>>..>.>>..>vv.vv.v.v.v..>....v..>.>.v>.>.>......>>.v..vv>...>>.v.v.>.v....v>v..>.>..v.>>>.v
>>vv>vvv>>..vv.vv.v.vv..>.>...>..>>v>.>.>..v.v.v>v>.vvv.v.v..v>.vv.vv.>>.>>v.v....>v..v.v..v.>.v.v...v.v.v>.>.v>...>>.v.v.v..>..>>..v>..>.>
v.v>vv>>.v...>..vv.....v.>v.>.vv.>v.v>vv.>v...>.vvv>....v...v...>..v>>vv...>vv..>.>v.v......>v>..>>>>...>.vv>...v>>..>..v.v.....>.>..v.>v..
v.....>vv>v.>>>.v..>>>v..v>v.v....v>..>..>..v.>...vvvv..v.....v.>..>..>vv>.....>....>v>>.v.vv>...v......vv..>>.>vv.v..v..v..v..v>..v>.vv.>>
vv>.vv..v.>>vv..v>.v.>..v.>>..v..v.v.vv.v.>>..v>..>..v.v>v..>.v>v.v...v...>.>....vv>>>v>>...v.>v>>>>v..>>vv>..v..>.>...>.....>.>v>....v>vv.
..>....>...vv>>.....>vv>v.>.v>.>v.>vv.v.vvv.v>.v...v..>.>.>.v......v>..>v...>>.......v>..>>.v.....v..>>>v.>.vvvv.v...>>>v>.v...>v.>....>..v
>..v>.v.....>.v.>.>>>vv...>..>.>...vv>..>>v.>>v>....v.>>>...>..>>>vv>v.vvv.>v...>>..v..>..v..>>.v>..v.v..>..>.>..vvv..>.>.....v...v>v......
"""
}
