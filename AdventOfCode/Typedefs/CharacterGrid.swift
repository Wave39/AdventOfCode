//
//  CharacterGrid.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public typealias CharacterGrid = [[Character]]

public extension CharacterGrid {
    var width: Int {
        self[0].count
    }

    var height: Int {
        self.count
    }

    func pointIsValid(_ point: Point2D) -> Bool {
        point.x >= 0 && point.y >= 0 && point.x < width && point.y < height
    }
    
    func getAllPoints() -> [Point2D] {
        var points = [Point2D]()
        for y in 0..<self.count {
            for x in 0..<self[0].count {
                points.append(Point2D(x: x, y: y))
            }
        }

        return points
    }

    func getAllPointsMatchingCharacter(_ character: Character) -> [Point2D] {
        var points = [Point2D]()
        for y in 0..<self.count {
            for x in 0..<self[0].count {
                if characterAtCoordinates(x, y) == character {
                    points.append(Point2D(x: x, y: y))
                }
            }
        }

        return points
    }

    func getCharacterMap(ignorePeriods: Bool) -> [Character: [Point2D]] {
        var retval = [Character: [Point2D]]()
        for point in self.getAllPoints() {
            let character = self.characterAtPoint(point)
            if !ignorePeriods || character != "." {
                retval[character, default: [Point2D]()].append(point)
            }
        }
        
        return retval
    }

    func characterAtPoint(_ point: Point2D) -> Character {
        self[point.y][point.x]
    }

    mutating func setCharacterAtPoint(_ point: Point2D, _ char: Character) {
        self[point.y][point.x] = char
    }
    
    func characterAtCoordinates(_ x: Int, _ y: Int) -> Character {
        self[y][x]
    }

    mutating func setCharacterAtCoordinates(_ x: Int, _ y: Int, _ char: Character) {
        self[y][x] = char
    }

    func adjacentGridCells(origin: Point2D, includeDiagonals: Bool) -> [(Point2D, Character)] {
        var retval: [(Point2D, Character)] = []
        let adjacentPoints = origin.adjacentLocations(includeDiagonals: includeDiagonals)
        for point in adjacentPoints {
            if point.x >= 0 && point.x < self[0].count && point.y >= 0 && point.y < self.count {
                retval.append((point, self[point.y][point.x]))
            }
        }

        return retval
    }

    func findInstancesOf(_ character: Character) -> [Point2D] {
        var retval: [Point2D] = []
        for y in 0..<height {
            for x in 0..<width {
                if self[y][x] == character {
                    retval.append(Point2D(x: x, y: y))
                }
            }
        }

        return retval
    }

    func findFirstLetter() -> Point2D? {
        for y in 0..<height {
            for x in 0..<width {
                if self[y][x].isLetter {
                    return Point2D(x: x, y: y)
                }
            }
        }

        return nil
    }

    func printToConsole() {
        for line in self {
            var s = ""
            for c in line {
                s += String(c)
            }

            print(s)
        }
    }

    func toString() -> String {
        var s = ""
        for line in self {
            for c in line {
                s += String(c)
            }

            s += "\n"
        }

        return s
    }

    func printToConsole(x1: Int, x2: Int, y1: Int, y2: Int) {
        let xStart = Swift.min(x1, x2)
        let xEnd = Swift.max(x1, x2)
        let yStart = Swift.min(y1, y2)
        let yEnd = Swift.max(y1, y2)
        for y in yStart...yEnd {
            let line = self[y]
            var s = ""
            for x in xStart...xEnd {
                s += String(line[x])
            }

            print(s)
        }
    }

    func getDirectionalPoint(point: Point2D, direction: CompassDirection) -> Point2D {
        if direction == .North {
            return Point2D(x: point.x, y: point.y - 1)
        } else if direction == .East {
            return Point2D(x: point.x + 1, y: point.y)
        } else if direction == .South {
            return Point2D(x: point.x, y: point.y + 1)
        } else if direction == .West {
            return Point2D(x: point.x - 1, y: point.y)
        } else {
            return point
        }
    }

    func getCharacterAtCharacterGridPoint(_ point: Point2D) -> Character {
        self[point.y][point.x]
    }

    func getDirectionalCharacter(point: Point2D, direction: CompassDirection) -> Character {
        if direction == .North {
            return getCharacterAtCharacterGridPoint(Point2D(x: point.x, y: point.y - 1))
        } else if direction == .East {
            return getCharacterAtCharacterGridPoint(Point2D(x: point.x + 1, y: point.y))
        } else if direction == .South {
            return getCharacterAtCharacterGridPoint(Point2D(x: point.x, y: point.y + 1))
        } else if direction == .West {
            return getCharacterAtCharacterGridPoint(Point2D(x: point.x - 1, y: point.y))
        } else {
            return getCharacterAtCharacterGridPoint(point)
        }
    }

    func isNextStepOffGrid(point: Point2D, direction: CompassDirection) -> Bool {
        if direction == .North {
            return point.y == 0
        } else if direction == .South {
            return point.y == self.height - 1
        } else if direction == .East {
            return point.x == self.width - 1
        } else {
            return point.x == 0
        }
    }
}

public func getCharacterGrid(str: String, separator: Character = "\n") -> CharacterGrid {
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

public func initializeEmptyCharacterGrid(height: Int, width: Int) -> CharacterGrid {
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

public func getCharacterAtCharacterGridPoint(grid: CharacterGrid, point: Point2D) -> Character {
    grid[point.y][point.x]
}

public func getOnCount(grid: CharacterGrid) -> Int {
    getCharacterCount(grid: grid, character: "#")
}

public func getCharacterCount(grid: CharacterGrid, character: Character) -> Int {
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

public func findCharacter(grid: CharacterGrid, character: Character) -> Point2D? {
    for y in 0..<grid.count {
        for x in 0..<grid[y].count {
            if grid[y][x] == character {
                return Point2D(x: x, y: y)
            }
        }
    }

    return nil
}

public func adjacentCharacters(grid: CharacterGrid, row: Int, col: Int) -> [Character] {
    adjacentCharacters(grid: grid, origin: Point2D(x: col, y: row))
}

public func adjacentCharacters(grid: CharacterGrid, origin: Point2D) -> [Character] {
    var retval: [Character] = []
    let adjacentPoints = origin.adjacentLocations(includeDiagonals: true)
    for point in adjacentPoints {
        if point.x >= 0 && point.x < grid[0].count && point.y >= 0 && point.y < grid.count {
            retval.append(grid[point.y][point.x])
        }
    }

    return retval
}

public func directionalCharacters(grid: CharacterGrid, row: Int, col: Int, direction: CompassDirection, terminateWhenFound: [Character] = []) -> [Character] {
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

public func getCharacterGridEdge(grid: CharacterGrid, direction: CompassDirection) -> String {
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

public func rotateCharacterGrid(grid: CharacterGrid, rotateRight: Bool) -> CharacterGrid {
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

public func flipCharacterGrid(grid: CharacterGrid, flipHorizontally: Bool, flipVertically: Bool) -> CharacterGrid {
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
