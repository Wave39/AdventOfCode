//
//  CharacterGrid.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

typealias CharacterGrid = [[Character]]

func getCharacterGrid(str: String, separator: Character) -> CharacterGrid {
    var grid: CharacterGrid = []
    let lines = str.split(separator: separator)
    for line in lines {
        var lineArray: [Character] = []
        for c in line {
            lineArray.append(c)
        }
        
        grid.append(lineArray)
    }
    
    return grid
}

func initializeEmptyCharacterGrid(height: Int, width: Int) -> CharacterGrid {
    var grid: CharacterGrid = []
    for _ in 0..<height {
        var lineArray: [Character] = []
        for _ in 0..<width {
            lineArray.append(".")
        }
        
        grid.append(lineArray)
    }
    
    return grid
}

func printCharacterGrid(grid: CharacterGrid) {
    for line in grid {
        var s = ""
        for c in line {
            s += String(c)
        }
        
        print (s)
    }
}

func getCharacterAtCharacterGridPoint(grid: CharacterGrid, point: Point2D) -> Character {
    return grid[point.y][point.x]
}

func getOnCount(grid: CharacterGrid) -> Int {
    var retval = 0
    for y in 0..<grid.count {
        for x in 0..<grid[y].count {
            if grid[y][x] == "#" {
                retval += 1
            }
        }
    }
    
    return retval
}
