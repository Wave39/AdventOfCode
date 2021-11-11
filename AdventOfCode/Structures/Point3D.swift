//
//  Point3D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Point3D: Hashable, CustomStringConvertible {
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
    var description: String {
        "(\(x),\(y),\(z))"
    }

    static func == (lhs: Point3D, rhs: Point3D) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    static func maximumBounds(arr: [Point3D]) -> Point3D {
        var retval = Point3D(x: Int.min, y: Int.min, z: Int.min)
        for p in arr {
            if p.x > retval.x {
                retval.x = p.x
            }

            if p.y > retval.y {
                retval.y = p.y
            }

            if p.z > retval.z {
                retval.z = p.z
            }
        }

        return retval
    }

    static func minimumBounds(arr: [Point3D]) -> Point3D {
        var retval = Point3D(x: Int.max, y: Int.max, z: Int.max)
        for p in arr {
            if p.x < retval.x {
                retval.x = p.x
            }

            if p.y < retval.y {
                retval.y = p.y
            }

            if p.z < retval.z {
                retval.z = p.z
            }
        }

        return retval
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }

    func manhattanDistanceTo(pt: Point3D) -> Int {
        var retval = abs(self.x - pt.x)
        retval += abs(self.y - pt.y)
        retval += abs(self.z - pt.z)
        return retval
    }

    func adjacentLocations() -> [Point3D] {
        var retval: [Point3D] = []
        retval.append(Point3D(x: self.x, y: self.y - 1, z: self.z))
        retval.append(Point3D(x: self.x - 1, y: self.y, z: self.z))
        retval.append(Point3D(x: self.x + 1, y: self.y, z: self.z))
        retval.append(Point3D(x: self.x, y: self.y + 1, z: self.z))
        retval.append(Point3D(x: self.x, y: self.y, z: self.z - 1))
        retval.append(Point3D(x: self.x, y: self.y, z: self.z + 1))
        return retval
    }

    func adjacentLocationsWithDiagonals() -> [Point3D] {
        var retval: [Point3D] = []
        for deltaX in -1...1 {
            for deltaY in -1...1 {
                for deltaZ in -1...1 {
                    if deltaX != 0 || deltaY != 0 || deltaZ != 0 {
                        retval.append(Point3D(x: self.x + deltaX, y: self.y + deltaY, z: self.z + deltaZ))
                    }
                }
            }
        }

        return retval
    }
}
