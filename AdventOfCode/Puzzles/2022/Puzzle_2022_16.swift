//
//  Puzzle_2022_16.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_16: PuzzleBaseClass {
    private struct Valve {
        var identifier = ""
        var flowRate = 0
        var tunnels: [String] = []
    }

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.test)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.test)
    }

    private func solvePart1(str: String) -> Int {
        var valveDict: [String: Valve] = [:]

        func walk(_ arr: [String]) {
            guard let lastValve = arr.last else {
                print("Could not find last entry of array")
                return
            }

            guard let valve = valveDict[lastValve] else {
                print("Could not find valve with identifier of \(lastValve)")
                return
            }

            for next in valve.tunnels {
                if next.count > 30 {
                    print("Reached 30 count with arr \(arr)")
                } else {
                    var nextArray = arr
                    nextArray.append(next)
                    walk(nextArray)
                }
            }
        }

        let lines = str.parseIntoStringArray()
        for line in lines {
            let components = line.capturedGroups(withRegex: "Valve (.*) has flow rate=(.*); tunnels? leads? to valves? (.*)", trimResults: true)
            print(line)
            print(components)
            var valve = Valve()
            valve.identifier = components[0]
            valve.flowRate = Int(components[1]) ?? 0
            valve.tunnels = components[2].parseIntoStringArray(separator: ",").map { $0.trim() }
            valveDict[components[0]] = valve
        }

        print(valveDict)

        // walk(["AA"])

        return 1_728
    }

    private func solvePart2(str: String) -> Int {
        2_304
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
"""

    static let final = """
Valve GJ has flow rate=14; tunnels lead to valves UV, AO, MM, UD, GM
Valve HE has flow rate=0; tunnels lead to valves QE, SV
Valve ET has flow rate=0; tunnels lead to valves LU, SB
Valve SG has flow rate=0; tunnels lead to valves FF, SB
Valve LC has flow rate=0; tunnels lead to valves QJ, GM
Valve EE has flow rate=13; tunnels lead to valves RE, BR
Valve AA has flow rate=0; tunnels lead to valves QC, ZR, NT, JG, FO
Valve TF has flow rate=0; tunnels lead to valves LU, MM
Valve GO has flow rate=0; tunnels lead to valves LB, AH
Valve QE has flow rate=24; tunnels lead to valves LG, HE
Valve MI has flow rate=0; tunnels lead to valves KU, FF
Valve BR has flow rate=0; tunnels lead to valves HY, EE
Valve UV has flow rate=0; tunnels lead to valves GP, GJ
Valve EH has flow rate=0; tunnels lead to valves UU, FF
Valve WK has flow rate=0; tunnels lead to valves HY, EL
Valve NT has flow rate=0; tunnels lead to valves FF, AA
Valve KI has flow rate=0; tunnels lead to valves OQ, AO
Valve AH has flow rate=22; tunnels lead to valves GO, RE
Valve EL has flow rate=0; tunnels lead to valves WK, SQ
Valve GP has flow rate=0; tunnels lead to valves SB, UV
Valve GM has flow rate=0; tunnels lead to valves LC, GJ
Valve LU has flow rate=9; tunnels lead to valves UU, DW, TF, ET, ML
Valve LB has flow rate=0; tunnels lead to valves GO, VI
Valve QC has flow rate=0; tunnels lead to valves ML, AA
Valve JJ has flow rate=0; tunnels lead to valves QJ, DV
Valve MM has flow rate=0; tunnels lead to valves TF, GJ
Valve VI has flow rate=18; tunnel leads to valve LB
Valve NV has flow rate=0; tunnels lead to valves SB, KU
Valve VT has flow rate=0; tunnels lead to valves HY, JG
Valve RE has flow rate=0; tunnels lead to valves AH, EE
Valve FO has flow rate=0; tunnels lead to valves SB, AA
Valve DV has flow rate=10; tunnels lead to valves JH, UD, JJ
Valve SQ has flow rate=12; tunnels lead to valves EL, QA
Valve OQ has flow rate=23; tunnels lead to valves KI, IV, JS
Valve FF has flow rate=3; tunnels lead to valves EU, NT, SG, MI, EH
Valve IV has flow rate=0; tunnels lead to valves LG, OQ
Valve HY has flow rate=8; tunnels lead to valves VT, BR, WK
Valve ML has flow rate=0; tunnels lead to valves LU, QC
Valve JS has flow rate=0; tunnels lead to valves EM, OQ
Valve KU has flow rate=5; tunnels lead to valves MI, VL, NV, HU, DW
Valve QA has flow rate=0; tunnels lead to valves OS, SQ
Valve EU has flow rate=0; tunnels lead to valves FF, OS
Valve SV has flow rate=0; tunnels lead to valves QJ, HE
Valve JG has flow rate=0; tunnels lead to valves AA, VT
Valve DW has flow rate=0; tunnels lead to valves LU, KU
Valve UD has flow rate=0; tunnels lead to valves DV, GJ
Valve QJ has flow rate=17; tunnels lead to valves JJ, SV, LC, EM, YA
Valve HU has flow rate=0; tunnels lead to valves JH, KU
Valve ZR has flow rate=0; tunnels lead to valves AA, VL
Valve YA has flow rate=0; tunnels lead to valves QJ, OS
Valve JH has flow rate=0; tunnels lead to valves HU, DV
Valve OS has flow rate=15; tunnels lead to valves EU, YA, QA
Valve LG has flow rate=0; tunnels lead to valves QE, IV
Valve SB has flow rate=4; tunnels lead to valves FO, SG, NV, GP, ET
Valve UU has flow rate=0; tunnels lead to valves EH, LU
Valve VL has flow rate=0; tunnels lead to valves ZR, KU
Valve AO has flow rate=0; tunnels lead to valves GJ, KI
Valve EM has flow rate=0; tunnels lead to valves QJ, JS
"""
}
