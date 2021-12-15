//
//  Vertex.swift
//  AdventOfCode
//
//  Created by admin on 12/15/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

open class Vertex: Hashable, Equatable {
    open var identifier: String
    open var neighbors: [(Vertex, Int)] = []
    open var pathLengthFromStart = Int.max
    open var pathVerticesFromStart: [Vertex] = []

    public init(identifier: String) {
        self.identifier = identifier
    }

    public static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    open func clearCache() {
        pathLengthFromStart = Int.max
        pathVerticesFromStart = []
    }
}
