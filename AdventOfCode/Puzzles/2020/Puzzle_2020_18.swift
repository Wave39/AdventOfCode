//
//  Puzzle_2020_18.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_18 : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_Input.puzzleInput)
    }
    
    func calculateExpressionResult(arr: [String]) -> Int {
        var retval = Int(arr[0])!
        var addMode = true
        for idx in 1..<arr.count {
            if idx % 2 == 1 {
                addMode = arr[idx] == "+"
            } else {
                if addMode {
                    retval += Int(arr[idx])!
                } else {
                    retval *= Int(arr[idx])!
                }
            }
        }
        
        return retval
    }
    
    func calculateExpressionResultForPart2(arr: [String]) -> Int {
        var newArr = [ arr[0] ]
        for idx in stride(from: 1, to: arr.count - 1, by: 2) {
            if arr[idx] == "+" {
                newArr[newArr.count - 1] = String(Int(newArr.last!)! + Int(arr[idx + 1])!)
            } else {
                newArr.append(arr[idx])
                newArr.append(arr[idx + 1])
            }
        }
        
        return calculateExpressionResult(arr: newArr)
    }
    
    func parseParenthesis(line: String, originalIdx: Int, part2: Bool) -> (Int, Int) {
        var expressionArray: [String] = []
        var idx = originalIdx + 1
        var s = ""
        while line[idx] != ")" {
            let c = line[idx]
            if c == "(" {
                let (newValue, newIdx) = parseParenthesis(line: line, originalIdx: idx, part2: part2)
                expressionArray.append(String(newValue))
                s = ""
                idx = newIdx
            } else if c == "+" {
                s = "+"
            } else if c == "*" {
                s = "*"
            } else if c >= "0" && c <= "9" {
                s += String(c)
            } else {
                if s.count > 0 {
                    expressionArray.append(s)
                }
                
                s = ""
            }
            
            idx += 1
        }
        
        if s.count > 0 {
            expressionArray.append(s)
        }
        
        if part2 {
            return (calculateExpressionResultForPart2(arr: expressionArray), idx)
        } else {
            return (calculateExpressionResult(arr: expressionArray), idx)
        }
    }
    
    func parseLine(line: String, part2: Bool) -> Int {
        var expressionArray: [String] = []
        var idx = 0
        var s = ""
        while idx < line.count {
            let c = line[idx]
            if c == "(" {
                let (newValue, newIdx) = parseParenthesis(line: line, originalIdx: idx, part2: part2)
                expressionArray.append(String(newValue))
                s = ""
                idx = newIdx
            } else if c == "+" {
                s = "+"
            } else if c == "*" {
                s = "*"
            } else if c >= "0" && c <= "9" {
                s += String(c)
            } else {
                if s.count > 0 {
                    expressionArray.append(s)
                }
                
                s = ""
            }
            
            idx += 1
        }
        
        if s.count > 0 {
            expressionArray.append(s)
        }
        
        if part2 {
            return calculateExpressionResultForPart2(arr: expressionArray)
        } else {
            return calculateExpressionResult(arr: expressionArray)
        }
    }
    
    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var retval = 0
        for line in lines {
            retval += parseLine(line: line, part2: false)
        }
        
        return retval
    }
    
    func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var retval = 0
        for line in lines {
            retval += parseLine(line: line, part2: true)
        }
        
        return retval
    }
    
}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
5 + (8 * 3 + 9 + 3 * 4 * 3)
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
1 + (2 * 3) + (4 * (5 + 6))
2 * 3 + (4 * 5)
1 + 2 * 3 + 4 * 5 + 6
"""

    static let puzzleInput_test2 = """
1 + (2 * 3) + (4 * (5 + 6))
"""
    
    static let puzzleInput = """
