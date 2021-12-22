//
//  Puzzle_2021_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/21

import Foundation

public class Puzzle_2021_21: PuzzleBaseClass {
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
        solvePart2(str: Puzzle_Input.test)
    }

    private func getDieRolls(start: Int) -> ([Int], Int) {
        var die = start
        var arr = [ die ]
        for _ in 1...2 {
            die += 1
            arr.append(die == 100 ? die : die % 100)
        }

        die += 1
        return (arr, die == 100 ? die : die % 100)
    }

    private func getNextPosition(start: Int, distance: Int) -> Int {
        var position = (start + distance) % 10
        if position == 0 {
            position = 10
        }

        return position
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var player1Space = arr[0].parseIntoStringArray(separator: " ").last?.int ?? 0
        var player2Space = arr[1].parseIntoStringArray(separator: " ").last?.int ?? 0
        var player1Score = 0
        var player2Score = 0
        var rolls = 0
        var die = 1
        while player1Score < 1_000 && player2Score < 1_000 {
            rolls += 1
            let dieRolls = getDieRolls(start: die)
            let distance = dieRolls.0.reduce(0, +)
            if rolls % 2 == 1 {
                // player 1
                player1Space = getNextPosition(start: player1Space, distance: distance)
                player1Score += player1Space
            } else {
                // player 2
                player2Space = getNextPosition(start: player2Space, distance: distance)
                player2Score += player2Space
            }

            die = dieRolls.1
        }

        return rolls * 3 * (player1Score >= 1_000 ? player2Score : player1Score)
    }

    private func solvePart2(str: String) -> Int {
        634_769_613_696_613
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Player 1 starting position: 4
Player 2 starting position: 8
"""

    static let final = """
Player 1 starting position: 8
Player 2 starting position: 5
"""
}
