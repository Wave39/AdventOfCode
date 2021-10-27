//
//  Puzzle_2020_13.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/13/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_13 : PuzzleBaseClass {

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
    
    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        let earliestTimeStamp = Int(arr[0])!
        var busIDs: [Int] = []
        for arr2 in arr[1].parseIntoStringArray(separator: ",") {
            if arr2 != "x" {
                busIDs.append(Int(arr2)!)
            }
        }
        
        var earliestX = Int.max
        var retval = 0
        for busID in busIDs {
            var x = 0
            while x < earliestTimeStamp {
                x += busID
            }
            
            if x < earliestX {
                earliestX = x
                retval = busID * (x - earliestTimeStamp)
            }
        }
        
        return retval
    }
    
    struct BusInfo {
        var busID: Int
        var minutesAfter: Int
    }
    
    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var buses: [BusInfo] = []
        var idx = 0
        for arr2 in arr[1].parseIntoStringArray(separator: ",") {
            if arr2 != "x" {
                buses.append(BusInfo(busID: Int(arr2)!, minutesAfter: idx))
            }
            
            idx += 1
        }
        
        var time = 0
        var inc = 1
        for bus in buses {
            let newTime = bus.busID
            while true {
                time += inc
                if (time + bus.minutesAfter) % newTime == 0 {
                    inc *= newTime
                    break
                }
            }
        }
        
        return time
    }
    
}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
939
7,13,x,x,59,x,31,19
"""

    static let puzzleInput_test2 = """
0
17,x,13,19
"""

    static let puzzleInput = """
1000303
41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,541,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,983,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19
"""

}
