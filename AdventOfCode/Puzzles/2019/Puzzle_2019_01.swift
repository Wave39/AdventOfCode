//
//  Puzzle-2019-01.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_01: PuzzleBaseClass {
    private func CalculateFuel(mass: Int) -> Int {
        Int(floor(Double(mass) / 3.0) - 2)
    }

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_01_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_01_Input.puzzleInput)
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoIntArray()

        var retval = 0
        for s in arr {
            retval += CalculateFuel(mass: s)
        }

        return retval
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoIntArray()

        var retval = 0
        for s in arr {
            var f = CalculateFuel(mass: s)
            while f > 0 {
                retval += f
                f = CalculateFuel(mass: f)
            }
        }

        return retval
    }
}

private class Puzzle_2019_01_Input: NSObject {
    static let puzzleInput = """
120333
142772
85755
90217
74894
86021
66768
147353
67426
145635
100070
88290
110673
109887
91389
121365
52760
58613
130918
57842
80622
50466
80213
85816
149832
133813
60211
69491
129415
141471
77916
98907
63440
109545
80183
143073
77783
88546
149648
128010
55530
54878
103885
57312
81011
148450
137947
67252
106264
149860
71677
101209
128477
112159
56027
53313
118916
98057
131668
61605
107488
65517
63594
84072
79214
141606
137375
112525
64572
126216
57013
130003
122450
50642
136844
96272
97861
59071
106870
116595
144966
88723
124038
63629
105304
52928
92917
147571
120553
113823
85524
71152
95199
102000
118874
133317
146849
60450
103307
117162
"""
}
