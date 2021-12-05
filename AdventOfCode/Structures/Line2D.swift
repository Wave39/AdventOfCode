//
//  Line2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/5/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

public struct Line2D: Hashable, CustomStringConvertible {
    public var start = Point2D.origin
    public var end = Point2D.origin
    public var description: String {
        "\(start.description) -> \(end.description)"
    }

    public static func == (lhs: Line2D, rhs: Line2D) -> Bool {
        lhs.start == rhs.start && lhs.end == rhs.end
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(start)
        hasher.combine(end)
    }
}
