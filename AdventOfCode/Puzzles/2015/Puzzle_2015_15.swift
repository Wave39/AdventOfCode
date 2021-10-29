//
//  Puzzle_2015_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/28/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_15: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        class Ingredient {
            var name = ""
            var capacity = 0
            var durability = 0
            var flavor = 0
            var texture = 0
            var calories = 0
        }

        var ingredientArray: [Ingredient] = []
        for originalPuzzleLine in puzzleInputLineArray {
            var puzzleLine = originalPuzzleLine.replacingOccurrences(of: ",", with: "")
            puzzleLine = puzzleLine.replacingOccurrences(of: ":", with: "")
            let components = puzzleLine.split { $0 == " " }.map(String.init)
            let i = Ingredient()
            i.name = components[0]
            i.capacity = Int(components[2])!
            i.durability = Int(components[4])!
            i.flavor = Int(components[6])!
            i.texture = Int(components[8])!
            i.calories = Int(components[10])!
            ingredientArray.append(i)
        }

        let teaspoonCount = 100
        let part2CalorieCount = 500
        var highestCookieScorePart1 = 0
        var highestCookieScorePart2 = 0

        func processCookie(measurements: [Int]) {
            var capacity = 0
            var durability = 0
            var flavor = 0
            var texture = 0
            var calories = 0
            for idx in 0..<ingredientArray.count {
                capacity += measurements[idx] * ingredientArray[idx].capacity
                durability += measurements[idx] * ingredientArray[idx].durability
                flavor += measurements[idx] * ingredientArray[idx].flavor
                texture += measurements[idx] * ingredientArray[idx].texture
                calories += measurements[idx] * ingredientArray[idx].calories
            }

            capacity = max(capacity, 0)
            durability = max(durability, 0)
            flavor = max(flavor, 0)
            texture = max(texture, 0)

            let cookieScore = capacity * durability * flavor * texture
            if cookieScore > highestCookieScorePart1 {
                highestCookieScorePart1 = cookieScore
            }

            if calories == part2CalorieCount && cookieScore > highestCookieScorePart2 {
                highestCookieScorePart2 = cookieScore
            }
        }

        func buildArray(node: [Int]) {
            if node.count == ingredientArray.count - 1 {
                let sumSoFar = node.reduce(0, +)
                var newNode = node
                newNode.append(teaspoonCount - sumSoFar)
                processCookie(measurements: newNode)
                return
            }

            let sumSoFar = node.reduce(0, +)
            for i in 0...(teaspoonCount - sumSoFar) {
                var newNode = node
                newNode.append(i)
                buildArray(node: newNode)
            }
        }

        let rootArray: [Int] = []
        buildArray(node: rootArray)

        return (highestCookieScorePart1, highestCookieScorePart2)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
Sprinkles: capacity 5, durability -1, flavor 0, texture 0, calories 5
PeanutButter: capacity -1, durability 3, flavor 0, texture 0, calories 1
Frosting: capacity 0, durability -1, flavor 4, texture 0, calories 6
Sugar: capacity -1, durability 0, flavor 0, texture 2, calories 8
"""
}
