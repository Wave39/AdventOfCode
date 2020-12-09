//
//  main.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

print ("")
print ("Welcome to BP's Advent Of Code Solution Machine.")
print ("Make sure to click in the Output window to enter which puzzle you would like to solve.")

let maxYear = 2020
let defaultYear = maxYear
let defaultPuzzle = 9
let defaultYearAndPuzzle = "\(maxYear) \(defaultPuzzle)"

var quitApp = false
while !quitApp {
    var puzzle = 0
    var year = maxYear
    while !quitApp && (puzzle < 1 || puzzle > 25) {
        print ("")
        print ("Which year and puzzle would you like the Solution Machine to solve? (Enter a year from 2015 to 2020 and a number from 1 to 25, default of \(defaultYearAndPuzzle), or Q to quit)")
        let response = readLine()
        if response == "q" || response == "Q" {
            quitApp = true
        } else if response != "" {
            let arr = response!.parseIntoStringArray(separator: " ")
            if arr.count == 2 {
                year = arr[0].toInt()
                puzzle = arr[1].toInt()
            } else if arr.count == 1 {
                year = defaultYear
                puzzle = arr[0].toInt()
            }
        } else {
            let arr = defaultYearAndPuzzle.parseIntoStringArray(separator: " ")
            year = arr[0].toInt()
            puzzle = arr[1].toInt()
            print ("Defaulting to puzzle \(defaultYearAndPuzzle)")
        }
    }
    
    if !quitApp {
        if year >= 15 && year <= 99 {
            year += 2000
        }
        
        print ("")
        print ("Solving \(year) puzzle \(puzzle), please stand by...")
        
        let start = DispatchTime.now()
        if year == 2020 {
            Puzzle_2020().solve(puzzleNumber: puzzle)
        } else if year == 2019 {
            Puzzle_2019().solve(puzzleNumber: puzzle)
        } else if year == 2018 {
            Puzzle_2018().solve(puzzleNumber: puzzle)
        } else if year == 2017 {
            Puzzle_2017().solve(puzzleNumber: puzzle)
        } else if year == 2016 {
            Puzzle_2016().solve(puzzleNumber: puzzle)
        } else if year == 2015 {
            Puzzle_2015().solve(puzzleNumber: puzzle)
        }
        
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(year) puzzle \(puzzle): \(String(format: "%.3f", timeInterval)) seconds")
    }
}

print ("")
print ("Thanks for checking out my Advent Of Code Solution Machine.")
