//
//  CharacterGrid.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

typealias CharacterGrid = [[Character]]

func getCharacterGrid(str: String, separator: Character = "\n") -> CharacterGrid {
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
    return getCharacterCount(grid: grid, character: "#")
}

func getCharacterCount(grid: CharacterGrid, character: Character) -> Int {
    var retval = 0
    for y in 0..<grid.count {
        for x in 0..<grid[y].count {
            if grid[y][x] == character {
                retval += 1
            }
        }
    }
    
    return retval
}

func adjacentCharacters(grid: CharacterGrid, row: Int, col: Int) -> [Character] {
    var retval: [Character] = []
    let origin = Point2D(x: col, y: row)
    let adjacentPoints = origin.adjacentLocations(includeDiagonals: true)
    for point in adjacentPoints {
        if point.x >= 0 && point.x < grid[0].count && point.y >= 0 && point.y < grid.count {
            retval.append(grid[point.y][point.x])
        }
    }
    
    return retval
}

func directionalCharacters(grid: CharacterGrid, row: Int, col: Int, direction: CompassDirection, terminateWhenFound: [Character] = []) -> [Character] {
    var retval: [Character] = []
    let origin = Point2D(x: col, y: row)
    let offsetFromOrigin = direction.OffsetFromOrigin()
    var point = Point2D(x: origin.x + offsetFromOrigin.x, y: origin.y + offsetFromOrigin.y)
    while point.x >= 0 && point.x < grid[0].count && point.y >= 0 && point.y < grid.count {
        let gridPoint = grid[point.y][point.x]
        retval.append(gridPoint)
        point = Point2D(x: point.x + offsetFromOrigin.x, y: point.y + offsetFromOrigin.y)
        if terminateWhenFound.count > 0 {
            if terminateWhenFound.contains(gridPoint) {
                point = Point2D(x: -1, y: -1)
            }
        }
    }
    
    return retval
}
