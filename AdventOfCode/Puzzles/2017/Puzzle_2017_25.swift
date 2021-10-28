//
//  Puzzle_2017_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_25: PuzzleBaseClass {

    struct Substep {
        var newValue: Int = 0
        var newDirection: Int = 0
        var continueWith: Int = 0
    }

    struct Step {
        var ifZero: Substep
        var ifOne: Substep
    }

    var steps: [Step] = []
    var tapeArray: [Int] = []
    var stepCount: Int = 0

    func solve() {
        let solution = solvePart1()
        print("Part 1 solution: \(solution)")
    }

    func solvePart1() -> Int {
        let puzzleInput = PuzzleInput.final
        parsePuzzleInput(str: puzzleInput)
        return solvePuzzle()
    }
    
    func parsePuzzleInput(str: String) {
        steps = []
        let lineArray = str.split(separator: "\n")
        stepCount = Int(String(lineArray[0]))!
        var lineIndex = 1
        while lineIndex < lineArray.count {
            let components = lineArray[lineIndex].split(separator: ",")
            let substep0 = Substep(newValue: Int(String(components[0]))!, newDirection: Int(String(components[1]))!, continueWith: Int(String(components[2]))!)
            let substep1 = Substep(newValue: Int(String(components[3]))!, newDirection: Int(String(components[4]))!, continueWith: Int(String(components[5]))!)
            steps.append(Step(ifZero: substep0, ifOne: substep1))
            lineIndex += 1
        }
    }
    
    func solvePuzzle() -> Int {
        let arraySize = 2_000_000
        var cursorPosition = arraySize / 2
        var state = 0
        tapeArray = []
        for _ in 0..<arraySize {
            tapeArray.append(0)
        }
        
        for _ in 0..<stepCount {
            let step = steps[state]
            if tapeArray[cursorPosition] == 1 {
                tapeArray[cursorPosition] = step.ifOne.newValue
                cursorPosition += step.ifOne.newDirection
                state = step.ifOne.continueWith
            } else {
                tapeArray[cursorPosition] = step.ifZero.newValue
                cursorPosition += step.ifZero.newDirection
                state = step.ifZero.continueWith
            }
        }
        
        let onesArray = tapeArray.filter { $0 == 1 }
        return onesArray.count
    }

}

private class PuzzleInput: NSObject {

    static let test1 =
"""
6
1,1,1,0,-1,1
1,-1,0,1,1,0
"""
    
//"""
//Begin in state A.
//Perform a diagnostic checksum after 6 steps.
//
//In state A:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state B.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state B.
//
//In state B:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//"""
    
    static let final =
    
"""
12173597
1,1,1,0,-1,2
1,-1,0,1,1,3
1,1,0,0,-1,4
1,1,0,0,1,1
1,-1,5,1,-1,2
1,1,3,1,1,0
"""
    
//"""
//Begin in state A.
//Perform a diagnostic checksum after 12173597 steps.
//
//In state A:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state B.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state C.
//
//In state B:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state D.
//
//In state C:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the left.
//    - Continue with state E.
//
//In state D:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//  If the current value is 1:
//    - Write the value 0.
//    - Move one slot to the right.
//    - Continue with state B.
//
//In state E:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state F.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the left.
//    - Continue with state C.
//
//In state F:
//  If the current value is 0:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state D.
//  If the current value is 1:
//    - Write the value 1.
//    - Move one slot to the right.
//    - Continue with state A.
//"""
    
}
