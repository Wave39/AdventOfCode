//
//  Rect2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

struct Rect2D: Hashable {
    var x1: Int = 0
    var y1: Int = 0
    var x2: Int = 0
    var y2: Int = 0

    func hash(into hasher: inout Hasher) {
        hasher.combine(x1)
        hasher.combine(y1)
        hasher.combine(x2)
        hasher.combine(y2)
    }

    var description: String {
        return "(\(x1),\(y1)) -> (\(x2),\(y2))"
    }

    static func == (lhs: Rect2D, rhs: Rect2D) -> Bool {
        return lhs.x1 == rhs.x1 && lhs.y1 == rhs.y1 && lhs.x2 == rhs.x2 && lhs.y2 == rhs.y2
    }

}
