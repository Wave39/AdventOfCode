//
//  Puzzle_2018_07.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/30/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_07: NSObject {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> String {
        let puzzleInput = (Puzzle_2018_07_Input.puzzleInput, 5, 60)
        return solvePart1(str: puzzleInput.0)
    }
    
    func solvePart2() -> Int {
        let puzzleInput = (Puzzle_2018_07_Input.puzzleInput, 5, 60)
        return solvePart2(str: puzzleInput.0, numberOfElves: puzzleInput.1, additionalSecondsPerStep: puzzleInput.2)
    }
    
    func parseInstructionsIntoDictionary(str: String) -> Dictionary<String, String> {
        var retval: Dictionary<String, String> = [:]
        
        let arr = str.parseIntoStringArray()
        for line in arr {
            let words = line.parseIntoStringArray(separator: " ")
            let firstStep = words[1]
            let secondStep = words[7]
            if retval[secondStep] == nil {
                retval[secondStep] = firstStep
            } else {
                retval[secondStep] = retval[secondStep]! + firstStep
            }
            
            if retval[firstStep] == nil {
                retval[firstStep] = ""
            }
        }
        
        return retval
    }
    
    func findFirstAvailableStep(dict: Dictionary<String, String>) -> String {
        for k in dict.keys.sorted() {
            if dict[k]?.count == 0 {
                return k
            }
        }
        
        return ""
    }
    
    func removeStepFromDictionary(dict: Dictionary<String, String>, stepToRemove: String) -> Dictionary<String, String> {
        var retval: Dictionary<String, String> = [:]
        for (k, v) in dict {
            if k != stepToRemove {
                retval[k] = v.replacingOccurrences(of: stepToRemove, with: "")
            }
        }
        
        return retval
    }
    
    func solvePart1(str: String) -> String {
        var dict = parseInstructionsIntoDictionary(str: str)
        var retval = ""
        repeat {
            let available = findFirstAvailableStep(dict: dict)
            retval += available
            dict = removeStepFromDictionary(dict: dict, stepToRemove: available)
        } while dict.count > 0
            
        return retval
    }
    
    func completionTimeForTask(str: String, additionalSecondsPerStep: Int) -> Int {
        let asciiTime = str.asciiValue - "A".asciiValue + 1
        return Int(asciiTime) + additionalSecondsPerStep
    }
    
    func findAvailableSteps(dict: Dictionary<String, String>) -> [String] {
        var retval: [String] = []
        for k in dict.keys.sorted() {
            if dict[k]?.count == 0 {
                retval.append(k)
            }
        }
        
        return retval
    }
    
    func findAvailableElf(elves: Array<(String, Int)>) -> Int {
        for idx in 0..<elves.count {
            if elves[idx].0 == "" {
                return idx
            }
        }
        
        return -1
    }
    
    func isStepInProgress(elves: Array<(String, Int)>, step: String) -> Bool {
        for elf in elves {
            if elf.0 == step {
                return true
            }
        }
        
        return false
    }
    
    func solvePart2(str: String, numberOfElves: Int, additionalSecondsPerStep: Int) -> Int {
        var second = 0
        var dict = parseInstructionsIntoDictionary(str: str)
        var elves: Array<(String, Int)> = []
        for _ in 1...numberOfElves {
            elves.append(("", 0))
        }
        
        repeat {
            // find available tasks and assign to available elves
            let availableSteps = findAvailableSteps(dict: dict)
            for step in availableSteps {
                let availableElf = findAvailableElf(elves: elves)
                if availableElf != -1 && !isStepInProgress(elves: elves, step: step) {
                    elves[availableElf] = (step, completionTimeForTask(str: step, additionalSecondsPerStep: additionalSecondsPerStep))
                }
            }
            
            second += 1
            
            // subtract a second from each elf's work
            for idx in 0..<elves.count {
                if elves[idx].0.count > 0 {
                    elves[idx].1 = elves[idx].1 - 1
                }
            }

            // check for elves that are done
            for idx in 0..<elves.count {
                if elves[idx].0.count > 0 && elves[idx].1 == 0 {
                    dict = removeStepFromDictionary(dict: dict, stepToRemove: elves[idx].0)
                    elves[idx] = ("", 0)
                }
            }
        } while dict.count > 0
        
        return second
    }
}

