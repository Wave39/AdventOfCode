//
//  Puzzle_2017_22.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_22: PuzzleBaseClass {

    enum Direction: Int {
        case UP = 0
        case RIGHT = 1
        case DOWN = 2
        case LEFT = 3

        func nextDirectionByTurningRight() -> Direction {
            Direction(rawValue: (self.rawValue + 1) % 4) ?? .UP
        }

        func nextDirectionByTurningLeft() -> Direction {
            Direction(rawValue: (self.rawValue - 1 + 4) % 4) ?? .UP
        }

        func nextDirectionByReversing() -> Direction {
            Direction(rawValue: (self.rawValue + 2) % 4) ?? .UP
        }
    }

    let gridSize = 20_000
    let gridCenter: Point2D = Point2D(x: 10_000, y: 10_000)

    func translatePoint(point: Point2D) -> Point2D {
        Point2D(x: (point.x + gridCenter.x), y: (point.y + gridCenter.y))
    }

    func getCharacterAtVirtualCoordinates(grid: CharacterGrid, point: Point2D) -> Character {
        let newPoint = Point2D(x: (point.x + gridCenter.x), y: (point.y + gridCenter.y))
        return getCharacterAtCharacterGridPoint(grid: grid, point: newPoint)
    }

    func solve() {
        let part1Solution = solvePart1()
        print("Part 1 solution: \(part1Solution)")

        let part2Solution = solvePart2()
        print("Part 2 solution: \(part2Solution)")
    }

    func solvePart1() -> Int {
        let puzzleInput = PuzzleInput.final
        return solvePart1(str: puzzleInput)
    }

    func solvePart2() -> Int {
        let puzzleInput = PuzzleInput.final
        return solvePart2(str: puzzleInput)
    }

    func solvePart1(str: String) -> Int {
        let startingGrid = getCharacterGrid(str: str, separator: "\n")
        let startingOffset = Int(startingGrid.count / 2)

        var theGrid = initializeEmptyCharacterGrid(height: gridSize, width: gridSize)
        for y in 0..<startingGrid.count {
            for x in 0..<startingGrid[0].count {
                let pt = Point2D(x: x, y: y)
                let translatedPoint = translatePoint(point: Point2D(x: (x - startingOffset), y: (y - startingOffset)))
                theGrid[translatedPoint.y][translatedPoint.x] = getCharacterAtCharacterGridPoint(grid: startingGrid, point: pt)
            }
        }

        var currentPoint = translatePoint(point: Point2D(x: 0, y: 0))
        var currentDirection = Direction.UP
        var infectionCount = 0
        for _ in 0..<10_000 {
            let c = getCharacterAtCharacterGridPoint(grid: theGrid, point: currentPoint)
            if c == "#" {
                currentDirection = currentDirection.nextDirectionByTurningRight()
            } else {
                currentDirection = currentDirection.nextDirectionByTurningLeft()
            }

            if c == "#" {
                theGrid[currentPoint.y][currentPoint.x] = "."
            } else {
                theGrid[currentPoint.y][currentPoint.x] = "#"
                infectionCount += 1
            }

            if currentDirection == .UP {
                currentPoint.y -= 1
            } else if currentDirection == .DOWN {
                currentPoint.y += 1
            } else if currentDirection == .LEFT {
                currentPoint.x -= 1
            } else {
                currentPoint.x += 1
            }
        }

        return infectionCount
    }

    func solvePart2(str: String) -> Int {
        let startingGrid = getCharacterGrid(str: str, separator: "\n")
        let startingOffset = Int(startingGrid.count / 2)

        var theGrid = initializeEmptyCharacterGrid(height: gridSize, width: gridSize)
        for y in 0..<startingGrid.count {
            for x in 0..<startingGrid[0].count {
                let pt = Point2D(x: x, y: y)
                let translatedPoint = translatePoint(point: Point2D(x: (x - startingOffset), y: (y - startingOffset)))
                theGrid[translatedPoint.y][translatedPoint.x] = getCharacterAtCharacterGridPoint(grid: startingGrid, point: pt)
            }
        }

        var currentPoint = translatePoint(point: Point2D(x: 0, y: 0))
        var currentDirection = Direction.UP
        var infectionCount = 0
        for _ in 0..<10_000_000 {
            let c = getCharacterAtCharacterGridPoint(grid: theGrid, point: currentPoint)
            if c == "." {
                currentDirection = currentDirection.nextDirectionByTurningLeft()
            } else if c == "#" {
                currentDirection = currentDirection.nextDirectionByTurningRight()
            } else if c == "F" {
                currentDirection = currentDirection.nextDirectionByReversing()
            }

            if c == "." {
                theGrid[currentPoint.y][currentPoint.x] = "W"
            } else if c == "W" {
                theGrid[currentPoint.y][currentPoint.x] = "#"
                infectionCount += 1
            } else if c == "#" {
                theGrid[currentPoint.y][currentPoint.x] = "F"
            } else if c == "F" {
                theGrid[currentPoint.y][currentPoint.x] = "."
            }

            if currentDirection == .UP {
                currentPoint.y -= 1
            } else if currentDirection == .DOWN {
                currentPoint.y += 1
            } else if currentDirection == .LEFT {
                currentPoint.x -= 1
            } else {
                currentPoint.x += 1
            }
        }

        return infectionCount
    }

}

private class PuzzleInput: NSObject {

    static let test1 =

"""
..#
#..
...
"""

    static let final =

"""
..#..##...##.######.##...
..#...#####..#.#####..#..
...##.#..##.#.##....#...#
#.#.#.#..###...#....##..#
..#..#####.....##..#.#..#
.##.#####.#.....###.#..#.
##..####...#.##.#...##...
###.#.#####...##.#.##..#.
#.##..##.#....#.#..#.##..
###.######......####..#.#
###.....#.##.##.######..#
...####.###.#....#..##.##
#..####.#.....#....###.#.
#..##..#.####.#.##..#.#..
#..#.#.##...#...#####.##.
#.###..#.##.#..##.#######
...###..#..####.####.#.#.
.#..###..###.#....#######
.####..##.#####.#.#..#.#.
#.#....##.....##.##.....#
....####.....#..#.##..##.
######..##..#.###...###..
..##...##.....#..###.###.
##.#.#..##.#.#.##....##.#
.#.###..##..#....#...##.#
"""

}
