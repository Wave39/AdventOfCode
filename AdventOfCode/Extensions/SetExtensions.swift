//
//  SetExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/23/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension Set {
    static func + (lhs: Set, rhs: Set) -> Set {
        lhs.union(rhs)
    }

    static func + (lhs: Set, rhs: Set.Element) -> Set {
        lhs.union([rhs])
    }

    static func - (lhs: Set, rhs: Set) -> Set {
        lhs.subtracting(rhs)
    }

    static func - (lhs: Set, rhs: Set.Element) -> Set {
        lhs.subtracting([rhs])
    }
}
