//
//  Puzzle_2017_02.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_02: PuzzleBaseClass {
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_2017_02_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_2017_02_Input.puzzleInput)
    }

    func solvePart1(str: String) -> Int {
        var total = 0
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var minValue = Int.max
            var maxValue = 0
            for element in line {
                let elementInt = element.int
                if elementInt < minValue {
                    minValue = elementInt
                }

                if elementInt > maxValue {
                    maxValue = elementInt
                }

            }

            total += (maxValue - minValue)
        }

        return total
    }

    func findEvenlyDivisibleIntegers(arr: [String]) -> (Int, Int) {
        for i in 0...(arr.count - 2) {
            for j in (i + 1)...(arr.count - 1) {
                var e1 = arr[i].int
                var e2 = arr[j].int
                if e1 < e2 {
                    let t = e1
                    e1 = e2
                    e2 = t
                }

                if e1.isMultiple(of: e2) {
                    return (e1, e2)
                }
            }
        }

        return (0, 0)
    }

    func solvePart2(str: String) -> Int {
        var total = 0
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            let ints = findEvenlyDivisibleIntegers(arr: line)
            total += (ints.0 / ints.1)
        }

        return total
    }
}

private class Puzzle_2017_02_Input: NSObject {
    static let puzzleInput_test1 =
"""
5 1 9 5
7 5 3
2 4 6 8
"""

    static let puzzleInput_test2 =
"""
5 9 2 8
9 4 7 3
3 8 6 5
"""

    static let puzzleInput =
"""
86    440    233    83    393    420    228    491    159    13    110    135    97    238    92    396
3646    3952    3430    145    1574    2722    3565    125    3303    843    152    1095    3805    134    3873    3024
2150    257    237    2155    1115    150    502    255    1531    894    2309    1982    2418    206    307    2370
1224    343    1039    126    1221    937    136    1185    1194    1312    1217    929    124    1394    1337    168
1695    2288    224    2667    2483    3528    809    263    2364    514    3457    3180    2916    239    212    3017
827    3521    127    92    2328    3315    1179    3240    695    3144    3139    533    132    82    108    854
1522    2136    1252    1049    207    2821    2484    413    2166    1779    162    2154    158    2811    164    2632
95    579    1586    1700    79    1745    1105    89    1896    798    1511    1308    1674    701    60    2066
1210    325    98    56    1486    1668    64    1601    1934    1384    69    1725    992    619    84    167
4620    2358    2195    4312    168    1606    4050    102    2502    138    135    4175    1477    2277    2226    1286
5912    6261    3393    431    6285    3636    4836    180    6158    6270    209    3662    5545    204    6131    230
170    2056    2123    2220    2275    139    461    810    1429    124    1470    2085    141    1533    1831    518
193    281    2976    3009    626    152    1750    1185    3332    715    1861    186    1768    3396    201    3225
492    1179    154    1497    819    2809    2200    2324    157    2688    1518    168    2767    2369    2583    173
286    2076    243    939    399    451    231    2187    2295    453    1206    2468    2183    230    714    681
3111    2857    2312    3230    149    3082    408    1148    2428    134    147    620    128    157    492    2879
"""
}
