//
//  Puzzle_2018_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/30/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_06: NSObject {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        let puzzleInput = Puzzle_2018_06_Input.puzzleInput
        return solvePart1(str: puzzleInput)
    }

    func solvePart2() -> Int {
        let puzzleInput = Puzzle_2018_06_Input.puzzleInput
        return solvePart2(str: puzzleInput)
    }

    func parseIntoNormalizedCoordinates(str: String) -> [Point2D] {
        var retval: [Point2D] = []
        var minX = Int.max
        var minY = Int.max
        let arr = str.parseIntoStringArray()
        for s in arr {
            let coords = s.parseIntoStringArray(separator: ",")
            let x = coords[0].int
            let y = coords[1].int
            let p = Point2D(x: x, y: y)
            retval.append(p)
            if x < minX {
                minX = x
            }

            if y < minY {
                minY = y
            }
        }

        for idx in 0..<retval.count {
            retval[idx] = Point2D(x: retval[idx].x - minX, y: retval[idx].y - minY)
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        let points = parseIntoNormalizedCoordinates(str: str)
        let maxBounds = Point2D.maximumBounds(arr: points)
        var gridLocations: [[GridLocation]] = []
        for _ in 0...maxBounds.y {
            var lineArray: [GridLocation] = []
            for _ in 0...maxBounds.x {
                lineArray.append(GridLocation())
            }

            gridLocations.append(lineArray)
        }

        for row in 0...maxBounds.y {
            for col in 0...maxBounds.x {
                let gridLocation = gridLocations[row][col]
                let gl = Point2D(x: col, y: row)
                for point in points {
                    let d = gl.manhattanDistanceTo(pt: point)
                    if d < gridLocation.closestDistance {
                        gridLocation.closestDistance = d
                        gridLocation.closestPointIndex = [ point ]
                    } else if d == gridLocation.closestDistance {
                        gridLocation.closestPointIndex.append(point)
                    }
                }
            }
        }

        // accumulate set of points closest to the edges of the bounding box
        // this was what I missed the first time through
        var closestPointSet: Set<Point2D> = []
        for row in 0...maxBounds.y {
            var pointsToRemove: [Point2D] = []

            let pt1 = Point2D(x: 0, y: row)
            var minimumDistance1 = Int.max
            for point in points {
                let d = pt1.manhattanDistanceTo(pt: point)
                if d < minimumDistance1 {
                    minimumDistance1 = d
                    pointsToRemove = [ point ]
                } else if d == minimumDistance1 {
                    pointsToRemove.append(point)
                }
            }

            let pt2 = Point2D(x: maxBounds.x, y: row)
            var minimumDistance2 = Int.max
            for point in points {
                let d = pt2.manhattanDistanceTo(pt: point)
                if d < minimumDistance2 {
                    minimumDistance2 = d
                    pointsToRemove = [ point ]
                } else if d == minimumDistance2 {
                    pointsToRemove.append(point)
                }
            }

            for point in pointsToRemove {
                closestPointSet.insert(point)
            }
        }

        for col in 0...maxBounds.x {
            var pointsToRemove: [Point2D] = []

            let pt1 = Point2D(x: col, y: 0)
            var minimumDistance1 = Int.max
            for point in points {
                let d = pt1.manhattanDistanceTo(pt: point)
                if d < minimumDistance1 {
                    minimumDistance1 = d
                    pointsToRemove = [ point ]
                } else if d == minimumDistance1 {
                    pointsToRemove.append(point)
                }
            }

            let pt2 = Point2D(x: col, y: maxBounds.y)
            var minimumDistance2 = Int.max
            for point in points {
                let d = pt2.manhattanDistanceTo(pt: point)
                if d < minimumDistance2 {
                    minimumDistance2 = d
                    pointsToRemove = [ point ]
                } else if d == minimumDistance2 {
                    pointsToRemove.append(point)
                }
            }

            for point in pointsToRemove {
                closestPointSet.insert(point)
            }
        }

        var largestArea = 0
        for point in points {
            if point.x > 0 && point.x < maxBounds.x && point.y > 0 && point.y < maxBounds.y && !closestPointSet.contains(point) {
                var areaForThisPoint = 0
                for row in 0...maxBounds.y {
                    for col in 0...maxBounds.x {
                        let gridLocation = gridLocations[row][col]
                        if gridLocation.closestPointIndex.count == 1 && gridLocation.closestPointIndex[0] == point {
                            areaForThisPoint += 1
                        }
                    }
                }

                if areaForThisPoint > largestArea {
                    largestArea = areaForThisPoint
                }
            }
        }

        return largestArea
    }

    func solvePart2(str: String) -> Int {
        var retval = 0
        let points = parseIntoNormalizedCoordinates(str: str)
        let maxBounds = Point2D.maximumBounds(arr: points)
        var gridLocations: [[GridLocation]] = []
        for _ in 0...maxBounds.y {
            var lineArray: [GridLocation] = []
            for _ in 0...maxBounds.x {
                lineArray.append(GridLocation())
            }

            gridLocations.append(lineArray)
        }

        for row in 0...maxBounds.y {
            for col in 0...maxBounds.x {
                var totalDistance = 0
                let gl = Point2D(x: col, y: row)
                for point in points {
                    totalDistance += gl.manhattanDistanceTo(pt: point)
                }

                if totalDistance < 10000 {
                    retval += 1
                }
            }
        }

        return retval
    }
}

private class GridLocation {
    var closestDistance = Int.max
    var closestPointIndex: [Point2D] = []
}

private class Puzzle_2018_06_Input: NSObject {

    static let puzzleInput_test = """
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
"""

    static let puzzleInput = """
174, 356
350, 245
149, 291
243, 328
312, 70
327, 317
46, 189
56, 209
84, 60
308, 202
289, 331
201, 139
354, 201
283, 130
173, 144
110, 280
242, 250
196, 163
217, 300
346, 188
329, 225
112, 275
180, 190
255, 151
107, 123
86, 304
236, 88
313, 124
297, 187
203, 289
104, 71
100, 151
227, 47
318, 293
268, 225
116, 49
222, 125
261, 146
47, 117
119, 214
183, 242
136, 210
91, 300
326, 237
144, 273
300, 249
200, 312
305, 50
235, 265
322, 291
"""
}
