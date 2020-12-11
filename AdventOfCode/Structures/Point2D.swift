//
//  Point2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Point2D: Hashable, CustomStringConvertible {
    var x : Int = 0
    var y : Int = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    
    static var origin: Point2D {
        return Point2D(x: 0, y: 0)
    }
    
    var description: String {
        return "(\(x),\(y))"
    }
    
    static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func maximumBounds(arr: [Point2D]) -> Point2D {
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
    
    func manhattanDistanceTo(pt: Point2D) -> Int {
        return abs(self.x - pt.x) + abs(self.y - pt.y)
    }
    
    func adjacentLocations(includeDiagonals: Bool = false) -> [Point2D] {
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
    
    func moveForward(direction: CompassDirection) -> Point2D {
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
