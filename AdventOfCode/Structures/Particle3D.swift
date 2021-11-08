//
//  Particle3D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Particle3D: Hashable {
    var x: Int = 0
    var y: Int = 0
    var z: Int = 0
    var deltaX: Int = 0
    var deltaY: Int = 0
    var deltaZ: Int = 0

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(deltaX)
        hasher.combine(deltaY)
        hasher.combine(deltaZ)
    }

    var description: String {
        "(\(x),\(y),\(z)) -> (\(deltaX),\(deltaY),\(deltaZ))"
    }

    static func == (lhs: Particle3D, rhs: Particle3D) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.deltaX == rhs.deltaX && lhs.deltaY == rhs.deltaY && lhs.deltaZ == rhs.deltaZ
    }

    static func boundingRectangle(arr: [Particle3D]) -> Rect3D {
        var retval = Rect3D()
        retval.x1 = Int.max
        retval.y1 = Int.max
        retval.z1 = Int.max
        retval.x2 = Int.min
        retval.y2 = Int.min
        retval.z2 = Int.min

        for p in arr {
            if p.x < retval.x1 {
                retval.x1 = p.x
            }

            if p.y < retval.y1 {
                retval.y1 = p.y
            }

            if p.z < retval.z1 {
                retval.z1 = p.z
            }

            if p.x > retval.x2 {
                retval.x2 = p.x
            }

            if p.y > retval.y2 {
                retval.y2 = p.y
            }

            if p.z > retval.z2 {
                retval.z2 = p.z
            }
        }

        return retval
    }
}
