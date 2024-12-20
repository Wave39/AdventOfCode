//
//  ArrayExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension Array {
    var combinationsWithoutRepetition: [[Element]] {
        guard !isEmpty else {
            return [[]]
        }
        return Array(self[1...]).combinationsWithoutRepetition.flatMap { [$0, [self[0]] + $0] }
    }

    func generatePermutations() -> [[Element]] {
        var retval: [[Element]] = []
        var arrCopy = self

        func permutations(_ n: Int, _ a: inout [Element]) {
            if n == 1 {
                retval.append(a)
                return
            }

            for i in 0..<(n - 1) {
                permutations(n - 1, &a)
                a.swapAt(n - 1, (n % 2 == 1) ? 0 : i)
            }

            permutations(n - 1, &a)
        }

        permutations(arrCopy.count, &arrCopy)

        return retval
    }

    func mapped<Value>(by keyPath: KeyPath<Element, Value>) -> [Value: Element] {
        let keys = self.map { $0[keyPath: keyPath] }
        return Dictionary(uniqueKeysWithValues: zip(keys, self))
    }

    private func combinations(of elements: ArraySlice<Element>, count: Int) -> [[Element]] {
        guard count > 0 else { return [[]] }
        guard let first = elements.first else { return [] }

        let head = [first]
        let combos = combinations(of: elements.dropFirst(), count: count - 1)
        let withHead = combos.map { head + $0 }
        return withHead + combinations(of: elements.dropFirst(), count: count)
    }

    func combinations(of count: Int) -> [[Element]] {
        return combinations(of: ArraySlice(self), count: count)
    }

    func generateCombinationsOfSize(_ size: Int) -> [[Element]] {
        var results = [[Element]]()
        for _ in 1...size {
            let oldResults = results
            results = []
            for newElement in self {
                if oldResults.isEmpty {
                    results.append([newElement])
                } else {
                    for oldResult in oldResults {
                        results.append(oldResult + [newElement])
                    }
                }
            }
        }

        return results
    }

    func chunked(by condition: (Element, Element) -> Bool) -> [[Element]] {
        guard !isEmpty else { return [] }
        var result = [[Element]]()
        var tmp = [Element]()
        for index in 0 ..< self.count - 1 {
            tmp.append(self[index])
            if !condition(self[index], self[index + 1]) {
                result.append(tmp)
                tmp.removeAll()
            }
        }
        tmp.append(self[self.count - 1])
        result.append(tmp)

        return result
    }
}

public extension Array where Element == Int {
    func countIntegerGaps() -> Int {
        guard self.count > 1 else { return 0 }
        var gapCount = 0
        for i in 0..<self.count - 1 {
            let difference = self[i + 1] - self[i]
            if difference > 1 {
                gapCount += 1
            }
        }

        return gapCount
    }
}
