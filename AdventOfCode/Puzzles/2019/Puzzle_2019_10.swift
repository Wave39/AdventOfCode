//
//  Puzzle_2019_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/10/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_10: PuzzleBaseClass {

    enum SectorType {
        case Asteroid
        case Empty
    }

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1.0)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> (Int, Point2D) {
        return solvePart1(str: Puzzle_2019_10_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_10_Input.puzzleInput, base: Point2D(x: 30, y: 34))
    }

    func solvePart1(str: String) -> (Int, Point2D) {
        let lines = str.parseIntoStringArray()
        var sectorGrid: [[SectorType]] = []
        for line in lines {
            var lineArray: [SectorType] = []
            for c in line {
                if c == "." {
                    lineArray.append(.Empty)
                } else {
                    lineArray.append(.Asteroid)
                }
            }

            sectorGrid.append(lineArray)
        }

        let gridWidth = sectorGrid[0].count
        let gridHeight = sectorGrid.count
        var asteroidCoordinates: [Point2D] = []

        for y in 0..<gridHeight {
            for x in 0..<gridWidth {
                if sectorGrid[y][x] == .Asteroid {
                    asteroidCoordinates.append(Point2D(x: x, y: y))
                }
            }
        }

        var retval = 0
        var baseLocation: Point2D = Point2D()

        for base in asteroidCoordinates {
            var visibleAsteroids = 0
            for candidate in asteroidCoordinates {
                if candidate != base {
                    let x0 = min(base.x, candidate.x)
                    let y0 = min(base.y, candidate.y)
                    let x1 = max(base.x, candidate.x)
                    let y1 = max(base.y, candidate.y)
                    let rise = y1 - y0
                    let run = x1 - x0
                    let ratio = run == 0 ? -1.0 : Double(rise) * 1.0 / Double(run)
                    let ratioString = String(format: "%.5f", ratio)
                    let asteroidsToCheck = asteroidCoordinates.filter { $0.x >= x0 && $0.x <= x1 && $0.y >= y0 && $0.y <= y1 }
                    var asteroidIsVisible = true
                    for asteroid in asteroidsToCheck {
                        if asteroid != candidate && asteroid != base {
                            let thisX0 = min(base.x, asteroid.x)
                            let thisY0 = min(base.y, asteroid.y)
                            let thisX1 = max(base.x, asteroid.x)
                            let thisY1 = max(base.y, asteroid.y)
                            let thisRise = thisY1 - thisY0
                            let thisRun = thisX1 - thisX0
                            let thisRatio = thisRun == 0 ? -1.0 : Double(thisRise) * 1.0 / Double(thisRun)
                            let thisRatioString = String(format: "%.5f", thisRatio)
                            if ratioString == thisRatioString {
                                asteroidIsVisible = false
                            }
                        }
                    }

                    if asteroidIsVisible {
                        visibleAsteroids += 1
                    }
                }
            }

            if visibleAsteroids > retval {
                retval = visibleAsteroids
                baseLocation = base
            }
        }

        return (retval, baseLocation)
    }

    func solvePart2(str: String, base: Point2D) -> Int {
        let lines = str.parseIntoStringArray()
        var sectorGrid: [[SectorType]] = []
        for line in lines {
            var lineArray: [SectorType] = []
            for c in line {
                if c == "." {
                    lineArray.append(.Empty)
                } else {
                    lineArray.append(.Asteroid)
                }
            }

            sectorGrid.append(lineArray)
        }

        let gridWidth = sectorGrid[0].count
        let gridHeight = sectorGrid.count
        var asteroidCoordinates: [Point2D] = []

        for y in 0..<gridHeight {
            for x in 0..<gridWidth {
                if sectorGrid[y][x] == .Asteroid {
                    asteroidCoordinates.append(Point2D(x: x, y: y))
                }
            }
        }

        enum DirectionFromBase {
            case north
            case northeast
            case east
            case southeast
            case south
            case southwest
            case west
            case northwest
        }

        struct AsteroidInfo {
            var position: Point2D
            var direction: DirectionFromBase
            var slope: Double
        }

        var asteroidArray: [AsteroidInfo] = []
        for asteroid in asteroidCoordinates {
            if asteroid != base {
                let direction: DirectionFromBase
                if asteroid.x == base.x {
                    if asteroid.y < base.y {
                        direction = .north
                    } else {
                        direction = .south
                    }
                } else if asteroid.y == base.y {
                    if asteroid.x < base.x {
                        direction = .west
                    } else {
                        direction = .east
                    }
                } else {
                    if asteroid.x > base.x {
                        if asteroid.y > base.y {
                            direction = .southeast
                        } else {
                            direction = .northeast
                        }
                    } else {
                        if asteroid.y > base.y {
                            direction = .southwest
                        } else {
                            direction = .northwest
                        }
                    }
                }

                let slope = Double(asteroid.y - base.y) / Double(asteroid.x - base.x)

                asteroidArray.append(AsteroidInfo(position: asteroid, direction: direction, slope: slope))
            }
        }

        var asteroidsRemoved = 0
        var retval = 0

        func CheckPureDirection(_ direction: DirectionFromBase) {
            let arr = asteroidArray.filter { $0.direction == direction }.sorted(by: { base.manhattanDistanceTo(pt: $0.position) < base.manhattanDistanceTo(pt: $1.position) })
            if !arr.isEmpty {
                asteroidsRemoved += 1
                let asteroidToRemove = arr.first!
                asteroidArray.removeAll(where: { $0.position == asteroidToRemove.position })
                if asteroidsRemoved == 200 {
                    retval = asteroidToRemove.position.x * 100 + asteroidToRemove.position.y
                }
            }
        }

        func CheckDiagonalDirection(_ direction: DirectionFromBase) {
            let arr = asteroidArray.filter { $0.direction == direction }
            if !arr.isEmpty {
                var slopesSet: Set<String> = Set()
                for a in arr {
                    slopesSet.insert(a.slope.toString())
                }

                let slopesArray = Array(slopesSet).sorted(by: { Double($0)! < Double($1)! })
                for slope in slopesArray {
                    let arr2 = arr.filter { $0.slope.toString() == slope }.sorted(by: { base.manhattanDistanceTo(pt: $0.position) < base.manhattanDistanceTo(pt: $1.position) })
                    if !arr2.isEmpty {
                        asteroidsRemoved += 1
                        let asteroidToRemove = arr2.first!
                        asteroidArray.removeAll(where: { $0.position == asteroidToRemove.position })
                        if asteroidsRemoved == 200 {
                            retval = asteroidToRemove.position.x * 100 + asteroidToRemove.position.y
                        }
                    }
                }
            }
        }

        while !asteroidArray.isEmpty {
            CheckPureDirection(.north)
            CheckDiagonalDirection(.northeast)
            CheckPureDirection(.east)
            CheckDiagonalDirection(.southeast)
            CheckPureDirection(.south)
            CheckDiagonalDirection(.southwest)
            CheckPureDirection(.west)
            CheckDiagonalDirection(.northwest)
        }

        return retval

    }

}

