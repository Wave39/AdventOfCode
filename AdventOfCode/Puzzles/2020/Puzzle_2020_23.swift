//
//  Puzzle_2020_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/23/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

// Part 2 solution borrowed from:
// https://www.felixlarsen.com/blog/23rd-december-solution-advent-of-code-2020-swift

import Foundation

class Puzzle_2020_23 : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> String {
        return solvePart1(str: Puzzle_Input.puzzleInput, moves: 100)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_Input.puzzleInput)
    }
    
    func solvePart1(str: String, moves: Int) -> String {
        var cups = str.map { Int(String($0))! }
        for moveIndex in 0..<moves {
            let currentIndex = moveIndex % cups.count
            let currentCup = cups[currentIndex]
            var removedCups = [Int]()
            for idx in 1...3 {
                removedCups.append(cups[(currentIndex + idx) % cups.count])
            }
            
            var otherCups = [Int]()
            for idx in 4..<cups.count {
                otherCups.append(cups[(currentIndex + idx) % cups.count])
            }
            
            let lesserCups = otherCups.filter { $0 < currentCup }.sorted()
            let searchValue: Int
            if lesserCups.count > 0 {
                searchValue = lesserCups.last!
            } else {
                let greaterCups = otherCups.filter { $0 > currentCup }.sorted()
                searchValue = greaterCups.last!
            }
            
            let insertIndex = otherCups.firstIndex(of: searchValue)! + 1
            if insertIndex == otherCups.count {
                otherCups.append(contentsOf: removedCups)
            } else {
                otherCups.insert(contentsOf: removedCups, at: insertIndex)
            }
            
            for idx in 1..<cups.count {
                cups[(currentIndex + idx) % cups.count] = otherCups[idx - 1]
            }
        }
        
        let startIndex = cups.firstIndex(of: 1)!
        var retval = ""
        for idx in 1..<cups.count {
            retval += String(cups[(startIndex + idx) % cups.count])
        }
        
        return retval
    }
    
    func solvePart2(str: String) -> Int {
        func runMove(_ currentCup: Node) -> Node {
            var iterator: Node = currentCup.next!
            var pickUp = [Node]()
            for _ in 1...3 {
                pickUp.append(iterator)
                iterator = iterator.next!
            }
            let nextCup = iterator
            var destination = currentCup.value - 1
            var destinationNode: Node? = nil
            while destinationNode == nil {
                if pickUp.contains(where: { $0.value == destination })   {
                    if destination == 1 {
                        destination = maxValue
                    } else {
                        destination -= 1
                    }
                    continue
                } else if destination == 0 {
                    destination = maxValue
                }
                destinationNode = cupsLinkedList[destination]
            }
            let afterNode = destinationNode!.next
            destinationNode!.next = pickUp.first!
            pickUp.last!.next = afterNode
            currentCup.next = nextCup
            return nextCup
        }

        var cups = str.map { Int(String($0))! }

        class Node {
            let value: Int
            var next: Node?
            
            init(value: Int, next: Node? = nil) {
                self.value = value
                self.next = next
            }
        }

        var cupsLinkedList = [Int: Node]()
        let maxValue = 1_000_000
        cups.append(contentsOf: Array(10...maxValue) as [Int])
        cups.forEach { cup in
            cupsLinkedList[cup] = Node(value: cup)
        }
        cups.enumerated().forEach { (i,cup) in
            if i == cups.count - 1 {
                cupsLinkedList[cup]?.next = cupsLinkedList[cups[0]]
            } else {
                cupsLinkedList[cup]?.next = cupsLinkedList[cups[i+1]]
            }
        }
        var currentNode = cupsLinkedList[cups[0]]!

        for _ in 1...10_000_000 {
            (currentNode) = runMove(currentNode)
        }
        
        let node1 = cupsLinkedList[1]!.next!
        let node2 = node1.next!
        return node1.value * node2.value
    }
}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
389125467
"""

    static let puzzleInput = """
583976241
"""

}
