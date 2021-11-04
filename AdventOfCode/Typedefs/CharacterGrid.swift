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

        print(s)
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
        if !terminateWhenFound.isEmpty {
            if terminateWhenFound.contains(gridPoint) {
                point = Point2D(x: -1, y: -1)
            }
        }
    }

    return retval
}

func getCharacterGridEdge(grid: CharacterGrid, direction: CompassDirection) -> String {
    if direction == .North {
        return String(grid.first ?? [])
    } else if direction == .South {
        return String(grid.last ?? [])
    } else {
        var retval = ""
        for line in grid {
            let c = line[(direction == .West ? 0 : line.count - 1)]
            retval += String(c)
        }

        return retval
    }
}

func rotateCharacterGrid(grid: CharacterGrid, rotateRight: Bool) -> CharacterGrid {
    let height = grid.count
    let width = grid[0].count
    var newGrid = initializeEmptyCharacterGrid(height: width, width: height)
    for y in 0..<height {
        for x in 0..<width {
            if rotateRight {
                newGrid[y][x] = grid[width - x - 1][y]
            } else {
                newGrid[y][x] = grid[x][height - y - 1]
            }
        }
    }

    return newGrid
}

func flipCharacterGrid(grid: CharacterGrid, flipHorizontally: Bool, flipVertically: Bool) -> CharacterGrid {
    let height = grid.count
    let width = grid[0].count
    var newGrid = initializeEmptyCharacterGrid(height: height, width: width)
    for y in 0..<height {
        for x in 0..<width {
            let newX = flipHorizontally ? (width - x - 1) : x
            let newY = flipVertically ? (height - y - 1) : y
            newGrid[y][x] = grid[newY][newX]
        }
    }

    return newGrid
}
