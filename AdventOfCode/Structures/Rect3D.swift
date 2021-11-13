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
}
