//
//  Puzzle_2016_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_17: PuzzleBaseClass {
    struct GameState {
        var currentX: Int
        var currentY: Int
        var moves: String
    }

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (String, Int) {
        func getOpenDirections(string: String) -> [Bool] {
            var arr: [Bool] = []
            for idx in 0...3 {
                if "0123456789a".contains(String(string[idx])) {
                    arr.append(false)
                } else {
                    arr.append(true)
                }
            }

            return arr
        }

        func solveGameState(passcode: String, state: GameState, findShortest: Bool) -> String {
            var gameStates = [ state ]
            var leaveLoop = false
            var foundString = ""
            var newGameStates: [GameState]
            while !leaveLoop {
                newGameStates = []
                for gs in gameStates {
                    let md5 = (passcode + gs.moves).md5
                    let openDirections = getOpenDirections(string: md5)
                    if openDirections[0] && gs.currentY > 1 {
                        newGameStates.append(GameState(currentX: gs.currentX, currentY: gs.currentY - 1, moves: gs.moves + "U"))
                    }

                    if openDirections[1] && gs.currentY < 4 {
                        newGameStates.append(GameState(currentX: gs.currentX, currentY: gs.currentY + 1, moves: gs.moves + "D"))
                    }

                    if openDirections[2] && gs.currentX > 1 {
                        newGameStates.append(GameState(currentX: gs.currentX - 1, currentY: gs.currentY, moves: gs.moves + "L"))
                    }

                    if openDirections[3] && gs.currentX < 4 {
                        newGameStates.append(GameState(currentX: gs.currentX + 1, currentY: gs.currentY, moves: gs.moves + "R"))
                    }
                }

                for newGS in newGameStates {
                    if newGS.currentX == 4 && newGS.currentY == 4 {
                        if findShortest {
                            leaveLoop = true
                            foundString = newGS.moves
                        } else {
                            if newGS.moves.count > foundString.count {
                                foundString = newGS.moves
                            }
                        }
                    }
                }

                gameStates = newGameStates.filter { $0.currentX != 4 || $0.currentY != 4 }
                if gameStates.isEmpty {
                    leaveLoop = true
                }
            }

            return foundString
        }

        let part1Passcode = "pvhmgsws"
        let part1GameState = GameState(currentX: 1, currentY: 1, moves: "")
        let part1Solution = solveGameState(passcode: part1Passcode, state: part1GameState, findShortest: true)
        let part2Solution = solveGameState(passcode: part1Passcode, state: part1GameState, findShortest: false)
        return (part1Solution, part2Solution.count)
    }
}
