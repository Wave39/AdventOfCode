//
//  Puzzle_2017_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_14 : PuzzleBaseClass {

    var elementArray: [Int] = []

    func solve() {
        let solution = solveBothParts()
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }
    
    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2017_14_Input.puzzleInput
        return solvePuzzle(str: puzzleInput)
    }
    
    func reverseElementArray(pos: Int, len: Int) {
        let halfLen = Int(len / 2)
        for idx in 0..<halfLen {
            let idx1 = (pos + idx) % elementArray.count
            let idx2 = (pos + (len - idx - 1)) % elementArray.count
            let t = elementArray[idx1]
            elementArray[idx1] = elementArray[idx2]
            elementArray[idx2] = t
        }
    }
    
    func setUpElementArray(ctr: Int) {
        elementArray = []
        for idx in 0..<ctr {
            elementArray.append(idx)
        }
    }
    
    func calculateKnotHash(str: String) -> String {
        setUpElementArray(ctr: 256)
        var inputLengthArray = str.asciiArray.map { Int($0) }
        inputLengthArray.append(contentsOf: [ 17, 31, 73, 47, 23 ])
        
        var currentPosition = 0
        var skipSize = 0
        for _ in 0..<64 {
            for inputLength in inputLengthArray {
                reverseElementArray(pos: currentPosition, len: inputLength)
                currentPosition += (inputLength + skipSize)
                skipSize += 1
            }
        }
        
        var denseHash: [Int] = []
        for i in 0...15 {
            let idx = i * 16
            var v = elementArray[idx]
            for j in 1...15 {
                v = v ^ elementArray[idx + j]
            }
            
            denseHash.append(v)
        }
        
        var knotHash = ""
        for i in denseHash {
            knotHash += ((i <= 15 ? "0" : "") + String(i, radix: 16))
        }
        
        return knotHash
    }
    
    func printArray(arr: [String], rows: Int, cols: Int) {
        for idx in 0..<rows {
            print (arr[idx].substring(from: 0, to: cols))
        }
    }
    
    func findHash(arr: [String]) -> (Int?, Int?) {
        for y in 0..<arr.count {
            let line = arr[y]
            for x in 0..<line.count {
                if line.substring(from: x, to: (x + 1)) == "#" {
                    return (x, y)
                }
            }
        }
        
        return (nil, nil)
    }
    
    func flagHash(arr: inout [String], pos: (Int, Int)) {
        if arr[pos.1].substring(from: pos.0, to: (pos.0 + 1)) != "#" {
            return
        }
        
        arr[pos.1] = arr[pos.1].replace(index: pos.0, newChar: "O")
        
        // left
        if pos.0 > 0 {
            flagHash(arr: &arr, pos: (pos.0 - 1, pos.1))
        }
        
        // right
        if pos.0 < (arr[pos.1].count - 1) {
            flagHash(arr: &arr, pos: (pos.0 + 1, pos.1))
        }
        
        // up
        if pos.1 > 0 {
            flagHash(arr: &arr, pos: (pos.0, pos.1 - 1))
        }
        
        // down
        if pos.1 < (arr.count - 1) {
            flagHash(arr: &arr, pos: (pos.0, pos.1 + 1))
        }
    }
    
    func solvePuzzle(str: String) -> (Int, Int) {
        var knotHashArray: [String] = []
        var usedCount = 0
        for idx in 0...127 {
            let k = str + "-" + String(idx)
            let knotHash = calculateKnotHash(str: k).convertHexToBinary().convertBinaryToHashesAndDots()
            knotHashArray.append(knotHash)
            let ones = knotHash.filter { $0 == "#" }
            usedCount += ones.count
        }

        var hashPosition = findHash(arr:knotHashArray)
        var regionCounter = 0
        while hashPosition.0 != nil {
            flagHash(arr: &knotHashArray, pos: hashPosition as! (Int, Int))
            regionCounter += 1
            hashPosition = findHash(arr: knotHashArray)
        }

        return (usedCount, regionCounter)
    }
    
}

private class Puzzle_2017_14_Input: NSObject {

    static let puzzleInput_test1 = "flqrgnkx"
    
    static let puzzleInput = "nbysizxe"

}
