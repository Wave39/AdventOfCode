//
//  Puzzle_2023_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

// The polygon matching algorithm was adapted from:
// https://github.com/Kumark95/AdventOfCode/blob/master/Core/Solvers/Year2023/Day10/Model/PipeMaze.cs

import Foundation

public class Puzzle_2023_10: PuzzleBaseClass {
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

    private func solvePart1(str: String) -> Int {
        let grid = str.parseIntoCharacterMatrix()
        let initialPosition = grid.findInstancesOf("S")[0]
        let initialMoves = grid.adjacentGridCells(origin: initialPosition, includeDiagonals: false)
        var initialValidMoves = [Point2D]()
        for move in initialMoves {
            if move.0.x == initialPosition.x {
                if move.0.y == initialPosition.y - 1 {
                    // north
                    if "|7F".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                } else {
                    // south
                    if "|LJ".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                }
            } else {
                if move.0.x == initialPosition.x - 1 {
                    // west
                    if "-LF".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                } else {
                    // east
                    if "-J7".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                }
            }
        }
        
        var moves = Set<Point2D>()
        moves.insert(initialPosition)
        moves.insert(initialValidMoves[0])
        var currentPosition = initialValidMoves[0]
        while true {
            let currentTile = grid.characterAtPoint(currentPosition)
            var nextPositions = [Point2D]()
            if currentTile == "|" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
            } else if currentTile == "-" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            } else if currentTile == "L" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            } else if currentTile == "J" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
            } else if currentTile == "7" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
            } else if currentTile == "F" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            }

            if !moves.contains(nextPositions[0]) {
                moves.insert(nextPositions[0])
                currentPosition = nextPositions[0]
            } else if !moves.contains(nextPositions[1]) {
                moves.insert(nextPositions[1])
                currentPosition = nextPositions[1]
            } else {
                break
            }
        }

        return moves.count / 2
    }

    private func isTileInsidePolygon(tilePosition: Point2D, polygonVertices: [Point2D]) -> Bool {
        var isInside = false

        // Iterates over adjacent positions of the polygon
        // For each pair, it checks if the horizontal line extending to the right intersects with the polygon edge
        var j = polygonVertices.count - 1
        for i in 0..<polygonVertices.count {
            let vertexA = polygonVertices[i]
            let vertexB = polygonVertices[j]

            if vertexA.y < tilePosition.y && vertexB.y >= tilePosition.y || vertexB.y < tilePosition.y && vertexA.y >= tilePosition.y {
                if vertexA.x + (tilePosition.y - vertexA.y) / (vertexB.y - vertexA.y) * (vertexB.x - vertexA.x) < tilePosition.x {
                    isInside = !isInside;
                }
            }

            j = i;
        }

        return isInside
    }

    private func solvePart2(str: String) -> Int {
        let grid = str.parseIntoCharacterMatrix()
        let initialPosition = grid.findInstancesOf("S")[0]
        let initialMoves = grid.adjacentGridCells(origin: initialPosition, includeDiagonals: false)
        var initialValidMoves = [Point2D]()
        for move in initialMoves {
            if move.0.x == initialPosition.x {
                if move.0.y == initialPosition.y - 1 {
                    // north
                    if "|7F".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                } else {
                    // south
                    if "|LJ".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                }
            } else {
                if move.0.x == initialPosition.x - 1 {
                    // west
                    if "-LF".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                } else {
                    // east
                    if "-J7".contains(move.1) {
                        initialValidMoves.append(move.0)
                    }
                }
            }
        }

        var moves = [ initialPosition, initialValidMoves[0] ]
        var moveSet = Set<Point2D>()
        moveSet.insert(initialPosition)
        moveSet.insert(initialValidMoves[0])
        var currentPosition = initialValidMoves[0]
        while true {
            let currentTile = grid.characterAtPoint(currentPosition)
            var nextPositions = [Point2D]()
            if currentTile == "|" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
            } else if currentTile == "-" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            } else if currentTile == "L" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            } else if currentTile == "J" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .North))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
            } else if currentTile == "7" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .West))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
            } else if currentTile == "F" {
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .South))
                nextPositions.append(grid.getDirectionalPoint(point: currentPosition, direction: .East))
            }

            if !moveSet.contains(nextPositions[0]) {
                moves.append(nextPositions[0])
                moveSet.insert(nextPositions[0])
                currentPosition = nextPositions[0]
            } else if !moveSet.contains(nextPositions[1]) {
                moves.append(nextPositions[1])
                moveSet.insert(nextPositions[1])
                currentPosition = nextPositions[1]
            } else {
                break
            }
        }

        var vertices = [Point2D]()
        for move in moves {
            let c = grid.characterAtPoint(move)
            if c != "|" && c != "-" {
                vertices.append(move)
            }
        }

        var retval = 0
        for row in 0..<grid.height {
            for col in 0..<grid.width {
                let position = Point2D(x: col, y: row)

                // Random pipes that are not connected to the main loop also count
                if (!moveSet.contains(position) && isTileInsidePolygon(tilePosition: position, polygonVertices: vertices))
                {
                    retval += 1
                }
            }
        }

        return retval
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
.....
.S-7.
.|.|.
.L-J.
.....
"""

    static let test2 = """
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
"""

    static let final = """
