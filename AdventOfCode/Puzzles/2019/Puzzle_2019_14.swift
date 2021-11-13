//
//  Puzzle_2019_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/15/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_14: PuzzleBaseClass {
    private struct ChemicalComponent: CustomStringConvertible {
        var amount: Int = 0
        var compound: String = ""

        static func Create(_ str: String) -> ChemicalComponent {
            let s = str.trim()
            let arr = s.parseIntoStringArray(separator: " ")
            return ChemicalComponent(amount: arr[0].int, compound: arr[1])
        }

        var description: String {
            "\(amount) \(compound)"
        }
    }

    private struct ChemicalEquation: CustomStringConvertible {
        var reactants: [ChemicalComponent] = []
        var product = ChemicalComponent()

        var description: String {
            "\(reactants) => \(product)"
        }
    }

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solve(str: Puzzle_2019_14_Input.puzzleInput, part: 1)
    }

    public func solvePart2() -> Int {
        solve(str: Puzzle_2019_14_Input.puzzleInput, part: 2)
    }

    private func solve(str: String, part: Int) -> Int {
        let lines = str.parseIntoStringArray()
        var equations: [ChemicalEquation] = []
        for line in lines {
            var equation = ChemicalEquation()
            let arr1 = line.components(separatedBy: " => ")
            let arr2 = arr1[0].split(separator: ",")
            for r in arr2 {
                equation.reactants.append(ChemicalComponent.Create(String(r)))
            }

            equation.product = ChemicalComponent.Create(String(arr1[1]))
            equations.append(equation)
        }

        var excessCompounds: Dictionary<String, Int> = [:]

        func getOre(compound: String, amountNeeded: Int) -> Int {
            var amount = amountNeeded
            if compound == "ORE" {
                return amount
            }

            if let excessCompound = excessCompounds[compound] {
                if amount <= excessCompound {
                    excessCompounds[compound]? -= amount
                    return 0
                }

                amount -= excessCompound
            }

            excessCompounds[compound] = 0

            guard let equation = equations.first(where: { $0.product.compound == compound }) else {
                return 0
            }

            let multiple: Int
            if equation.product.amount > amount {
                multiple = 1
            } else {
                multiple = Int(ceil(Double(amount) / Double(equation.product.amount)))
            }

            let producedAmount = multiple * equation.product.amount

            var retval = 0
            for r in equation.reactants {
                retval += getOre(compound: r.compound, amountNeeded: r.amount * multiple)
            }

            if producedAmount > amount {
                excessCompounds[compound]? += (producedAmount - amount)
            }

            return retval
        }

        if part == 1 {
            return getOre(compound: "FUEL", amountNeeded: 1)
        }

        let availableOre = 1_000_000_000_000

        var step = Double(availableOre)
        var num = 1.0
        var retval = 0
        var lastBelow = 0
        var lastAbove = 0

        while true {
            excessCompounds = [:]
            let amountOfOreNeeded = getOre(compound: "FUEL", amountNeeded: Int(num))
            if amountOfOreNeeded < availableOre {
                lastBelow = Int(num)
            } else {
                lastAbove = Int(num)
            }

            step = (step / 2)
            if step < 1 {
                break
            }

            if amountOfOreNeeded > availableOre {
                num -= step
            } else {
                num += step
            }
        }

        for x in (lastBelow - 1)...(lastAbove + 1) {
            excessCompounds = [:]
            let ore = getOre(compound: "FUEL", amountNeeded: x)
            if ore <= availableOre {
                retval = x
            }
        }

        return retval
    }
}

private class Puzzle_2019_14_Input: NSObject {
    static let puzzleInput_test1 = """
10 ORE => 10 A
1 ORE => 1 B
7 A, 1 B => 1 C
7 A, 1 C => 1 D
7 A, 1 D => 1 E
7 A, 1 E => 1 FUEL
"""

    static let puzzleInput_test2 = """
9 ORE => 2 A
8 ORE => 3 B
7 ORE => 5 C
3 A, 4 B => 1 AB
5 B, 7 C => 1 BC
4 C, 1 A => 1 CA
2 AB, 3 BC, 4 CA => 1 FUEL
"""

    static let puzzleInput_test3 = """
157 ORE => 5 NZVS
165 ORE => 6 DCFZ
44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
179 ORE => 7 PSHF
177 ORE => 5 HKGWZ
7 DCFZ, 7 PSHF => 2 XJWVT
165 ORE => 2 GPVTF
3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
"""

