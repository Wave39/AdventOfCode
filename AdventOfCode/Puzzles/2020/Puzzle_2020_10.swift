//
//  Puzzle_2020_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/10/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2020_10: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    private func solvePart1(str: String) -> Int {
        var arr = str.parseIntoIntArray().sorted()
        arr.insert(0, at: 0)
        arr.append((arr.max() ?? 0) + 3)
        var ones = 0
        var threes = 0
        for idx in 0..<(arr.count - 1) {
            let diff = arr[idx + 1] - arr[idx]
            if diff == 1 {
                ones += 1
            } else if diff == 3 {
                threes += 1
            }
        }

        return ones * threes
    }

    private func getRunPermutationCount(arr: [Int]) -> Int {
        let combinations = arr.combinationsWithoutRepetition.filter { $0.contains(arr.first ?? 0) && $0.contains(arr.last ?? 0) }
        var valid = 0
        for combination in combinations {
            var combinationGood = true
            for idx in 0..<(combination.count - 1) {
                if arr[idx + 1] - arr[idx] > 3 {
                    combinationGood = false
                }
            }

            if combination.count == 2 && ((arr.last ?? 0) - (arr.first ?? 0)) > 3 {
                combinationGood = false
            }

            if combinationGood {
                valid += 1
            }
        }

        return valid
    }

    private func solvePart2(str: String) -> Int {
        var arr = str.parseIntoIntArray().sorted()
        arr.insert(0, at: 0)
        arr.append(arr.max() ?? 0 + 3)
        var runs: [[Int]] = []
        var currentRun: [Int] = []
        for idx in 0..<(arr.count - 1) {
            let diff = arr[idx + 1] - arr[idx]
            if diff == 1 {
                currentRun.append(arr[idx])
                currentRun.append(arr[idx + 1])
            } else if diff == 3 {
                if !currentRun.isEmpty {
                    runs.append(currentRun.unique().sorted())
                    currentRun = []
                }
            }
        }

        if !currentRun.isEmpty {
            runs.append(currentRun.unique().sorted())
        }

        var count = 1
        for r in runs {
            count *= getRunPermutationCount(arr: r)
        }

        return count
    }
}

private class Puzzle_Input: NSObject {
    static let puzzleInput_test1 = """
16
10
15
5
1
11
7
19
6
12
4
"""

    static let puzzleInput_test2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

    static let puzzleInput = """
144
10
75
3
36
80
143
59
111
133
1
112
23
62
101
137
41
24
8
121
35
105
161
69
52
21
55
29
135
142
38
108
141
115
68
7
98
82
9
72
118
27
153
140
61
90
158
102
28
134
91
2
17
81
31
15
120
20
34
56
4
44
74
14
147
11
49
128
16
99
66
47
125
155
130
37
67
54
60
48
136
89
119
154
122
129
163
73
100
85
95
30
76
162
22
79
88
150
53
63
92
"""
}
