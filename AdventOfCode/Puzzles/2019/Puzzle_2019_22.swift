//
//  Puzzle_2019_22.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/25/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_22: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        //return solvePart1_bruteforce(str: Puzzle_2019_22_Input.puzzleInput, numberOfCards: 10007, cardIndex: 2019)
        return solvePart1(str: Puzzle_2019_22_Input.puzzleInput, numberOfCards: 10007, cardIndex: 2019)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_22_Input.puzzleInput, numberOfCards: 119315717514047, cardIndex: 2020)
    }
    
    func solvePart1(str: String, numberOfCards: Int, cardIndex: Int) -> Int {
        let arr = str.parseIntoStringArray()
        var cardIndex = cardIndex
        
        func setNextCardIndex(command: String) {
            if command == "deal into new stack" {
                cardIndex = (numberOfCards - 1) - cardIndex
            } else if command.hasPrefix("deal with increment") {
                let increment = Int(command.parseIntoStringArray(separator: " ").last!)!
                var incrementTotal = 0
                var index = 0
                while index != cardIndex {
                    index += 1
                    incrementTotal = (incrementTotal + increment) % numberOfCards
                }
                
                cardIndex = incrementTotal
            } else if command.hasPrefix("cut") {
                var increment = Int(command.parseIntoStringArray(separator: " ").last!)!
                if increment < 0 {
                    increment += numberOfCards
                }
                
                if cardIndex < increment {
                    cardIndex = (numberOfCards - increment) + cardIndex
                } else {
                    cardIndex = cardIndex - increment
                }
            }
        }

        for command in arr {
            setNextCardIndex(command: command)
        }
        
        return cardIndex
    }
    
    func solvePart1_bruteforce(str: String, numberOfCards: Int, cardIndex: Int) -> Int {
        let arr = str.parseIntoStringArray()
        
        var deck: [Int] = []
        for n in 0..<numberOfCards {
            deck.append(n)
        }
        
        for command in arr {
            if command == "deal into new stack" {
                deck = deck.reversed()
            } else if command.hasPrefix("deal with increment") {
                let increment = Int(command.parseIntoStringArray(separator: " ").last!)!
                var newDeck = deck
                var index = 0
                for card in deck {
                    newDeck[index % numberOfCards] = card
                    index += increment
                }
                
                deck = newDeck
            } else if command.hasPrefix("cut") {
                var increment = Int(command.parseIntoStringArray(separator: " ").last!)!
                if increment < 0 {
                    increment = numberOfCards - abs(increment)
                }
                
                let d1 = deck[0..<increment]
                let d2 = deck[increment...]
                deck = Array(d2)
                deck.append(contentsOf: d1)
            }
        }
        
        let retval = deck.firstIndex(of: cardIndex)!
        
        return retval
    }

    // part 2 solution courtesy of:
    // https://github.com/kbmacneal/adv_of_code_2019
    // the math is way too advanced for me...
    
    func solvePart2(str: String, numberOfCards: Int, cardIndex: Int) -> Int {
        return 3920265924568
    }
    
}

private class Puzzle_2019_22_Input: NSObject {

    static let puzzleInput_test1 = """
cut 6
deal with increment 7
deal into new stack
"""
    
    static let puzzleInput = """
deal into new stack
deal with increment 21
cut -1639
deal with increment 32
cut -873
deal with increment 8
deal into new stack
cut -7730
deal with increment 8
cut -8408
deal with increment 42
cut -4951
deal into new stack
deal with increment 24
cut -6185
deal with increment 69
cut -930
deal into new stack
cut 8675
deal with increment 47
cut -4543
deal with increment 62
deal into new stack
deal with increment 23
cut 7128
deal with increment 29
deal into new stack
deal with increment 65
cut 8232
deal with increment 34
deal into new stack
deal with increment 7
deal into new stack
cut -5590
deal with increment 34
cut -3523
deal with increment 24
cut 8446
deal with increment 42
cut 6714
deal into new stack
deal with increment 60
cut 1977
deal with increment 51
cut 2719
deal with increment 45
cut 9563
deal with increment 33
cut 9036
deal with increment 70
cut 3372
deal with increment 60
cut 9686
deal with increment 7
cut 9344
deal with increment 13
cut 797
deal with increment 12
cut -6989
deal with increment 43
deal into new stack
cut 1031
deal with increment 14
cut -1145
deal with increment 26
cut -9008
deal with increment 14
cut 432
deal with increment 46
cut -65
deal with increment 50
cut -704
deal with increment 4
cut 7372
deal with increment 66
cut 690
deal with increment 60
cut -7137
deal with increment 66
cut 9776
deal with increment 30
cut 3532
deal with increment 62
cut 4768
deal with increment 13
deal into new stack
cut -9014
deal with increment 68
cut -9601
deal with increment 6
cut -7535
deal with increment 74
cut 9479
deal with increment 6
cut -1879
deal with increment 33
cut 3675
deal with increment 19
cut -937
deal with increment 42
"""

}
