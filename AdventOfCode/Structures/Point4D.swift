//
//  Point4D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Point4D: Hashable, CustomStringConvertible {
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
    var t: Int = 0

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(t)
    }

    var description: String {
        "(\(x),\(y),\(z),\(t))"
    }

    static func == (lhs: Point4D, rhs: Point4D) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.t == rhs.t
    }

    func manhattanDistanceTo(pt: Point4D) -> Int {
        var retval = abs(self.x - pt.x)
        retval += abs(self.y - pt.y)
        retval += abs(self.z - pt.z)
        retval += abs(self.t - pt.t)
        return retval
    }

    func adjacentLocationsWithDiagonals() -> [Point4D] {
        var retval: [Point4D] = []
        for deltaX in -1...1 {
            for deltaY in -1...1 {
                for deltaZ in -1...1 {
                    for deltaT in -1...1 {
                        if deltaX != 0 || deltaY != 0 || deltaZ != 0 || deltaT != 0 {
                            retval.append(Point4D(x: self.x + deltaX, y: self.y + deltaY, z: self.z + deltaZ, t: self.t + deltaT))
                        }
                    }
                }
            }
        }

        return retval
    }

}
