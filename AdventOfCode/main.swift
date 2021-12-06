//
//  main.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

print("")
print("Welcome to BP's Advent Of Code Solution Machine.")
print("Make sure to click in the Output window to enter which puzzle you would like to solve.")

private let kMaxYear = 2_021
private let kDefaultYear = kMaxYear
private let kDefaultPuzzle = 6
private let kDefaultYearAndPuzzle = "\(kMaxYear) \(kDefaultPuzzle)"

private var quitApp = false

while !quitApp {
    var puzzle = 0
    var year = kMaxYear
    while !quitApp && (puzzle < 1 || puzzle > 25) {
        print("")
        print("Which year and puzzle would you like the Solution Machine to solve? (Enter a year from 2015 to 2020 and a number from 1 to 25, default of \(kDefaultYearAndPuzzle), or Q to quit)")
        guard let response = readLine() else { continue }
        if response == "q" || response == "Q" {
            quitApp = true
        } else if !response.isEmpty {
            let arr = response.parseIntoStringArray(separator: " ")
            if arr.count == 2 {
                year = arr[0].int
                puzzle = arr[1].int
            } else if arr.count == 1 {
                year = kDefaultYear
                puzzle = arr[0].int
            }
        } else {
            let arr = kDefaultYearAndPuzzle.parseIntoStringArray(separator: " ")
            year = arr[0].int
            puzzle = arr[1].int
            print("Defaulting to puzzle \(kDefaultYearAndPuzzle)")
        }
    }

    if !quitApp {
        if year >= 15 && year <= 99 {
            year += 2_000
        }

        print("")
        print("Solving \(year) puzzle \(puzzle), please stand by...")

        let start = DispatchTime.now()
        if year == 2_021 {
            Puzzle_2021().solve(puzzleNumber: puzzle)
        } else if year == 2_020 {
                Puzzle_2020().solve(puzzleNumber: puzzle)
        } else if year == 2_019 {
            Puzzle_2019().solve(puzzleNumber: puzzle)
        } else if year == 2_018 {
            Puzzle_2018().solve(puzzleNumber: puzzle)
        } else if year == 2_017 {
            Puzzle_2017().solve(puzzleNumber: puzzle)
        } else if year == 2_016 {
            Puzzle_2016().solve(puzzleNumber: puzzle)
        } else if year == 2_015 {
            Puzzle_2015().solve(puzzleNumber: puzzle)
        }

        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        print("Time to evaluate \(year) puzzle \(puzzle): \(String(format: "%.3f", timeInterval)) seconds")
    }
}

print("")
print("Thanks for checking out my Advent Of Code Solution Machine.")
