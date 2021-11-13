//
//  Rect2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public struct Rect2D: Hashable {
    public var x1: Int = 0
    public var y1: Int = 0
    public var x2: Int = 0
    public var y2: Int = 0
    public var description: String {
        "(\(x1),\(y1)) -> (\(x2),\(y2))"
    }

    public static func == (lhs: Rect2D, rhs: Rect2D) -> Bool {
        lhs.x1 == rhs.x1 && lhs.y1 == rhs.y1 && lhs.x2 == rhs.x2 && lhs.y2 == rhs.y2
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x1)
        hasher.combine(y1)
        hasher.combine(x2)
        hasher.combine(y2)
    }
}