.F7FFJ7L-7.F-7.F7|F-L-7F7F|7.F7F7FJ.FLFF-77.FFF7-|FL-7LF-7F7FF--77.-777F-LJFFL7FJ.|-L7-FF-FJ77F7F7F-7F.|F7JF-L-J--|-F7|F-LF--77..J..F---.F7-
|7LJJ-||.FF-7.|||J-|LL|-J7JFF77LFFJ.7J|L|LJ7F7J|-77||7LL7||L7L7FJFF|F-7|7-|FFJFJ|-|.L7.|.7.|F7-|F7J-JFFJFLJL|J7L|FF77J.-7LJF|LJ7||FFJF-JF-7J
L7J|JJF-L|J.L7.LJF77.LF7JL-J|.L.7J-FF7|FJ7LF||LJLL.LJ-J|||L7L-JL7-J7JFL|L7FF--F-|.|F-L|F7-.L7J|L|.J.L||7||7.|.F7--J|J-|F|7||7-LF--JJ.L-JF-J-
.LFF--|.|LFJ7||.||7-7||J.F|F|-J-|.|L|L-7L-J|.-77.|F.|.FFJL-JF---J7-FJL7L---J|J.JJFF77LJ-J.FFJ.-.|J7F.|L--J7-FJL-F-7J.|JLF7FL7|7F7LL----7J7|7
..7JJFJF|J.L-7-F7JJL|-L.|F-FJ7J7L|7-L7FJ7L77J|JL--|FF7-L--7FJF7F7L7J-L-7|J|-L.FL-J.L|-J.L|7L-|LFJ|LF-FJLJ7FJ.|7LL-J-J77-L-|JL--J7JLF|-FJL---
FFJ.L7LJ7.|J|..LJ|FFLF--J|.JF7L|L-J.L||F-7F7JF7..7-|||-F7FJ|FJ||L-7LLL7FJ.F7|-|.FL|JL|F7.FJF-J-F-7FJ.L|.FF|7F|7L|||.F||7|LL7|.LLF7.L77|J.LL.
7J7|.F7.LJ|F7--J-L7J7.F|..F.7J-LFJ.F7|LJFJ||FJ|-||FF||FJ|L7||FJ|F-J7..J|F|.F7-|FLL|F-F-7F7||F|.J-L||7.L-J7LJ|J|.7JF7|7JL|LJ-L7L7|J-||JL|JJ--
LF-JFJ|LJJ|.F-F.|LL.|F77J.LJ||.FF7F||L-7|7|||FJ-F7F7||L7|F|||L7|L7F7-|LFF7FJL7F77|L--L7|||F-7JL7L|.F7-FL--JFLJFFFJL7LJ-FF-|-L77F77.JJ|FJJF.|
LF7L7LF.||F.L-|77|.|LFL|7FF-|7-FJL7||F7|L-J|||F7||||||FJL-JLJFJ|FJ|L7J-FJ|L7FJ||7FJ||FJLJLJFJ|J7.F-J|.|F7|JLJJ|..FLFJL7JL7.-.|F.|F-JF-L..|F7
-LJ7||L-F7|7.FLJ-J.F77.77|7JF77L-7LJ||LJF7FJ|||||LJLJLJF-7F-7L7|L-JFJLFL7|FJL7|L77--7L-7F--JFF7-F77L|FFFJJ77|FFF77||-LL7F|.F7-J-FJ.LF-|-|7.|
JFFL77|.L-|L-J-|7FLFJL7LFF7-||F-7L-7||F-JLJFJ|||L-7F7F7L7LJLL7||F--J|FF-J||F-J|FJ7|FF7FJL-7JFF7F777FF77||.F-7-FJL-77-F7F-7-LJ-|FF-L-|F77J|FJ
FJ7L|L--F7|F7|7FJ-|..||.L||FJ|L7|F7|||L---7L7LJ|F7LJLJL-JF7-FJLJL7F7F7L7FJ||F7||JF-7||L7F-J-FJ|||F7F7JL77.L7|7L7F-J--LLL7L7FJLJ7|JJ.L|.7-FFJ
L7|F7.|-|L-JLFF-JF-7FF--7|LJFJF|||LJLJF---JFJF-J|L7F--7F-JL7L7F--J|||L7|L-JLJLJL7L7|||FJL7-LL7||||LJL7F-7F7||F-JL7J|FJ|-|FJ7JFFF7FFF-|-|--L7
L-J-7-7-|JJL-JF-77F|7L-7LJF-JLFJ||F--7L-7F-JFJF7L7|L7FJL--7|FJL7F7|LJFJ|F-------JL|LJLJF7|F7L|||||F7FJL7LJLJ|L7F-JLF7F--J|F77F7||7JL7L.L7.JJ
F..L|J.F|LJ.FF77-LF--7L|F7L7F7L7LJL-7L--JL-7L7|L7||FJL7.F7||L-7||||F-JL||F7F--7LF7L--7FJLJ|L-JLJ|LJ|L-7|F--7L7|L--7||L--7LJL7||||F7.--JJJJJ.
-77JF--F--FLJF7.LFL-7|LLJL7LJ|JL-7F-JF7.F7FL7||FJ||L7FJFJLJL--J|||||F-7|||||F7|FJ|FF7||7F7L7F7F7L7FJF-JLJF7L7||F-7||L--7L-7FJ|||LJL7F|7||L77
L|7-|J.|.F--L|LJ-7F-J|F7|FL7FJF-7||F-JL7||F-J|||FJL-JL7L------7||LJ||FJ||||||LJL7L7||||FJL7LJLJ|FJ|FJF7F7|L7|LJ|F||L--7L7.|L-JLJF7FJFLFFJ|.F
..JJ||7LLJ.7--7|L-L-7|||-F-JL7L7LJLJF-7|||L-7LJ|L7F---JF--7F7FJ||F-J|L7|LJLJL7F7L7||||||F-J7F7FJ|FJ|FJ|||L7|L-7L7LJ-F7|FJFJF7F7FJLJF-.FJLL77
J.|.L.-7L|77-F7-77LFJ||L7L7F7L7L-7F-JJLJ|L7JL-7|FJ|F7F7L-7|||L7|||JFJFJ|F--7FJ||7|||||LJL7F7||L7|L7LJFJ||FJL-7L7L7F7|LJ|L|FJ||||JJLL77JFJ.77
|.FL|-LLFL---|.FF7.L7||FJ7LJL7L7FJL-77F7|FJF--J|L7LJ||L-7|LJL7||||FJFJF|L-7LJL||FJLJ||F--J||||FJL7L-7L7|||F--JJL7LJ|L-7L7|L7||LJJ.|-FJ-LF7FJ
FFJ||--LFJ|JFLF7||F-JLJ|F7F-7L7||F--JFJLJL7L--7|FJF-JL-7|L--7LJLJ|L7|F7|F-JF7FJ||F-7LJL-7L||||L-7L7FJFJ|LJ|FF7F7L7FJF7|FJ|FJ|L7-7-F7F7.LJ7|.
FL.J|JLF.FLFF7||||L---7||||FJFJLJL--7|F7F7L7F7|||FJF7F7||FF7L--7FJFJLJLJL--JLJFJLJ||F--7|FJ||L7FJFJL7|FJF7L7|LJL7|L7|LJL-JL7L-J7J|LLJ-7..F7-
J-7-J-FF.|JFJLJLJL-7LFJ||LJL7L-7F--7|||LJL7||LJ|||FJ|||||FJL---J|||F----7F-7F-JF7F7||F7LJ|FJ|FJ|FJ7FJ|L-JL7||F--J|FJ|F---7FJF7F7-|.||J.7F-7J
L-J-|.F|.L-L----7F7L7L7|L7F7|F7||F7LJLJLF7|||F-J||L7|||||L7F---7|FJ|LF-7LJ-LJ7FJ||||||L7-|L7||.||F7|FJ7F7L|LJL-7FJL-J|7F7LJ||||L-7-LJ|..|7|7
|FLFJF|J7L7|F7F7LJL7L-JL7LJ|LJ||LJL7F77FJLJLJL-7||FJLJ||L7LJJF-JLJFJFJFJF----7L7LJLJ||FJFJFJ|L7|LJLJL7FJL7|F-7FJL7F--JFJL--7|||F-JJ|.F7F|-F7
LL.|F7JLFF7FJ|||F--JF7F7L--JF-JL-7FJ||FJF---7F-J|||F7FJ|FJ|F7L---7L7|FJF|F---JFJF7F-J|L7L7L7L7|L--7F-JL-7LJ|-||F-JL7FFJF---J|||L7F7-FJL7LFLF
.|-F---FFJ|L7|||L---JLJL---7|F7F7|L-J|L-JF--JL-7|LJ|LJFJL-7|L7F--JFJ|L--J|F-7FJFJ||F7L7L-JFJFJL7F7|L-7FFJF7L7LJL--7L7L7|F7F7||L7LJL7|F-J7L-J
-JF7|-7JL7L-JLJL-----------J|||||L7F-JF-7L7F-7FJL-7|F7L7F-J|FJL--7L7L7F--J|FJL-JFJ||L-JF--J|L7FJ|||F-JFJFJL-JF7.F7|FJF|LJ|||||F|F--J|L-7JJ-.
FLF-J7L7LL---7F---7F7F7F7F-7LJLJL7|L-7|FJLLJFJ|F7FJ||L7||F7||F7F7|FJFJL-7FJ|F7F-JFJL-7FJFF77FJL7|||L7FJFJF--7||FJLJ|F7|F-J|LJ|FJL-7.|F-JJJ.L
F|LJ|FJL-|JF7LJF77LJLJ|||||L-7F-7LJF7|||-F-7L7|||L7|L7||||||LJLJ||L-JF7FJ|FJ|||F7L--7||F7|L7L-7||LJFJL7L-JF-J||L-7FJ||||F7L7FJ|F-7L-JL----7|
LJ|JFJ||FFFJL-7||F7F-7LJLJF--J|FJF7|LJ||FJFJFJ||L-J|7|||LJ||F--7LJF--JLJFJL7||LJL-7FJ|||||FJF7||L-7L7FJF--JF7|L7J|L-JLJ||L-JL-JL7|F7F7F-7FJJ
F----JL|7LL--7LJLJ|L7|F-7LL--7|L7|||7FJ|L7L7L7|L--7|FJLJF-JLJF7|F7|F--7FJF-J||F--7||FJ||||L7||||F7L7||FJF7FJLJFJFJF-7F7LJF-7F7F-J||LJ||FJL7J
F77FJ.LLF7F--JF--7L-JLJFJF7F-J|7LJ|L7L7L7L7L7|L7F7|LJF7FJ|F7J||||LJL-7|L7|F7||L7FJ|||FJ||L7|||||||J|LJ|J|LJF--JFJFJFJ|L7FJ|LJ|L-7|L-7LJL-7||
--L77FJ|||L-7FJF-JF-7F7L7||L--JF7FL7|FJFJFL7LJFJ|||F7|LJF7|L-J||L7F7FJL7||||||FJL7|||L7|L7|||||LJL7|F7L7|F-JF--JFJ-L7L7|L7F7||F7|L-7L7LJ-||7
.L|LF..FJL7FJL7L--J|LJL7LJL----J|F-J|L7|FF7|F-JL||LJ||F7||L-7FJ|FJ||L-7|||||||L7FJ|||FJ|FJ|||||F--JLJ|FJ|L--JF7FJ-F7L-JL-J|L7LJ|L-7L-J.FLLJ.
|L7-J7-L-7LJF-J|F-7F7F-JF--7F7F7LJF7L7|L7||||F7FJL7FJ||LJ|F7||FJL7||F7|||||||L7|L7||||FJ|FJLJ||L-7F7FJL7|F--7|||F7|L--7F77|FJF7L--JJF7-L.|J7
77LJ.-.L-|F7|-F7L7||LJF7L-7LJLJL--JL7|L7LJ|||||L7FJL7|L7J|||||L-7||||||||||||FJ|-|||||L7|L7F-JL-7||LJF7LJL-7LJLJ||L-7FJ|L-JL7||F7F7L||F|7|-|
|F--JJ7|F||LJFJL7||L--JL--JF---7F7F-JL-JF7||LJL7|L7FJL7|FJ|||L7FJ||||||||||||L7L7|||||FJL7|L-7F7|LJF7||F---JF---JL7FJL7|F---J|LJLJL-J|JLL77J
FLJLL7FJL||JFJF7LJL--------JF-7LJ|L---7FJ||L7F7|L7|L7LLJ|FJ||FJ|FJ|LJLJLJLJ|L7L7|||||||F-J|F-J|LJF-JLJ|L---7|F----JL7FJ|L----JF7F----J|F.L77
-J|JJL.LF|L7L-JL7F7F7F--7F-7|FJF7L---7LJFJL7LJ|L7|L7|F--JL7||L7|L7L-------7|FJFJ|||||||L--JL-7L-7L---7L---7LJL---7F-JL-JF----7||L--7.L-L77L7
JF|7..FF7L-J7F-7||||||F-J|FJ|L-J|F--7L7FJ|FJF7|FJL7LJ|F7F-J||FJ|FJF7F7F7F-J|L7|FJLJ|||||F----JF7L7F--JF7F7L--7F7FJL7F7F7L-7F7LJL---JJ77L-7J.
|J|L-7-|L-7F7L7LJ|||||L7FJ|FJF--J|F-JFLJF7|FJ||L7FJF-J|LJF-J|L7|L7||||||L7FJFJ|L-77|||L7|F-7F7||FJ|F-7|LJL--7LJLJF7||LJL-7LJL-7F7F-7.|7JF|JL
L-|..L7L-7LJL-JF7||||L7||FJ|-L---JL-----J||L7LJL|L7L7FJ-FJF7L7LJFLJ||||L-J|FJFJF7L7||L7|||FJ|||LJF|L7||F----JF7|FJLJL7-F7L-7F-J||L7L7.|7FJ.L
|-7-7FJ|LL-7F7FJ|||||FJLJL-JF---7F7F--7F7|L7||F-JFJFJL-7L7||FJ7F---J||L--7|L7|FJL7|||7LJLJL7|||F--JFJLJL-----JL-JF7F7L-JL-7LJF7||FJFJ-JLJ777
JFL-F|.|J.LLJ||FJ|||LJF7F---JF-7LJ|L-7LJ|L7|L7L7FJ-L7F-JFLJ|L7FJF-7FJ|F7FJ|FJ|L-7||LJF7F7F-J||||F-7L7F-7|F7F7F7F7|LJ|F-7F7L--JLJLJFJJ7.7|F77
LJJ7J|F|..L|7LJL-JLJFFJ|L--7FJLL-7L-7L-7L-JL7|LLJFF-JL--7F-JFJ|FJJ|L7||LJFJL7L7FJLJF-JLJLJF-J||LJ.L-JL7L-JLJLJ||||F7LJF|||F-7F7F7FJFL|-L|JJ|
LJ7L.7-FF77F7-F-7F7F7L7|F--J|F-7FL-7|F7|F-7JLJF7F7|F-7F7|L-7|FJL7FJFJ|L-7L7FJFJL--7|F7F--7|F7LJ-F7F7F7L--7F--7LJLJ|L--7||LJFJ||||L77F7.L|7||
|.FL.LF---7||-L7LJLJL7||L---JL7L---JLJLJ|FJF7FJLJ|||FJ||L7FJ|L7FJL7L7|F7L7|L7L7F--J||||F-J||L--7|LJ|||F7|LJF7|F---JF--JLJF7|FJLJL7L-J|7.||L-
..FJ.FL7F7LJL7|L----7LJ|-F7|F7L--------7|L-JLJF--JLJL7|L-JL7|FJL-7|FJ|||FJL7L7|L7F7LJLJL--JL--7|L-7LJLJL7F-JLJ|F---JF----J|LJF7F7L-7FJ7FF77L
F-|-7F|LJL7F-JF-7F--JF-JFJ|FJL--------7LJF--7FJF---7FJ|F---J|L7F7||L7||LJF-JFJL7LJL7F---------J|F7L-7F-7|L----JL----JF7F--JF7|LJL77LJLJ-LJJ|
F-|--LF---J|F7L7|L--7L-7L7|L---------7LS7L-7LJL|F--JL-JL-7F7|FJ||||FJ|L-7L-7L-7|F7FJL--7F7F---7LJ|F-J|FJL-7F--7F-7F-7||L---JLJF-7|7F|.|FLJL7
-7.|FLL7F-7|||FJ|FF7L-7L7|L--77F----7L-7L--JF7FJL-----7F7LJ|||FJ|||L7L-7|F-JF7|||||J|F7LJLJF--JF7LJF7||F-7LJF7|L7|L7|||F7F---7|JLJLFJ|LL77LF
FLL-||LLJFJLJLJFJFJL-7|FJL--7L7L---7L--JF7|FJLJF-7F--7LJ|7FJ|||FJ||FJF-J|L--J||LJ|L-7|L--7FJF7FJ|F7|LJLJFJF7||L-JL7|LJ||LJF-7|L--7---LF-L77|
F|FFLJ-F-JF---7|JL--7LJ|F7F7L7|7F-7L---7|L-JF7FJJLJF7L-7|FJFJ||L7|LJ7L-7L--7FJL-7|F7|L7F7LJFJLJL|||L7F-7L-JLJ|LF-7|L-7|L77|FJL---JJ.||.||7-L
F|777F-L--JF7|||F--7L-7||LJL7||FJFJF---J|F--JLJF7F7|L7LLJL7L7||FJL----7L7F7|L7F-J||LJ-LJL7FJF7F7LJL-JL7|F----JFJFJL7FJL7L-JL----77.F|7-F7|J|
|.|FF77|F--JL-J||F7L--J|L--7LJ|L7|.L----JL-----JLJLJFJF--7L7|||L7F7F-7L7|||L7LJ|.LJF-7F--JL7|LJL7F7F7J||L-7F7L|FJF7LJF7L7F--7F--J7F7JJ||J77|
L--FL-F-JF----7|LJL-7F7L---JF7L7|L7F7F7F7F7F-7F-----JFJF-JFJ|||FJ|||.|FJLJL7L-7777|L7LJF---JL7F7LJLJL-JL--J|L7||7||F-JL7|L-7LJJJFFJ||.||FLFL
F-LL7-L-7|7F--JL7F7JLJ|F7F--JL7||FJ||||||||L7LJF7F7F7L7L-7L7|LJ|FJLJFJL7.F-JF-J7-F7-L--JF--7.LJ|F-7F7F7F-7LL7LJL7|LJF7FJL7FJF-7|L---7FJF-7LL
L7|FLJ..LJ-L---7|||F7FLJ||F---JLJL-JLJLJ||L7L--JLJLJL-JF-J-LJF7|L-7LL-7|FJF7|J-L|||-F7F-JF7L---JL7LJ||||FJF7|F--JL7FJ|L7||L-JFJ7|J-J7LL|JL-7
L7-F.LJ.FFLF---JLJLJL---J|L----7F7F7F--7LJLL-7F-------7L77FLFJLJF-J7-LLJL-JLJF-.F|L-J|L--JL---7F-JF-J|LJL-JLJL----JL7L7L7L--7|F777-L|7J.L|F7
LFJ|L.|-F|FL----7F7F----7|FF7F-J|||||F-JF---7LJJF----7L7L77.L--7L7J|.|.|J7FJJJLFFJF-7L7|F-7F--JL7FJF7|F---7F7F7F7F--JFL-JF-7|LJL7J.L|.77FFF|
||-FJ--.|JF-----J|||F7F7LJFJLJF7|||LJL--JF--J|F7|F--7L7L-JF7|-L|FJ-|-|.L7F|L|L7|L-JLL7L7L7|L--7FJL-JLJL--7LJLJ|||L-------JFJL---J-FFJ.-|-JJ|
7L7L-JFFJ-L---7F7||||LJL7-L7F-JLJLJF7F7F7L7F7FJLJL7-L-JJF7|L7.FLJJFL.F.LLF7-J|F-7F7F7L7L-J||F7LJ7F-7F77F7L--7|LJL---7F----J.F7F--7J.L7JLLFJF
|FLJLF-|JLF7F7||LJ||L7F7L--J|F-----JLJLJL7LJLJF--7L7FF-7||L7|-L-J-|7F77-FJ-F77L7|||||F|F-7L-JL--7L7LJL-J|F-7L7F7F7F7LJF7F7F7||L7FJ7FL77.F|-L
|--|FJ|L|-|LJ|LJF7LJJLJL7F--JL--------7F7|F7F7L-7L7L7L7LJL-JL77FJJ|7-J|.LJLF---JLJLJL-J||L7F---7L7L----7LJ7L7LJ||LJ|F7|||||||L-JL-7F7JL-|JL|
|.|L|LLF|7L-7|F-J|F7-F7FJ|F--7F7F----7LJ|||LJ|F7L7L7L-JF7F7F7|-LJ.|---F-LJFL---7F-7F-7FJF7LJF7FJFJFF--7L---7|F7LJF-J|||LJLJLJF---7LJ|77.||F|
F777L|.|J-F-JLJF7LJ|FJ||FJ|F7LJLJF--7|F-J|L-7||L7|FJF7FJLJLJLJJ|FJ-J7|JFFF7|JLFJL7LJJLJL|L-7||L7|F7L7FJF---JLJ|F7|F7|||F--7F-JF-7L--J-L.--F|
LJ-FFJ-L|LL----JL7FJL7|LJ.LJL--7FJLFJ|L-7L7FJLJL||L7||L-7F7F77-77L|7-7--7F7J-FJF-JJF---7L-7LJL7||||7|L7L-----7|||LJ||||L-7LJF-JFJJF7J||F|-||
L---JLL.-J|F7F7F7||FFJ|F7F7F---J|F-JLL--JLLJF7F7LJ.LJ|F7LJLJL77JF-J|LJ7F7.||F|FJ7|.L--7|F7L--7LJLJL-JFJF-----J|||F-J||L7FJF7L7FJF7|L7F777FF|
-7FJF77-|FFJLJLJLJL7L7||||LJF7F-JL-7JF-7F7F7||||F7F-7LJL---7FJ|.JJ77JLF|77|FLLJLF7-F7FJLJL---JF7F7F-7|FL---7F7LJLJF7|L-JL-JL7||.|||FJ|L77FL7
F--J-F----JF--7F--7L7||||L--JLJF---JFJFJ|||LJLJLJ||FJ7F-7F7LJJ7F|FL-77LL|--L.L|FJL7||L7F-7F7F7|||LJFJ|F7F-7LJL7F7FJLJF7F----J|L-JLJL7L7L7JLJ
J7L--L----7L-7LJF-JFJ||||F7F--7L----JFJJ||L7F----J||F7L7||L7F7J-F7L|.--F|.FJFFFJF7LJL7LJ7LJLJLJ|L7FL7|||L7|F--J|||F--J|L-----JF----7L-JFJJ7J
FL-..F----JF-JF7L-7L-JLJLJ|L-7|LF-7F-JF7||FJL---7L|LJ|-|||FJ|||F77-|L..-JFL7FFL-J|F-7|F7F7F7F--JFJF7||||L||L---JLJL-7|L-7F--7FJF--7L-7FJJ||7
FJ.LFL----7|F-J|F-JF7F-7F7L--JL7L7|L--JLJLJF----JFJF7|FJ|||L|L7|L7-||F-J.J.-FJ.|FJ|FJLJLJLJ|L---JFJLJLJL-J|F---7F7F7L--7|L-7|L-JF7L-7|L-7F7J
..77||F|J7|||F7LJF7||L7LJL----7L-J|F-------JF77F7L7|LJL7LJL-JFJ|FJ-|-JJ|.L7.|FF-JFJL-7F7F-7L----7L---7F7F7LJF7F||LJL---JL--J|F-7|L7FJ|F7LJ||
7.LF|LFJ-FLJLJL--JLJ|FJF7LF7F7L--7LJ7F------JL-JL7|L7F7|F----JFJL77J.|.L--|-JFL7FJF-7LJLJFJF7F-7L----J|LJL-7|L7LJF7F7F7JF--7|L7||.||.|||F-JJ
....|-L7FLF---7F----J|FJL-JLJL---JF7FJF7F7F-7F7F7LJFJ||||7F7F-JF-JF77J|.JF|L7J.LJFL7L---7L-JLJ-L---7F7|F---JL7|LFJ||||L-JF7||FJLJFJL7|||L7JJ
7.FF|7J.F.L-7FJL-7F--JL-7F7F---7F-JLJFJLJ|L7|||||F7|FJLJL7|||F-JF-J|-F77J|LF7.-L|F7L---7L--7F------J|||L-----JL7L7||LJF--JLJLJF7LL7FJ||L7||L
F--7JF7FF---JL--7LJF---7LJ||F--J|F---J7F7|FJ|||||||LJF7F7LJ||L--JF-J7||J7J.|L7..FJL77F7L-7FJ|F-7F-7FJLJF---7F-7L-JLJF7|F7F7F--JL-7||7LJJLJ77
JJF|||F-L7F7F-7FJF7L--7|F7LJL-7FJL-7F--J||L7LJ|||||F7||||F7LJF--7L-7FJ||F-7-F7FFJF7L7||F-JL7LJFJ|FLJF7LL--7|L7|F7F7FJ|LJLJLJF-7F7|LJF|L-7|-7
J7-7.FF|-LJLJFJ|FJ|F7FJLJL7F7FJ|F-7LJF7FJL-JF7LJ||||||LJLJ|F7L-7L7FJ|FJFJFJJ|L7L7|L7LJ|L-7FJF7|FJF--JL----JL-JLJ||||FJF-----JFLJLJ7LF-7J-7.|
LJF|-FJL.|LF7L7|L7|||L--7FJ|LJFJL7L--JLJF---JL-7LJLJ|L--7FJ|L--J7LJ7|L-JFJF-JFJJLJ7L-7L77|L-J|LJ.L-------------7LJ||L7L----7F-7JF-77|FJJLF.F
.LJ|..7--F-JL-JL-J|||F--JL7L--JF7L------JF----7L7F7FL--7|L-JF7-F-7F7L--7|7L-7|F-7F--7L7L-JF--JF7F7F------------JF7LJ.L7F7F7LJFJFJFJFJL77FL-J
LF-|7FF7-L-------7LJ|L---7|.F7FJL--------JF7F7L-J|L-7F7LJF7F|L7L7||L7F-JL7LFJ|L7|L-7L-JF-7||F-JLJLJF-7F-------7FJL7FF7LJ|||F-JFJFJFJF-J-L-J.
L7J||.|.FF7F7FF--JF7L7F--JL-JLJF------77F7|LJL7F-JF-J|L7FJ|FJFJFJ||FJL--7L7L7L7|L77L-7FJFJL7L------JFLJF7F----J|F-JFJL-7LJ||LFJFJFJFJ|J|JL7.
LJF|J.77FJLJL-JF7FJL7LJF7F-----JF7|F-7L-JLJF-7LJF7|F7L7||FJ|FJFJFJ|L7|F7L7L7|FJL7L7F7LJFL7FJF--7F77F7|FJLJ|F7F7|L7FJF--JF7LJFJFJLL7|F777..|.
|7F|J|.-L----7FJ|L-7L--J||F-----JL-JLL-----JFJF-JLJ|L7|LJL7|L7L7L-JFJFJL-JFJ|L-7L7||L--7FJ|-L-7LJL-JL-JF---JLJ||FJL7L---JL7FJFJF7FJLJL-7--77
L7FJF7F-FF---JL7L7FJF---J|L7F7F-7F-7F--7F7F7L-J-F7L|FJL-7FJL7L7|F7FJ-L7F-7L-JF-JFJLJF--JL7L7F7L-----7F7|F--7F7LJL--JF7F---JL7|.|LJF7F--J|-|J
L||-L7-JL|F7F7FJFJ|FJF7F7|FJ|LJ.LJJLJF7LJLJL7-F7|L-JL--7|L-7L7|||LJLF7||FL7F-JF7|F-7L---7L7LJL------J|LJL-7|||F-----JLJF7F7FJL-JF7||L-7J-7F7
||LFLJ.F-LJLJ||FJFJL7|LJLJL-JF7F7F7F7||F-7F7L-JLJF7F---J|F-JFJLJL--7||LJF-JL-7||LJ|L7F--JFJF---7F7F7FJF-7FJLJ|L--7.F--7|LJ||F---J||L--JJJFFL
L|J...FF----7LJL-JF7LJ|F7LF7FJLJLJLJLJ||FJ||F7F7FJLJF7F7||-FJF-----J|L7FJF7F-J|L7JF7||F7F|FJFF-J|||LJJL7LJF-7L--7L-JF-JL-7||L--7LLJF7|F77FJ|
LL7F-7FL-7F7|F7F7FJL--7||FJ|L--------7|||FJLJLJLJF7FJ||||L7|FJ7F--77|FJL-J|L7|L7|FJ||LJL7LJF7L--J||F---JF-JFJ-F7L---JF7F7|LJF--JF7FJL-JL-7JJ
..|7.||FLLJ|LJLJ|L---7LJ|L7|F--7F----JLJLJF---7F-J||FJ||L7|||F7|F-JFJL77F7L7|F7||L7|L--7L--J|F7F7LJL----JF-J-FJL-----JLJLJF7L-7FJ||F-----JJ.
F-7-FJ|F--FL7F-7L---7L-7L-J|L-7|L------7F-JF--JL-7LJL7|L-J||LJ||L-7L7FJFJL-JLJ||L7|L--7L-7F7LJLJL7F7F7JF-J-F7|F-7F-7F7F-7FJL-7LJFJ||FF---7-|
J7|7||L7JFF7|||L7F-7L-7L7F7L--JL-------J|F7L---7FJF--JL-7FJL7FJ|F-JFJ|.L----7FJL7||F-7|F7LJ|F-7F7LJLJL7L---JLJL7LJFJ|||FJL--7L-7L-JL7|F--JL7
.7LFF-L|J-||LJF-JL7|F7L7LJL7F7F7F7F77F7|LJ|F---JL7|F-7F-JL7FJ|FJ|F7L7L7|F7F-JL--JLJL7LJ|L-7|L7LJL---7FJF7F-7F-7L-7L-JLJL7F-7|JFJF7F7LJL--77|
-J-||FFF-7||F7L---JLJL7L7F7||LJLJLJ|FJL7F7|L7F-7FJ||FJL-7FJL7|L7|||FJFJFJ||F----7F--JF7L7FJL-JF77F--JL-JLJFLJJ|F7L-7JF--JL7||FJFJLJL7F--7|FJ
LJF|F--JFJ||||F7F7LF7|L7LJ|LJF7F7F7LJF7LJ|L7LJFJ|FJ||F7J||F7|L-J||LJFJFJFJLJF---JL-7FJ|FJL7F7FJL7L-7F7F7F----7LJ|F7L7L7F-7|LJL7L--7FJL-7||JJ
FF-FL--7L-J||||||L-J|F-JF7L--JLJLJL--JL--J.L-7L-JL7|||L7|LJ|L--7||F-JFJFJ.F7L7F7F7FJ|FJ|F-J|LJF7|F-J|LJLJF7F-JF7|||FJFJL7|L7F7|F-7|L-7FJLJJ7
--7|-F-JF-7|||||L--7|L--JL-----7F---7F7F7F7F-JF-7FJ|||FJL-7|F7FJ|||F7L7|F7||-LJLJ||FJL7|L-7|F-JLJL-7|F---JLJF7||LJLJLL7FJ|FJ|LJ||LJF-J|F77F7
.L77.L--JFJLJLJ|-F7||F7F------7||F--J|||LJ|L-7||LJF||||F77|||||FJ||||FJ|||||F-7F-JLJF-JL-7LJL--7F7.LJL------JLJL-7F7F7LJ-|L7|F7L7.L|F7LJL-J|
7.L-|JJF-JF---7L-JLJLJ|L7F-7F7LJ|L---JLJF7|F-JL7F7FJ|||||FJ|||||FJ|||L7||||||FJL---7|F7.FJF---7||L-7-F------7F---J|LJL7JFJFJLJL7L-7LJL7F7F7|
|-|JJLFJF7|F--JF-7F7F7L-J|LLJL7FJF7F7F--JLJL-7FJ||L7|||||L7LJ||LJFJ||FJ||||||L-7F7J|LJ|FJFJF7JLJL-7L7|F7F--7LJF---JF-7L7|FJF---JF7L--7||||||
FJJ|JF|FJLJL7F7L7LJLJ|F--JF7F7LJFJLJ||F7F7F7FJL7||FJ||||||L-7||F-JFJ||FJ|||LJF7|||FJF-J|FJ.|L-7F7FJFJLJLJF-JF7|F--7L7|FJ||JL--7FJ|F7FJ||LJ||
77FJ-JLJF|F-J|L7|F7F-J|F-7|LJL--JF-7LJ||||||L7FJ|||FJ||||F7|||||F7L7|||7||L7FJLJ||L7|F7||F7L7FJ|||FJF7FF7L--JLJL-7L-JLJFJL-7LFJ||||LJFJ|||||
J-7JJFF---JF7|.LJ||L--JL7|L---7F7|7L7FJ||||L7|L7|||L7|LJ||L7|||||L7|LJL-JL7||F7FJ|FJLJ||||L7||FJ|||FJ|FJL7F-7F7F7L----7L--7|FJFJFJL-7L-J7FLJ
L-77F-|F--7|||F--JL---7FJ|F7F7LJ|L-7|L7||||FJ|FJ||L7|L-7||FJ|LJ|L7|L7F--7-||LJ|L7LJF7FJ||L7||LJFJ||L7||F-JL7||LJL--7F7L7F7LJL7L7L--7|7JL7-JJ
|FL||FLJ|LLJLJ|F-----7|L7LJLJL--JF7||FJ|||||FJL7|L7||F-J||L7L7J|FJL7||F7L-JL-7L7L--J|L7|L7||L-7|FJL7|LJL-7FJ|L--7F7LJL-J|L7JLL-J7J|LJ-7-F77|
FF-JF|F|-.F7F7|L7F---J|||F7F7F-7FJ||||FJ||||L-7|L7|||L-7LJFJFJFJL-7LJLJ|F7F7FJF|F---JFJL7|||F7|||LFJL7F7FJ|F|F-7LJL7F7F7|FJJLFJ-J-|J|FJ.|L-J
-F-F-L-F--|LJLJFJL---7L-J|||||FJL7LJLJ|FJ||L7FJL7|||L7FJF7L7L7L7F7|F---J||||L7FJL--7JL7FJ||||LJLJFJF7LJ|L7|FJL7|F7FJ|LJLJL--77J7.-.|L7LFL-|J
||--77FL-LL-7F-JF----JF7FJ||||L7FJF--7LJ|LJFJ|F-J||L7||FJL-JFJ-||||L-7F7|LJ|FJL7F--JF-J|-LJ|L---7|FJ|F7L7||L7FJLJ||||F----7FJ|FJFLF-7|.LFJJ.
-FJ-F7|.LFLFJ|F7L--7F7||||LJ||FJL-JF7L---7LL7||F7|L7|||L-7F7|F-J|||F-J||L-7|L7||L-7LL--JF--JF---JLJ||||FJLJF|L-7FJL7||F--7||LL7-7L7LF-7LJJ..
FF7.||JF-7JL-J||F7FJ||||L--7LJL--7FJL--7FJF7LJLJ|L7||||F-J|||L7FJ||L-7|L-7||FJFJF7L7JF-7L7F7L-7JF---J|||LLF-JF-JL-7LJLJF-JLJ7|FJ|7LJL-J7JL-7
LLJ7-L-|J.FF--JLJLJFJ|||F--JF7F--JL---7|L7|L----JFJ||LJ|F7|||7|||||F-J|F7|||L7|FJL7|FJFJ7LJ|F7|FJF7F7||L7FJF7L---7|F-7FJF7JJLJJ7L-7FLJ7|7.77
LLLFJ-FJ-FJL---7F-7L7LJ|L7F-JLJF7F7F--JL7||F7F7F7L7|L-7||LJ|L7|L7||L--J|LJ|L7||L-7|LJFJ|F7FJ||||FJ||||L-JL-J|F-7FJLJFJL-JL77FLJJ7.F--7-||FF7
|FJF7.J-FF7FF--JL7L7|F-JFJL--7FJ|||L---7||LJLJ|||FJ|F-JLJF-JFJ|FJ||F---JF7L7|||F7||F7L-7|LJFJ|||L7|||L----7FJL7|L--7L7F7F7L7JJ7LLL-JFLJFF|-J
F|F|J-|--7|-L7F7FJFJ|L7FJ|F--J|7LJ|F-7FJ||F---J|||FJL-7F7L-7L7||FJ|L7F-7|L7|||||LJLJ|F-JL-7L7||L7|LJ|F----J|F-J|F-7L7||LJL-J.L7..L|.LL7-FLJ7
-7-|F7L7J|F7|LJLJ7L7L7LJF7L7F7L7F-J|JLJFJ|L-7F7|||L-7FJ|L--JFJ|||FJ|LJFJL7LJ|||L-7F-JL-7F7L-JLJFJ|F-J|F----JL-7||FJFJ|L-7F7.F.|-7-|-LJJF-7||
||JL||FJFLF--------JFJF-JL-J||FJ|F7L--7L-JF-J|||LJF-JL7L---7|.LJ|L-7F-JF7L-7LJ|F-JL-7F7LJL---7|L7||F-JL7F-7F7FJ||L-JFJF7LJL7JLL-77F-7JF-J---
7.L-J-L-L7L7F7F7F7F-JFJF-7F7||L7LJ|F--JF7LL7FJLJ-FJF-7L-7F-JL-7FJF-JL--JL7FJFFJL-7F-J|L---7F7L7FJ||L-7FJL7||||FJL--7L7||F--J-JF|JJ|LJ7|JLLJJ
L7.FJJJ|L-7LJLJ||||F-JFJFLJ|||FJLFJL---JL7L|L--7FJFJLL7FJ|F7F-JL-JF------JL-7L7F7|L-7L--7JLJL-JL7||F-J|F7|||||L-7F-JFJ||L---7-JL|77FL|JF7-|.
|L7JL|-L---J-|-LJ||L7FJF7F-J|||F-JF------JFJF-7|L7L--7||FJ||L---7FJF-7F7F7F-JFJ|||F-JF-7L---7F-7LJ||F7LJ||LJ||7FJL-7L-J|F---J-JFL|-F-|LJJ--7
J7L7-7..|.L.---J-LJ-||FJLJF7|LJ|F7L---7F7FJFJFJ|FJF-7|||L7|L7F7FJL7|FJ|LJ|L-7|FJLJL7FJFJF---JL7L7FJLJL7FJ|F-JL7L7F7L--7|L-77L7FF7|.J7LFJL7FJ
FF7|7L7-|.|FJL7FFJ|.LJL--7|LJF-J|L7F-7LJ|L-J7L-JL7|FJ|||F|L7|||L7F||L7|F-JF7||L7F--JL7L7L-7.F-JFJL7F7FJL-JL7F7|JLJ|F--JL--JJJ--F7|FL7|LF-FJJ
F|FFJ7LL--F7F--.|F7F-----JL7FJF7|FJL7L-7L---7F---J|L-J||FJFJ||L-JFJ|7LJL7FJLJL-JL7F--J||F-JFJF7L-7LJ|L-7F--J||L--7|L77LL-|J-|F-7LJ7.L7|L-7FJ
LLJL777FJLLJJ7|LFJ|L------7||FJ||L7FJFFJF7F7||F--7|FF-J|L7L7||F7-L7|F---JL--77F--J|F---JL--JFJ|F7L7FJF7||F-7||F7FJ|FJJLJ.L|.L7.|J|L|JFJ7F.77
J.7J777L-J.|FJ-LL7L-------J||L7LJFJL-7L7|LJ||||F-JL7L-7L7|FJ|LJ|F-J|L-7F7F-7|FJF7FJL-7F-7F7FJ.||L7|L7|||LJFJ||||L7LJJJ.|.JJ|7L-F.|.J-7-|JFJ7
FFJ|FJ-|..FJ7|.|L|F-7F---7FJ|FJLFJF7FJFJL7.LJLJ|F-7|F7|FJ|L7|F-JL-7|F-J||L7||L-J||JF-JL7||||F7LJ7LJ-LJ|L-7L-J|||FJJJ|LF77|7F77J|L77L7JFJ-FJ|
L|.F|-LJ.FJF7LJJ|LJFJ|.F-J|||L-7|FJLJFJF7L--7F-JL7|||LJL7L7||L-7JJLJL7FJL7|LJFF-JL7L7F7||||LJL--7-LF--JF-JJ-FJ||L7-LL7|L-|-JJ7F|J.7.-77|F|JJ
FJ-7.-7--|FL--7F|.|L-JFJF7|FJF7||L7-FJFJ|F--JL-7FJLJ|F-7L7||L--JFFFJF||-FJ|FF-JF7FJ|LJ||LJL7F---JJ|L---J7|77L-JL-J77|J|7LL77LJ|.|-|F|.F-JJ|.
|JJFJJ.FLL.|.LL-JFF7|LL7|LJ|FJ||L7|FJFJFJL--7F-J|7.L||F|FJ|L--7JJ-L-LLJJL7|FJF-J||F7JFJL7F-JL7JL|.7LF|-LJ-7-FJJLL|.7JLLJ7.F7-FF77-LF|FFJ-777
||JL7|F-JLF77J|.L-.F-F-J||FJ|7LJ7||L7|FJF-7FJ|F7L-7.LJ-||FJF-7|.|JJ.L|7LL|||FJF-JLJL7|F7|L-7FJJ7F-|--JFL|LL7L|F-FF7L77L7--LF7LLF|JFL|7|--7JJ
JJ--J7-L-7JL|J|-..7|FL--J-L7|7J|FJ|FLJ|FJFJ|7LJ|F-J-7F-J|L7|-LJ-|J|7F|--LLJLJFJF-7F-JLJ||F-JL7-L--L-JL|.7FLJF||.-JJ7.|JL|.LJJ.F|.F7LF-J.FJ..
.|L-J|7|L7.|L-J.LJLJLJL|L||LJ7-LL-J-LLLJ7L7L7L|LJ.|7F|F7|JLJFL|.F.F-LLJ-LLLLJL7|FJL---7LJL-7FJJ.L77.F7|FL-JL|-J7|JF7F|7.F7LJ.--.F||LL.--F-|7
.-7J7LF7-|--JLF-.|7.FFFJF-FJL|F||L77L7|FJ-L-JF|J|-|-FJ|LJ|LL7-FLL.--7F-7.|7|.LLJL7F--7|||LFJ|J.|7FF-J-J7JL.||||-LL|JLJL|.J.LF.F7JL7|L|J.|.|L
|FJ.|.|--.LJJF-LFJJ7FLJ.7LJJF|-|J||7FJJF7F||.||.-7LFL-JJL-F.F.-JL.J-77|77.LL-7|-|||JLLJ-7-|FJJ7.L.|FJ-||LL-F-7F-77FJL.FL7J77F7FJJ.F--JJ-J7FJ
F--J..L-|FF.LFLL.|J-7J7F--|JL7|LL7.F|F-LJF|77||FL--7J|JL.L|7F-.L|7-F.--JL77FLL7|F||J7|LL|.LJ|L.77.-|.|L7F-.|LLF7|-77|.JJ|.F-JL|JFLF|F7|7F7J|
7|FJ.|.F|--J.F7L7JL-J.-FF-77.LF7|JF-J77FL|L-7J.F.L-JL-.|.7-|..7|.|||.|F--FFJJ.F7LLJF-|-.LFJJ||F|FF7|-|-|7F-|JJ.F77FF--7.LL|-JFLJL-L7|J-FF-F7
L7J.F|-7|J|-F|7L-77-L-7LL7FJF.J-|-----LJ-J||J7LF77|.FF-7|J-|F7.J-|7||77--7|||.L|.LL|-J.7-||.L-L7L|-7JL-||J-J.FFFL7LJ-L|-FJ.LF|7FJ--J|77L7.||
FJ-L--7J--J-LL--LL77-LL.L7J.JJJJL-|J..J----7L-JL|-J-|J-LJF-|.L-LJ..|JL-JLLLJJJ--7LJL-J.|L--FFJ.|JL-J.J-L|---F--|L|..7.L|.F|L-J--JJ.-.FJLL7JJ
"""
}
