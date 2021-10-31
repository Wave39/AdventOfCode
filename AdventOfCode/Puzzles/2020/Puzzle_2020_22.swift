//
//  Puzzle_2020_22.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/22/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_22: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_Input.puzzleInput)
    }

    func parseIntoCardArrays(str: String) -> ([Int], [Int]) {
        let lines = str.parseIntoStringArray()
        var player1 = [Int]()
        var player2 = [Int]()
        var player2Mode = false
        for line in lines {
            if line == "Player 1:" {
            } else if line == "Player 2:" {
                player2Mode = true
            } else if !line.isEmpty {
                if player2Mode {
                    player2.append(Int(line)!)
                } else {
                    player1.append(Int(line)!)
                }
            }
        }

        return (player1, player2)
    }

    func deckScore(_ deck: [Int]) -> Int {
        var retval = 0
        for multiplier in stride(from: deck.count, to: 0, by: -1) {
            retval += (multiplier * deck[deck.count - multiplier])
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        var (player1, player2) = parseIntoCardArrays(str: str)

        while !player1.isEmpty && !player2.isEmpty {
            let player1Card = player1.removeFirst()
            let player2Card = player2.removeFirst()
            if player1Card > player2Card {
                player1.append(player1Card)
                player1.append(player2Card)
            } else if player2Card > player1Card {
                player2.append(player2Card)
                player2.append(player1Card)
            } else {
                print("Tie!")
            }
        }

        let winningCards = (!player1.isEmpty ? player1: player2)
        return deckScore(winningCards)
    }

    struct Decks: Hashable {
        var player1: [Int] = []
        var player2: [Int] = []
    }

    func solvePart2(str: String) -> Int {
        func roundWinner(player1Cards: [Int], player2Cards: [Int]) -> (Int, [Int]) {
            var deckSet = Set<Decks>()
            var player1 = player1Cards
            var player2 = player2Cards
            while !player1.isEmpty && !player2.isEmpty {
                let decks = Decks(player1: player1, player2: player2)
                if deckSet.contains(decks) {
                    return (1, player1)
                } else {
                    deckSet.insert(decks)
                }

                let player1Card = player1.removeFirst()
                let player2Card = player2.removeFirst()
                var winningPlayer = 0
                if player1Card <= player1.count && player2Card <= player2.count {
                    var newPlayer1 = [Int]()
                    for idx in 0..<player1Card {
                        newPlayer1.append(player1[idx])
                    }

                    var newPlayer2 = [Int]()
                    for idx in 0..<player2Card {
                        newPlayer2.append(player2[idx])
                    }

                    (winningPlayer, _) = roundWinner(player1Cards: newPlayer1, player2Cards: newPlayer2)
                } else {
                    if player1Card > player2Card {
                        winningPlayer = 1
                    } else if player2Card > player1Card {
                        winningPlayer = 2
                    } else {
                        print("Tie!")
                    }
                }

                if winningPlayer == 1 {
                    player1.append(player1Card)
                    player1.append(player2Card)
                } else {
                    player2.append(player2Card)
                    player2.append(player1Card)
                }
            }

            return !player1.isEmpty ? (1, player1) : (2, player2)
        }

        let (player1, player2) = parseIntoCardArrays(str: str)
        let (_, winningCards) = roundWinner(player1Cards: player1, player2Cards: player2)
        return deckScore(winningCards)
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
"""

    static let puzzleInput = """
Player 1:
31
24
5
33
7
12
30
22
48
14
16
26
18
45
4
42
25
20
46
21
40
38
34
17
50

Player 2:
1
3
41
8
37
35
28
39
43
29
10
27
11
36
49
32
2
23
19
9
13
15
47
6
44
"""

}