private class Puzzle_2018_07_Input: NSObject {

    static let puzzleInput_test = """
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
"""
    
    static let puzzleInput = """
Step F must be finished before step N can begin.
Step V must be finished before step Y can begin.
Step B must be finished before step W can begin.
Step K must be finished before step O can begin.
Step E must be finished before step H can begin.
Step A must be finished before step P can begin.
Step Y must be finished before step S can begin.
Step T must be finished before step L can begin.
Step G must be finished before step R can begin.
Step I must be finished before step H can begin.
Step X must be finished before step M can begin.
Step N must be finished before step C can begin.
Step O must be finished before step R can begin.
Step Z must be finished before step R can begin.
Step R must be finished before step D can begin.
Step M must be finished before step C can begin.
Step H must be finished before step D can begin.
Step C must be finished before step U can begin.
Step J must be finished before step D can begin.
Step L must be finished before step Q can begin.
Step D must be finished before step U can begin.
Step S must be finished before step U can begin.
Step U must be finished before step Q can begin.
Step P must be finished before step Q can begin.
Step W must be finished before step Q can begin.
Step X must be finished before step R can begin.
Step P must be finished before step W can begin.
Step B must be finished before step U can begin.
Step E must be finished before step J can begin.
Step T must be finished before step R can begin.
Step M must be finished before step L can begin.
Step M must be finished before step P can begin.
Step V must be finished before step T can begin.
Step T must be finished before step U can begin.
Step R must be finished before step W can begin.
Step V must be finished before step A can begin.
Step X must be finished before step S can begin.
Step V must be finished before step U can begin.
Step C must be finished before step P can begin.
Step J must be finished before step S can begin.
Step F must be finished before step D can begin.
Step Y must be finished before step U can begin.
Step L must be finished before step W can begin.
Step F must be finished before step T can begin.
Step B must be finished before step E can begin.
Step F must be finished before step J can begin.
Step R must be finished before step M can begin.
Step Z must be finished before step W can begin.
Step K must be finished before step E can begin.
Step S must be finished before step W can begin.
Step U must be finished before step P can begin.
Step S must be finished before step P can begin.
Step D must be finished before step W can begin.
Step Z must be finished before step P can begin.
Step U must be finished before step W can begin.
Step M must be finished before step J can begin.
Step M must be finished before step W can begin.
Step H must be finished before step U can begin.
Step E must be finished before step C can begin.
Step C must be finished before step Q can begin.
Step L must be finished before step U can begin.
Step Y must be finished before step R can begin.
Step E must be finished before step D can begin.
Step A must be finished before step S can begin.
Step Z must be finished before step J can begin.
Step X must be finished before step W can begin.
Step C must be finished before step D can begin.
Step C must be finished before step S can begin.
Step G must be finished before step N can begin.
Step K must be finished before step Z can begin.
Step T must be finished before step I can begin.
Step H must be finished before step W can begin.
Step E must be finished before step Q can begin.
Step R must be finished before step J can begin.
Step O must be finished before step H can begin.
Step O must be finished before step J can begin.
Step L must be finished before step S can begin.
Step A must be finished before step H can begin.
Step K must be finished before step G can begin.
Step I must be finished before step X can begin.
Step T must be finished before step W can begin.
Step O must be finished before step W can begin.
Step N must be finished before step Q can begin.
Step V must be finished before step Z can begin.
Step H must be finished before step S can begin.
Step F must be finished before step L can begin.
Step X must be finished before step Z can begin.
Step I must be finished before step U can begin.
Step T must be finished before step J can begin.
Step G must be finished before step S can begin.
Step E must be finished before step U can begin.
Step M must be finished before step U can begin.
Step J must be finished before step U can begin.
Step E must be finished before step P can begin.
Step F must be finished before step C can begin.
Step O must be finished before step Q can begin.
Step D must be finished before step Q can begin.
Step A must be finished before step L can begin.
Step H must be finished before step J can begin.
Step I must be finished before step P can begin.
Step Y must be finished before step D can begin.
"""
    
}
