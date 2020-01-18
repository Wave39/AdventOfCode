//
//  Puzzle_2017_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_11 : PuzzleBaseClass {

    func solve() {
        let solution = solveBothParts()
        print ("Part 1 solution: \(solution.0)")
        print ("Part 2 solution: \(solution.1)")
    }
    
    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2017_11_Input.puzzleInput
        return solvePuzzle(str: puzzleInput)
    }
    
    func calculateDistance(pAxisSlash: Int, pAxisBackslash: Int, pAxisPipe: Int) -> Int {
        var axisSlash = pAxisSlash
        var axisBackslash = pAxisBackslash
        var axisPipe = pAxisPipe
        
        // reduce the steps
        // ne and s
        while axisSlash < 0 && axisPipe > 0 {
            axisSlash += 1
            axisPipe -= 1
            axisBackslash += 1
        }
        
        // nw and s
        while axisBackslash < 0 && axisPipe > 0 {
            axisBackslash += 1
            axisPipe -= 1
            axisSlash += 1
        }
        
        // se and n
        while axisBackslash > 0 && axisPipe < 0 {
            axisBackslash -= 1
            axisPipe += 1
            axisSlash -= 1
        }
        
        // sw and n
        while axisSlash > 0 && axisPipe < 0 {
            axisSlash -= 1
            axisPipe += 1
            axisBackslash -= 1
        }
        
        // ne and nw
        while axisSlash < 0 && axisBackslash < 0 {
            axisSlash += 1
            axisBackslash += 1
            axisPipe -= 1
        }
        
        // se and sw
        while axisSlash > 0 && axisBackslash > 0 {
            axisSlash -= 1
            axisBackslash -= 1
            axisPipe += 1
        }
        
        return abs(axisSlash) + abs(axisBackslash) + abs(axisPipe)
    }
    
    func solvePuzzle(str: String) -> (Int, Int) {
        var axisBackslash = 0   // \
        var axisSlash = 0       // /
        var axisPipe = 0        // |
        var maxDistance = 0
        let stepArray = str.split(separator: ",")
        for step in stepArray {
            if step == "n" {
                axisPipe -= 1
            } else if step == "nw" {
                axisBackslash -= 1
            } else if step == "ne" {
                axisSlash -= 1
            } else if step == "s" {
                axisPipe += 1
            } else if step == "sw" {
                axisSlash += 1
            } else if step == "se" {
                axisBackslash += 1
            }
            
            let currentDistance = calculateDistance(pAxisSlash: axisSlash, pAxisBackslash: axisBackslash, pAxisPipe: axisPipe)
            if currentDistance > maxDistance {
                maxDistance = currentDistance
            }
        }
        
        return (calculateDistance(pAxisSlash: axisSlash, pAxisBackslash: axisBackslash, pAxisPipe: axisPipe), maxDistance)
    }

}

