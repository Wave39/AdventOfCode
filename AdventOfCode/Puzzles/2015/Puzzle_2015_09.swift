//
//  Puzzle_2015_09.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2015_09: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        let puzzleInputLineArray = PuzzleInput.final.split { $0 == "-" }.map(String.init)

        class Distance {
            var startAt: String = ""
            var endAt: String = ""
            var distance: Int = 0
        }

        class Tree {
            var progress: Array<String> = []
            var branches: Array<Tree> = []
        }

        var distanceArray = Array<Distance>()
        for distanceLine in puzzleInputLineArray {
            let arr = distanceLine.split { $0 == " " }.map(String.init)
            let d = Distance()
            if arr[0] < arr[2] {
                d.startAt = arr[0]
                d.endAt = arr[2]
            } else {
                d.startAt = arr[2]
                d.endAt = arr[0]
            }

            d.distance = arr[4].int
            distanceArray.append(d)
        }

        var placeArray = Array<String>()
        for d in distanceArray {
            if !placeArray.contains(d.startAt) {
                placeArray.append(d.startAt)
            }

            if !placeArray.contains(d.endAt) {
                placeArray.append(d.endAt)
            }
        }

        placeArray.sort()

        func populateBranches(node: Tree) {
            // figure out which places have not been visited yet
            var unvisitedPlacesArray = Array<String>()
            for p in placeArray {
                if !node.progress.contains(p) {
                    unvisitedPlacesArray.append(p)
                }
            }

            if unvisitedPlacesArray.isEmpty {
                // no new places to visit, just leave
                return
            }

            // create new branches for unvisited places
            for p in unvisitedPlacesArray {
                let newNode = Tree()
                newNode.progress.append(contentsOf: node.progress)
                newNode.progress.append(p)
                node.branches.append(newNode)
            }

            for b in node.branches {
                populateBranches(node: b)
            }
        }

        func calculateDistanceBetweenPoints(point1: String, point2: String) -> Int {
            for distance in distanceArray {
                if (point1 == distance.startAt && point2 == distance.endAt) ||
                    (point2 == distance.startAt && point1 == distance.endAt) {
                        return distance.distance
                }
            }

            return 0
        }

        var shortestDistance: Int = 9_999_999_999
        var longestDistance: Int = 0
        func walkToBranchTips(node: Tree) {
            if node.branches.isEmpty {
                var theDistance = 0
                for idx in 0...(node.progress.count - 2) {
                    theDistance += calculateDistanceBetweenPoints(point1: node.progress[idx], point2: node.progress[idx + 1])
                }

                if theDistance < shortestDistance {
                    shortestDistance = theDistance
                }

                if theDistance > longestDistance {
                    longestDistance = theDistance
                }
            } else {
                for b in node.branches {
                    walkToBranchTips(node: b)
                }
            }
        }

        let rootNode = Tree()
        rootNode.progress = []
        populateBranches(node: rootNode)
        walkToBranchTips(node: rootNode)
        return (shortestDistance, longestDistance)
    }
}

private class PuzzleInput: NSObject {
    static let final = "AlphaCentauri to Snowdin = 66-AlphaCentauri to Tambi = 28-AlphaCentauri to Faerun = 60-AlphaCentauri to Norrath = 34-AlphaCentauri to Straylight = 34-AlphaCentauri to Tristram = 3-AlphaCentauri to Arbre = 108-Snowdin to Tambi = 22-Snowdin to Faerun = 12-Snowdin to Norrath = 91-Snowdin to Straylight = 121-Snowdin to Tristram = 111-Snowdin to Arbre = 71-Tambi to Faerun = 39-Tambi to Norrath = 113-Tambi to Straylight = 130-Tambi to Tristram = 35-Tambi to Arbre = 40-Faerun to Norrath = 63-Faerun to Straylight = 21-Faerun to Tristram = 57-Faerun to Arbre = 83-Norrath to Straylight = 9-Norrath to Tristram = 50-Norrath to Arbre = 60-Straylight to Tristram = 27-Straylight to Arbre = 81-Tristram to Arbre = 90"
}
