//
//  Size2D.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/26/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public struct Size2D: Equatable, Sendable {
    public let width: Int
    public let height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }

    public static var zero: Size2D {
        .init(width: 0, height: 0)
    }
}
