//
//  Puzzle_2019_04.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_04 : PuzzleBaseClass {

    public func solve() {
        let part1 = solvePart1(from: 134564, to: 585159)
        //let part1 = solvePart1(from: 123789, to: 123789)
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2(from: 134564, to: 585159)
        print ("Part 2 solution: \(part2)")
    }

    func IsValidPassword(password: Int) -> Bool {
        let s = "\(password)"
        var ascendingCharacters = false
        let s0 = Int(String(s[0]))!
        let s1 = Int(String(s[1]))!
        let s2 = Int(String(s[2]))!
        let s3 = Int(String(s[3]))!
        let s4 = Int(String(s[4]))!
        let s5 = Int(String(s[5]))!
        if s1 >= s0 && s2 >= s1 && s3 >= s2 && s4 >= s3 && s5 >= s4 {
            ascendingCharacters = true
        }
        
        var adjacentCharacters = false
        if s0 == s1 || s1 == s2 || s2 == s3 || s3 == s4 || s4 == s5 {
            adjacentCharacters = true
        }
        
        return adjacentCharacters && ascendingCharacters
    }
    
    func IsValidPassword2(password: Int) -> Bool {
        let s = "\(password)"
        var arr: [Int] = []
        for idx in 0...5 {
            arr.append(Int(String(s[idx]))!)
        }
        
        var ascendingCharacters = false
        if arr[1] >= arr[0] && arr[2] >= arr[1] && arr[3] >= arr[2] && arr[4] >= arr[3] && arr[5] >= arr[4] {
            ascendingCharacters = true
        }
        
        var adjacentCharacters = false
        var letterDictionary: Dictionary<Int, Int> = [:]
        for idx in 0...5 {
            if letterDictionary[arr[idx]] == nil {
                letterDictionary[arr[idx]] = 0
            }
            
            letterDictionary[arr[idx]]! += 1
        }
        
        for k in letterDictionary.keys {
            if letterDictionary[k] == 2 {
                adjacentCharacters = true
            }
        }
        
//        for idx in 0...4 {
//            if s[idx] == s[idx + 1] {
//                //print ("duplicate at index \(idx)")
//                if idx <= 3 {
//                    if s[idx] == s[idx + 2] {
//                        if idx >= 1 {
//                            if s[idx] != s[idx - 1] {
//                                adjacentCharacters = true
//                            }
//                        } else {
//                            adjacentCharacters = true
//                        }
//                    }
//                } else {
//                    if s[idx] != s[idx - 1] {
//                        adjacentCharacters = true
//                    }
//                }
//            }
//        }
        
        return adjacentCharacters && ascendingCharacters
    }
    
    public func solvePart1(from: Int, to: Int) -> Int {
        var retval = 0
        for i in from...to {
            if IsValidPassword(password: i) {
                retval += 1
            }
        }
        
        return retval
    }
    
    public func solvePart2(from: Int, to: Int) -> Int {
        var retval = 0
        for i in from...to {
            if IsValidPassword2(password: i) {
                retval += 1
            }
        }
        
        return retval
    }
    
}

