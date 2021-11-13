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

    public static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
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

    public func moveForward(direction: CompassDirection) -> Point2D {
        if direction == .North {
            return Point2D(x: self.x, y: self.y + 1)
        } else if direction == .East {
            return Point2D(x: self.x + 1, y: self.y)
        } else if direction == .South {
            return Point2D(x: self.x, y: self.y - 1)
        } else {
            return Point2D(x: self.x - 1, y: self.y)
        }
    }
}
