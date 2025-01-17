//
//  SequenceExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/10/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}


public extension Sequence {
    @inlinable func elements() throws(DestructuringError) -> (Element, Element) {
        let result: Void = ()
        var iterator = makeIterator()
        guard let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value) else { throw .notEnoughElements }
        guard iterator.next() == nil else { throw .tooManyElements }
        return result
    }

    @inlinable func elements() throws(DestructuringError) -> (Element, Element, Element) {
        let result: Void = ()
        var iterator = makeIterator()
        guard let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value) else { throw .notEnoughElements }
        guard iterator.next() == nil else { throw .tooManyElements }
        return result
    }

    @inlinable func elements() throws(DestructuringError) -> (Element, Element, Element, Element) {
        let result: Void = ()
        var iterator = makeIterator()
        guard let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value),
              let value = iterator.next(), case let result = join(result, value) else { throw .notEnoughElements }
        guard iterator.next() == nil else { throw .tooManyElements }
        return result
    }
}

@usableFromInline func join<Prefix>(_ value: Void, _ prefix: Prefix) -> (Prefix) {
    prefix
}

@usableFromInline func join<each T, Suffix>(_ value: (repeat each T), _ suffix: Suffix) -> (repeat each T, Suffix) {
    (repeat each value, suffix)
}

@_disfavoredOverload
@usableFromInline func join<Prefix, each T>(_ prefix: Prefix, _ value: (repeat each T)) -> (Prefix, repeat each T) {
    (prefix, repeat each value)
}

extension StringProtocol where Self.SubSequence == Substring {
    public func split(_ separator: String, maxSplits: Int = .max, omittingEmptySubsequences: Bool = true) -> [String] {
        split(separator: separator, maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences).map(String.init)
    }
}

public enum DestructuringError: Error {
    case notEnoughElements
    case tooManyElements
}
