//
//  Puzzle_2020_03.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/3/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_03: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    func solveArray(arr: [String], deltaX: Int, deltaY: Int) -> Int {
        let lineLength = arr[0].count
        var x = 0
        var y = 0
        var treeCount = 0
        while y < arr.count - 1 {
            y += deltaY
            x += deltaX
            if arr[y][x % lineLength] == "#" {
               treeCount += 1
            }
        }

        return treeCount
    }

    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return solveArray(arr: arr, deltaX: 3, deltaY: 1)
    }

    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return solveArray(arr: arr, deltaX: 1, deltaY: 1) * solveArray(arr: arr, deltaX: 3, deltaY: 1) * solveArray(arr: arr, deltaX: 5, deltaY: 1) * solveArray(arr: arr, deltaX: 7, deltaY: 1) * solveArray(arr: arr, deltaX: 1, deltaY: 2)
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

    static let puzzleInput = """
.#......##..#.....#....#.#.#...
.#.#...#.##.#..........#...##..
.........#.....#.####........#.
.......#.#...#.#...............
..#....#...#.#...#.#...#.#.....
...#...........#..#.........#.#
....#..#....#..#..#.#...#..##..
#...........#..#.....#.......#.
#..#...#...#.###...#...#.#...#.
#...#.#.......#...#...#...##.##
..#..................#.#.#....#
..#.##....#........##..........
.....#....#....#.#.......#.....
##.#..##.#.....###.......#.....
......#...###....#..#.#...#....
..............#.........#.##...
#......#.............#....#...#
.#..#......#.###....#...#.....#
..#........#.....#.....#...#..#
.......#...#..............#..#.
..#...#........#...##........#.
.#........#....#......#......#.
....#..#.###.......##....#.#..#
..#..###..#....................
......#...#....#.........#.#...
....#.##................#..#...
....#......######.....#........
.#......##.......#....#..##.###
..#...##.###..#.......#....#...
....#.###...#.#.#........#.....
...###...#.......#..........#.#
..........#...#..........##.#..
..#....#........#.....#....#..#
..#...#.#....##..#...##....#...
........##...#..##.....#.......
###.......#.#...#...#.......#.#
....#.#....##.###........#.....
.....#..............#....##..##
#......#.#....#.#......#.....##
.....#....#..#......#...#......
..#.##..#.....#..#....#......#.
.....#.#.#..........##....#....
.........#..#..........#.#.....
.##..#...#......#.#..#....#....
#.#..##.......#.#......##......
..#.#....#.#.....#.............
.#.........#.......#..#.#......
##.........#..##.#......#......
#..#.....#...#.....#.........#.
..........#..##..##.#..##...###
..##.....#...#..##...##.#.#....
..#..........#.#.....##.#....#.
.##..#..#.........###.......#..
......##....#...##....##.......
.....#.#.##...............#....
#..#......#.....#..#..#.#.....#
.....##.#....#.#.....#.#.#.....
....#..#.#..##....#.....#....#.
#...#.....#....#....#.#.#......
.....#................#.......#
.......#..#.#...#.#......#..#.#
...........#....#....###...#.#.
#.##....##..###.#.#......#.##.#
..##...#.#..#..#...#.....#.#.#.
#.....###.#..#.#...#.#......#.#
..##.#...#...#.#.....#.#.......
#....#...#.##......#.#......#..
..#.....##.....#...............
.....###...##.#...........#....
...#..##.....##....#...........
.....#..#......#..........#....
....##..##.#...#...#.#.....#.##
.#.....###..###.#...#.#..#....#
.#..........#...#..#.#.#..#...#
.##.##..#..#....#....####......
....#..#.#..........#..........
###...#.#..#..#...#..###.......
####.#...#....#..#...#..#......
.....##....#.#...#....##....##.
....#.#.##....#.##..#....#.#.#.
#......#..#.###....#####.##....
..##..#.#.#..#........##.##..##
#.#...#..#..#......#..#.....#..
.###.....#.#....#.#..##.....#.#
....#......#.#...#...#.#....#.#
.....#.###.##..................
.#..........#........#.#...##.#
.##......#.#.#..#....##.###..#.
..#.##....#....#.........#.#..#
........#..#..#.#.####.....##..
#..#.##.#......#.#..##.#...#..#
..#.#.##..#.##..........#......
##.#.....#.#.##..#..##.....##.#
.##........#..#.....#...#.##.##
...#....#.#.#.........##.....#.
...#....#.#....#...#..#........
.....#...#..#...#.##......##...
##.........#......#..........##
.#......#.....##....#.#.#.....#
..#.###......#..#.#....#.....#.
.#.......#...#...#.#.#.#..##...
...#..............#...###.....#
...##......#.#..#.#........#.#.
..##.#....#..........##...#.#..
..#...#.....#.######...##...#..
#...#...#............#.....#...
.###..###.##..#.........#......
.#........##..#....#...#.#..##.
#.#.##.#.#...###...............
..#.#.#......#.#.#....#.....#.#
.#...........#.##.#..#.###.....
.###.#....#...........##.#.#...
.#...#...........#..##.........
.#...#.#...........#..###....#.
.##.......#.....#.....##....#..
#.......#........#...##.##..#.#
....#..###..#.....##.......#...
......###.#...#..#....#.#...#..
..#..#.......##...#.#.#...#....
......#..#.......#.......##.#..
#.#....###.....#...#..#...#....
#...#.##.#........#..........##
.....#.#.##.#.#..#..##.......##
.#.#.......##....#.#...........
#..##.............##...#.#..#..
#...........#.#......#.##.##..#
...#...#...........#....###.#.#
.##..#.#.#....#....#####.......
..#...#.....#.#....#...........
.#..#........#.....#.#......#..
.#.........#...#...#.#.#..#....
.##.##......#.#...#.......#...#
.##...#..#..........#...#.....#
#..........#..#...#.#......#...
....##......#...##..##..#....#.
.##.......#...#.#..##..#..#....
.#.#................#....#.....
..#..#..###.......#............
...##.....#..#......#....#.....
....#...###...#....#..##...#.#.
#.........#.......#...#....#...
.#.#...#.#....##....#.#..##.#..
...#..#..#....#..#.#..##.....##
..#..#.#.#....#...#....#..#....
......###.....#...##.#..#.#...#
.#.#.#..#.##........#.#....#...
.#..........#....#.#.......#...
#.....#........#........#....#.
.#.#..#...#...................#
....####..#..#..#..#....#..#.#.
..##.#..........#.##..#.....##.
..................##..........#
....##....###.....#..#...#.#...
.##.........#..#...............
....##..###....#.##............
#.#...###.#..##...#...........#
.....#..#......#.....#.........
..#..##...#.....#.....#.#......
......#....###.#..#.#.#....#..#
#...#.......#.##.....#.........
.#.#..#...#.............##.....
......#..............#.....#..#
......#......###....#...#......
.....#.....#...#.......###.....
#..........##......##.#.#.....#
....#.......#..#......#.......#
..#...#.###...........#..#.###.
.....#...#.#...........#.#...##
........#.#.#........#.#.....#.
....##..##.#.#..#.#....#.#.##..
..#.#.#......##.....#...#.#...#
##...#..#......#.#.#..#...#....
....#..##...........#..#..#..#.
.#..##...#...#...##.#..#.#....#
.#.....####.#..#..#....##..#.#.
.#....#..#......#.....#.#.#....
....#..#.....#......#..........
..#.#..###.....#...#...#.....##
..#.#...##..#...........####...
.#.##....##.#......#.....##.#..
#.##..#....#.###..........##...
.###...#......#.#....##........
...................#..#.....#..
#.#...#.#..#.....#...#..####.##
....#.##..##...##.##.....#.....
.#...#.##...........#.......##.
###..#.....##...#.........##...
.###....##...###...............
.#....#####........#.#.#.##....
.#.#....####.##........#.......
.....#......#..................
......###.....##......#..##.#..
....#.#...........##.#....##.#.
...................#.#.#.......
#.#.#........#..#.......##.....
..#...#...#....#......#....##.#
#..#..............#......#....#
......#.........##.............
.....#.#....##..#.......#......
......#.......#...........#....
....#....#.#..##.#....#...#....
#.#.#..#..#.#.#.#...#....#....#
.#.#....#...#.#..#......#.....#
.#...........#.#....##.....#...
........#...#....#....##.....##
#..#..........#..#..#.....#....
#.#.###..........#.##....#...##
..#................#.##.##.....
..#...#.##...##...#.........#..
#....#......#......#.........#.
##...#...##.#.........#......#.
.......#.....#.................
...#...#.....##.........#.#..#.
..#......#...#.......#......#.#
#.......#...#.##.#..##..#......
.#.#............#...###..#.....
...#.......##.......#....#..#..
.....#..#.#....#.#.............
#....#...##.##....#....##......
........#......#.......#....#..
..#..#..##......##.#..#.#..##..
....##......#.##.##......#.....
........##.#...#.....#.......#.
..##.#....#..#......#.##.......
..##.####.#...#.#....#.........
.#........#.....#..#....#...#.#
###....##......#..#..#.##..#...
..........###.#..#..#....#.....
..#.........#....#.....#....#.#
.#...#.#.....##.#...#...#.#..#.
....##......##.##.#.....#..#...
....#.##...##.......#..##......
#..........#..#....#.......#.#.
..#.....#.................#....
..........#.#.#.....#.#....#..#
.......#..........#.##....#....
#..#.....#.......#........#....
#.....##..#.........##..#..#.#.
.##.#...#..........#....#......
....#..#.#......#.##..#..#.##..
...##.####....#.....#.#...##...
..#.#....#.#........#..........
#...#.#.##.##....##..#...#...#.
...#.#.......#..#...#..#..##..#
.....#....#........###.....#...
.......#..#.##....#.#.....#....
....##....#....#.......#.....#.
.........#........###...##.....
#.#..#...##.........#.#..#....#
...##...........#.........#...#
......#.#.#.........#..#.#.#...
........##.###....#..#.......#.
....#.#...#......#..#........##
.#....##....#...#.##.........#.
####.#..#...........##.#.#.....
...#....#..#.....#..##.####.#..
.##...#...........#.#.........#
#.#..#..#...#.#.#.........#..#.
#......###............#...#....
..#.......#....#...#...#..#...#
#.#.#...##..#...#...#.......##.
......#.#.......#..........#.#.
...............#...#..#...#.#..
.#.#...##.####..##.##....#..##.
#..####.......##.#........#...#
......###....##...#.#..#.##....
.##.....###..#...#.###.###.....
..#...#.....#...#..#..##..#....
...#...##.....##........#.#.##.
.#...#..#....#....#..###....#.#
..#.#.#.#.#..........#.#..#..##
.......###.....................
##.#......#.##.....#.........#.
......................#.#.....#
#..#........##.......#..##..#.#
#.#.#.....##.#.##.##.#....##...
.#...#.....#.........#.....#...
..#.........#.##.#.###.#......#
.........#..#.##...#.......###.
.....##........#......#........
...#.#...##...#........#.##....
.........##............#.####..
#....#...#...#..#....#..#.#.#.#
..#.........#......#.##........
....#.....#........#........#.#
.##.#..#.#..#..###......###....
#.###.....#.#.#.##........#..##
#.#..#...##.....#....#...#.#...
......#....#.....#...#.........
...#........##.......#.##..####
..#..#....#....#..#..#...#.##..
.##.....#............#...#.....
......#.......#.....#...#.#.#..
.........#.....#...##..........
.....#........##...........#...
#.#..##.#...#....#....#........
#.##..#.#.......#...#......#...
...........#.#..#..#.....##.#..
#....#.##.......#......#.##..#.
.....#........#.##.#...#.....#.
.....###..#.......##...........
.........#.#.#.....#.##.......#
.......#....#......#.#.....#...
##........#...#..#.#.........#.
##...........#.##...##......#..
..#.###.#.#.#...####..#....###.
.........#...#.....##....#.#.##
.###..###.#.#.....#.##.........
#..#...#.#.................##.#
##.........#.#....#.#...#.###..
#.#....#..............#.##.#...
...#..#....##.#..#.......#..##.
.#..#.###......##..........#..#
.##....#.#....#....#.#..#......
.......#.....#..#....#.##...#..
#.#.#.........###..#..#.....#..
...##..##...##....#..#......#..
..........#....#..........#....
#..##..#...#......#.....#.#....
#..##..#....#.#.#...#..........
......##..#.........#........#.
.##..#..#......###.....#..#....
.....#..#.##..........#.#..#...
"""

}
