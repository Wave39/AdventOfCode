//
//  Puzzle_2015_13.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/26/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2015_13: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        class HappinessPair {
            var person1: String = ""
            var person2: String = ""
            var happiness: Int = 0
        }

        class Tree {
            var progress: Array<String> = []
            var branches: Array<Tree> = []
        }

        var happinessPairArray = Array<HappinessPair>()
        for puzzleLine in puzzleInputLineArray {
            let arr = puzzleLine.split { $0 == " " }.map(String.init)
            let hp = HappinessPair()
            hp.person1 = arr[0]
            hp.person2 = arr[10].substring(from: 0, to: arr[10].count - 1)
            hp.happiness = arr[3].int
            if arr[2] == "lose" {
                hp.happiness = -hp.happiness
            }

            happinessPairArray.append(hp)
        }

        var personArray = Array<String>()
        for hp in happinessPairArray {
            if !personArray.contains(hp.person1) {
                personArray.append(hp.person1)
            }

            if !personArray.contains(hp.person2) {
                personArray.append(hp.person2)
            }
        }

        func populateBranches(node: Tree) {
            // figure out which people have not been seated yet
            var unseatedPeopleArray = Array<String>()
            for p in personArray {
                if !node.progress.contains(p) {
                    unseatedPeopleArray.append(p)
                }
            }

            if unseatedPeopleArray.isEmpty {
                // no new people to seat, just add in the first person again and leave
                if let firstPerson = node.progress.first {
                    node.progress.append(firstPerson)
                    return
                }
            }

            // create new branches for unvisited places
            for p in unseatedPeopleArray {
                let newNode = Tree()
                newNode.progress.append(contentsOf: node.progress)
                newNode.progress.append(p)
                node.branches.append(newNode)
            }

            for b in node.branches {
                populateBranches(node: b)
            }
        }

        func calculateHappinessBetweenPeople(person1: String, person2: String) -> Int {
            var happiness = 0
            for happinessPair in happinessPairArray {
                if (person1 == happinessPair.person1 && person2 == happinessPair.person2) ||
                    (person2 == happinessPair.person1 && person1 == happinessPair.person2) {
                    happiness += happinessPair.happiness
                }
            }

            return happiness
        }

        func calculateMaxHappiness(tree: Tree) -> Int {
            var maxHappiness: Int = 0
            func walkToBranchTips(node: Tree) {
                if node.branches.isEmpty {
                    var happiness = 0
                    for idx in 0...(node.progress.count - 2) {
                        happiness += calculateHappinessBetweenPeople(person1: node.progress[idx], person2: node.progress[idx + 1])
                    }

                    if happiness > maxHappiness {
                        maxHappiness = happiness
                    }
                } else {
                    for b in node.branches {
                        walkToBranchTips(node: b)
                    }
                }
            }

            walkToBranchTips(node: tree)

            return maxHappiness
        }

        let rootNode1 = Tree()
        rootNode1.progress = []
        populateBranches(node: rootNode1)
        let maxHappiness1 = calculateMaxHappiness(tree: rootNode1)

        let me = "Me"
        for person in personArray {
            let hp = HappinessPair()
            hp.person1 = me
            hp.person2 = person
            hp.happiness = 0
            happinessPairArray.append(hp)
        }

        personArray.append(me)

        let rootNode2 = Tree()
        rootNode2.progress = []
        populateBranches(node: rootNode2)
        let maxHappiness2 = calculateMaxHappiness(tree: rootNode2)

        return (maxHappiness1, maxHappiness2)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 81 happiness units by sitting next to Carol.
Alice would lose 42 happiness units by sitting next to David.
Alice would gain 89 happiness units by sitting next to Eric.
Alice would lose 89 happiness units by sitting next to Frank.
Alice would gain 97 happiness units by sitting next to George.
Alice would lose 94 happiness units by sitting next to Mallory.
Bob would gain 3 happiness units by sitting next to Alice.
Bob would lose 70 happiness units by sitting next to Carol.
Bob would lose 31 happiness units by sitting next to David.
Bob would gain 72 happiness units by sitting next to Eric.
Bob would lose 25 happiness units by sitting next to Frank.
Bob would lose 95 happiness units by sitting next to George.
Bob would gain 11 happiness units by sitting next to Mallory.
Carol would lose 83 happiness units by sitting next to Alice.
Carol would gain 8 happiness units by sitting next to Bob.
Carol would gain 35 happiness units by sitting next to David.
Carol would gain 10 happiness units by sitting next to Eric.
Carol would gain 61 happiness units by sitting next to Frank.
Carol would gain 10 happiness units by sitting next to George.
Carol would gain 29 happiness units by sitting next to Mallory.
David would gain 67 happiness units by sitting next to Alice.
David would gain 25 happiness units by sitting next to Bob.
David would gain 48 happiness units by sitting next to Carol.
David would lose 65 happiness units by sitting next to Eric.
David would gain 8 happiness units by sitting next to Frank.
David would gain 84 happiness units by sitting next to George.
David would gain 9 happiness units by sitting next to Mallory.
Eric would lose 51 happiness units by sitting next to Alice.
Eric would lose 39 happiness units by sitting next to Bob.
Eric would gain 84 happiness units by sitting next to Carol.
Eric would lose 98 happiness units by sitting next to David.
Eric would lose 20 happiness units by sitting next to Frank.
Eric would lose 6 happiness units by sitting next to George.
Eric would gain 60 happiness units by sitting next to Mallory.
Frank would gain 51 happiness units by sitting next to Alice.
Frank would gain 79 happiness units by sitting next to Bob.
Frank would gain 88 happiness units by sitting next to Carol.
Frank would gain 33 happiness units by sitting next to David.
Frank would gain 43 happiness units by sitting next to Eric.
Frank would gain 77 happiness units by sitting next to George.
Frank would lose 3 happiness units by sitting next to Mallory.
George would lose 14 happiness units by sitting next to Alice.
George would lose 12 happiness units by sitting next to Bob.
George would lose 52 happiness units by sitting next to Carol.
George would gain 14 happiness units by sitting next to David.
George would lose 62 happiness units by sitting next to Eric.
George would lose 18 happiness units by sitting next to Frank.
George would lose 17 happiness units by sitting next to Mallory.
Mallory would lose 36 happiness units by sitting next to Alice.
Mallory would gain 76 happiness units by sitting next to Bob.
Mallory would lose 34 happiness units by sitting next to Carol.
Mallory would gain 37 happiness units by sitting next to David.
Mallory would gain 40 happiness units by sitting next to Eric.
Mallory would gain 18 happiness units by sitting next to Frank.
Mallory would gain 7 happiness units by sitting next to George.
"""
}
