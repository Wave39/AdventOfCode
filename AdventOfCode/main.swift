//
//  main.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

let hardCodedPuzzleSelection = true

print("")
print("Welcome to BP's Advent Of Code Solution Machine.")

if hardCodedPuzzleSelection {
    let start = DispatchTime.now()
    let kDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let defaultYear = kDateComponents.year ?? 2_015
    let defaultDay = kDateComponents.day ?? 1
    print("\nSolving \(defaultYear) puzzle \(defaultDay), please stand by...")
    Puzzle_2023().solve(puzzleNumber: defaultDay)
    let end = DispatchTime.now()
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000
    print("Time to evaluate: \(String(format: "%.3f", timeInterval)) seconds")
    print("")
    print("Press Enter to terminate application")
    _ = readLine()
} else {
    print("Make sure to click in the Output window to enter which puzzle you would like to solve.")

    var quitApp = false
    
    let kDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let kDefaultYear = kDateComponents.year ?? 2_015
    var year = kDefaultYear
    var day = 0

    while !quitApp {
        let defaultDay = kDateComponents.day ?? 1
        let defaultYearAndPuzzle = "\(kDefaultYear) \(defaultDay)"
    
        while !quitApp && (day < 1 || day > 25) {
            print("")
            print("Which year and puzzle would you like the Solution Machine to solve? (Enter a year from 2015 to \(kDefaultYear) and a number from 1 to 25, default of \(defaultYearAndPuzzle), or Q to quit)")
            guard let response = readLine() else { continue }
            if response.lowercased().trim() == "q" {
                quitApp = true
            } else if !response.isEmpty {
                let arr = response.parseIntoStringArray(separator: " ")
                if arr.count == 2 {
                    year = arr[0].int
                    day = arr[1].int
                } else if arr.count == 1 {
                    year = kDefaultYear
                    day = arr[0].int
                }
            } else {
                let arr = defaultYearAndPuzzle.parseIntoStringArray(separator: " ")
                year = arr[0].int
                day = arr[1].int
                print("Defaulting to puzzle \(defaultYearAndPuzzle)")
            }
        }
    
        if !quitApp {
            if year >= 15 && year <= 99 {
                year += 2_000
            }
    
            print("")
            print("Solving \(year) puzzle \(day), please stand by...")
    
            let start = DispatchTime.now()
            if year == 2_023 {
                Puzzle_2023().solve(puzzleNumber: day)
            } else if year == 2_022 {
                Puzzle_2022().solve(puzzleNumber: day)
            } else if year == 2_021 {
                Puzzle_2021().solve(puzzleNumber: day)
            } else if year == 2_020 {
                Puzzle_2020().solve(puzzleNumber: day)
            } else if year == 2_019 {
                Puzzle_2019().solve(puzzleNumber: day)
            } else if year == 2_018 {
                Puzzle_2018().solve(puzzleNumber: day)
            } else if year == 2_017 {
                Puzzle_2017().solve(puzzleNumber: day)
            } else if year == 2_016 {
                Puzzle_2016().solve(puzzleNumber: day)
            } else if year == 2_015 {
                Puzzle_2015().solve(puzzleNumber: day)
            }
    
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time to evaluate \(year) day \(day): \(String(format: "%.3f", timeInterval)) seconds")
            day = 0
        }
    }
    
    print("")
    print("Thanks for checking out my Advent Of Code Solution Machine.")
}
