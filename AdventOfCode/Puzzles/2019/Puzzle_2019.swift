//
//  Puzzle_2019.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019 {
    
    func solve(puzzleNumber: Int) {
        
        if puzzleNumber == 1 {
            Puzzle_2019_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2019_02().solve()
        } else {
            print ("The puzzle number \(puzzleNumber) was not found.")
        }
        
    }
    
}
