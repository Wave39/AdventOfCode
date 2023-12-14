//
//  Puzzle_2023_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2023_14: PuzzleBaseClass {
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

    private func spinGrid(_ grid: CharacterGrid) -> CharacterGrid {
        let gridHeight = grid.height
        let gridWidth = grid.width

        var roundRockPositions = grid.findInstancesOf("O")
        var northGrid = grid
        for position in roundRockPositions {
            if position.y > 0 {
                for y in stride(from: position.y, through: 1, by: -1) {
                    if northGrid[y - 1][position.x] == "." {
                        northGrid[y - 1][position.x] = "O"
                        northGrid[y][position.x] = "."
                    } else {
                        break
                    }
                }
            }
        }

        roundRockPositions = northGrid.findInstancesOf("O").sorted { left, right -> Bool in
            left.x < right.x
        }

        var westGrid = northGrid
        for position in roundRockPositions {
            if position.x > 0 {
                for x in stride(from: position.x, through: 1, by: -1) {
                    if westGrid[position.y][x - 1] == "." {
                        westGrid[position.y][x - 1] = "O"
                        westGrid[position.y][x] = "."
                    } else {
                        break
                    }
                }
            }
        }

        roundRockPositions = westGrid.findInstancesOf("O").sorted { left, right -> Bool in
            left.y > right.y
        }

        var southGrid = westGrid
        for position in roundRockPositions {
            if position.y < (gridHeight - 1) {
                for y in position.y..<(gridHeight - 1) {
                    if southGrid[y + 1][position.x] == "." {
                        southGrid[y + 1][position.x] = "O"
                        southGrid[y][position.x] = "."
                    } else {
                        break
                    }
                }
            }
        }

        roundRockPositions = southGrid.findInstancesOf("O").sorted { left, right -> Bool in
            left.x > right.x
        }

        var eastGrid = southGrid
        for position in roundRockPositions {
            if position.x < (gridWidth - 1) {
                for x in position.x..<(gridWidth - 1) {
                    if eastGrid[position.y][x + 1] == "." {
                        eastGrid[position.y][x + 1] = "O"
                        eastGrid[position.y][x] = "."
                    } else {
                        break
                    }
                }
            }
        }

        return eastGrid
    }

    private func calculateLoad(_ grid: CharacterGrid) -> Int {
        let roundRockPositions = grid.findInstancesOf("O")
        let rowCount = grid.height
        var retval = 0
        for position in roundRockPositions {
            retval += (rowCount - position.y)
        }

        return retval
    }

    private func solvePart1(str: String) -> Int {
        let grid = str.parseIntoCharacterMatrix()
        let roundRockPositions = grid.findInstancesOf("O")
        var revisedGrid = grid
        for position in roundRockPositions {
            if position.y > 0 {
                for y in stride(from: position.y, through: 1, by: -1) {
                    if revisedGrid[y - 1][position.x] == "." {
                        revisedGrid[y - 1][position.x] = "O"
                        revisedGrid[y][position.x] = "."
                    } else {
                        break
                    }
                }
            }
        }

        return calculateLoad(revisedGrid)
    }

    private func solvePart2(str: String) -> Int {
        let originalGrid = str.parseIntoCharacterMatrix()
        let target = 1_000_000_000

        var gridDictionary = [CharacterGrid : Int]()
        var workGrid = originalGrid
        var i = 0
        while i < target {
            workGrid = spinGrid(workGrid)
            if gridDictionary[workGrid] != nil {
                let delta = i - gridDictionary[workGrid]!
                i += delta * ((target - i) / delta)
            }

            gridDictionary[workGrid] = i
            i += 1
        }

        return calculateLoad(workGrid)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
"""

    static let final = """
O#O#O#O..OO....#O..........#.#OO..........#..#....O.........O#...#...OOO.O.#.##...#.#..##..O.....#..
#.#....O..O...#..O...O.##.OO....#.#.O..#.OOO.O....#..#..OO......O#...#.#.#O.O..#OO..O.....#.##O...O.
###O#O#O.O#..OOOO.........#.#.O#.OO..#.##.#..O....O....#.O.#..O..O####.#..O#...O....OO..#O.....OO..#
.##.O#.......#....O#.......O.......OO......#...OO#..#####.O.......OOOO###O............#O..#O#.....O.
....O..#.#.#...O......O........O#..O..#O.#O...#O.#O...O#.#...#.O....##.OO.#...........#O.#O#...O....
O...O..O.....#..O.#...O.OO..##..#OO...O........O.O.......O.#O.#..O......O#.......#O.....O.#....#..O#
.....O.OO..OO.....O##.....O.#........##.O.#..O..#OO...#.#..#....#O..#.OO...OO#...#..O.....#OO..#.O..
#..#OOO.O.....OO...O##..........###..##.O#...O.O...#..O#...........OO..#O..#..O#O......O#.#....#.O#O
..#O...#.#OOO..#O.O..#O..#....O......O.O...O##O.....................O..##....#...O...#..#......#....
.#...#.#.#O.O...#.O.#.#O.......#.....O.#.....OO....O.OO.#OO.#...OO..O.O#.OO.O...##...O..#...O#..O.O.
....OO#...###...##O...O.#..OO#..#.......O#....#.#.#..O..O..O......O.....OO#O..#...#....#.#O..#O.....
.OO....O..........O..##.OO#O.....O#.O..O.O...........##O..O......OO.O...O#.#.#.#O...##....#O..O..O.#
...O#.....O....#.........OO........O#.#O....O......O....#..#.##.#.#O##.#......#...OO.#....O.......#.
..#.O...#..#...O...#.#.........OO.........O#......###.#.#.O.O..O..O.#O...O#O.#....O..O...O.#......O.
..#.............#OO.....##...#O....O...#...O....#O..#O...#.#.O..O#.#.....#O#.#O#....#...O...#..###..
#..O.OO...O.......O..O.O..#...O.....O..#.O##....O#.#......#..###.......O.O..#O....O##.O......###...O
....O..O#OO.O#......OO...O#.O...##...O.###.#O.O.O..#.#O...O....OOO.O...O...#....OO.O.##.....O#O##...
#...#OO......O............#.O..#O..OO.O#.O.O...O.....O..O.OOO..O...#......O............O.#..####O...
#..#....O....O..#O.......#.OO#......##....O...#....O#...#O....#...#....O...O....O#O...O.#.O........#
...O........O#....O.#O......#.##....O#.#.O...##O.##..#.....#....OO..OO.....#.#.#####......#.O.......
.#O......#..#O#..O.##.....#.......OO###....O#..O##.O#OO.#.#.OO##.OO.#....#.#.#.....OO....#O#...O....
OO..O.#OO....#...#....#..O.OO....O...O#.....O...#.O.O....O.O...O###....O.O..O.#.O.........O#....O#O#
.O..OO..##.O.#OO.OOO#........#.OO#....O..#O...O#.#....O.O.##O..O.O...O#...........O...O.##O.##....O#
....#...O.#.....O#..#.#...O.OOO.#.....O..O.#O...#O....O.O#.O#.O....#O#......##......O.#.....O...OO#.
..#..O.....O.....#..O...O...#.....O.O.O...OO.O####..O#.##..O#...#..O#..O...O.###..#......O.O.....#..
..O..O#.......OO.#.O.O#.#O..OO..O..#O....#......O.......OO#...#.#.......OOO##....O....O.....#O#..#.O
O#..O.O.......O#.OO....O...#OOO.#O#O.O#....O####.#......#.......O....#O#..#.#.....O..O.#.#O..#.O..OO
#..#.#.O.O..O...O.........O.#.O...OO.....#..#...#...O..OO.O..#...#..O.O.O....O#..O....#O#..O#.O.##..
#.......##..O.O..###O.OO....#OO.#O..O..#.O..####O#.O......O...O#........#.#.O.O.#...##.OO..##...#O..
OOOO#O...##...#.......O....O..OO.O##..O#.O.......O#....O##.O.....O#....O..O.....#.......O#....OO#...
O..#.O#.#.OO..OO.OO..OO..O#...O#.O.....O........O.......#..#..#..O.OO.........O.O.....O.OO...O..O.#.
....OOO......OOO..#....#.O..O#...O....##...O...O##O..#O.#.OO.O.....OO.O#.#...OO..O...##......#..O.#O
.#....#.O.#...O.O.O#...OO..O.#.............OO.#..........O....#..OO#.#.O....OO.OO##.O...##....OO..O.
...OO...O#O#O......##..O.OOO..O.#..O..O#.O#O....#..##..#....O.#.O..OO.O.....#O.O..#.O..#...#.O.#....
O....O.O.....O.O....#.#..O.OOO.O..#....OO.O..O#OO..O#..#.O.O......O.O..O#O..O.#.#...O...O..###.O....
........#.O.O#O#O..#...#.O.O..#.OO.#...O.......O....O.O#....O....O.O..O#..O#....O.....#.O....#O.O.O#
...##.O##..O.......O.OO..#O......O...............#.OO.....OO#....#..OO..O...O..#OO..O..O..##....OO#O
.##.#.#O.......O..O...O...OO...O#....##.#OO..O.....#OO.#.OO.....O..#.O.#......O.O.#.O...#....#.O#...
...O.####.#O#..O..OO.O..OOO#.#O..#O.O#.#O..#.#...#O....#...#.#.#....##..##.......#.O..#OOO...O.#....
..#O..O#O.OO.O.O....O.O...O#....##..##OO.#...#...O.OO#...O..#....O#.....#.O#OO..O........O....O...#.
....#OO.O.#.#.#O.......O..O#........#.#OO.####..O#........#.O#....#..O..O#..#.O.OO.O.......#.O..O..#
.#.#..OO#.#...#.OO...#...O#...##.#......#OO....#...OOOOO#..#O.#.#..#O.....#..OO.#.#....O...O.O......
O#..#OO......#.O.#..O.......OO...O.O...OO..##....#...#.#OOO......#.#.O.O..###O.OO.O...#.O....O...#..
O...O.O..OO..#O#.O.#.O..#..O#..#...#..O.O.........O#..##.....#.O...#O.....O.#.#O.OO.O.#O.O#...O.O#OO
......O..#.....#.O#...O..OO..O....#..O.....#.#OO....O.O.O.#..#.......O...O.O...O.O.O.O.##..##.OO.O..
.....OO##.....O..O#O.#.O.O...#......#.#....OO..OOO#..##.#O..O.#.#OOO.#O...O......OO.##..O.#.O.......
#.....O.......#......O..#..O.#.##...O.O..O........OO...O#O.###...O.#.O.O........#.#O...O##OO#.....##
O.O..#....O....#.O.O#O.O.....O..##....##...O...#O...#.#...O..#..O.......#..#.......##..O...O...O.OO.
.#.#.O.....O##O...###....O.O......#O...OO......O###O.O.......#..............O.O.O#.O......#...O#....
##O....O.......#..O...........O...#...#.O......#..O#.OO..#...#...O.....#......O.O........O#.O#.OO...
O#....O.......O.OO.#..O.........##....OO....#O.#...OOO#......O.......OOO#O.O.O#.#..#..#OO..OO..O...O
.O..#.O....OO.#O....#O......#...#O..O#.O#OO#.......O.#.....#......O....O...#..O#.....#...##..#.#.#.#
.....OO#....#......O.....OO.O#O#.........#.#......O.##....O.OO....##.#O..OO...O#.#....O..OO.O..#.O..
.....#...#....OO......O...#....#OO#.##.O.OO#O.O..O.O.......O...#..O...OO....OOO......O#.....#.O.....
.##..OO##......OOO....O.#.#...O#.O...O...#....O#..#...O.....O...#.....#O....O...OO#.O.OO...O..##...O
O..#OO#O#.##.#....OO.O.....O..#..O..#.#O...#.#.O...#O...O.....O.O....OO........#.#.OO.OO....OOO.#...
O...OO.O..##O..O.....O#...O.....O..#.....#.O..#...#.O.##.O##....O.O.....O#.#.O.O..#..O.....O........
O..O#.O....O#.O#.O.O.O...#O.....#....O..O.OO#O...#.#O#........#..OO#O..#..O.#O.....O...O....#O.#....
...#O.#..#O..O#O........O..O#........O#....##......OO#.#..O.#OO..##..O..........#.......#O....O#.O.#
.O..OO...###.O........O..........O..#.##.##.##.#O...O.##...O..##.##...O###.....#..#.O#O.OOO.OOO#...O
........##.O..#O#.....#..#...O..#.O......#OOOO##......#.O.O.....#.##......OO.#...#.O....O..O.OOO.#..
#.#....#.............OO....OO#.OO#..........OO.OO.O.O.O.....O.....O....#....#.#.#...O...#..##.......
..#O#OO...#.....#.......##O..#O......O.....O.O.O...#.....#O.O...O....#.O...#O.O.#....O...#.##.O.....
.....#...#.#..O.O.O.#....O##O.....O...#O.O....#.....##.O....O...#...O.#.....##....#.O...#......OO#..
O..#......OO#.....OO#..OOO..O.OO.....O.....#....O...O....##.O#.....##.O#.#OO...#.#.......#...#......
.O......O#.....O.O........##.O.O...#.OO...#OO..O#OOOO.....#........#..#.#..O#..#....O.#...#.....##O#
#.O...O#.#.#....##..O..........#.O.OO.#..#.O#....................O.OO.O#.#O..#..O#..#..OO.#O..OO##.O
O#O..O.#..#O...O....#....O##..O.O..#OO.O..O#O...O.OO.....#..O....#.....#..#...#.........O....O.O.#..
..O..O...OO......##OO#....O...#.#.....O...........O...O.#.O.#.OO#...#...OO..O.#.O.#O...#O..OO#.O...O
O..O.#O......O.O....OO..#..#...O...O#...O.OO.....O#...O..O#..O..O..#OO.#..O#....#...##O#.........#.#
O..OO#...#.OO............#OOO....O.O...#........#..#....O........OO#O....#.......##O.O.O#.#..O#O.#.#
#....O.O##..O...#..O#..#.....O.#..O.#..O#.##....O....O......#...#..OO.O..O.#OO...........#OO...#OO..
#.#.#.O.#.O.##.O....O#.#..O#...O....##O.#.O.O...#..O..O..##.O#.......##O..#O#.#.#.....O##O...O.O....
....#.....O.O.#....#..O.........O...O.O.....O#.....#...#..O.#.....OOO..#........O#.#O.....#....O#O..
......#O##.....#O##.....OO..O.O....#.O.......O.OO....#...#.O#OO..#O..O...#........##...#.....#...O..
#O..O.O...#.O##OO#..OO..O..#.#..##.O.....OO.#....O..O#..OO.......#.......OO.#.........O..........OO.
O.......O...#O.......O...#O#.O..#...#.O.......#...#.#..#O.O..........OO##.O.O..#......O...O..O#O..#.
.#......O.#......O#O...O.O....#..#O.O..#.#....O.##O#..O....O..OOO..O....OO......OO..O#O...#....#..#.
.........###.O..O........#...#..OO#.#.....#.#....#.#....#OO.O...O..O...O...O#.......O.........OO.#.#
O#O#.#.#..O..........#O..O.#.O.O##...OO......OO.O#..#O#...O.O...O..##..#.OO##..O....OO..#.OO........
O..O.O#..O#.O......O.O..OO...O.......O......#.O.OO#..###OO...##...#O.OO...OO..##..#O..OO.O....O....#
O....O..O....O..OO..##..OO...O##O...O..#O..O..O#.#O....O.....##..#O...O#.#O##.#.##O...##.#O...O.....
........O.OO#OO.###OO....O....#....O..#....#....#...O..#......O#O#O##.#O#.......O#..#O.....OOO...O..
O.....O.O..O......O.O....O.....O.....................O#..#...O.#...O.O...#..OO###...#...O##.#O......
..#O#.#O##...O..O....O#.##..OO#.O.#.OO..O#.O..##O..#OO.O.#.O##.#OO..#...O#O.O..O..O.O...#..#....O#..
...O.....O......#.O.O...O.#...O..#.OO..O...O..#..#.#...#O.....O...##O..#.....#O.#....O..O..O..O#....
..............OO#.........#.#.O...##...OO.OO..O..O##.#..O..O....O..#...#OO.OOO....#OO..O.#.#O.O.O#..
..#..O.O.O..##O.##.OO...O..##...O.O..O#.#.#..OO..OO..O#O.#O.#.....#O...OO#..O#......#..O......OO..O.
..OOO.O.#...#.O......#..OOO.#.#...O.O.O.O..#....O..O..#....#...O............O.....O..#O...O.O.O...#.
O..O.O..O.O....###OO.#..#.O.O....#.....OO.O#.O#.#.O..OO#O..#.....#.OO..O##..OO.....#...O.#.....#....
..O.O........O..OO#...##....O..O....O.......O....#....O##.......O.#.#......#..O.....O.#.#.....O...#.
.#.O#.O#..#....O.....#.O#.....OOOO..#.O...#.#....#O...O..O...#.#.....#OO#.#.#..#.O.#O...O...O.O#..O.
.O.......OO.O...#.O.OO.O.O..........#.O#........O.#.#.O...O.#O.O....OO...#......#...###OO#.#.O.O#...
..O.......#..O...#..O..##...........#.#..#....#.....#O...O.#.##.O....O#...#..O..##..O............#..
...O....#.#.#..###..O...#O.O#.O.OO...O....O#O#OO..#O..O..#...##.O...OOO.##..O..#......O..O...O.#..#.
#.#O.OO.O.#..O..O.##O.....#O..OO.....O....#.#OO...O.O..O..#O.#OO...#....#..##.........O...#.O......O
....#O.#..O.#......O..OO.#......O.O.O.OO.OO.#OO...O..#OO.O#...#O#...O.#O..O...OO.O.#O..O.O..O......O
O..O..O##....O......#O....O.O....##.OO...O.O#...O.....#O.O....OO......#.O.....#...OO.#...#...#..#.#.
....OO#.O...O.O#..OO..#.....O...O.OO..O.#...O..O..O#.....#.O#...O...#OOOO.##.#..OO...#..........#O..
..O.O.O.O.#...O..#.#OOO.#.#.##.#..O......OO.#O..O.#....#O#.O##......#.##.OO#.O.O.#..O..#O.#..#.OOO#.
"""
}