private class Puzzle_2019_10_Input: NSObject {

    static let puzzleInput_test1 = """
.#..#
.....
#####
....#
...##
"""

    static let puzzleInput_test2 = """
......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####
"""

    static let puzzleInput_test3 = """
#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###.
"""

    static let puzzleInput_test4 = """
.#..#..###
####.###.#
....###.#.
..###.##.#
##.##.#.#.
....###..#
..#.#..#.#
#..#.#.###
.##...##.#
.....#.#..
"""

    static let puzzleInput_test5 = """
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##
"""

    static let puzzleInput = """
....#.....#.#...##..........#.......#......
.....#...####..##...#......#.........#.....
.#.#...#..........#.....#.##.......#...#..#
.#..#...........#..#..#.#.......####.....#.
##..#.................#...#..........##.##.
#..##.#...#.....##.#..#...#..#..#....#....#
##...#.............#.#..........#...#.....#
#.#..##.#.#..#.#...#.....#.#.............#.
...#..##....#........#.....................
##....###..#.#.......#...#..........#..#..#
....#.#....##...###......#......#...#......
.........#.#.....#..#........#..#..##..#...
....##...#..##...#.....##.#..#....#........
............#....######......##......#...#.
#...........##...#.#......#....#....#......
......#.....#.#....#...##.###.....#...#.#..
..#.....##..........#..........#...........
..#.#..#......#......#.....#...##.......##.
.#..#....##......#.............#...........
..##.#.....#.........#....###.........#..#.
...#....#...#.#.......#...#.#.....#........
...####........#...#....#....#........##..#
.#...........#.................#...#...#..#
#................#......#..#...........#..#
..#.#.......#...........#.#......#.........
....#............#.............#.####.#.#..
.....##....#..#...........###........#...#.
.#.....#...#.#...#..#..........#..#.#......
.#.##...#........#..#...##...#...#...#.#.#.
#.......#...#...###..#....#..#...#.........
.....#...##...#.###.#...##..........##.###.
..#.....#.##..#.....#..#.....#....#....#..#
.....#.....#..............####.#.........#.
..#..#.#..#.....#..........#..#....#....#..
#.....#.#......##.....#...#...#.......#.#..
..##.##...........#..........#.............
...#..##....#...##..##......#........#....#
.....#..........##.#.##..#....##..#........
.#...#...#......#..#.##.....#...#.....##...
...##.#....#...........####.#....#.#....#..
...#....#.#..#.........#.......#..#...##...
...##..............#......#................
........................#....##..#........#
"""

}
