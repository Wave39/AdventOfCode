//
//  Puzzle_2017_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_24: PuzzleBaseClass {

    typealias Bridge = [Int]

    struct Component {
        var leftPort: Int = 0
        var rightPort: Int = 0
        static func == (lhs: Component, rhs: Component) -> Bool {
            return (lhs.leftPort == rhs.leftPort && lhs.rightPort == rhs.rightPort) || (lhs.leftPort == rhs.rightPort && lhs.rightPort == rhs.leftPort)
        }
        static func != (lhs: Component, rhs: Component) -> Bool {
            return !(lhs == rhs)
        }

    }

    typealias Components = [Component]

    var bridges: [Bridge] = []

    func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = PuzzleInput.final
        let components = parsePuzzleInput(str: puzzleInput)
        return solvePuzzle(components: components)
    }

    func parsePuzzleInput(str: String) -> Components {
        var retval: [Component] = []
        for line in str.split(separator: "\n") {
            let port = line.split(separator: "/")
            var comp = Component()
            comp.leftPort = Int(String(port[0]))!
            comp.rightPort = Int(String(port[1]))!
            retval.append(comp)
        }

        return retval
    }

    func solvePuzzle(components: Components) -> (Int, Int) {
        bridges = []
        let startingComponents = components.filter { $0.leftPort == 0 || $0.rightPort == 0 }
        for c in startingComponents {
            buildBridge(oldBridge: [], components: components, component: c)
        }

        var part1Strength = 0
        var part2Length = 0
        var part2Strength = 0
        for b in bridges {
            let bridgeStrength = b.reduce(0, +)
            if bridgeStrength > part1Strength {
                part1Strength = bridgeStrength
            }

            if b.count > part2Length {
                part2Length = b.count
                part2Strength = bridgeStrength
            } else if b.count == part2Length {
                if bridgeStrength > part2Strength {
                    part2Strength = bridgeStrength
                }
            }
        }

        return (part1Strength, part2Strength)
    }

    func buildBridge(oldBridge: Bridge, components: Components, component: Component) {
        var newBridge = oldBridge
        let searchValue = newBridge.last ?? 0
        if component.leftPort == searchValue {
            newBridge.append(component.leftPort)
            newBridge.append(component.rightPort)
        } else {
            newBridge.append(component.rightPort)
            newBridge.append(component.leftPort)
        }

        bridges.append(newBridge)
        let newComponents = components.filter { $0 != component }
        let nextComponents = newComponents.filter { $0.leftPort == newBridge.last! || $0.rightPort == newBridge.last! }
        for c in nextComponents {
            buildBridge(oldBridge: newBridge, components: newComponents, component: c)
        }
    }

}

private class PuzzleInput: NSObject {

    static let test1 =

"""
0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10
"""

    static let final =

"""
24/14
30/24
29/44
47/37
6/14
20/37
14/45
5/5
26/44
2/31
19/40
47/11
0/45
36/31
3/32
30/35
32/41
39/30
46/50
33/33
0/39
44/30
49/4
41/50
50/36
5/31
49/41
20/24
38/23
4/30
40/44
44/5
0/43
38/20
20/16
34/38
5/37
40/24
22/17
17/3
9/11
41/35
42/7
22/48
47/45
6/28
23/40
15/15
29/12
45/11
21/31
27/8
18/44
2/17
46/17
29/29
45/50
"""

}
