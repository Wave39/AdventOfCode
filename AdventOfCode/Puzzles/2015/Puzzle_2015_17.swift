//
//  Puzzle_2015_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/29/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_17 : PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let storageAmount = 150

        let puzzleInputArray = PuzzleInput.final.parseIntoIntArray()
        let sortedArray = puzzleInputArray.sorted()

        // figure out how many containers maximum need to be considered
        var maxCalcArray: [Int] = []
        var maxCalcIndex = 0
        while maxCalcArray.reduce(0, +) < storageAmount {
            maxCalcArray.append(sortedArray[maxCalcIndex])
            maxCalcIndex += 1
        }

        var maxContainerCount = maxCalcArray.count
        if maxCalcArray.reduce(0, +) > storageAmount {
            maxContainerCount -= 1
        }

        class Tree {
            var progress: Array<Int> = []
            var branches: Array<Tree> = []
        }

        func populateBranches(node: Tree, maxDepth: Int) {
            if node.progress.count == maxDepth {
                // we have reached the maximum depth, just return
                return
            }
            
            let lastIdx = node.progress.last ?? -1;
            
            // figure out which indices have not been used yet
            var unusedContainersArray = Array<Int>()
            for idx in (lastIdx + 1)..<sortedArray.count {
                if !node.progress.contains(idx) {
                    unusedContainersArray.append(idx)
                }
            }
            
            // create new branches for unvisited indices
            for c in unusedContainersArray {
                let newNode = Tree()
                newNode.progress.append(contentsOf: node.progress)
                newNode.progress.append(c)
                node.branches.append(newNode)
            }
            
            for b in node.branches {
                populateBranches(node: b, maxDepth: maxDepth)
            }
        }

        func calculateSumFromIndices(indexArray: [Int]) -> Int {
            var sum = 0
            for idx in indexArray {
                sum += sortedArray[idx]
            }
            
            return sum
        }

        func calculateMatchingCount(tree: Tree, atDepth: Int) -> Int {
            var ctr: Int = 0
            func walkToBranchTips(node: Tree) {
                if node.branches.count == 0 {
                    if calculateSumFromIndices(indexArray: node.progress) == storageAmount && node.progress.count == atDepth {
                        ctr += 1
                    }
                } else {
                    for b in node.branches {
                        walkToBranchTips(node: b)
                    }
                }
            }
            
            walkToBranchTips(node: tree)
            
            return ctr
        }

        var part1MatchingCount = 0
        var part2MatchingCount = 0
        for containerCount in 1...maxContainerCount {
            let rootNode1 = Tree()
            rootNode1.progress = []
            populateBranches(node: rootNode1, maxDepth: containerCount)
            let containerCountSum = calculateMatchingCount(tree: rootNode1, atDepth: containerCount)
            part1MatchingCount += containerCountSum
            if containerCountSum > 0 && part2MatchingCount == 0 {
                part2MatchingCount = containerCountSum
            }
        }

        return (part1MatchingCount, part2MatchingCount)
    }
    
}

fileprivate class PuzzleInput: NSObject {

    static let final = """
43
3
4
10
21
44
4
6
47
41
34
17
17
44
36
31
46
9
27
38
"""

}

