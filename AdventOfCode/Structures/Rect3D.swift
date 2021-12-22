//
//  Rect3D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public struct Rect3D: Hashable {
    public var x1: Int = 0
    public var y1: Int = 0
    public var z1: Int = 0
    public var x2: Int = 0
    public var y2: Int = 0
    public var z2: Int = 0
    public var description: String {
        "(\(x1),\(y1),\(z1)) -> (\(x2),\(y2),\(z2))"
    }

    public static func == (lhs: Rect3D, rhs: Rect3D) -> Bool {
        lhs.x1 == rhs.x1 && lhs.y1 == rhs.y1 && lhs.z1 == rhs.z1 && lhs.x2 == rhs.x2 && lhs.y2 == rhs.y2 && lhs.z2 == rhs.z2
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x1)
        hasher.combine(y1)
        hasher.combine(z1)
        hasher.combine(x2)
        hasher.combine(y2)
        hasher.combine(z2)
    }

    public func normalize() -> Rect3D {
        var rect = self
        if rect.x1 > rect.x2 {
            Int.swap(&rect.x1, &rect.x2)
        }
        if rect.y1 > rect.y2 {
            Int.swap(&rect.y1, &rect.y2)
        }
        if rect.z1 > rect.z2 {
            Int.swap(&rect.z1, &rect.z2)
        }

        return rect
    }

    public func intersection(with rect: Rect3D) -> Rect3D? {
        let rect1 = self // .normalize()
        let rect2 = rect // .normalize()

        let leftX = max(rect1.x1, rect2.x1)
        let rightX = min(rect1.x2, rect2.x2)
        if rightX - leftX > 0 {
            let leftY = max(rect1.y1, rect2.y1)
            let rightY = min(rect1.y2, rect2.y2)
            if rightY - leftY > 0 {
                let leftZ = max(rect1.z1, rect2.z1)
                let rightZ = min(rect1.z2, rect2.z2)
                if rightZ - leftZ > 0 {
                    return Rect3D(x1: leftX, y1: leftY, z1: leftZ, x2: rightX, y2: rightY, z2: rightZ)
                }
            }
        }

        return nil
    }
}
