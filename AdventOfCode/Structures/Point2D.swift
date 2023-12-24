//
//  Point2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public struct Point2D: Hashable, CustomStringConvertible {
    public static var origin: Point2D {
        Point2D(x: 0, y: 0)
    }

    public var x: Int = 0
    public var y: Int = 0
    public var description: String {
        "(\(x),\(y))"
    }

    public static func == (left: Point2D, right: Point2D) -> Bool {
        left.x == right.x && left.y == right.y
    }

    public static func + (left: Point2D, right: Point2D) -> Point2D {
        Point2D(x: left.x + right.x, y: left.y + right.y)
    }

    public static func += (left: inout Point2D, right: Point2D) {
        left = Point2D(x: left.x + right.x, y: left.y + right.y)
    }

    public static func - (left: Point2D, right: Point2D) -> Point2D {
        Point2D(x: left.x - right.x, y: left.y - right.y)
    }

    public static func -= (left: inout Point2D, right: Point2D) {
        left = Point2D(x: left.x - right.x, y: left.y - right.y)
    }

    public static func maximumBounds(arr: [Point2D]) -> Point2D {
        var retval = Point2D(x: 0, y: 0)
        for p in arr {
            if p.x > retval.x {
                retval.x = p.x
            }

            if p.y > retval.y {
                retval.y = p.y
            }
        }

        return retval
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }

    public func manhattanDistanceTo(pt: Point2D) -> Int {
        abs(self.x - pt.x) + abs(self.y - pt.y)
    }

    // For the adjacentLocations array, the indices of the adjacent locations are:
    //
    // Including diagonals:
    //
    //  4  0  5
    //   \ | /
    // 1 - * - 2
    //   / | \
    //  6  3  7
    //
    // Not including diagonals:
    //
    //     0
    //     |
    // 1 - * - 2
    //     |
    //     3
    //

    public func adjacentLocations(includeDiagonals: Bool = false) -> [Point2D] {
        var retval: [Point2D] = []
        retval.append(Point2D(x: self.x, y: self.y - 1))
        retval.append(Point2D(x: self.x - 1, y: self.y))
        retval.append(Point2D(x: self.x + 1, y: self.y))
        retval.append(Point2D(x: self.x, y: self.y + 1))
        if includeDiagonals {
            retval.append(Point2D(x: self.x - 1, y: self.y - 1))
            retval.append(Point2D(x: self.x + 1, y: self.y - 1))
            retval.append(Point2D(x: self.x - 1, y: self.y + 1))
            retval.append(Point2D(x: self.x + 1, y: self.y + 1))
        }

        return retval
    }

    public func adjacentLocationsWithinGrid(rows: Int, columns: Int, includeDiagonals: Bool = false) -> [Point2D] {
        let locations = adjacentLocations(includeDiagonals: includeDiagonals)
        return locations.filter { $0.x >= 0 && $0.x < columns && $0.y >= 0 && $0.y < rows }
    }

    public func moveForward(direction: CompassDirection) -> Point2D {
        if direction == .North {
            return Point2D(x: self.x, y: self.y + 1)
        } else if direction == .East {
            return Point2D(x: self.x + 1, y: self.y)
        } else if direction == .South {
            return Point2D(x: self.x, y: self.y - 1)
        } else if direction == .West {
            return Point2D(x: self.x - 1, y: self.y)
        } else {
            return self
        }
    }

    public func moveForwardFromTopLeftOrigin(direction: CompassDirection) -> Point2D {
        if direction == .North {
            return Point2D(x: self.x, y: self.y - 1)
        } else if direction == .East {
            return Point2D(x: self.x + 1, y: self.y)
        } else if direction == .South {
            return Point2D(x: self.x, y: self.y + 1)
        } else if direction == .West {
            return Point2D(x: self.x - 1, y: self.y)
        } else {
            return self
        }
    }

    public func moveForward(direction: CompassDirection, rows: Int, columns: Int) -> Point2D? {
        let point = moveForward(direction: direction)
        if point.x < 0 || point.x >= columns || point.y < 0 || point.y >= rows {
            return nil
        }

        return point
    }

    public func moveForwardFromTopLeftOrigin(direction: CompassDirection, rows: Int, columns: Int) -> Point2D? {
        let point = moveForwardFromTopLeftOrigin(direction: direction)
        if point.x < 0 || point.x >= columns || point.y < 0 || point.y >= rows {
            return nil
        }

        return point
    }

    public func locationsAtManhattanDistance(_ manhattanDistance: Int) -> [Point2D] {
        if manhattanDistance == 0 {
            return [ self ]
        }

        var retval: [Point2D] = []
        var x1 = self.x
        var x2 = self.x
        for y in (y - manhattanDistance - 1)...(y - 1) {
            retval.append(Point2D(x: x1, y: y))
            if x1 != x2 {
                retval.append(Point2D(x: x2, y: y))
            }

            x1 -= 1
            x2 += 1
        }

        retval.append(Point2D(x: self.x - manhattanDistance - 1, y: self.y))
        retval.append(Point2D(x: self.x + manhattanDistance + 1, y: self.y))

        x1 = self.x
        x2 = self.x
        for y in stride(from: (y + manhattanDistance + 1), through: (y + 1), by: -1) {
            retval.append(Point2D(x: x1, y: y))
            if x1 != x2 {
                retval.append(Point2D(x: x2, y: y))
            }

            x1 -= 1
            x2 += 1
        }

        return retval
    }

    public func directionTo(_ point: Point2D, topLeftOrigin: Bool = false) -> CompassDirection {
        let delta = self - point
        if topLeftOrigin {
            if delta.x == 0 && delta.y == -1 {
                return .South
            } else if delta.x == 0 && delta.y == 1 {
                return .North
            } else if delta.x == 1 && delta.y == 0 {
                return .West
            } else {
                return .East
            }
        } else {
            if delta.x == 0 && delta.y == 1 {
                return .South
            } else if delta.x == 0 && delta.y == -1 {
                return .North
            } else if delta.x == 1 && delta.y == 0 {
                return .West
            } else {
                return .East
            }
        }
    }
}