    static let puzzleInput_test4 = """
2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
17 NVRVD, 3 JNWZP => 8 VPVL
53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
22 VJHF, 37 MNCFX => 5 FWMGM
139 ORE => 4 NVRVD
144 ORE => 7 JNWZP
5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
145 ORE => 6 MNCFX
1 NVRVD => 8 CXFTF
1 VJHF, 6 MNCFX => 4 RFSQX
176 ORE => 6 VJHF
"""

    static let puzzleInput_test5 = """
171 ORE => 8 CNZTR
7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
114 ORE => 4 BHXH
14 VRPVC => 6 BMBT
6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
5 BMBT => 4 WPTQ
189 ORE => 9 KTJDG
1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
12 VRPVC, 27 CNZTR => 2 XDBXC
15 KTJDG, 12 BHXH => 5 XCVML
3 BHXH, 2 VRPVC => 7 MZWV
121 ORE => 7 VRPVC
7 XCVML => 6 RJRHP
5 BHXH, 4 VRPVC => 5 LTCX
"""

    static let puzzleInput = """
8 LHFV => 3 PMVMQ
2 ZXNM, 1 PSVLS, 4 GRDNT, 26 GLZH, 3 VHJX, 16 BGPF, 1 LHVTN => 4 BTQL
10 NKHSG, 20 FCPC, 11 GRDNT => 5 HDJB
6 WPZN, 1 LHFV => 7 BGPF
1 WDXT, 1 PLCNZ => 3 QHFKR
12 LCHZ => 1 TPXCK
11 LSNG => 4 XFGH
195 ORE => 4 GRNC
8 XFGQ => 1 GRDNT
1 FBRG => 5 LCHZ
7 XZBJ, 8 RSZF, 9 SVDX => 9 LWDP
20 WDXT => 5 RQFRT
1 LXQWG, 1 GLZH => 6 SDLJ
4 XFGH => 1 GCZLZ
1 WPZN => 1 FBRG
19 XZBJ => 5 WXGV
1 GDXC => 6 WDXT
1 WXGV, 1 NKHSG, 2 LWDP => 5 FCNPB
4 LWDP, 5 BGPF => 9 KLRB
1 GMRN => 4 GLZH
1 RQFRT => 5 SVDX
2 HWKG => 7 LHFV
2 LCHZ, 13 JTJT, 10 TPXCK => 3 RSZF
29 MZTVH => 6 TSGR
9 NRFLK, 1 SVDX => 5 NKHSG
123 ORE => 9 GDXC
1 PZPBV, 21 PMVMQ, 1 GCZLZ => 8 SKZGB
3 GRNC, 5 GDXC => 8 QZVM
6 VTDQ, 13 TCQW, 3 FCNPB, 48 PSVLS, 3 RLNF, 73 BTQL, 5 MHRVG, 26 BGPF, 26 HDJB, 5 XFGQ, 6 HTFL => 1 FUEL
5 QZVM, 2 JTJT => 1 PXKHG
3 LSNG, 1 PMVMQ => 8 VTDQ
31 XFGH => 1 FCPC
9 PSVLS => 8 FWGTF
1 GRNC => 3 WPZN
16 JBXDX, 4 GRNC => 6 HWKG
1 SKZGB, 5 RSZF => 4 XZBJ
134 ORE => 9 CTDRZ
1 SVDX, 2 TPXCK => 7 JTJT
6 RQFRT, 4 KBCW => 3 BGNLR
12 KLRB, 12 LHFV => 4 HTFL
2 GMRN => 6 XFGQ
16 WNSW, 12 SKZGB => 8 LXQWG
2 NRFLK, 2 CTDRZ => 9 JBXDX
1 PZPBV => 8 RLNF
2 JTJT, 5 GCZLZ => 3 WNSW
5 WXGV, 2 LCHZ => 2 SCDS
1 QHFKR => 3 GMRN
10 JTJT, 2 HRCG => 8 KBCW
7 HWKG => 4 PSVLS
7 WNSW, 1 PXKHG, 3 BGNLR => 9 MZTVH
15 TPXCK, 11 LHFV => 5 HRCG
1 LSNG, 1 HWKG => 3 PZPBV
7 BGPF => 9 PLCNZ
1 ZGWT => 6 ZXNM
26 NKHSG, 1 LHFV, 2 JTJT, 26 WXGV, 6 SDLJ, 1 KLRB, 1 TSGR => 8 TCQW
154 ORE => 4 NRFLK
1 GMRN => 3 VHJX
5 QZVM, 3 GDXC => 7 LSNG
5 WNSW => 5 ZGWT
6 QHFKR, 8 PZPBV, 10 FBRG, 13 FWGTF, 1 LHVTN, 4 SCDS, 8 VHJX, 7 TSGR => 6 MHRVG
12 GLZH => 5 LHVTN
"""
}
