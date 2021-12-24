//
//  Puzzle_2021_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/23

import Foundation

public class Puzzle_2021_23: PuzzleBaseClass {
    private typealias Burrow = CharacterGrid

    //      c                   1 1 1
    // r    0 1 2 3 4 5 6 7 8 9 0 1 2
    // 0    # # # # # # # # # # # # #
    // 1    # . . . . . . . . . . . #
    // 2    # # # B # C # B # D # # #
    // 3        # A # D # C # A #
    // 4        # # # # # # # # #

    //      c                   1 1 1
    // r    0 1 2 3 4 5 6 7 8 9 0 1 2
    // 0    # # # # # # # # # # # # #
    // 1    # . . . . . . . . . . . #
    // 2    # # # B # C # B # D # # #
    // 3        # D # C # B # A #
    // 4        # D # B # A # C #
    // 5        # A # D # C # A #
    // 6        # # # # # # # # #

    private struct Amphipod: CustomStringConvertible {
        var type: Character
        var position: Point2D

        var description: String {
            "\(type) @ \(position)"
        }

        var isInHomeColumn: Bool {
            (Puzzle_2021_23.homeColumnDict[self.type] ?? 3) == self.position.x
        }

        func isHome(burrow: Burrow, part1: Bool) -> Bool {
            if !self.isInHomeColumn {
                // not in the home column
                return false
            }

            if part1 {
                if self.position.y == 3 {
                    // in the home column and at the bottom
                    return true
                } else {
                    // in the home column at the top, check the one below to see if it is also home
                    return self.type == burrow.characterAtCoordinates(self.position.x, 3)
                }
            } else {
                if self.position.y == 5 {
                    // in the home column and at the bottom
                    return true
                } else if self.position.y == 4 {
                    return self.type == burrow.characterAtCoordinates(self.position.x, 5)
                } else if self.position.y == 3 {
                    return self.type == burrow.characterAtCoordinates(self.position.x, 4) && self.type == burrow.characterAtCoordinates(self.position.x, 5)
                } else {
                    // in the home column at the top, check the one below to see if it is also home
                    return self.type == burrow.characterAtCoordinates(self.position.x, 3) && self.type == burrow.characterAtCoordinates(self.position.x, 4) && self.type == burrow.characterAtCoordinates(self.position.x, 5)
                }
            }
        }
    }

    private struct AmphipodMove: CustomStringConvertible {
        var type: Character
        var fromPosition: Point2D
        var toPosition: Point2D

        var description: String {
            "\(type): \(fromPosition) -> \(toPosition)"
        }

        var energy: Int {
            let steps: Int
            if fromPosition.y == 1 && toPosition.y == 1 {
                steps = abs(fromPosition.x - toPosition.x)
            } else if fromPosition.y == 1 {
                steps = (abs(fromPosition.x - toPosition.x)) + (toPosition.y - 1)
            } else if toPosition.y == 1 {
                steps = (abs(fromPosition.x - toPosition.x)) + (fromPosition.y - 1)
            } else {
                steps = (abs(fromPosition.x - toPosition.x)) + (fromPosition.y - 1) + (toPosition.y - 1)
            }

            return steps * (scoreDict[type] ?? 1)
        }
    }

