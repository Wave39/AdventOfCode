//
//  CollectionExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/26/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at a given index in the collection if it exists
    ///
    /// - Parameter index: The index for which to retrieve the element.
    subscript(safe index: Self.Index) -> Self.Iterator.Element? {
        guard index >= startIndex else {
            return nil
        }

        guard index < endIndex else {
            return nil
        }

        return self[index]
    }

    /// Returns the elements at a given range in the collection if it exists
    ///
    /// - Parameter range: The range for which to retrieve the elements.
    subscript(safe range: Range<Self.Index>) ->  Self.SubSequence? {
        guard range.lowerBound >= startIndex else {
            return nil
        }

        guard range.upperBound <= endIndex else {
            return nil
        }

        return self[range]
    }

    /// Returns `self` if not empty, `nil` otherwise.
    var selfIfNotEmpty: Self? {
        guard !isEmpty else {
            return nil
        }
        return self
    }
}

extension RandomAccessCollection {
    func binarySearch(predicate: (Element) -> Bool) -> Index {
        var low = startIndex
        var high = endIndex
        while low != high {
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            if predicate(self[mid]) {
                low = index(after: mid)
            } else {
                high = mid
            }
        }
        return low
    }
}