6 * ((5 * 3 * 2 + 9 * 4) * (8 * 8 + 2 * 3) * 5 * 8) * 2 + (4 + 9 * 5 * 5 + 8) * 4
2 + (3 + 3 + (9 + 3 * 4 * 9) + 2 + 5 * 7) * 7 * (3 * 6 * 5 * 9 + 6) + 6
3 * (7 * 7 + 5 * 2) + 7 * 8 * 9 * 6
9 + 3 * (3 + 3 * 2 + 4) * 2 * (5 + 9 * 9 * (2 + 5 * 2 * 4) * 6)
2 * 3 * (2 + 7 + 3 + 7) + 3 + 7
(4 + (4 + 7 * 6 * 5) + 6) + (3 * 2 + 2) + 3 + (8 * 5 * 6) + 9
(2 + 3 + (8 + 9 + 4 * 8) * (5 * 3 * 7 + 9 * 5 * 8) + 6) * 9 + 6
(4 + (6 * 5) + 4 + 7 + 7) + (2 + 3) * 2
2 + 9 + 7 + (8 + 7 + 2 * 4 * 8 + 2) + (3 + 5 * 5 * (7 * 7 * 2 * 7)) + ((6 * 6 + 7 + 9 * 9 * 7) + 4 + 3)
7 + ((8 + 4) + (4 + 9 + 9) + 3 + 3) + 7
9 + 9 * 6 + 6
(7 * 7 * 7 * 3 + 2) * 5 * 7
3 + 6 + ((9 * 6 * 7 + 9 + 8 * 6) * 5 * 5 * (8 * 6 * 9 + 6)) * 8 * 9 + 8
4 + (7 * 7 + 9 * (5 + 4 * 3 * 4 + 6 + 7) * 6 * 2)
3 + 5 * (4 * 8) * 9 * (2 * 5 * (5 + 9 + 5 * 8 + 6 + 6)) * 5
3 + (8 + 2 * 6 * 7 + 5) + (2 * 2 + 5 * 8) + 6 * 9
((9 * 5 + 9 + 5 + 8 * 2) * 5) + (7 + 6 * 2 + (5 * 9 * 9) * 3) * 5 * 4 * 9
9 * 9 * (3 + 6 + 4 * (3 + 3 + 7 * 6 + 4 * 6)) + 2
4 + 5
8 * (3 + 3) * 9 * ((9 + 2 * 2) * 3 * 8 + 7) + 7 * 3
(5 * 7 + 5 * 9 + 7) * 5 + 5 * 3 * 8 * 6
(6 + 7 + 6 + 8 * (6 * 8)) * 8
4 + 3 + (7 * 7 * 2)
(8 * 7 * (7 * 2 * 2 * 8)) + 4
4 * (4 + 6 + 7 * 2 * (6 + 6 + 3 + 6 * 2 * 5)) * 9 + 7 + 6 + 8
9 * 8 + (7 * (8 * 7 * 4 + 8 * 6 + 2) + 7 * 9) + 8 + 2
(9 + 7 * 8 * 8 * (7 * 4 * 7 * 2 * 6 + 2) + 6) * (2 + (2 + 2 + 2 * 5 + 5 * 9) + 5 + 8 + 6)
4 + 2 * 7 * (9 + 8 + 3 + 9 * 4 + (8 + 7 * 6 + 7)) + 4
7 * 9 * 8 * (5 * 4 + 8 + 2 + 2 + 4) * 5
4 * 4 * (5 * (6 * 2 + 9)) + 5 * 3
2 + 2 * (5 + (9 * 7 * 8 * 9 * 8 * 2) * 6 * (4 + 6 + 6 + 6)) + (3 + 9 + 6 * 2)
2 + ((3 * 4) + 2) * 9 * 4 + 4 * 3
(4 + 2 + (5 * 6 * 2 + 7 + 8 * 2)) * 6 * 8 * (2 + 3 * 2 * 8)
9 * 2 + (5 * 7 + (3 * 9 + 2 + 2 + 5)) + 8
4 * 9 * 7 + ((5 * 4 + 6 * 3 + 3) * (8 * 6 * 3 + 9 * 8 + 7))
4 + (9 * 7 + 4 + 6 + 5 * 2)
7 + 4 * 9 * ((8 + 8 + 8 * 6) * (5 + 2 * 2 * 5 + 8 * 5) + 5 + (8 + 4 * 2 * 5 + 6) + 6)
(7 + (2 + 7 + 8 + 4 + 9 + 4) + 9 * 4 + 5 * 5) + 6 + ((7 + 7 * 5 + 3 * 3 + 3) * 6)
((4 + 7 * 9 + 5 * 4 + 8) * (7 * 9 * 3) + 7) + (5 * 2)
9 * (8 * 8 * 2) * 2 * 5 * 4 + 6
9 + ((9 + 5 + 9) + 2 + 4 + 8) * 3
3 + (2 + 5)
9 + (2 + 4 + 4 * 9 + (7 * 2 + 3 * 8 + 3 * 2) + (4 * 6 * 9 + 7)) + 7
(7 + 6) * (4 * 5 * 4)
(9 * 2 * 7 + (7 * 3 + 4 + 6 * 3 + 9) + (9 + 6)) + 4 + 8
5 * ((6 * 2) * (9 + 7 + 7 + 2)) * (3 + 9 * 6 + 2 * 3) + 4 + 7
6 + (9 + (8 + 6 * 4 + 7)) + 2 * 8 * 7
4 + (8 + 4 * 5 * (2 + 2 * 4) + 7) * 2
3 * 5 * 2 + 4 * 6 + 9
(7 + (2 * 7 * 4 + 5)) * 4
6 + 5 + ((7 + 6 * 4 + 7 + 5 * 5) * 5) * 8
7 * 3 + 4 + 9 * (7 + (9 * 5 * 7 * 3 + 8 * 2)) + 6
(6 * (2 + 8 * 2 + 2) * 2 * (5 * 7)) + 8 + (4 + 4 * 7 + 8 + 8 + 9) * (6 + 7)
6 * (2 * 6 + 6 * 3 + 5 + 8) + 6 + 3
8 * (8 * 3 + 9 * 7) * 7
6 * 7 + 8 * (8 * 9 + (5 + 8 * 5 + 6) * 6 * 2) + 7 * 3
((9 * 4 * 4) + 4 * 2) + 3 + (9 + 3 + 8) * 3 * 2
7 + (2 * 4 * (2 * 6 + 8) * 8) + 8 * 5
6 * 4 * 5 * 8 * (9 * 8)
6 * (6 * 3 * 9 * (2 + 3 + 2))
3 * 9 + 6 + 5
2 * (7 + 8 + 9 * 9 * 7) + 4 * 6 * ((8 * 3 * 2 * 3 + 9 + 9) + 3 * (8 * 5 + 3 * 5 + 7 + 9))
6 + 9 * 7 * 8 + (9 + 5 + 8 * 4 + 4 * 8)
6 * 5 + 2 + (4 + (8 + 7 * 6 * 9 * 2 * 3) * (8 * 6 * 4) + 5 * (7 * 8) * 2) * 9 * 2
4 + (3 + 8 * (2 * 8 + 9 * 6) * 6)
((3 + 7) * 9 * 9 + 9) * 7
2 * 9 * (4 * 9 * (9 * 8 + 6 * 5) + 3)
7 + 4 + 3 + 7 + (8 + 4 * 8 + 8 + 8) * 8
6 * (7 * 6 * (2 + 8 + 9 + 4) * (8 * 2) * 4 + (7 * 9 * 3 * 3 + 2 * 6)) * 6 + 8 + 5
6 * 6 + 8 + 7
3 * ((8 + 6) * 4 * (8 + 7 * 7 * 7) + 8 * 7 * 5) * ((9 + 9 + 3 + 7 + 4) * 7 + 4)
4 * 4 + 5 + 5 + 7
4 + (6 + 4 + 9)
7 * 3 + (5 * 6 + (5 * 3 + 7 + 2)) * 9
4 * ((2 * 4) * 6 + 8) + 6 * 5 + (8 * 9)
2 * (3 * 4) + 2 + 2
(2 * 4 * 5 + 2 + 4 * 5) + 5 + 3 * 6
9 * 2 * 6 + 3 + (3 + 8) * (6 * 4 + 2)
9 * 6 * 4 + (9 * 8 * 5 * 6 + (5 * 6)) + 9 * 7
9 + 2 * 6 * (9 + 3 + (5 + 2 + 3 + 8 * 2 * 6) * 9) * 7 + 9
8 + (7 * 2 + (3 + 6) * (6 + 6 + 8)) + 8 * 5 + 4
3 * (3 * 2 + 5 * 4 + (8 * 3 * 5) + (6 * 5 * 8 + 7 * 4 * 5)) + 6 * 6
6 + 7 + 7 + 2 + (2 + (4 * 3) + 3 + 8)
((2 + 3 + 2) * 9 + 2 * 4 * 7 + 9) * 8 + 7 * 4 + 3 + 2
(5 + (7 + 9 * 3 * 6 + 5 + 8) * 2) * 7
3 + 3 * 3 + (6 + 7 * 3 * 2 * 5 * 7) + (4 * 6 * 5 + 3 * (3 + 6 + 5 + 5) + 8)
4 * 5 + 8 + (5 + 6) + (4 + 2 * 2 + 4)
5 * 6 * 8 * (3 * 2 + 7 + (4 * 8 * 3) * 3 + 3)
5 + 8 * 6 * 4 * (2 * 4 + (3 + 6 + 9 * 6 * 2 * 6) * 9 + 3 + 9) + 9
(6 + (4 + 5 * 8) + 8 * 9) + 7 * 2
(5 + 2 * 3 * 3 * 2 * 8) + 3 + 2 + (7 + 4) + 4
(9 * 8 * 2) * 2 + 2
8 * 6 + 3
6 + 9 * (9 + 2) + (7 + 7 + (5 * 9 * 4) + (2 * 6)) + 5
5 + 7 * 7 * (7 + 8 * (7 * 9 + 2 * 6 + 9) + 3) * 6
2 + (5 * 3 + 7 * 5 * 3 * 3) + 6
4 + 9 * 8 * (4 * 8) + (3 + 5) * (8 * 5 + 6 + 9)
(5 * 6 + (7 + 3)) + 3 + 9 + 7 + 7
(8 * 5 + (3 + 6 * 2 + 3) * 8 + (7 * 3 + 7 * 4 + 9) + 9) + 7 + (8 + 2 + (7 * 7 * 3) * (4 * 5 + 4 * 9 * 8)) * 5 * (3 + 8 * 4)
2 * 5 + (6 + 8 + 8 * 7 * 7 + (7 + 3 + 9 * 6 + 7))
2 * 3 * ((7 + 6) + 8 + 6 * (4 * 3 * 7) * 7) + 3 * 9 * (8 + (2 + 9 + 9))
8 * 8 * (3 + 8 * 3 * 5 * 5 + 3)
(7 * 4 + 7 * 6 * 6 * (2 * 6 + 7)) * 3
8 * (3 * (5 + 8 * 8 + 7 + 2)) + 8
4 + (7 * (9 * 2 + 2 * 7) * 7 + 4 + 9 * 4) + 3
5 + 3 + 5 + 2 * ((9 * 9 + 2 * 3) + 2 * (3 * 8 + 8 * 7 * 6 + 7) + 9 + 5)
5 * 5 + 9 * (4 * 9 * 9 * 3) + 9 + (7 + 9 * 8 * 2)
7 * 7 + (7 + 2 * (9 + 6 * 3 + 2 + 3) + (2 * 6) + 6) * 2 * 5
(7 * (2 + 6 + 2 + 9) * 7) + (8 * 2 + 4 + 6 * 2 + 3) + 3
3 + 3 * 6 * ((3 * 5) * (8 * 6 + 4)) + ((9 + 2 + 5) + (4 + 2 + 2 * 3 + 5 + 6) + 7 + 5 + 6) + 5
5 * 9 + 9
(5 + 3 + (4 + 4) + 7 + 7 * 9) * ((7 + 7) * 5 * 7)
7 * ((7 + 5) * 2 * 7) * 7
9 * ((6 + 4) * (6 * 5 * 8 + 6 * 2 * 3)) * 8 + 5
3 + 2 + 5 * 5 + (8 + (8 * 2 + 9 * 7 * 4)) * 2
(6 + 2 * 5 + 3) + 9 * (5 * 6 + (7 * 6 + 8 + 4 + 8) + 8 + 8)
(3 + (3 * 4 * 8 * 3 + 6 + 8) + 9 + 8 + (3 * 9 * 9 + 4 * 8 + 9) + (7 + 6 + 9 + 6)) + 8 + 5 + 2 * 7
6 * (7 + (2 + 5 + 5 * 6 + 4) * 6 * (2 * 5 * 7 * 4 * 7 * 4)) * 9 * 2
3 * (7 * 4 + 7 + 9) + ((4 * 4 * 2 * 8) + 9 + 6 * 9 * (9 + 9 + 2 * 2) * 5) + 5 * 6 + 9
6 + (4 * 5 + 8 * 8 * 9)
((9 * 2) * 2 * (4 * 8 + 4 * 8) + 6 + 6) * 2
(5 * (3 * 2 * 2 + 4 + 4) + 6 * (8 + 6 * 3 + 6)) * (3 * 7 * (5 * 9 * 7 + 5 * 6 * 2) + 6) + 2 + 8 * ((9 + 5 + 4 + 8 * 5 * 4) + 3) * 5
8 * 4 + 8 + 6 * ((4 * 3 + 5 * 6 + 5) * 2) * 3
3 * (2 * 8 * 8 * 7 * (2 + 7) + 8)
(9 * 8 * (4 + 8 * 3 * 7 * 6 + 8)) + 7
9 * ((6 * 5 + 6 * 5 * 2 * 2) + (8 + 6 + 3 + 4) + 6)
2 * (8 * (5 + 9 * 4 * 5) + 9 * (5 + 5 + 8 * 4) + 8 * 5) + 4 * 3 + 3
(9 + 3 + 9) * (7 + 9 + 7 + 4 + (3 + 4)) * 2
(9 + 7 + 8 * 5) + 3 * 4 * 2 + 3 * 6
(7 + 3 + 3 + 2 * 9) + (6 + 6 + (7 + 4 * 5) + 6 + 3) * 8
5 * 7 * 9 + (6 * 9 * 7 * (3 + 4) + 4 + 6)
(3 + 4 + (8 + 5 * 6) * 9 * 6) * 6 * (8 + 7 * 8) * 3 + 2 * 5
7 + (8 + (3 * 4) + (4 + 9 + 9 * 7 + 4) + (2 * 2 + 7) * (6 * 9)) + (9 * (7 * 4 + 5 + 2 * 3) + 3 + 7) + 8 + 2 + 7
(6 + 8 + 4 * 8 + 9 + 2) * 3 + 4
3 + 7 * (4 * 3 + 2 + 3)
(5 + 8 * (8 + 2 + 3 * 9) + 9 * 7 + 2) * 8 * 7 + 3 + 5
(6 * 2 + 4) + 4
6 * (2 + (5 + 2 + 9 + 8 * 7 + 6) + 7) + 4 * 7 * 4
4 * 6 * ((9 * 2 * 6 * 4 * 2) * 5) + 9
(9 * (3 * 2 + 5 + 9 + 3 * 6) + 5 * 5) + 5 * 3 * 6
(9 * (3 + 6 + 2 * 4 + 8 + 2) * 8) * 9 * 2 * 3
2 + 6 + (7 + 9 + 7 + (6 + 5 * 8 + 3 + 7) + 8) + 3
(4 * 6 * 3) + (6 * 9 + 3 + (3 * 8 + 9 * 9 + 5 + 8) * 8 * 7) + 4
7 * 9 + ((8 + 8 * 2) * 7 + 5 * 2 * 8) + 8 + 9 * 6
3 + ((6 + 9 + 9 * 8 * 5 + 6) * 3) + 4 + (3 + 5 * (6 * 8 * 7 + 5 * 3) * 2 * 7) + (9 * 5)
3 + 6 + (5 + 2) * 6 * 8
(4 + 4 + (8 * 6 * 5 + 5 + 9 * 9) + (7 * 3) + 9) * 7
3 * 5 * 8 * 9 + 4
7 * ((3 + 2) * 9 * (4 * 4 + 5 + 7) * 7)
7 * 5 + 8 * ((8 + 3 + 5 + 3 + 4) + (6 * 7 + 6) + (3 * 9 * 7 + 6 * 6) * (7 * 7 + 9 + 9 * 9)) * 7 + ((3 * 9 + 7 + 6) * 5)
(9 * 5) * 6 + (7 * (3 * 6) * (8 + 6) * 8 + 6)
3 * 5 * 2 * 8 * (5 + 6 + 6) + (9 + 2 * 5 + 4 + 4 + 9)
(2 * 8 * 5 + 5) * 4
7 * (9 * (4 + 4 * 6) * 5) * 5 * 4 + 5 * 7
(6 + 2 + 2 + 4) + 4 * 9 * (6 + 3 * 4 * 9) + 2 * 8
6 + 9 + 9 + (5 + (5 * 3 + 7 * 9 * 3) * 7 + 8 + 3) + 4
(5 * 9 * 7 + 8) + 2 * 7 * 2 * 8
4 + 2 * 5 * 2 * 3 + 7
5 + 6 * 2 + (3 + 2 + 8 * (3 * 6 * 5 * 2 * 2)) + ((8 * 3) + (2 * 9 + 4 + 9 + 7 * 5) + 4 * 9 + (6 + 7 + 5 + 4) + (9 * 8 + 2 + 9 + 2))
((8 * 5 + 6 + 9 * 4 * 6) + 2 + (8 + 9) + 3) + 2 * 2 + (4 + 6 * 9 * 4) + 2 * (3 + 3)
2 + (3 + 3) * (2 * (4 + 4 + 2 * 9) + 9 + 9 + 8 * 9)
3 + (7 * 4 + 5 * (4 * 9) + (7 * 5 * 4 + 7 * 7 + 6)) + 8
5 * 5 * (6 * 3 * 9) * 9 + 6 * 7
9 + 5 * (7 * (2 + 8) + 6) + 8
3 + 3 * (8 + 2) * 2
5 * (8 * 7 + (9 + 4 * 7 + 7 + 2) + (4 + 3 + 5 * 2) * 5 * 5) * 2 * 6
4 + (5 * 5 * 2 * (3 * 5 + 5 * 5) * 5) * 7
5 + (7 * (9 * 3 + 9 * 3 + 5 * 8) * 9 * 3 * 5 * 7) * 7 + (6 + 4 * 8) + 9 * 2
6 * 7 + 4 + (2 + 2 * 4 + 9 * 4 + (5 * 5 + 4 * 5 * 6))
2 + (4 + 3 * (6 * 4 + 2 * 4) * 5 + 8 * 6) + (6 * (9 * 4) + 5 + 4 * 7)
4 + 6 + 6 + (5 + 3 * (3 + 4 * 8) + 9)
7 + 7 + 5 + 8 + ((2 + 2 + 5 + 2 * 5) * 3 * 8 * 9)
3 * (5 + 4 + 3) * (4 + 2 * 5 + 8) * 6 + (4 * 9 + 2 + 6) * 5
(9 + 7 * 9 * 2 * 7) * 7 + 2 + 4 + 8 * (7 * 9 + 9 + 8)
(7 * 7 * 5 + 4 + 3) + 9 * 8 + 9 + 4
(2 * 3 * 8 + 6 * 6 * 7) * (7 * 5 * (8 + 6 * 3 * 4 * 7 * 8)) * 3 * (7 * 4 * 7 * 8)
((4 * 5 + 4) + 8 * 3 + (9 * 9 * 4)) * (7 * 9)
6 * (4 * 9 * 9) * (5 + (5 * 8 * 3 + 3) * 9) * 8 * 3 + 6
(4 + 8 + 9 * 7 * 7) * 5 + (2 + 9 + 5 + 5) + 3 * 7
2 * 6 + 8 * (2 * 6 * 8)
5 + 7 * 2 + 7 + (3 * (7 * 9 + 7) + (9 + 3 * 5 * 9 * 5 + 7) + 8 * 5)
8 + 3 * 9 * 6 + 9 * 2
5 + (6 + (7 + 5 * 4 * 4) + 6)
(3 + 9 + 9 * (6 * 3 * 8 * 9 + 4)) + 2 + 9 * 3 * 8
(2 * (9 + 3 * 8 + 9 + 7) + 4 * 6 * 7) + (9 + 4 * (2 * 8 * 2 + 3 + 6) * (5 * 2) + (6 + 4 + 6 + 5 * 3 * 9) + 8) * (8 * 2 + 9 * 6 * 8) + 6
4 + (4 + (7 + 9) * (7 * 7 * 6 + 3 * 8) + 6 + 9) * 5 * (5 + 9 + (6 * 8 * 8 * 2 * 2 + 6) + 3 + 6 * (4 + 7 * 7))
4 + 8 + 9 + 3
9 * 7 + 9 * 3 * ((8 * 7 * 4 * 5) * 6 * (6 + 6 + 4 + 8 + 4 + 6) * 9 * 6 * (2 * 5 * 8)) + 6
(3 + 8 * 6 + 8 * 9) + 2
7 + 8 + 5 + 3 + 6
2 + 4 + 4 * 4
((8 * 8 * 9 * 4 * 8) + (4 + 6 + 7 * 2 * 4 + 6) + 9) * 4 * 6 * 7
9 * (6 + (3 + 5 + 9 * 6) + 9 * (2 * 2 * 9) * (8 + 5 * 4 + 4 * 2)) * 9 * 6 * 2
4 + 9 + 2 + 6 + 5 * (7 * 3 + 7 * 6 * 7 * 4)
5 + 9 * 6 + (6 * 6 + 8) * (6 * 3 * 3 * 7 * 5)
8 + 9 + (7 + 3 + 4 * 9) + 7
2 + ((5 * 9 + 7 + 4 * 6) * 5 * 3) + 5 * 9 * ((5 * 7 * 2) + 4 + 5 + 4) * 5
8 + (2 * (4 * 3 + 2 * 7 * 6) + 5 * 6) + (7 + 3 + 8 * 9)
3 + (7 * 3 + 6) + (3 * (7 * 5 + 5 * 3 * 7)) + 9 + 6
8 * 9
3 * 3
6 * 7 + 6 + 2 + 6 + (5 + (3 + 4 * 9 * 2 + 9) + 9 + 9 * 3 + 7)
4 * ((4 * 3 + 8 * 3 * 7 + 9) + 3) * (5 + 9 * 6 + (6 + 7)) + 2 + 6 * 7
(2 * 8 + 9 + 2 + 4 + 6) + ((3 + 3 * 7 + 7 + 2 * 9) * 4 + 9)
3 + 4 * 8 + 7 * (3 * 5 + (5 * 6) * 3)
5 * ((2 + 9 * 5 + 3 + 8 * 9) * 8 * 2 + 7 + 5 * 5) + 7 + (7 * 6 * 4 * 2 + 5) * 2
2 * 3 + 2 * 4 * 6 + 2
3 * 4 * 6 + 7 * (4 * (5 * 7 + 8 * 2) * 4 + 5 * 6 + (2 * 2 * 2))
(6 + 5 + (8 + 4 + 2 * 5 + 5 + 4)) + ((8 + 8) + 6 + (4 + 6)) + 7 * (3 + 2 + 9 + 2 * 9) + 8
2 * 6 * 3 + 6 * (4 + (4 + 4 + 7 + 8 + 9) * 8 * (4 + 8 * 4 + 5 + 9) * 7) * 3
8 * 8 + 8 + 3 * 7
4 + 9 * ((9 * 3 + 7 * 2) * 8) * (7 + 5 * 9)
6 + 2 * (7 + (9 + 3 * 4 + 8 * 2) + 7)
4 * 5 + 6 + 6 + 6 * (4 * 8 + 7)
(8 * 2) * (4 * 4 * (8 + 3 * 3 + 8 * 8) * 6 * 4)
2 + (9 + 4 * 7 + 9 * 2 + 8) + 8 + 5 + (4 * 2)
((5 * 3) + 3 * 8 + 9) * (9 * 8) * 3
((9 + 4 * 5 + 8 + 5) * (7 * 4 * 9 + 4 + 7 + 8) * 4 + 9) + 4
3 * (2 * 2 + 9 * (2 + 5 + 6 + 4) * 4) + 6 + ((8 * 3 + 6 + 9) * 5 + 4) + 6 * (9 + (2 + 3 + 8) + (3 + 7 * 3 * 3 * 4 + 8) + 4)
((9 * 2 + 3 * 6) + 2 + 7) + 7 + ((5 + 3 * 4 * 2 + 7 * 9) * 9 + 7 * 2) + (3 + 9 + 5)
2 * 3 + 2 * (2 + 7 * 2 + 3) * 6 * 7
(9 * (4 * 7 * 8 + 9 * 5 + 6) + 6 * 5 + 9) * (6 + 8 + 6 * 9 + 8 + 9) * 9 + 2 + 2
7 + (2 * 4 + 4) * 3 + 8
2 * 6 + ((8 * 7 * 2 * 3 * 5 * 3) + 5 + 5 + 4 * (6 * 7 * 9 + 5) * 7) + 2
8 + (8 + 6 + 8 * 2) * (2 * 9 + 5 + 2)
8 + (8 + (4 + 3 * 6)) * 6 * 6
5 + 5 + (4 + 2 * 8) + 9 * 5
(8 + 6 * 9 * 7 * 9) * (7 * 3) * 8 + 4 + 6
((5 + 4 + 3) * (5 * 4 + 9 * 2 + 9) * 4 * 2 * 3) + 3 + 6
(7 + 9 * 5 + 5) + (8 * 3 * 3 * (6 * 3 + 8 * 6 * 9 + 5)) * 5 + (2 * 8 * 2 * 8)
6 + (9 * 6 + 7 * (3 * 3 + 2) + 4 * 4)
(9 + 4 * (2 * 4) * 5) + 9 * 7 * 7
(7 + 6 + 4 + 6 * 8) * 7 * 3 + (4 * 9) + 3 + 5
6 + 7 + 4 + 7 * 6 * (3 + 5 * (5 + 4 * 9 + 5 + 6) * 7 + 9)
((8 * 5 * 3) + 5 + 3 * 8 + 3) + (7 + 6 * 7 + 6 * (7 * 8 + 4)) + 4 + 8 + 4
8 * 5 + (7 * 4 * 2 + 5 + (3 * 6 + 8 + 3) + (5 * 3))
7 * 9
5 + 6 * 4 * 5 * (2 + 3 + 5 + (4 + 9 + 8 * 8 + 7) * 5 * (7 * 7 * 6 + 5))
5 + 7 * (3 + 6) * ((3 + 6 + 6) * (8 + 6 * 6 * 4 + 7 + 2) + (2 + 9 * 2 * 6 * 3 + 9) + 7 + 7) + ((7 + 3 * 3 * 7 * 4) + 2 * 2) * 7
6 * 3 * ((8 * 8 + 7 * 8 * 4 + 5) + 9)
2 + (7 + (6 + 7 + 9 + 2 * 9 + 2)) + 4 + (4 * 6 * 3) + 3
5 * 6 + (2 + 8 + 9 + (6 + 8 + 3) * 2) + 8
5 + (4 + 8 + 7 * 7 + 3 + 8) * (4 + 4 * 3 + (9 * 5 * 4 * 9) * 9) * 5 * ((6 * 4) * (4 * 6 + 9 + 9 + 8) * (8 + 3 + 2 + 7 * 9) + 6) + 2
3 + (4 + 4 * 6 * 4 + 6 + 3) * (5 + (7 * 6 * 4 * 6 + 9 * 8)) * (9 * 7 + 5 * 2 * 4 + 8) + 9
6 + 3 * (3 + 3 * (9 * 4 * 3 * 9 * 7) * 3 + 4) * 3
4 * 3 * 3 * 4 * 2 + (2 * 3 * 9 * (9 * 9 * 6) * 6)
9 + 4 + (7 + 6 + (3 + 4 * 7 * 3) + (5 * 8 + 9 + 6) * (4 + 8 * 4 + 6) * 8) + 8 * (2 + (5 + 5))
7 + 6 + 5 + 2 + 2 + 8
(6 * 2 + 6 + 5 * (9 * 4)) * 8 + 5
5 + 2 + (6 * 4 + 3 + 3 * 3 + 9) * (9 + 2 * 2) + 9
6 + (9 + 7 * 7 + 3 * 7 * 2) + (8 * 5)
9 * (3 * 6 * 2 + 5) * 4 + 6 * (3 * 8 + 9 * 2 + 8 + 9) + 2
6 + (9 * 2 * 3 * (3 * 8 + 7 * 4))
8 + (6 + 6 + (2 + 8 * 9) + 7 + 6 * (6 + 8 * 2)) * (9 * 7) * 3 + 3
(4 * (6 * 8 + 3 * 8 * 5) * 8 + 3 + (8 * 9 * 3 * 3)) + 5 * 7 * 9 + 9
7 * 5 * (5 * 9 * (6 * 2 * 4) + 8 + 9) * 7 + (8 * 7 + 7 + (7 * 4) + 7) + (7 + 3)
8 * (5 * (5 + 2)) + 5 + 6
8 + 9 * (3 + (3 * 7 * 2))
(5 + 3 * 8 * 7) * 2 + 5 * 9
7 * 4 * 2 * 5 + (7 + 8 + 4 + 9 * 8 * 8) * 3
7 * 8 + 7 * 8 * 2
(9 + (3 + 5 + 3 * 8 + 8 + 3)) + 8 + 6 * 5 + (5 * 2 * 3 + 3 * (2 * 7 * 4 * 4 + 7 + 4)) + (7 + (8 + 4 * 4 + 9 + 8 * 9) * 7)
4 + 4 + 8 + ((5 * 3) * 8 * 3 * 4 * 7) + 5
2 + 9 * (5 * 6 * (7 * 5 + 4 + 7) * (9 * 2 * 7 * 7 * 2 + 7) * 4)
9 + (6 * 6) * 2 + 2 * 8 * 2
4 + 2 * (2 * 9 * 4 * 2 + 9 + 4) + (7 + 4 + 8 + 9) * 8 + 5
7 * ((5 * 9 * 8) * 8) + 6 + (7 * 5 * 4 * 6 * 5) + 6 * 3
7 * 8 * (7 + 3) * 2 * 9 * 2
9 + ((7 * 9 * 7 + 5 * 8 * 9) * 2 + 6 * 9 + (4 * 3 + 8)) + 2 * 9 * 3 + 5
6 * 2 + (7 + (4 + 8 + 7 + 6) * 2 + 7 * (7 + 3 * 8 * 5)) * 6
(9 * 8 + 3 * 9 * 5) * 9 + 3 * 5
8 + (7 + 2) + (9 + 9 * 7 + 3 * 4 + 6)
7 + 8 * 4 + 8 * (8 * 4) * 8
(3 * 4 * 2 * (2 + 2) + 9) + 8 + 9
5 * (9 * 6) + 7
2 + ((9 + 4 * 7) + 5 + 2 + (4 + 4 + 7 + 4 * 4) + 7 * 4) + 6
((6 + 3 + 6 * 8 + 8 * 6) + 5 + 6 + 2 + 7 + 5) * ((9 * 6) + 2 * 3 * 8)
(5 + 7 + 3 + 6 + (9 + 2 + 3) + 4) * 6 * (9 + 5) * 2 + 6
4 * 6 + 4 * (9 * 4 * (3 + 5) * 8 + (7 + 8 + 9 + 3)) + 4 * 4
9 * 4 + 8 + 9 * (4 + 6 + 9 + 2 + 4)
(8 * 5) * 6 * 6 + 8 + 5
(7 + 4 + 7 * 3 + 7 + 7) * 2
9 + 5 * (4 * 2 + 4 * 9 * 3)
5 * 6 * 2 * ((6 + 8 * 5 * 7) + (2 + 7 * 5 + 7) * 7 * 2 * (3 * 2 + 6 * 7 * 3) + 5) + 3 * 3
6 * 2 + 7 + 5 + 5 * ((7 + 2 * 7 + 6 + 2) * 4)
((8 * 3 * 4 * 7 * 8) * 9 * 8 * 2) + 8 * 9 * (3 * 9) * 3 * (2 * 6 + 7 + 9 * 4)
2 + (4 * 4 * 8 * (4 + 8 * 3 * 2 * 9 + 4) * 5 * (7 * 7 + 3 + 2 + 3)) * 5 + 6
5 + 5 + 9 * (8 * 9 + 9 * 9 + (2 + 9) + 9) * 2
(5 * 6 + 8) + 9 + (2 * 6 + 5 + 5 * (3 + 9 + 2) + 2) + 3 * ((3 * 7) + 8 * 5) + (3 + 2)
(9 * 7 + 4 + 2 * (2 * 2 + 3 + 8)) + 6
4 * 5 * ((7 * 7 * 2 + 5 + 9 * 4) * (9 + 4 * 7 + 8) * 8 * 3)
9 * 4 + (8 + (4 + 8 + 3) * 6 * 9 + 3 * 7) * 5 * 4
8 + (7 + 3 * (8 * 6 * 8 + 7 * 8) + (6 * 2 * 3 + 7 * 9))
(6 * 4 * 4 * 8 + (6 + 6)) * 8 + 2 + 4 + 9 * 7
7 + (9 + 5 * (2 + 5 + 8 + 2 * 2 * 4) * 2 + 6) + 5 + 6 + 3 * (6 * (9 + 3))
2 * (8 * 4) * 7 + 3 * 9
3 + 6 + 2 + 6 + 3 * (3 + (2 * 6 + 6 * 3) * 6 + 2 * (7 * 7 + 7))
6 + 2 * 7 * (8 * 5 * 8 * 9 + 8)
2 * 8 + 3 * (5 * 6 + 3 * 2 * 5 * 8)
(7 + (5 * 8 + 5 + 4 + 9) + 4 + 3 * 3 * (9 + 5 * 3 * 7 * 6)) + 3 + (6 * 2 * 3 * 4) + ((2 * 2) + 9 + (9 + 3 + 6 * 9 * 4 + 4) + 8)
(8 * 5 + (3 + 3 * 5 + 9 * 2) + 4 + (5 + 5 + 7 * 3) + 6) * ((2 + 2 * 4) * 3 + 5)
9 * 9 * (3 + 2 + 7 * 2 + 6 * 5) + 2 + 4 * (2 + 3 * (8 * 4) + 2)
(6 * 8 + (5 * 7 * 6 + 3 + 4 * 4) + (6 + 7) + 9) * (7 * 7 * 5 + 4) + 2 + 9 * 9
4 * 9 * 2 * (7 * 3 * (6 + 8 * 5))
8 + 2 + 2 * (7 * 9 + 4 + (4 + 5 + 3 * 7 + 4 + 8)) + 4 * 2
(4 + (7 * 3) * 8 * 2) * 5 * 9 + 9 * 4 + 3
(6 * 6 + (8 * 4 + 3 + 2 * 6) * 6) * 5 * 2 + 7 * (6 + (7 * 3)) + (6 + 6 * (6 * 9 * 8 + 3 * 3) * 3)
(8 + 8 + 5 * 6) + 7 + 4 + ((9 + 7) * (2 * 9 * 2) * 8) + 5
5 * 9 * (8 * (9 * 8 * 4) * 9 * 8)
7 + (3 * 6 + (6 * 2 * 9) * 2)
7 + 9 + 6 + (6 + 4 + 7) + 4
3 + 6 * 3
2 * 7 * 7 + (2 + 2 + 7 + (5 * 9 * 2 * 7 * 9)) + 5 * 9
2 * (2 + 7 * 2 * (5 + 7 + 7) * 7) + 8 + 5
9 + 7 + 5
8 + 8 + 3 * 2 * 5 * (5 * (6 + 9) * (4 * 5 * 8 * 2 + 4))
7 + 8 * (6 * 8) * 8 * (3 * 2 + 8 + 5 + 8 + 8)
7 * 8 * (2 * 3 + 9 * 6) * 8 + ((9 * 3 + 9 + 3 * 9 + 6) + 7 * 2 + 9 + (7 + 3 * 9 * 6) * (5 * 6 + 4 * 2 + 4 + 3))
3 * 9 + (4 * 6 + 3 * 3 + 4 * (5 * 5))
((5 * 9 + 7 + 9) + 4 + 9 + 8 + 8 + 5) * 9 + (8 + 7 * (4 * 5 + 5 * 7 + 7)) + 4 * 2 * ((4 + 9 * 6 + 2) * 3 * 2 * 8 * 9)
4 + 6 + 3 * (8 + 9 + 9) * 7 + 5
((5 * 8 * 9 * 9 + 5) + (5 * 8 * 5 * 3 * 8) * 5 * 3 + (6 * 6 * 8 + 2 + 5 + 6)) + 2 * 6 + 3 + 3 + 2
7 * 6 * 3 + (6 + 7 * 3 + (7 * 8 * 7 + 9 * 7) * 7) * 7 + 4
(7 * 4 + 8 + 8) * (3 * 9 + 9 + 9 + 9 + 7) * (6 * 6 * 3 + 8 * (6 + 3 + 8 + 7 + 3)) * 2 + 5
(9 + 3) * 5 * 9
((2 + 2 + 7 * 2 * 4) + 5 + 2 + 5) * 5 + 2 * 7 + (6 * (6 + 8 * 5 + 6) * 5 * 6 * 3) + 8
(8 * 4 * 9 + 7) + (8 + 4)
8 * (4 + 5 + (9 * 2 + 8 + 4 * 8) * 2) + 8
(9 + 9) + 5
7 * (7 + 3 + 7) + 5 + 8 * 3
(6 * 6 * (3 + 4 + 6 + 7 + 5 * 2) * 4 * 2 * 7) + 2 + (4 * 8 + 8) + 2 + 7
2 + 5 * 5 + ((3 * 7 + 5 + 2 * 3) + 5 * 2 * 6 * 8)
9 + 9 * (2 + (9 + 4) + 9) * 8 + 3
7 * 5
7 + 5 * 7 * (9 * 8 * 7 * 5) * 8
(8 + (5 + 2 + 8 * 7 + 8)) + 3 + 2 + 9 + (8 + (9 * 4 + 4 * 4 * 3) + 4 * 4) + 9
(7 * 8) + (6 + 4 * 9 + 8 + 4 + (6 + 6 * 8)) * (2 + 6 * 3 + (3 * 2 * 7 + 2) * 5 + (4 * 4 + 7 + 4)) * 9
3 * 9 * ((3 * 7 * 8 * 9) + 7 * (7 + 5 * 9 * 7) * 8 + 4 + 2) + 9 * 5
(8 * 6 * 3 + (9 + 5)) * 4 + 9 * 7 + ((6 * 7) + 9 + 8 + 9) + 3
8 * ((4 + 8) * 7 + 8 + 2 * 8) * 5 * 7 + (6 + 3 * 6) * 9
((6 + 2 * 7 + 2 + 9 * 5) * 5 * 9 + (7 * 7)) * 9 * 2 * 6 + 4
8 + (7 * 8 + 6 * 8 * 5) + 2 * (4 + 4 * 9 + 9 + 9) * 3 * 8
9 * ((9 + 3) * 3 * 3 * 5 * 2 * 5) * 5 * (8 * 3 * (6 * 4 * 6 * 7 * 9) + 2)
9 + 6 + 7 + 6 * ((2 + 8 * 6 + 7 + 6) + 6 + (9 + 9 * 9 + 5)) * 8
(7 * 4 + (4 + 5 + 2 + 3)) + 7 * 7 * 3 + 3 * (5 + 4 + 2 + 3)
(4 * 6) + 6 * 8 + 3 + 8 + (5 * 7 * 5)
(9 + 2 * (6 + 4 * 9 + 7) * 3) * 4
(8 + 2 * 4 * 7 * (9 * 4) + 4) * (3 + 4 * 5) + (4 * 2 * 8 * (6 + 6 + 9) + 3 * (6 + 6 + 7 + 3)) * 3
3 * 5 + 6
5 + 2 + 8 * 6 + (4 + (9 * 3) * (6 + 9 * 6 + 3 * 7) + 4 * 5 + 8)
(3 + 5 * (6 * 2 * 5 + 3 + 2)) * 8 * 7 * 7
7 * 2 + 8 * ((6 + 2 * 6 + 8 + 9 + 3) + 6 * 4)
7 + 7 + 3 * 6 + ((2 * 9 * 2 * 5 + 6) + 6 + 6)
(9 + 4) + 3 + 5 * ((9 + 4 * 8 * 5) + 7 + 3 + 6 * 6 + (5 * 5 + 6))
(8 + 4 + 2) + (7 + 2)
6 * (4 * 9 + 7 + 8 * (8 + 8)) + 5 + 6 + 5 * 9
3 * (4 + 8 + 2 + 2) * 9 + 5 * 4
(5 * 8 * (9 * 4 * 7 + 3 * 3 * 8) + 5) * (6 + (3 * 3 * 3 * 4)) + 4 * ((7 * 3 * 4 + 3) * 4 * 8 * (9 + 3) + 4)
4 * ((8 * 8 + 6 + 7 * 6) * 9 * 5 * 5 + 4)
(3 + 7 * 8 + (7 * 7 * 7 * 7)) * 6 + 8 + (8 + 5) + 8 + 5
(7 * (8 * 3 + 3 + 8) + 2 * 8 + 6) * 8 + 6
4 + (3 * 6 + 5) * (6 + 3 + (6 + 8 + 6 * 9 * 8) * (3 * 6) + 6 * 3)
6 + (9 * (7 + 9 * 6 + 9 + 8)) * 9 * 8 * 5 * (9 + (3 + 4 + 2 + 9 + 6) * (3 * 5 * 2 + 6 * 8 * 6) + (8 + 7 * 6) + (7 * 4 * 8 * 7 + 3 * 9) + (3 + 7 + 9))
3 + 9 * 7 + ((9 + 8 + 3 * 2) + 6 + 5 + (4 + 8 * 5 * 4 * 7) + (9 * 3 * 8))
4 * 2 * 2 + (6 + 8) + 6
3 * 7 * (8 * 3)
5 + 5 + 6 + (2 * 5 * 5) + (6 + 6)
9 * 6 * (3 + (6 * 2 + 4 + 8 * 3) * 6 + (3 * 9 * 9 + 9)) * 9
(3 * 3) * 8 * 2 * 3 * 2 * 8
((4 * 5 * 3) * 8 * (9 * 2 + 4 * 3 * 7 * 6) * 9) * (6 + 6 + 6 * 8) + 8 + 5 * 2
7 * (5 * 7 + 4 + 8) * 2 * 4
(6 + 3 * (2 * 8 + 4 + 2 + 9 + 6) + 7) * 3 * 2 * 9
9 * (8 + 9 + (9 + 8) * 5) + (4 + 3 * 7 + 5 + (6 * 2 + 5)) * 2
(5 * 7 + 6 + (3 + 3) + 9) + 6
8 + (6 * (6 + 7 * 3))
(7 + 7) * 3 + 5 * (9 + 7 + (5 + 9 + 2) * 3 * 7)
4 * (3 + 8 + 2 + 3) * 8 + (7 * 6 * 9 + (4 * 7 * 5) * 3 * 3) * 5 + 7
4 + 7 * (9 + 5 * 2 * 2 * 2 + 7) * 2
4 + 3 + 5 + (6 * (5 * 7 + 2 * 7)) + 4 + (2 * 8 + (3 + 2 + 3 * 2) * 5 * (2 * 2))
6 + 6 + 2 + 6 + (9 * 2 * 9)
"""

}