    private static var scoreDict: [Character: Int] = [ "B": 10, "C": 100, "D": 1_000 ] // nil coalesce this to 1 for A
    private static var homeColumnDict: [Character: Int] = [ "B": 5, "C": 7, "D": 9 ] // nil coalesce this to 3 for A

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
        solvePart2(str: Puzzle_Input.final2)
    }

    private func burrowIsComplete(_ burrow: Burrow, part1: Bool) -> Bool {
        if part1 {
            return burrow[2][3] == "A" && burrow[3][3] == "A" && burrow[2][5] == "B" && burrow[3][5] == "B" && burrow[2][7] == "C" && burrow[3][7] == "C" && burrow[2][9] == "D" && burrow[3][9] == "D"
        } else {
            return burrow[2][3] == "A" && burrow[3][3] == "A" && burrow[4][3] == "A" && burrow[5][3] == "A" && burrow[2][5] == "B" && burrow[3][5] == "B" && burrow[4][5] == "B" && burrow[5][5] == "B" && burrow[2][7] == "C" && burrow[3][7] == "C" && burrow[4][7] == "C" && burrow[5][7] == "C" && burrow[2][9] == "D" && burrow[3][9] == "D" && burrow[4][9] == "D" && burrow[5][9] == "D"
        }
    }

    private func findDestinations(_ burrow: Burrow, for pod: Amphipod, part1: Bool) -> [Point2D] {
        // check to see if the pod is already home
        if pod.isHome(burrow: burrow, part1: part1) {
            return []
        }

        // check to see if the pod is buried in a room and cannot move yet
        if part1 {
            if pod.position.y == 3 && burrow.characterAtCoordinates(pod.position.x, 2) != "." {
                return []
            }
        } else {
            if pod.position.y > 1 && burrow.characterAtCoordinates(pod.position.x, pod.position.y - 1) != "." {
                return []
            }
        }

        // check to see if there is a path for the pod to move home
        let homeX = Puzzle_2021_23.homeColumnDict[pod.type] ?? 3
        if part1 {
            if burrow.characterAtCoordinates(homeX, 3) == "." || (burrow.characterAtCoordinates(homeX, 2) == "." && burrow.characterAtCoordinates(homeX, 3) == pod.type) {
                var pathIsClear = true
                let xStart = (min(homeX, pod.position.x) + 1)
                let xEnd = (max(homeX, pod.position.x) - 1)
                if xStart <= xEnd {
                    for xIndex in xStart...xEnd {
                        if burrow.characterAtCoordinates(xIndex, 1) != "." {
                            pathIsClear = false
                        }
                    }
                }

                if pathIsClear {
                    return [ Point2D(x: homeX, y: burrow.characterAtCoordinates(homeX, 3) == "." ? 3 : 2) ]
                }
            }
        } else {
            if burrow.characterAtCoordinates(homeX, 5) == "." || (burrow.characterAtCoordinates(homeX, 4) == "." && burrow.characterAtCoordinates(homeX, 5) == pod.type) || (burrow.characterAtCoordinates(homeX, 3) == "." && burrow.characterAtCoordinates(homeX, 4) == pod.type && burrow.characterAtCoordinates(homeX, 5) == pod.type) || (burrow.characterAtCoordinates(homeX, 2) == "." && burrow.characterAtCoordinates(homeX, 3) == pod.type && burrow.characterAtCoordinates(homeX, 4) == pod.type && burrow.characterAtCoordinates(homeX, 5) == pod.type) {
                var pathIsClear = true
                let xStart = (min(homeX, pod.position.x) + 1)
                let xEnd = (max(homeX, pod.position.x) - 1)
                if xStart <= xEnd {
                    for xIndex in xStart...xEnd {
                        if burrow.characterAtCoordinates(xIndex, 1) != "." {
                            pathIsClear = false
                        }
                    }
                }

                if pathIsClear {
                    let dotY: Int
                    if burrow.characterAtCoordinates(homeX, 5) == "." {
                        dotY = 5
                    } else if burrow.characterAtCoordinates(homeX, 4) == "." {
                        dotY = 4
                    } else if burrow.characterAtCoordinates(homeX, 3) == "." {
                        dotY = 3
                    } else {
                        dotY = 2
                    }

                    return [ Point2D(x: homeX, y: dotY) ]
                }
            }
        }

        // check to see if the pod is locked in place on the horizontal row
        if pod.position.y == 1 {
            return []
        }

        var xPositions = [Int]()

        // see where the pod can move on the horizontal row
        let startingX = pod.position.x

        // move to the left
        if startingX > 1 {
            var hitAnotherPod = false
            for xIndex in stride(from: startingX - 1, through: 1, by: -1) {
                if xIndex == 3 || xIndex == 5 || xIndex == 7 || xIndex == 9 || hitAnotherPod {
                    continue
                }

                if burrow.characterAtCoordinates(xIndex, 1) != "." {
                    hitAnotherPod = true
                } else {
                    xPositions.append(xIndex)
                }
            }
        }

        // move to the right
        if startingX < 11 {
            var hitAnotherPod = false
            for xIndex in (startingX + 1)...11 {
                if xIndex == 3 || xIndex == 5 || xIndex == 7 || xIndex == 9 || hitAnotherPod {
                    continue
                }

                if burrow.characterAtCoordinates(xIndex, 1) != "." {
                    hitAnotherPod = true
                } else {
                    xPositions.append(xIndex)
                }
            }
        }

        return xPositions.map { Point2D(x: $0, y: 1) }
    }

    private func findAmphipods(_ burrow: Burrow) -> [Amphipod] {
        var amphipods = [Amphipod]()

        for point in burrow.getAllPoints() {
            let char = burrow.characterAtPoint(point)
            if char == "A" || char == "B" || char == "C" || char == "D" {
                amphipods.append(Amphipod(type: char, position: point))
            }
        }

        return amphipods
    }

    private func processInput(str: String, part1: Bool) -> Int {
        var minimumScore = Int.max
        var movesCache = [Burrow: [AmphipodMove]]()

        func processBurrow(_ burrow: Burrow, currentScore: Int) {
            if burrowIsComplete(burrow, part1: part1) {
                if currentScore < minimumScore {
                    minimumScore = currentScore
                }

                return
            }

            if currentScore > minimumScore {
                return
            }

            var moves = [AmphipodMove]()
            if let cachedMoves = movesCache[burrow] {
                moves = cachedMoves
            } else {
                let amp = findAmphipods(burrow)
                for pod in amp {
                    let destinations = findDestinations(burrow, for: pod, part1: part1)
                    for dest in destinations {
                        moves.append(AmphipodMove(type: pod.type, fromPosition: pod.position, toPosition: dest))
                    }
                }

                movesCache[burrow] = moves
            }

            for move in moves {
                var newBurrow = burrow
                newBurrow[move.toPosition.y][move.toPosition.x] = move.type
                newBurrow[move.fromPosition.y][move.fromPosition.x] = "."
                processBurrow(newBurrow, currentScore: currentScore + move.energy)
            }
        }

        let burrow = getCharacterGrid(str: str)
        minimumScore = Int.max
        processBurrow(burrow, currentScore: 0)
        return minimumScore
    }

    private func solvePart1(str: String) -> Int {
        processInput(str: str, part1: true)
    }

    private func solvePart2(str: String) -> Int {
        processInput(str: str, part1: false)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
#############
#...........#
###B#C#B#D###
###A#D#C#A###
#############
"""

    static let test2 = """
#############
#...........#
###B#C#B#D###
###D#C#B#A###
###D#B#A#C###
###A#D#C#A###
#############
"""

    static let final = """
#############
#...........#
###C#C#A#B###
###D#D#B#A###
#############
"""

    static let final2 = """
#############
#...........#
###C#C#A#B###
###D#C#B#A###
###D#B#A#C###
###D#D#B#A###
#############
"""
}
