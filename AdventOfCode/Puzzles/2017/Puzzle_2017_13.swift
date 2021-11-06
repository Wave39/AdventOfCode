//
//  Puzzle_2017_13.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_13: PuzzleBaseClass {

    struct Layer {
        var maxDepth: Int = 0
        var currentDepth: Int = 0
        var currentDirection: Int = 1
    }

    var layerDictArray: Array<Dictionary<Int, Layer>> = []

    func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2017_13_Input.puzzleInput
        return solvePuzzle(str: puzzleInput)
    }

    func moveScanners(layerDict: inout Dictionary<Int, Layer>) {
        for k in layerDict.keys {
            guard let v = layerDict[k]?.currentDepth,
                  let m = layerDict[k]?.maxDepth else {
                      continue
                  }

            if v == 0 {
                layerDict[k]?.currentDirection = 1
            } else if v == (m - 1) {
                layerDict[k]?.currentDirection = -1
            }

            let newValue = v + (layerDict[k]?.currentDirection ?? 0)
            layerDict[k]?.currentDepth = newValue
        }
    }

    func calculateSeverity(pLayerDict: Dictionary<Int, Layer>, maxLayer: Int, delay: Int) -> Int {
        var currentLayer = 0
        var severity = -1

        while currentLayer <= maxLayer {
            let state = layerDictArray[currentLayer + delay]
            if let layer = state[currentLayer] {
                if layer.currentDepth == 0 {
                    if severity == -1 {
                        severity = 0
                    }

                    severity += (currentLayer * layer.maxDepth)
                }
            }

            currentLayer += 1
        }

        return severity
    }

    func solvePuzzle(str: String) -> (Int, Int) {
        let lineArray = str.split(separator: "\n")
        var layerDict: Dictionary<Int, Layer> = [:]
        var maxLayer = 0
        for line in lineArray {
            let elementArray = line.split(separator: ":")
            let k = elementArray[0].int
            var layer = Layer()
            layer.maxDepth = String(elementArray[1]).trim().int
            layerDict[k] = layer
            if k > maxLayer {
                maxLayer = k
            }
        }

        let upperLimit = 5000000

        // build the layer dictionaries for the first N picoseconds
        for _ in 0...upperLimit {
            layerDictArray.append(layerDict)
            moveScanners(layerDict: &layerDict)
        }

        let part1 = calculateSeverity(pLayerDict: layerDict, maxLayer: maxLayer, delay: 0)

        var part2 = 0
        while calculateSeverity(pLayerDict: layerDict, maxLayer: maxLayer, delay: part2) != -1 && part2 < upperLimit {
            part2 += 1
        }

        return (part1, part2)
    }

}

private class Puzzle_2017_13_Input: NSObject {

    static let puzzleInput_test1 =

"""
0: 3
1: 2
4: 4
6: 4
"""

    static let puzzleInput =

"""
0: 4
1: 2
2: 3
4: 4
6: 6
8: 5
10: 6
12: 6
14: 6
16: 12
18: 8
20: 9
22: 8
24: 8
26: 8
28: 8
30: 12
32: 10
34: 8
36: 12
38: 10
40: 12
42: 12
44: 12
46: 12
48: 12
50: 14
52: 14
54: 12
56: 12
58: 14
60: 14
62: 14
66: 14
68: 14
70: 14
72: 14
74: 14
78: 18
80: 14
82: 14
88: 18
92: 17
"""

}