fileprivate class Puzzle_2017_11_Input: NSObject {

    static let puzzleInput_test1 = "ne,ne,ne"
    static let puzzleInput_test2 = "ne,ne,sw,sw"
    static let puzzleInput_test3 = "ne,ne,s,s"
    static let puzzleInput_test4 = "se,sw,se,sw,sw"

    static let puzzleInput =
    
"""
ne,n,n,nw,nw,nw,nw,sw,nw,nw,s,sw,sw,sw,s,n,sw,s,s,s,s,se,se,s,s,se,s,s,se,se,se,nw,s,se,n,se,s,se,se,se,se,se,se,nw,n,se,nw,ne,ne,ne,se,ne,se,ne,ne,ne,ne,ne,ne,nw,ne,n,ne,sw,s,ne,ne,se,n,n,n,ne,nw,ne,ne,n,n,n,n,n,n,n,n,n,n,n,ne,n,se,n,n,n,n,ne,nw,n,s,n,nw,n,n,n,n,sw,n,n,nw,n,sw,n,nw,n,n,n,nw,sw,n,sw,n,nw,n,n,ne,sw,n,nw,se,sw,sw,nw,n,nw,n,n,nw,n,n,nw,nw,nw,n,nw,n,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,ne,nw,sw,s,sw,nw,nw,nw,nw,nw,sw,sw,ne,sw,sw,nw,sw,nw,sw,n,nw,nw,se,n,nw,nw,n,sw,s,sw,nw,nw,nw,sw,sw,sw,nw,sw,sw,nw,nw,sw,nw,sw,sw,n,sw,sw,sw,nw,s,n,n,nw,sw,n,sw,sw,nw,sw,sw,sw,n,sw,se,sw,sw,sw,nw,se,sw,sw,sw,sw,nw,sw,n,sw,sw,sw,s,sw,sw,s,se,n,se,s,sw,sw,sw,sw,se,s,s,sw,sw,sw,sw,n,sw,sw,sw,sw,s,s,sw,sw,ne,sw,ne,sw,s,sw,sw,sw,s,s,s,sw,s,se,s,ne,s,s,s,ne,sw,s,s,s,s,s,s,s,s,s,ne,s,s,s,s,s,s,s,s,nw,s,s,sw,s,n,s,sw,s,s,s,n,s,s,n,se,s,s,s,s,s,s,s,ne,s,nw,sw,s,s,n,ne,s,s,s,se,n,s,nw,sw,se,s,s,s,s,s,s,ne,s,ne,se,s,s,n,s,n,s,s,s,s,s,s,s,se,n,ne,nw,ne,s,nw,s,s,s,s,nw,nw,se,s,s,se,se,s,s,s,s,s,s,s,se,se,se,nw,s,s,se,s,s,se,se,se,s,se,se,se,s,s,se,s,n,se,ne,s,s,se,se,s,se,sw,sw,se,ne,se,s,se,s,ne,se,se,s,se,se,ne,nw,se,s,se,se,s,se,s,se,s,sw,se,se,s,sw,s,se,se,s,s,se,se,se,nw,se,se,n,s,se,ne,se,se,se,se,se,se,se,se,se,se,n,s,se,se,sw,se,se,sw,ne,se,se,se,se,se,se,se,se,se,se,se,n,n,se,se,se,se,se,se,se,se,se,se,se,ne,se,se,sw,ne,se,se,se,se,se,se,ne,se,se,se,se,ne,se,se,sw,ne,se,sw,ne,ne,n,se,se,ne,se,s,sw,ne,se,se,se,se,se,se,se,ne,se,se,n,ne,ne,sw,sw,ne,s,ne,se,se,se,s,ne,s,sw,se,se,se,se,ne,n,se,nw,se,ne,ne,se,ne,se,se,ne,se,se,ne,nw,ne,se,ne,ne,ne,se,se,se,ne,se,sw,ne,se,nw,se,ne,ne,ne,se,ne,ne,n,nw,ne,ne,ne,ne,ne,ne,ne,ne,se,ne,ne,sw,se,ne,se,ne,sw,ne,n,ne,s,ne,se,ne,ne,ne,se,sw,ne,s,se,sw,ne,ne,ne,ne,ne,ne,ne,ne,se,s,s,sw,ne,ne,ne,ne,nw,ne,ne,se,ne,ne,nw,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,sw,ne,ne,ne,ne,ne,se,ne,ne,ne,ne,ne,se,ne,nw,ne,ne,nw,sw,ne,ne,ne,ne,s,s,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,ne,ne,ne,n,ne,ne,ne,n,nw,ne,ne,n,ne,ne,ne,n,ne,ne,n,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,n,nw,ne,ne,ne,n,n,n,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,n,ne,n,ne,ne,ne,n,n,sw,ne,ne,n,ne,ne,ne,ne,ne,ne,n,se,s,ne,ne,se,nw,s,ne,n,ne,n,ne,n,ne,n,ne,sw,ne,n,ne,n,ne,ne,s,s,se,ne,se,n,ne,se,n,n,ne,ne,nw,ne,n,n,ne,ne,ne,ne,ne,ne,ne,ne,n,n,n,n,ne,ne,n,n,ne,n,sw,n,ne,sw,ne,n,n,ne,s,n,s,n,ne,se,ne,n,s,n,ne,n,ne,n,ne,ne,n,n,ne,nw,n,n,n,ne,se,n,n,n,ne,n,n,ne,ne,ne,n,n,ne,nw,ne,ne,n,n,ne,n,n,s,n,ne,n,ne,n,n,n,n,ne,n,ne,n,n,n,ne,s,sw,sw,ne,n,n,n,n,n,n,n,ne,nw,n,ne,n,n,sw,n,n,n,ne,n,n,n,n,n,ne,n,s,n,ne,n,ne,ne,n,s,n,nw,n,n,s,se,n,n,n,n,n,se,se,n,n,n,n,n,nw,n,se,n,n,n,n,n,se,n,n,n,se,n,se,n,n,n,n,ne,n,n,ne,n,nw,n,n,n,n,n,n,nw,sw,n,nw,n,nw,n,n,n,nw,n,n,n,nw,n,n,ne,sw,n,n,n,nw,se,n,n,n,ne,n,s,n,n,n,ne,nw,se,n,n,n,nw,n,n,n,nw,n,n,n,n,n,sw,n,n,n,n,n,n,se,ne,nw,n,sw,se,n,sw,n,nw,n,n,sw,n,n,nw,ne,n,s,nw,n,n,n,n,s,ne,nw,n,nw,n,n,sw,n,nw,n,n,nw,n,n,nw,n,n,n,s,n,n,n,nw,nw,n,n,n,nw,n,nw,nw,n,nw,se,sw,se,nw,n,n,n,n,nw,n,n,sw,nw,n,nw,nw,n,n,n,nw,n,nw,n,n,n,n,nw,n,n,nw,nw,sw,n,nw,n,nw,n,n,n,s,nw,n,n,nw,ne,sw,n,ne,nw,n,n,n,n,se,nw,nw,n,nw,nw,s,n,nw,nw,nw,n,n,sw,nw,nw,ne,se,nw,nw,s,nw,nw,nw,nw,sw,s,n,nw,nw,n,nw,nw,nw,nw,nw,se,nw,s,nw,nw,n,n,se,n,nw,n,n,n,nw,ne,nw,nw,n,nw,n,nw,n,nw,nw,ne,se,nw,nw,nw,s,nw,sw,n,nw,nw,n,n,se,ne,nw,n,n,s,n,nw,nw,n,nw,n,sw,s,nw,nw,nw,n,ne,nw,nw,n,se,n,nw,s,nw,nw,n,se,n,n,se,n,ne,nw,ne,nw,s,nw,nw,nw,nw,nw,nw,n,n,nw,nw,se,nw,n,n,nw,nw,ne,n,nw,n,s,nw,n,nw,sw,n,nw,nw,nw,nw,n,s,n,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,n,n,ne,nw,nw,nw,nw,n,nw,nw,nw,n,nw,ne,nw,n,nw,n,nw,nw,nw,nw,se,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,s,nw,s,nw,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,se,nw,s,nw,ne,n,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,se,nw,nw,nw,se,nw,nw,nw,nw,se,nw,nw,s,nw,n,ne,nw,nw,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,sw,s,nw,sw,nw,nw,nw,nw,nw,nw,sw,ne,nw,sw,nw,nw,nw,sw,nw,sw,nw,nw,nw,nw,ne,sw,nw,sw,nw,nw,ne,sw,nw,nw,nw,nw,nw,nw,nw,se,se,n,nw,nw,nw,nw,nw,nw,se,nw,sw,sw,nw,nw,sw,nw,nw,sw,nw,nw,nw,sw,nw,nw,nw,nw,n,ne,ne,nw,sw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,sw,nw,nw,sw,sw,nw,nw,sw,nw,nw,n,sw,sw,nw,nw,se,nw,sw,nw,sw,nw,sw,nw,nw,nw,nw,sw,nw,sw,se,ne,ne,nw,se,s,nw,sw,n,nw,nw,nw,nw,nw,nw,sw,nw,nw,nw,nw,sw,s,sw,sw,n,nw,nw,ne,sw,nw,nw,nw,sw,nw,sw,nw,se,nw,ne,nw,nw,nw,n,nw,se,nw,nw,nw,ne,nw,nw,nw,nw,sw,s,sw,nw,nw,sw,se,n,sw,n,sw,nw,sw,sw,sw,nw,nw,nw,sw,nw,nw,n,nw,n,sw,ne,nw,se,nw,nw,nw,nw,nw,sw,nw,sw,nw,nw,nw,sw,s,nw,sw,s,nw,sw,sw,sw,sw,s,n,nw,sw,nw,sw,ne,s,sw,n,nw,nw,nw,nw,nw,nw,sw,sw,nw,nw,sw,sw,sw,nw,nw,sw,sw,ne,n,nw,nw,n,s,nw,nw,sw,se,nw,nw,sw,nw,nw,se,nw,nw,sw,sw,nw,ne,nw,nw,se,nw,sw,sw,nw,ne,sw,nw,nw,sw,nw,sw,nw,sw,nw,sw,sw,sw,sw,nw,sw,nw,sw,s,nw,sw,nw,sw,sw,sw,nw,nw,nw,nw,s,sw,nw,sw,nw,ne,sw,nw,nw,s,nw,sw,nw,sw,sw,sw,se,nw,sw,nw,sw,sw,sw,nw,sw,nw,sw,sw,nw,nw,sw,sw,sw,nw,nw,ne,nw,s,sw,sw,ne,n,sw,sw,nw,n,sw,nw,sw,sw,ne,ne,nw,sw,nw,sw,n,sw,sw,s,sw,sw,s,sw,se,sw,se,sw,sw,sw,nw,sw,sw,sw,se,sw,sw,sw,sw,sw,n,sw,sw,nw,sw,nw,nw,sw,nw,se,s,sw,sw,sw,s,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,nw,ne,sw,sw,nw,sw,s,s,sw,sw,nw,nw,nw,sw,sw,ne,sw,sw,se,sw,sw,nw,nw,se,sw,sw,sw,sw,sw,sw,n,sw,sw,nw,sw,ne,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,n,sw,sw,sw,nw,sw,sw,nw,n,sw,n,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,nw,sw,se,s,sw,se,sw,ne,nw,n,sw,se,sw,se,sw,se,sw,ne,sw,sw,se,n,sw,ne,sw,sw,s,sw,ne,nw,se,s,se,sw,sw,sw,sw,sw,sw,se,sw,s,se,sw,s,sw,sw,sw,se,sw,sw,sw,sw,nw,sw,sw,sw,s,sw,sw,sw,sw,sw,sw,nw,sw,sw,sw,sw,sw,sw,sw,ne,n,sw,nw,sw,ne,se,sw,ne,sw,sw,sw,sw,n,sw,ne,sw,sw,ne,sw,sw,s,sw,ne,s,ne,sw,se,n,ne,s,sw,sw,sw,sw,s,sw,sw,sw,s,sw,s,sw,sw,sw,s,sw,sw,sw,sw,sw,nw,sw,s,sw,sw,s,sw,sw,sw,sw,s,sw,sw,n,n,sw,sw,sw,s,sw,sw,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,sw,s,sw,sw,s,nw,sw,sw,sw,sw,sw,sw,se,sw,sw,s,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,s,s,sw,sw,n,ne,sw,ne,s,nw,n,sw,sw,n,nw,sw,sw,sw,ne,nw,n,sw,sw,ne,ne,s,sw,sw,se,sw,sw,sw,sw,sw,s,s,sw,ne,s,s,s,sw,nw,sw,s,sw,sw,s,s,sw,sw,se,ne,s,s,n,s,s,sw,n,sw,sw,sw,sw,sw,n,s,sw,sw,se,ne,sw,sw,nw,s,sw,s,sw,sw,s,nw,s,n,sw,s,n,s,sw,sw,sw,s,sw,sw,se,nw,sw,sw,se,sw,s,ne,s,sw,s,sw,nw,sw,sw,n,s,s,n,sw,sw,sw,sw,s,se,sw,s,s,sw,sw,s,s,s,s,s,sw,s,s,s,sw,ne,sw,sw,sw,sw,sw,sw,s,sw,nw,sw,sw,s,sw,sw,s,s,sw,s,s,s,s,sw,s,sw,s,nw,s,sw,sw,s,sw,sw,sw,sw,ne,sw,n,sw,s,s,s,sw,sw,sw,n,sw,se,s,sw,s,sw,sw,sw,s,sw,n,nw,se,sw,se,s,s,ne,s,nw,s,s,n,s,sw,sw,sw,sw,s,sw,sw,sw,se,s,s,nw,s,se,sw,sw,s,s,sw,s,s,sw,sw,s,sw,n,nw,sw,sw,sw,sw,s,sw,s,sw,sw,s,s,ne,s,se,sw,sw,s,sw,s,sw,s,sw,s,s,s,s,s,ne,sw,s,sw,nw,sw,s,sw,s,se,ne,nw,s,s,s,n,sw,sw,sw,s,s,sw,n,sw,sw,s,s,s,s,s,nw,sw,s,sw,n,n,s,sw,sw,s,sw,sw,sw,s,sw,n,n,se,s,s,s,sw,se,sw,s,sw,s,se,sw,sw,sw,sw,sw,n,s,sw,nw,ne,sw,s,s,s,se,s,s,sw,sw,ne,s,s,s,s,s,sw,s,sw,sw,n,sw,se,sw,sw,sw,n,sw,s,s,s,s,sw,s,s,s,sw,s,sw,sw,nw,se,sw,s,sw,s,sw,nw,s,sw,se,sw,n,s,nw,s,s,s,sw,sw,sw,s,s,s,s,sw,sw,s,s,s,s,nw,ne,s,sw,s,sw,s,sw,ne,s,s,s,n,n,s,s,nw,s,s,nw,s,s,s,n,s,s,s,sw,s,sw,s,n,s,sw,s,s,sw,s,sw,s,sw,se,s,s,s,s,ne,s,s,sw,s,s,s,sw,n,s,s,s,s,nw,s,s,sw,s,s,sw,sw,se,s,sw,sw,sw,se,se,s,sw,s,nw,ne,sw,s,ne,sw,sw,s,s,s,s,s,s,nw,s,ne,s,sw,s,s,sw,s,sw,s,s,s,s,sw,sw,se,s,se,sw,s,sw,s,s,s,s,s,sw,s,s,s,sw,s,s,sw,sw,s,s,sw,sw,s,n,s,sw,sw,s,s,sw,sw,s,s,s,sw,s,sw,s,sw,s,s,sw,s,s,s,s,sw,s,s,n,s,se,se,s,n,s,s,sw,sw,s,s,s,n,s,s,s,s,s,s,sw,n,s,s,s,ne,s,n,sw,s,s,s,s,s,s,sw,s,s,s,nw,s,sw,s,s,s,s,s,sw,nw,s,s,sw,s,s,s,sw,s,ne,s,s,s,s,s,s,s,s,s,s,se,s,s,s,s,sw,s,s,s,sw,s,s,s,s,s,s,n,s,s,s,s,s,s,s,s,s,s,sw,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,se,s,s,s,s,s,s,ne,s,s,s,s,nw,s,s,se,s,s,s,se,s,s,s,sw,s,s,sw,s,s,s,nw,s,s,ne,s,s,s,ne,s,se,s,s,se,s,s,s,s,ne,s,sw,sw,s,sw,ne,s,nw,s,s,s,s,s,s,s,s,s,s,s,s,se,s,s,s,s,sw,s,sw,s,s,s,s,s,se,s,s,ne,s,sw,sw,s,s,sw,sw,s,s,s,se,se,sw,s,s,ne,s,n,s,ne,nw,s,s,s,s,se,se,s,s,s,s,s,ne,s,s,s,s,ne,s,s,s,s,se,s,s,se,s,s,se,s,s,s,s,s,se,s,nw,n,ne,s,s,s,sw,s,ne,s,sw,s,nw,s,se,s,n,s,s,ne,sw,s,s,s,s,se,s,s,s,nw,s,s,s,s,s,se,s,s,sw,s,s,s,s,s,s,s,s,se,s,s,s,n,n,se,s,se,s,se,s,s,s,s,nw,s,s,s,s,ne,s,s,s,s,s,s,se,s,sw,s,ne,s,nw,s,s,s,s,s,se,s,s,se,se,s,s,se,s,s,s,se,s,sw,sw,s,n,s,s,s,s,s,n,n,s,s,s,s,s,s,s,se,n,s,s,se,ne,nw,s,nw,se,s,n,s,s,s,se,s,ne,se,s,s,s,n,s,nw,ne,sw,se,s,s,s,n,se,s,se,se,s,s,s,se,nw,sw,s,s,se,s,se,s,s,se,se,se,s,se,s,s,s,sw,s,se,s,s,s,s,s,se,s,n,s,s,s,ne,sw,se,sw,s,s,s,s,s,s,nw,se,s,s,nw,se,s,s,s,se,se,n,sw,sw,se,ne,s,n,s,ne,nw,s,n,ne,se,nw,nw,s,s,se,s,s,s,se,sw,se,s,s,se,s,ne,se,se,nw,se,s,s,s,n,s,ne,s,se,s,se,se,s,s,s,se,s,se,n,s,n,s,s,s,se,se,se,sw,se,s,se,sw,se,n,s,s,ne,s,s,se,ne,s,n,se,se,s,s,se,s,s,s,s,s,s,s,se,n,s,s,s,se,n,se,se,s,n,s,s,se,s,sw,se,ne,s,s,s,s,sw,se,s,s,s,s,s,sw,s,ne,se,s,se,s,se,sw,s,se,s,s,se,s,s,s,se,n,n,n,nw,s,s,s,s,sw,nw,se,se,n,sw,se,s,s,ne,sw,s,se,s,nw,s,se,s,se,se,s,se,s,s,s,s,ne,s,s,s,nw,se,se,ne,se,se,se,se,se,s,s,s,s,s,se,s,n,se,se,se,se,se,nw,se,s,s,se,s,s,s,s,s,s,se,se,se,s,se,se,ne,s,n,s,s,s,se,se,s,s,ne,se,s,se,se,se,ne,s,se,s,se,se,s,se,se,s,s,se,ne,s,se,se,se,se,s,se,se,se,sw,se,se,s,se,s,se,se,s,s,se,ne,n,sw,s,s,n,se,nw,s,se,s,se,se,se,se,n,se,s,sw,s,se,s,se,s,nw,se,s,se,s,se,s,se,s,se,se,se,s,se,se,s,se,se,se,nw,sw,sw,s,se,se,se,s,ne,se,nw,ne,ne,s,sw,sw,s,se,se,s,se,se,se,se,s,se,sw,nw,nw,s,se,s,se,s,n,se,se,se,se,s,ne,se,se,se,se,s,sw,nw,sw,s,se,se,s,s,n,se,sw,ne,se,se,n,se,sw,sw,ne,s,s,s,se,se,s,se,sw,s,se,s,se,se,n,s,se,s,nw,se,s,n,nw,se,sw,se,se,se,se,se,se,se,s,s,s,s,se,n,se,s,se,se,s,se,se,se,se,s,s,s,s,s,se,sw,se,se,se,s,se,s,se,se,s,se,se,se,sw,se,s,se,s,s,se,se,n,se,se,s,se,s,se,se,se,s,ne,se,se,s,se,se,ne,nw,sw,se,ne,s,se,se,se,sw,s,s,s,se,se,se,ne,se,s,se,s,s,se,se,n,se,s,se,se,se,s,ne,se,se,sw,s,se,s,se,s,se,se,s,s,sw,se,s,se,se,s,se,s,se,ne,se,se,s,se,se,se,se,ne,se,se,se,s,s,se,s,se,se,se,n,se,se,s,s,se,s,se,se,se,se,nw,se,se,ne,se,se,se,se,se,s,se,se,sw,se,s,s,n,s,se,se,s,nw,s,se,se,se,sw,se,s,se,se,se,se,se,se,nw,se,se,s,se,se,s,s,s,se,sw,n,se,se,ne,s,se,se,sw,se,s,se,se,se,se,s,se,nw,s,se,se,s,sw,ne,se,s,se,se,se,s,se,s,se,se,se,n,se,se,se,s,se,se,se,se,se,se,ne,se,se,nw,se,se,n,se,se,ne,se,se,se,se,se,sw,s,s,se,se,sw,se,n,n,s,se,s,se,se,ne,se,se,ne,se,se,nw,se,n,ne,se,se,sw,se,se,se,se,sw,s,s,se,se,se,n,se,s,n,se,se,se,s,se,s,se,se,se,se,se,se,se,se,se,se,se,se,se,ne,s,se,se,se,se,se,ne,se,se,n,s,se,se,n,se,se,se,se,se,se,se,se,se,s,se,se,se,se,se,se,n,se,se,se,se,se,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,sw,sw,se,nw,se,sw,se,se,se,nw,se,se,se,s,se,se,se,se,ne,se,n,se,se,se,se,se,se,se,sw,se,s,nw,se,se,s,se,se,se,se,s,ne,se,se,se,se,ne,se,se,se,se,se,se,se,se,se,se,s,se,n,se,se,se,se,se,se,se,ne,se,s,se,se,se,se,s,se,se,se,se,sw,se,se,se,se,se,se,nw,se,se,se,nw,se,se,se,se,se,se,sw,se,sw,se,nw,se,se,se,ne,se,se,se,se,se,se,se,s,se,se,s,se,se,se,se,se,se,s,se,s,se,se,se,se,sw,sw,ne,se,ne,se,se,se,se,se,se,se,n,se,se,se,se,se,se,s,se,se,se,se,se,se,ne,se,se,ne,se,sw,se,se,se,se,sw,se,se,se,se,se,se,se,se,se,ne,se,se,se,se,se,se,se,sw,ne,n,ne,nw,se,n,se,ne,se,sw,se,se,se,ne,nw,nw,se,ne,se,se,se,ne,se,ne,se,ne,s,se,se,se,nw,se,se,se,s,ne,s,se,se,nw,se,se,se,sw,ne,se,s,se,se,se,se,nw,nw,se,s,ne,s,ne,se,se,se,s,sw,ne,sw,se,se,se,se,se,se,se,se,ne,se,se,se,sw,se,se,se,ne,se,se,se,se,se,n,se,se,s,se,se,se,se,se,ne,sw,se,ne,se,se,se,se,se,se,se,ne,se,se,se,se,sw,nw,se,ne,ne,ne,ne,se,se,se,se,ne,se,se,n,n,ne,s,ne,se,se,se,ne,se,se,se,se,se,ne,se,n,ne,se,ne,se,n,se,se,se,se,n,ne,se,ne,ne,se,s,sw,se,n,n,se,se,se,se,s,n,se,se,se,nw,se,ne,se,nw,se,n,ne,se,se,se,se,sw,se,se,sw,n,se,ne,se,se,ne,se,se,se,se,se,se,ne,ne,se,n,ne,ne,se,se,se,nw,se,n,se,se,se,se,nw,se,ne,sw,se,ne,se,se,se,se,se,ne,se,se,se,se,n,se,se,se,ne,s,se,ne,sw,nw,se,ne,se,se,se,se,se,sw,sw,ne,se,se,ne,se,ne,se,ne,se,sw,se,n,se,n,s,se,se,se,ne,se,sw,se,nw,se,ne,nw,n,se,sw,se,ne,n,se,se,se,se,ne,ne,ne,se,se,nw,ne,ne,se,se,se,ne,se,se,se,nw,se,s,ne,se,se,nw,ne,ne,ne,se,se,nw,ne,se,se,se,nw,se,s,ne,se,sw,se,se,sw,se,nw,se,s,se,se,se,se,se,se,se,se,sw,se,s,se,se,se,n,se,sw,se,se,se,se,se,sw,ne,ne,se,sw,nw,s,ne,ne,s,ne,ne,se,ne,ne,ne,se,ne,se,ne,ne,ne,nw,se,n,se,n,ne,se,ne,se,ne,ne,ne,se,nw,se,se,n,se,se,se,n,sw,ne,ne,se,ne,se,se,se,se,nw,se,ne,se,s,se,ne,s,se,ne,ne,s,ne,nw,se,nw,ne,se,se,se,n,ne,se,se,se,se,se,s,se,se,se,sw,n,se,se,se,se,ne,ne,ne,ne,ne,ne,ne,se,nw,se,sw,se,se,se,n,se,se,se,se,se,sw,sw,ne,sw,se,ne,ne,n,se,ne,se,ne,ne,se,ne,se,ne,s,se,ne,ne,se,ne,ne,ne,ne,s,n,ne,ne,s,ne,nw,sw,se,ne,s,ne,ne,ne,se,se,se,s,se,se,se,ne,sw,nw,se,ne,se,sw,sw,nw,ne,se,se,ne,s,se,ne,se,se,n,se,ne,se,se,ne,ne,se,se,se,nw,se,nw,se,ne,ne,ne,n,ne,se,s,se,se,ne,se,ne,se,ne,se,ne,n,nw,ne,ne,ne,ne,ne,se,n,nw,sw,se,ne,sw,ne,se,se,ne,nw,ne,se,ne,ne,ne,ne,n,ne,se,sw,ne,se,ne,se,se,n,se,se,se,ne,ne,nw,se,s,se,nw,ne,ne,nw,se,ne,s,se,ne,ne,ne,nw,ne,ne,ne,se,se,sw,sw,se,ne,n,ne,nw,se,se,se,ne,ne,ne,s,sw,ne,se,se,ne,se,se,ne,se,ne,se,se,sw,se,se,se,se,se,n,se,ne,ne,se,nw,ne,sw,se,n,se,ne,nw,se,ne,s,se,ne,ne,sw,ne,ne,se,ne,se,ne,se,ne,ne,ne,se,se,ne,se,se,nw,ne,ne,se,sw,se,se,s,ne,ne,se,se,s,se,n,ne,se,se,nw,nw,se,se,se,ne,ne,ne,ne,n,se,se,se,ne,ne,ne,ne,ne,ne,se,se,se,sw,ne,se,ne,ne,ne,ne,se,se,se,se,nw,sw,ne,ne,ne,s,s,ne,se,se,ne,sw,ne,ne,se,se,se,ne,ne,nw,se,se,se,se,se,se,ne,se,se,se,se,se,se,ne,ne,ne,ne,ne,se,se,n,se,ne,se,nw,se,se,se,ne,ne,ne,se,se,ne,ne,ne,se,se,sw,se,ne,ne,nw,ne,ne,se,ne,sw,ne,se,se,ne,ne,ne,ne,se,se,se,ne,ne,sw,se,nw,se,ne,s,ne,nw,se,ne,ne,se,ne,ne,se,s,ne,ne,se,se,se,se,s,ne,s,se,ne,n,ne,n,ne,s,ne,se,sw,ne,se,se,ne,se,ne,ne,se,se,se,ne,ne,ne,ne,se,nw,se,ne,se,ne,se,sw,ne,se,ne,ne,sw,ne,ne,ne,nw,se,ne,ne,se,se,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,sw,n,se,se,sw,ne,ne,ne,ne,se,ne,ne,se,se,se,ne,s,ne,s,ne,nw,n,s,se,se,ne,ne,ne,s,se,n,ne,n,ne,se,se,ne,se,ne,ne,se,ne,ne,se,nw,ne,ne,n,se,ne,ne,ne,ne,ne,ne,sw,se,ne,ne,nw,ne,ne,ne,se,ne,se,s,se,ne,nw,ne,se,ne,se,s,sw,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,se,ne,ne,n,ne,ne,ne,ne,ne,ne,se,ne,s,ne,se,se,ne,se,n,se,ne,se,ne,s,nw,ne,ne,nw,se,se,se,ne,s,s,n,ne,ne,se,ne,ne,ne,ne,ne,ne,nw,n,se,s,ne,ne,ne,ne,ne,se,ne,ne,ne,se,ne,ne,ne,se,ne,ne,ne,se,ne,ne,ne,ne,ne,ne,ne,sw,ne,se,s,ne,ne,se,s,ne,ne,s,ne,n,n,n,se,ne,ne,ne,se,ne,ne,ne,se,ne,se,ne,se,se,ne,ne,se,ne,ne,ne,ne,ne,ne,sw,s,ne,ne,ne,se,ne,ne,nw,ne,nw,ne,ne,ne,ne,sw,n,ne,se,se,s,se,ne,se,ne,ne,ne,se,sw,ne,ne,ne,s,ne,ne,se,ne,ne,ne,ne,ne,ne,se,n,ne,ne,ne,ne,ne,ne,se,ne,ne,ne,ne,ne,sw,ne,se,ne,ne,ne,ne,ne,ne,ne,ne,ne,se,ne,se,ne,se,ne,se,ne,ne,ne,se,se,ne,ne,ne,ne,se,nw,ne,ne,se,ne,ne,se,ne,n,n,n,ne,ne,se,ne,ne,ne,ne,ne,ne,nw,se,nw,ne,n,ne,nw,ne,s,se,ne,ne,ne,ne,nw,s,ne,ne,ne,ne,se,ne,ne,n,ne,ne,ne,ne,nw,se,ne,ne,ne,n,ne,ne,ne,ne,ne,ne,ne,se,ne,nw,se,ne,ne,n,ne,se,se,nw,s,ne,n,ne,ne,ne,ne,ne,ne,se,ne,ne,sw,ne,ne,se,n,s,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,se,ne,sw,n,s,ne,ne,ne,ne,sw,ne,ne,ne,ne,s,ne,se,ne,ne,se,se,ne,se,se,ne,s,ne,ne,se,s,s,sw,ne,s,se,ne,ne,ne,ne,ne,ne,sw,s,ne,ne,ne,ne,se,ne,ne,ne,ne,ne,n,n,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,ne,sw,n,se,se,ne,se,se,n,ne,se,ne,s,ne,ne,ne,ne,ne,ne,ne,ne,nw,ne,s,sw,ne,ne,ne,ne,ne,sw,ne,sw,n,ne,ne,ne,ne,s,ne,ne,ne,ne,nw,ne,ne,ne,sw,ne,s,ne,ne,ne,ne,ne,ne,ne,sw,ne,ne,ne,ne,s,sw,nw,ne,ne,s,ne,ne,ne,ne,ne,ne,ne,sw,sw,sw,nw,ne,ne,s,s,s,sw,sw,se,sw,s,nw,nw,nw,nw,nw,sw,n,n,ne,nw,n,n,ne,n,n,n,n,se,ne,n,ne,n,se,ne,ne,ne,ne,s,ne,ne,s,ne,ne,ne,se,s,sw,s,se,se,se,ne,ne,se,ne,se,ne,se,se,se,se,se,se,se,se,s,sw,se,s,se,n,nw,nw,ne,nw,se,n,se,se,s,s,ne,s,nw,n,nw,s,se,ne,se,nw,s,s,se,s,s,nw,s,se,se,nw,s,s,s,sw,s,sw,s,nw,sw,s,nw,s,s,nw,s,s,s,ne,ne,s,s,s,s,sw,s,n,sw,sw,sw,sw,sw,s,s,sw,sw,sw,s,sw,sw,sw,sw,se,sw,nw,sw,sw,sw,ne,sw,nw,nw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,se,nw,sw,n,sw,nw,sw,nw,nw,sw,nw,nw,sw,nw,s,sw,n,sw,nw,nw,nw,sw,s,s,nw,nw,sw,sw,sw,nw,nw,nw,sw,se,ne,se,nw,sw,ne,sw,nw,nw,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,se,sw,nw,n,sw,nw,nw,nw,nw,nw,nw,nw,nw,s,nw,n,nw,sw,nw,nw,n,nw,nw,s,ne,nw,nw,ne,nw,nw,nw,nw,nw,n,nw,s,n,nw,nw,n,n,n,nw,nw,n,nw,se,nw,nw,nw,nw,se,n,nw,nw,nw,n,nw,sw,n,n,s,se,nw,ne,n,n,n,n,nw,nw,n,n,n,n,n,n,s,n,sw,nw,nw,nw,ne,n,n,n,n,n,n,n,sw,n,ne,n,n,n,n,n,n,nw,n,se,ne,n,n,n,n,sw,n,n,n,n,n,n,n,s,nw,n,n,n,n,n,n,ne,n,n,n,n,n,n,n,n,n,ne,s,s,n,n,sw,n,se,n,n,s,n,n,ne,ne,ne,n,ne,n,n,ne,ne,ne,n,ne,ne,ne,n,n,nw,n,n,n,ne,ne,sw,n,s,sw,n,n,n,n,n,n,n,n,n,sw,n,n,n,n,n,ne,nw,ne,ne,n,s,n,s,ne,n,ne,n,ne,n,ne,n,ne,n,se,ne,n,ne,nw,n,ne,sw,ne,ne,ne,n,n,ne,ne,ne,sw,nw,ne,se,ne,ne,sw,s,ne,s,ne,ne,ne,ne,ne,ne,ne,n,ne,ne,nw,ne,ne,s,ne,ne,ne,ne,ne,ne,se,sw,ne,ne,ne,ne,ne,n,ne,ne,ne,se,ne,ne,ne,sw,ne,sw,ne,se,ne,ne,ne,ne,ne,ne,ne,ne,sw,ne,ne,ne,se,ne,ne,ne,nw,ne,s,ne,ne,se,se,ne,ne,se,ne,s,se,ne,ne,ne,ne,ne,ne,ne,se,ne,se,ne,ne,ne,se,ne,se,ne,se,se,ne,se,se,ne,se,ne,ne,se,ne,ne,ne,ne,se,se,ne,s,s,ne,ne,se,se,ne,se,ne,s,ne,ne,se,se,ne,se,sw,ne,sw,se,ne,ne,sw,se,ne,ne,se,se,ne,se,se,se,se,se,nw,ne,se,ne,sw,ne,se,se,se,ne,se,se,se,se,ne,nw,ne,se,ne,se,ne,sw,se,se,ne,se,se,se,ne,se,nw,ne,s,se,se,ne,s,se,ne,ne,se,sw,nw,se,sw,n,n,se,se,s,se,s,se,ne,se,se,se,n,se,n,sw,ne,se,se,se,se,nw,se,n,se,se,ne,se,sw,se,n,n,se,s,se,se,n,se,se,nw,se,se,se,se,sw,se,se,se,ne,se,ne,se,se,se,se,se,se,se,se,se,nw,se,se,nw,se,n,se,se,se,se,se,se,se,se,se,sw,se,se,se,se,se,s,s,se,sw,ne,se,se,ne,nw,s,n,ne,s,se,se,se,n,ne,s,se,s,se,se,se,se,se,nw,se,se,nw,se,se,se,s,se,se,se,se,se,se,s,se,sw,ne,s,s,se,se,s,se,se,se,se,nw,se,se,se,nw,se,s,se,se,se,sw,se,se,nw,s,se,s,se,se,se,se,s,s,se,s,se,se,se,n,s,n,sw,s,se,s,s,se,s,se,s,se,se,s,se,sw,s,se,s,s,se,se,s,n,sw,se,s,se,se,se,s,s,se,nw,se,se,sw,se,s,s,se,se,s,s,se,ne,nw,se,s,s,se,s,n,s,ne,s,s,sw,s,s,se,sw,s,s,se,s,s,s,s,s,se,s,s,s,s,se,se,se,s,s,nw,se,s,s,s,s,se,nw,ne,s,se,s,se,s,ne,s,se,s,s,se,se,s,n,se,nw,n,se,s,s,n,se,n,sw,s,n,s,ne,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,se,se,s,ne,s,s,s,s,s,s,se,s,s,n,s,se,s,s,s,sw,s,s,s,s,s,s,s,s,sw,s,nw,nw,ne,s,n,se,s,s,ne,s,s,sw,nw,sw,s,s,nw,s,s,s,s,sw,s,s,s,s,ne,sw,s,sw,s,s,s,s,n,s,s,s,s,s,s,s,nw,s,s,s,s,se,s,s,s,n,s,s,s,s,s,s,se,s,ne,s,nw,nw,s,s,sw,s,nw,s,s,s,s,s,s,s,sw,sw,s,s,s,s,s,s,s,ne,s,s,s,s,sw,s,sw,nw,s,nw,sw,s,n,se,s,sw,s,s,ne,se,s,sw,sw,s,s,s,s,s,s,s,s,s,s,sw,s,s,s,s,sw,s,s,sw,s,s,s,s,s,s,ne,s,sw,sw,sw,s,sw,sw,nw,sw,sw,sw,s,sw,s,s,s,sw,s,s,s,se,s,s,nw,sw,sw,s,sw,s,s,s,s,s,sw,sw,sw,s,sw,sw,s,se,sw,ne,sw,sw,s,n,sw,s,s,s,s,s,s,sw,s,sw,s,sw,sw,nw,sw,se,s,s,s,ne,se,sw,sw,sw,sw,s,s,sw,s,sw,s,sw,sw,sw,n,n,sw,sw,s,sw,sw,sw,s,s,sw,sw,sw,sw,s,sw,s,sw,sw,s,s,sw,s,s,sw,sw,sw,s,sw,sw,sw,s,sw,n,s,nw,s,s,nw,sw,n,sw,sw,n,se,sw,s,se,s,sw,s,s,ne,sw,sw,s,nw,sw,n,se,sw,sw,sw,s,sw,sw,s,sw,sw,sw,nw,sw,sw,n,sw,se,n,sw,sw,s,n,sw,sw,sw,sw,sw,s,s,sw,sw,sw,sw,s,sw,sw,sw,sw,sw,sw,s,sw,s,sw,sw,sw,sw,sw,s,sw,sw,s,sw,s,nw,s,n,sw,s,s,sw,sw,sw,sw,sw,sw,s,sw,s,sw,s,sw,sw,s,sw,nw,s,se,s,sw,n,se,ne,sw,sw,sw,sw,sw,sw,sw,s,sw,sw,sw,s,sw,ne,sw,s,sw,sw,s,sw,ne,s,sw,sw,ne,ne,sw,sw,sw,sw,sw,nw,ne,s,sw,nw,sw,sw,ne,sw,sw,sw,sw,ne,s,sw,sw,sw,sw,sw,se,sw,sw,sw,sw,sw,sw,se,s,sw,sw,sw,sw,sw,se,sw,nw,sw,sw,sw,sw,sw,sw,sw,se,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,se,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,sw,ne,sw,sw,nw,sw,sw,sw,sw,ne,sw,sw,nw,s,sw,sw,sw,n,sw,nw,nw,sw,se,sw,sw,sw,s,nw,ne,sw,sw,sw,sw,sw,s,sw,sw,sw,ne,sw,sw,s,sw,sw,sw,sw,nw,sw,se,nw,sw,nw,sw,sw,s,sw,sw,sw,sw,sw,sw,sw,sw,se,nw,n,sw,nw,sw,sw,sw,nw,sw,n,n,sw,nw,sw,sw,s,sw,sw,sw,n,s,nw,sw,sw,sw,sw,sw,nw,nw,nw,nw,ne,nw,sw,sw,n,se,nw,sw,nw,n,sw,nw,sw,sw,sw,sw,sw,sw,n,sw,sw,sw,nw,sw,sw,sw,sw,nw,nw,n,sw,se,nw,nw,sw,n,se,nw,se,nw,sw,sw,sw,nw,nw,sw,sw,s,sw,sw,nw,nw,sw,nw,sw,sw,nw,sw,sw,sw,sw,nw,sw,nw,sw,s,sw,sw,nw,sw,sw,sw,nw,nw,sw,sw,sw,nw,sw,sw,nw,sw,nw,nw,sw,nw,nw,sw,nw,sw,sw,sw,nw,nw,sw,sw,s,sw,nw,sw,ne,sw,sw,nw,sw,nw,sw,s,sw,nw,nw,se,sw,ne,sw,sw,sw,s,sw,nw,n,sw,n,nw,sw,nw,sw,nw,ne,nw,nw,nw,se,nw,n,nw,sw,sw,nw,nw,nw,sw,sw,nw,nw,ne,sw,sw,nw,sw,sw,nw,nw,sw,sw,sw,sw,s,sw,sw,sw,sw,sw,sw,se,ne,nw,nw,ne,sw,ne,nw,sw,sw,sw,nw,nw,nw,sw,nw,sw,sw,ne,nw,nw,nw,nw,nw,ne,nw,ne,nw,sw,nw,sw,nw,ne,nw,sw,sw,nw,nw,nw,nw,sw,sw,nw,se,ne,nw,se,sw,nw,n,nw,nw,nw,nw,nw,sw,sw,sw,nw,sw,sw,nw,sw,sw,sw,sw,n,n,sw,nw,n,ne,nw,s,sw,sw,nw,nw,nw,sw,nw,nw,nw,nw,nw,sw,sw,nw,nw,sw,s,nw,sw,sw,nw,nw,sw,nw,sw,nw,sw,nw,sw,nw,nw,nw,nw,sw,ne,nw,nw,nw,nw,nw,sw,sw,nw,s,nw,nw,nw,nw,nw,sw,nw,sw,nw,nw,nw,s,nw,nw,sw,sw,nw,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,nw,se,n,nw,sw,nw,sw,sw,nw,sw,nw,sw,ne,nw,nw,s,sw,ne,ne,s,sw,sw,sw,nw,ne,nw,nw,s,nw,nw,nw,n,s,sw,nw,nw,nw,nw,ne,nw,ne,se,nw,sw,nw,s,sw,nw,nw,nw,nw,sw,nw,ne,nw,nw,n,nw,nw,nw,nw,sw,nw,nw,nw,se,s,s,se,nw,nw,nw,nw,nw,ne,nw,sw,n,nw,nw,s,nw,nw,nw,nw,nw,nw,nw,n,nw,ne,ne,nw,nw,se,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,sw,n,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,se,nw,nw,nw,nw,nw,nw,nw,nw,s,n,n,nw,se,nw,nw,nw,nw,ne,nw,n,nw,nw,nw,sw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,sw,nw,nw,nw,n,s,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,nw,n,nw,n,nw,nw,nw,se,sw,n,nw,n,nw,nw,se,se,nw,nw,nw,nw,nw,nw,n,n,ne,sw,nw,nw,nw,n,nw,nw,n,s,nw,nw,nw,ne,nw,nw,nw,nw,nw,nw,nw,n,se,nw,s,n,nw,nw,nw,se,nw,nw,nw,n,nw,nw,n,n,nw,nw,nw,nw,sw,nw,nw,nw,nw,nw,n,nw,nw,n,n,nw,n,nw,se,n,nw,nw,sw,nw,nw,nw,nw,sw,nw,se,n,nw,nw,nw,nw,n,nw,nw,nw,nw,nw,nw,nw,se,nw,nw,nw,se,ne,nw,nw,ne,nw,nw,n,nw,se,nw,n,nw,sw,nw,nw,n,nw,se,n,nw,se,nw,nw,nw,se,n,nw,n,nw,n,n,nw,se,nw,s,nw,nw,se,s,nw,nw,n,nw,nw,nw,nw,nw,n,nw,se,nw,nw,nw,nw,nw,s,nw,nw,nw,nw,nw,nw,se,nw,se,nw,se,nw,n,nw,nw,nw,nw,n,nw,n,nw,nw,nw,nw,nw,s,sw,nw,nw,nw,ne,sw,ne,nw,s,nw,nw,n,nw,sw,nw,se,n,n,nw,nw,se,nw,nw,nw,n,n,nw,ne,nw,n,n,n,n,nw,ne,nw,n,ne,n,n,nw,n,nw,nw,n,s,n,nw,nw,nw,nw,nw,n,nw,n,nw,n,nw,s,n,nw,n,nw,nw,nw,s,sw,s,ne,nw,nw,n,nw,nw,nw,nw,nw,nw,sw,sw,n,n,sw,s,ne,n,n,n,nw,ne,nw,n,nw,se,n,sw,n,n,nw,n,nw,nw,s,nw,nw,n,nw,sw,nw,n,n,nw,nw,nw,n,nw,nw,n,se,nw,n,n,nw,nw,n,nw,n,nw,n,n,nw,nw,nw,nw,n,n,s,nw,sw,n,n,n,n,ne,n,nw,n,n,se,nw,nw,nw,nw,nw,n,n,nw,nw,nw,s,n,n,nw,n,n,nw,nw,nw,nw,nw,nw,s,s,nw,nw,nw,s,sw,nw,s,s,nw,n,nw,n,sw,sw,n,n,nw,n,sw,nw,n,n,nw,nw,nw,nw,n,n,nw,n,nw,n,s,nw,n,n,nw,n,nw,n,nw,nw,nw,n,ne,n,n,nw,n,nw,nw,nw,nw,ne,n,n,ne,nw,se,se,ne,nw,n,nw,n,n,se,n,n,n,n,n,sw,n,nw,n,se,nw,n,n,n,n,se,n,n,n,se,nw,n,se,nw,n,n,nw,n,sw,n,nw,n,n,se,nw,sw,n,n,n,n,n,sw,n,n,n,sw,sw,n,ne,n,n,nw,n,n,n,n,n,n,se,nw,n,n,s,se,n,nw,ne,n,nw,nw,n,nw,n,n,n,n,n,nw,n,n,n,n,nw,nw,n,nw,n,n,n,n,n,nw,nw,n,n,ne,n,n,n,nw,s,sw,n,n,n,n,n,nw,n,n,nw,s,n,n,n,n,n,ne,ne,se,n,nw,n,n,nw,se,nw,n,nw,n,n,nw,n,s,nw,s,n,n,nw,nw,n,nw,n,n,n,n,ne,n,nw,nw,n,n,nw,n,n,n,n,n,nw,n,n,nw,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,n,nw,n,n,n,sw,nw,sw,n,nw,n,sw,nw,n,s,n,n,ne,n,sw,n,ne,nw,n,nw,n,n,n,n,nw,n,n,n,n,n,n,n,n,nw,ne,n,se,n,n,n,n,n,n,n,n,nw,n,n,n,n,nw,n,nw,se,n,sw,ne,n,n,n,n,n,n,n,n,n,nw,n,n,n,n,n,n,n,n,n,nw,n,n,n,n,n,n,n,n,n,se,n,s,nw,ne,n,n,se,n,ne,ne,n,nw,n,n,n,n,ne,ne,n,n,n,nw,ne,s,n,n,n,nw,n,n,se,n,n,sw,sw,n,s,ne,n,sw,se,nw,n,ne,n
"""

}
