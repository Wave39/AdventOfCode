//
//  Puzzle_2016_13.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_13: PuzzleBaseClass {
    struct MoveState {
        var currentCoordinate: Point2D
        var previousCoordinate: Point2D
        var numberOfMoves: Int
    }

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let origin = Point2D(x: 1, y: 1)
        let goal = Point2D(x: 31, y: 39)
        let favoriteNumber = 1364
        var coordinatesSeen: Set<String> = Set()
        var part2Solution = 0

        func coordinateIsWall(c: Point2D) -> Bool {
            if c.x < 0 || c.y < 0 {
                return true
            }

            let n = (c.x * c.x) + (3 * c.x) + (2 * c.x * c.y) + (c.y) + (c.y * c.y) + favoriteNumber
            let str = String(n, radix: 2)
            let ones = str.filter({ $0 == "1" }).count
            return (ones % 2) == 1
        }

        func getValidMoveCoordinates(moveState: MoveState) -> [Point2D] {
            var arr: [Point2D] = []

            for xDelta in [ -1, 1] {
                let newCoordinate = Point2D(x: moveState.currentCoordinate.x + xDelta, y: moveState.currentCoordinate.y)
                if newCoordinate != moveState.previousCoordinate && !coordinateIsWall(c: newCoordinate) {
                    if !coordinatesSeen.contains(newCoordinate.description) {
                        arr.append(newCoordinate)
                        coordinatesSeen.insert(newCoordinate.description)
                    }
                }
            }

            for yDelta in [-1, 1] {
                let newCoordinate = Point2D(x: moveState.currentCoordinate.x, y: moveState.currentCoordinate.y + yDelta)
                if newCoordinate != moveState.previousCoordinate && !coordinateIsWall(c: newCoordinate) {
                    if !coordinatesSeen.contains(newCoordinate.description) {
                        arr.append(newCoordinate)
                        coordinatesSeen.insert(newCoordinate.description)
                    }
                }
            }

            return arr
        }

        func processMoveState(moveState: MoveState, goal: Point2D) -> Int {
            var currentStates = [ moveState ]
            var goalFound = 0
            var ctr = 0
            coordinatesSeen = Set()
            coordinatesSeen.insert(moveState.currentCoordinate.description)

            while goalFound == 0 {
                if ctr == 50 {
                    part2Solution = coordinatesSeen.count
                }

                var nextStates: [ MoveState ] = []
                for state in currentStates {
                    let validMoves = getValidMoveCoordinates(moveState: state)
                    for move in validMoves {
                        let nextMove = MoveState(currentCoordinate: move, previousCoordinate: state.currentCoordinate, numberOfMoves: state.numberOfMoves + 1)
                        nextStates.append(nextMove)
                        if move == goal {
                            goalFound = nextMove.numberOfMoves
                        }
                    }
                }

                currentStates = nextStates
                ctr += 1
            }

            return goalFound
        }

        let part1 = MoveState(currentCoordinate: origin, previousCoordinate: origin, numberOfMoves: 0)
        coordinatesSeen = Set()

        let part1Solution = processMoveState(moveState: part1, goal: goal)
        return (part1Solution, part2Solution)
    }
}
