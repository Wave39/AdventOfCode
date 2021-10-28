//
//  Puzzle_2019_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/29/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_24: PuzzleBaseClass {

    typealias Grid = [[Int]]
    typealias Grid3D = [Int : Grid]
    
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_24_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_24_Input.puzzleInput)
    }
    
    func processGrid(grid: Grid) -> Grid {
        let height = grid.count
        let width = grid[0].count
        var retval = Grid()
        for y in 0..<height {
            var lineArray: [Int] = []
            for x in 0..<width {
                let adjacent = Point2D(x: x, y: y).adjacentLocations()
                let currentBug = grid[y][x]
                var neighboringBugs = 0
                for adj in adjacent {
                    if adj.x >= 0 && adj.x < width && adj.y >= 0 && adj.y < height {
                        if grid[adj.y][adj.x] == 1 {
                            neighboringBugs += 1
                        }
                    }
                }
                
                if currentBug == 1 {
                    if neighboringBugs == 1 {
                        lineArray.append(1)
                    } else {
                        lineArray.append(0)
                    }
                } else {
                    if neighboringBugs == 1 || neighboringBugs == 2 {
                        lineArray.append(1)
                    } else {
                        lineArray.append(0)
                    }
                }
            }
            
            retval.append(lineArray)
        }
        
        return retval
    }
    
    func calculateBiodiversity(grid: Grid) -> Int {
        let height = grid.count
        let width = grid[0].count
        var retval = 0
        var mult = 1
        for y in 0..<height {
            for x in 0..<width {
                if grid[y][x] == 1 {
                    retval += mult
                }
                
                mult *= 2
            }
        }
        
        return retval
    }
    
    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var grid = Grid()
        for line in arr {
            var lineArray: [Int] = []
            for c in line {
                if c == "." {
                    lineArray.append(0)
                } else {
                    lineArray.append(1)
                }
            }
            
            grid.append(lineArray)
        }
        
        var gridSet: Set<Grid> = Set()
        gridSet.insert(grid)
        var leaveLoop = false
        while !leaveLoop {
            grid = processGrid(grid: grid)
            if gridSet.contains(grid)
            {
                leaveLoop = true
            } else {
                gridSet.insert(grid)
            }
        }
        
        return calculateBiodiversity(grid: grid)
    }
    
    func countBugs(dict: Grid3D) -> Int {
        var retval = 0
        for k in dict.keys {
            let grid = dict[k]!
            let height = grid.count
            let width = grid[0].count
            for y in 0..<height {
                for x in 0..<width {
                    if grid[y][x] == 1 {
                        retval += 1
                    }
                }
            }
        }
        
        return retval
    }
    
    func processGridDictionary(dict: Grid3D) -> Grid3D {
        var retval = Grid3D()
        
        retval[201] = dict[201]!
        retval[-201] = dict[-201]!
        
        for z in -200...200 {
            let grid = dict[z]!
            let gridInside = dict[z - 1]!
            let gridOutside = dict[z + 1]!
            
            let height = grid.count
            let width = grid[0].count
            var newGrid = Grid()
            for y in 0..<height {
                var lineArray: [Int] = []
                for x in 0..<width {
                    if x == 2 && y == 2 {
                        lineArray.append(0)
                    } else {
                        let adjacent2D = Point2D(x: x, y: y).adjacentLocations()
                        var adjacent3D: [Point3D] = []
                        for adj in adjacent2D {
                            if adj.x < 0 {
                                adjacent3D.append(Point3D(x: 1, y: 2, z: 1))
                            } else if adj.x >= width {
                                adjacent3D.append(Point3D(x: 3, y: 2, z: 1))
                            } else if adj.y < 0 {
                                adjacent3D.append(Point3D(x: 2, y: 1, z: 1))
                            } else if adj.y >= height {
                                adjacent3D.append(Point3D(x: 2, y: 3, z: 1))
                            } else if adj.x == 2 && adj.y == 2 {
                                if x == 1 {
                                    for y0 in 0..<height {
                                        adjacent3D.append(Point3D(x: 0, y: y0, z: -1))
                                    }
                                } else if x == 3 {
                                    for y0 in 0..<height {
                                        adjacent3D.append(Point3D(x: width - 1, y: y0, z: -1))
                                    }
                                } else if y == 1 {
                                    for x0 in 0..<width {
                                        adjacent3D.append(Point3D(x: x0, y: 0, z: -1))
                                    }
                                } else {
                                    for x0 in 0..<width {
                                        adjacent3D.append(Point3D(x: x0, y: height - 1, z: -1))
                                    }
                                }
                            } else {
                                adjacent3D.append(Point3D(x: adj.x, y: adj.y, z: 0))
                            }
                        }
                        
                        let currentBug = grid[y][x]
                        var neighboringBugs = 0
                        for adj in adjacent3D {
                            if adj.z == 1 {
                                if gridOutside[adj.y][adj.x] == 1 {
                                    neighboringBugs += 1
                                }
                            } else if adj.z == -1 {
                                if gridInside[adj.y][adj.x] == 1 {
                                    neighboringBugs += 1
                                }
                            } else {
                                if grid[adj.y][adj.x] == 1 {
                                    neighboringBugs += 1
                                }
                            }
                        }
                        
                        if currentBug == 1 {
                            if neighboringBugs == 1 {
                                lineArray.append(1)
                            } else {
                                lineArray.append(0)
                            }
                        } else {
                            if neighboringBugs == 1 || neighboringBugs == 2 {
                                lineArray.append(1)
                            } else {
                                lineArray.append(0)
                            }
                        }
                    }
                }
                
                newGrid.append(lineArray)
            }

            retval[z] = newGrid
        }
        
        return retval
    }
    
    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var gridDictionary = Grid3D()
        for z in -201...201 {
            var grid = Grid()
            for line in arr {
                var lineArray: [Int] = []
                for c in line {
                    if z == 0 {
                        if c == "." {
                            lineArray.append(0)
                        } else {
                            lineArray.append(1)
                        }
                    } else {
                        lineArray.append(0)
                    }
                }
                
                grid.append(lineArray)
            }
            
            gridDictionary[z] = grid
        }
        
        for _ in 1...200 {
            gridDictionary = processGridDictionary(dict: gridDictionary)
        }
        
        return countBugs(dict: gridDictionary)
    }
    
}

private class Puzzle_2019_24_Input: NSObject {

    static let puzzleInput_test = """
....#
#..#.
#..##
..#..
#....
"""

    static let puzzleInput = """
#.#.#
..#..
.#.##
.####
###..
"""
    
}
