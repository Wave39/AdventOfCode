//
//  ArrayExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Array {
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

    var combinationsWithoutRepetition: [[Element]] {
        guard !isEmpty else {
            return [[]]
        }
        return Array(self[1...]).combinationsWithoutRepetition.flatMap { [$0, [self[0]] + $0] }
    }
}
