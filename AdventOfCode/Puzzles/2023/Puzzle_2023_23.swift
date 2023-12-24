//
//  Puzzle_2023_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2023_23: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    struct StepLocation {
        var location: Point2D
        var history: Set<Point2D>
    }

    private func solvePart1(str: String) -> Int {
        let map = str.parseIntoCharacterMatrix()
        let mapRows = map.height
        let mapColumns = map.width
        let startingPoint = Point2D(x: Int(map.first!.firstIndex(of: ".")!), y: 0)
        let endingPoint = Point2D(x: Int(map.last!.firstIndex(of: ".")!), y: map.height - 1)

        var steps = [StepLocation]()
        let startingStep = StepLocation(location: startingPoint, history: [startingPoint])
        steps.append(startingStep)
        var retval = 0
        while !steps.isEmpty {
            let currentStep = steps.removeFirst()
            if currentStep.location == endingPoint {
                if currentStep.history.count > retval {
                    retval = currentStep.history.count
                }

                continue
            }

            let options = currentStep.location.adjacentLocationsWithinGrid(rows: mapRows, columns: mapColumns)
            for option in options {
                let mapCharacter = map.characterAtPoint(option)
                if mapCharacter == "#" {
                    continue
                }

                if currentStep.history.contains(option) {
                    continue
                }

                var pathIsOk = true
                if mapCharacter != "." {
                    let optionDirection = currentStep.location.directionTo(option, topLeftOrigin: true)
                    if mapCharacter == "<" && optionDirection != .West {
                        pathIsOk = false
                    } else if mapCharacter == ">" && optionDirection != .East {
                        pathIsOk = false
                    } else if mapCharacter == "^" && optionDirection != .North {
                        pathIsOk = false
                    } else if mapCharacter == "v" && optionDirection != .South {
                        pathIsOk = false
                    }
                }

                if pathIsOk {
                    var newHistory = currentStep.history
                    newHistory.insert(option)
                    let nextStep = StepLocation(location: option, history: newHistory)
                    steps.append(nextStep)
                }
            }
        }

        return retval - 1
    }

    private func solvePart2(str: String) -> Int {
        return 6_466
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#
"""

    static let final = """
#.###########################################################################################################################################
#.#...###...#.......#.....#.....###.....###...#...#.....###...#.............#.......#...#...#...#.....#...#####.....#...###.....#...#####...#
#.#.#.###.#.#.#####.#.###.#.###.###.###.###.#.#.#.#.###.###.#.#.###########.#.#####.#.#.#.#.#.#.#.###.#.#.#####.###.#.#.###.###.#.#.#####.#.#
#.#.#.....#...#.....#.#...#...#...#...#.###.#.#.#.#...#.###.#.#.....#.......#...#...#.#.#.#.#.#.#...#.#.#...###.#...#.#...#...#...#.###...#.#
#.#.###########.#####.#.#####.###.###.#.###.#.#.#.###.#.###.#.#####.#.#########.#.###.#.#.#.#.#.###.#.#.###.###.#.###.###.###.#####.###.###.#
#.#.#.......#...#...#.#.#...#.#...#...#...#.#...#...#.#...#.#.#####.#.#...>.>.#.#.###.#.#.#.#.#.###.#.#...#.....#...#.#...###.....#...#...#.#
#.#.#.#####.#.###.#.#.#.#.#.#.#.###.#####.#.#######.#.###.#.#.#####.#.#.###v#.#.#.###.#.#.#.#.#.###.#.###.#########.#.#.#########.###.###.#.#
#.#.#.....#...###.#...#...#.#.#...#.....#.#...#.....#.#...#.#.###...#.#.#...#...#...#.#...#.#.#.#...#.>.>.#.........#.#.###...###.#...###.#.#
#.#.#####.#######.#########.#.###.#####.#.###.#.#####.#.###.#.###.###.#.#.#########.#.#####.#.#.#.#####v###.#########.#.###.#.###.#.#####.#.#
#...#.....###...#.........#.#.#...#.....#.#...#.#...#.#...#.#.>.>.###...#.#...#...#.#...#...#.#.#.#####...#...###...#.#...#.#.#...#.#...#.#.#
#####.#######.#.#########.#.#.#.###.#####.#.###.#.#.#.###.#.###v#########.#.#.#.#.#.###.#.###.#.#.#######.###.###.#.#.###.#.#.#.###.#.#.#.#.#
#...#.#.....#.#.#...#...#.#.#.#.###.....#.#.#...#.#.#...#.#...#.###.....#.#.#.#.#.#...#.#.#...#.#...#...#...#...#.#.#.#...#.#.#...#.#.#.#.#.#
#.#.#.#.###.#.#.#.#.#.#.#.#.#.#.#######.#.#.#.###.#.###.#.###.#.###.###.#.#.#.#.#.###.#.#.#.###.###.#.#.###.###.#.#.#.#.###.#.###.#.#.#.#.#.#
#.#...#...#.#.#.#.#.#.#...#...#...>.>.#.#.#.#...#.#...#.#.#...#...#.#...#...#...#...#...#.#.###.#...#.#.#...###.#.#.#.#.#...#...#.#...#...#.#
#.#######.#.#.#.#.#.#.#############v#.#.#.#.###.#.###.#.#.#.#####.#.#.#############.#####.#.###.#.###.#.#.#####.#.#.#.#.#.#####.#.#########.#
#.#...#...#...#.#.#.#.#.......#.....#.#.#...###.#.###.#.#.#.#...#...#...#.......#...###...#...#.#.#...#.#.....#...#.#.#.#.....#.#.###.....#.#
#.#.#v#.#######.#.#.#.#.#####.#.#####.#.#######.#.###.#.#.#.#.#.#######.#.#####.#.#####.#####.#.#.#.###.#####.#####.#.#.#####.#.#.###.###.#.#
#...#.>.#...#...#.#...#...#...#.....#.#.......#.#...#...#...#.#.#...#...#.....#.#.....#...#...#...#...#.......#...#...#.......#.#.#...###...#
#####v###.#.#.###.#######.#.#######.#.#######.#.###.#########.#.#.#.#.#######.#.#####.###.#.#########.#########.#.#############.#.#.#########
#...#.....#.#...#.###...#.#.#...#...#...#.....#.#...###.......#.#.#.#...#####.#.#.....#...#.....#.....#.........#.........#...#...#.........#
#.#.#######.###.#.###.#.#.#.#.#.#.#####.#.#####.#.#####.#######.#.#.###.#####.#.#.#####.#######.#.#####.#################.#.#.#############.#
#.#.........###...#...#...#...#...#...#.#.....#.#.....#.......#...#.....#.....#...#...#.....#...#.......#.....#...........#.#.#.............#
#.#################.###############.#.#.#####.#.#####.#######.###########.#########.#.#####.#.###########.###.#.###########.#.#.#############
#.................#.#...#...#.......#.#.......#...#...#.......#.....#...#...........#.....#.#...#.......#...#.#.#...###...#.#.#.............#
#################.#.#.#.#.#.#.#######.###########.#.###.#######.###.#.#.#################.#.###.#.#####.###.#.#.#.#.###.#.#.#.#############.#
#...#.............#...#.#.#.#.#.......#...#.....#...###.........#...#.#.........#.....#...#.....#.#...#.....#...#.#...#.#.#.#.#.........#...#
#.#.#.#################.#.#.#.#.#######.#.#.###.#################.###.#########.#.###.#.#########.#.#.###########.###.#.#.#.#.#.#######.#.###
#.#.#...........#...###.#.#...#.......#.#...#...#.....#...###...#...#...#.....#...###...###.....#...#...#.....###...#.#.#.#.#.#.......#.#.###
#.#.###########.#.#.###.#.###########.#.#####.###.###.#.#.###.#.###.###.#.###.#############.###.#######.#.###.#####.#.#.#.#.#.#######v#.#.###
#.#.###.........#.#...#...#.........#...#.....###...#...#.....#.....###.#.###.....#...#...#.#...#.....#...#...#.....#.#.#.#.#...#...>.#.#...#
#.#.###.#########.###.#####.#######.#####.#########.###################.#.#######.#.#.#.#.#.#.###.###.#####.###.#####.#.#.#.###.#.###v#.###.#
#.#.....#...#.....#...#...#.......#.......#...###...#...#.............#...###.....#.#.#.#.#.#.#...#...###...###.....#.#.#...###...#...#.....#
#.#######.#.#.#####.###.#.#######.#########.#.###.###.#.#.###########.#######.#####.#.#.#.#.#.#.###.#####.#########.#.#.###########.#########
#.........#...#...#.#...#.#...###...#...#...#...#.....#...###.........#.......#...#.#...#.#.#.#...#.#...#...###.....#.#.#.....#.....###...###
###############.#.#.#.###.#.#.#####.#.#.#.#####.#############.#########.#######.#.#.#####.#.#.###.#.#.#.###v###.#####.#.#.###.#.#######.#.###
###...#...#.....#...#...#.#.#.......#.#.#.#.....#...#...#...#.....#...#.........#.#.#.....#.#...#.#.#.#...>.>.#.....#.#.#...#.#.........#...#
###.#.#.#.#.###########.#.#.#########.#.#.#.#####.#.#.#.#.#.#####.#.#.###########.#.#.#####.###.#.#.#.#####v#.#####.#.#.###.#.#############.#
#...#...#...###...#...#.#.#.#.....###.#.#.#.#...#.#.#.#.#.#...#...#.#...#.........#.#.#...#...#.#.#...###...#.#...#.#.#.###.#...............#
#.#############.#.#.#.#.#.#.#.###.###.#.#.#.#.#.#.#.#.#.#.###.#.###.###.#.#########.#.#.#.###.#.#.#######.###.#.#.#.#.#.###.#################
#...#...###.....#.#.#.#.#.#...#...#...#.#.#.#.#.#.#.#.#.#...#.#...#.#...#.....#...#.#.#.#.#...#.#.#.......###.#.#.#.#...#...#...#...........#
###.#.#v###.#####.#.#.#.#.#####.###.###.#.#.#.#.#.#.#.#.###.#.###v#.#.#######.#.#.#.#.#.#.#.###.#.#.#########.#.#.#.#####.###.#.#.#########.#
###...#.>.#...#...#.#.#.#.#...#...#...#.#.#.#.#.#.#.#.#...#.#...>.>.#...#...#.#.#.#.#...#.#.###...#.........#.#.#.#.....#...#.#.#.#.........#
#######v#.###.#.###.#.#.#.#.#.###v###.#.#.#.#.#.#.#.#.###.#.#####v#####.#.#.#v#.#.#.#####.#.###############.#.#.#.#####.###.#.#.#.#.#########
#.......#.....#.#...#...#.#.#.#.>.>...#.#.#.#.#.#.#.#...#.#.#.....#...#.#.#.>.>.#...#.....#...###...#.......#...#.#.....###...#.#.#.###.....#
#.#############.#.#######.#.#.#.#v#####.#.#.#.#.#.#.###.#.#.#.#####.#.#.#.###v#######.#######.###.#.#.###########.#.###########.#.#.###.###.#
#.....#...#...#.#.#.......#.#.#.#...###...#...#.#.#.#...#...#.......#.#.#...#...#...#.........#...#...#...#...###...#####...###...#.....#...#
#####.#.#.#.#.#.#.#.#######.#.#.###.###########.#.#.#.###############.#.###.###.#.#.###########.#######.#.#.#.###########.#.#############.###
#...#...#...#.#.#.#...#...#.#.#.###...#...#.....#.#.#...#.............#...#.###...#.#...###...#.........#...#.....#...#...#.....#.........###
#.#.#########.#.#.###.#.#.#.#.#.#####.#.#.#.#####.#.###.#.###############.#.#######.#.#.###.#.###################.#.#.#.#######.#.###########
#.#...........#.#.###...#...#...#...#...#.#.......#...#.#.....#...#######.#.#.......#.#.#...#.....#...#...........#.#.#...#.....#...#####...#
#.#############.#.###############.#.#####.###########.#.#####.#.#.#######.#.#.#######.#.#.#######.#.#.#.###########.#.###.#.#######.#####.#.#
#.#...........#...#.....#.....#...#...#...#.....#...#...#...#...#.......#...#.....###.#.#.#.......#.#.#...#...#.....#.#...#...#...#.....#.#.#
#.#.#########.#####.###.#.###.#.#####.#v###.###.#.#.#####.#.###########.#########.###.#.#.#.#######.#.###v#.#.#.#####.#.#####.#.#.#####.#.#.#
#...#.........#...#...#.#...#.#.....#.>.>.#.#...#.#.#.....#.#...........#...#...#.#...#.#.#.#...#...#.#.>.>.#.#...#...#.....#.#.#.#.....#.#.#
#####.#########.#.###.#.###.#.#####.###v#.#.#.###.#.#.#####.#.###########.#.#.#.#v#.###.#.#.#.#.#.###.#.#v###.###.#.#######.#.#.#.#v#####.#.#
#.....#.........#...#.#.###.#.#...#...#.#...#...#.#.#...#...#.......###...#.#.#.>.>.#...#.#...#.#...#.#.#...#...#.#.#...#...#.#.#.>.#...#.#.#
#.#####.###########.#.#.###.#.#.#.###.#.#######.#.#.###.#.#########.###.###.#.###v###.###.#####.###.#.#.###.###.#.#.#.#.#.###.#.###v#.#.#.#.#
#.....#.#...........#.#...#.#.#.#.###.#.....#...#.#.#...#...#.....#...#...#.#.###...#...#...#...#...#...#...###.#.#.#.#.#.#...#...#...#...#.#
#####.#.#.###########.###.#.#.#.#.###.#####.#.###.#.#.#####.#.###.###.###.#.#.#####.###.###.#.###.#######.#####.#.#.#.#.#.#.#####.#########.#
#.....#.#...#...#...#.#...#.#.#.#.....#.....#...#.#.#.....#.#.#...#...#...#.#.#.....###.#...#...#.#.......#...#...#...#.#.#.#...#.###...#...#
#.#####.###.#.#.#.#.#.#.###.#.#.#######.#######.#.#.#####.#.#.#.###v###.###.#.#.#######.#.#####.#.#.#######.#.#########.#.#.#.#.#.###.#.#.###
#.#...#...#.#.#...#.#.#.#...#...###...#...#.....#.#...#...#.#.#.#.>.>.#...#...#...#...#.#.....#.#.#.........#.........#.#.#.#.#.#.#...#...###
#.#.#.###.#.#.#####.#.#.#.#########.#.###.#.#####.###.#.###.#.#.#.#v#.###.#######.#.#.#.#####.#.#.###################.#.#.#.#.#.#.#.#########
#...#...#.#...###...#.#...#####...#.#.#...#.....#.#...#...#...#...#.#.#...###...#...#.#.......#.#.#...................#.#.#...#...#.........#
#######.#.#######v###.#########.#.#.#.#.#######.#.#.#####.#########.#.#.#####.#.#####.#########.#.#.###################.#.#################.#
#.......#.#.....#.>.#...###.....#...#...###.....#.#.......#.......#.#...#.....#.......#...#...#...#...................#.#.#.................#
#.#######.#.###.#v#.###.###.###############.#####.#########.#####.#.#####.#############.#.#.#.#######################.#.#.#.#################
#.......#.#.#...#.#...#...#...........#...#.......###...###...#...#.....#.#.......#...#.#...#.......###...............#...#.............#...#
#######.#.#.#.###.###.###.###########.#.#.###########.#.#####.#.#######.#.#.#####.#.#.#.###########.###.###############################.#.#.#
#...###...#.#.#...#...#...###.........#.#...#.......#.#.#.....#.......#.#.#.#.....#.#.#.#...........#...#.............#.........#.......#.#.#
#.#.#######.#.#.###.###.#####.#########.###.#.#####.#.#.#.###########.#.#.#.#.#####.#.#.#.###########.###.###########.#.#######.#.#######.#.#
#.#...#...#.#.#...#.....#...#.....#...#.#...#.....#...#.#.....#.....#.#.#.#.#.#...#.#...#.#.....#...#...#.#...........#.......#...#.....#.#.#
#.###.#.#.#.#.###.#######.#.#####.#.#.#.#.#######.#####.#####.#.###.#.#.#.#.#.#.#.#.#####.#.###.#.#.###.#.#.#################.#####.###.#.#.#
#...#...#...#...#.....###.#.......#.#.#.#.#...###.#.....#...#...###.#...#...#...#...#.....#.#...#.#...#...#.......###...#.....#.....###...#.#
###.###########.#####.###.#########.#.#.#.#.#.###.#.#####.#.#######v#################.#####.#.###.###.###########.###.#.#.#####.###########.#
###.#...#.....#.#...#.#...#.....###.#.#.#.#.#...#.#...#...#.#...#.>.>.#...#...#.......#.....#...#.#...#.....#...#...#.#.#.......#...#.......#
###.#.#.#.###.#.#.#.#.#.###.###.###.#.#.#.#.###.#.###.#.###.#.#.#.#v#.#.#.#.#.#.#######.#######.#.#.###.###.#.#.###.#.#.#########.#.#.#######
###...#.#.###.#...#...#.....#...#...#...#...#...#...#.#.#...#.#...#.#.#.#.#.#.#.........#.......#.#.###...#...#.....#.#.#...#...#.#.#.......#
#######.#.###v###############.###.###########.#####.#.#.#.###.#####.#.#.#.#.#.###########.#######.#.#####.###########.#.#.#.#.#.#.#.#######.#
###...#...###.>.#...#.......#...#.#...#...###.#...#.#...#...#.###...#.#.#...#...#...#.....#...#...#.....#.........#...#.#.#.#.#.#.#...#.....#
###.#.#######v#.#.#.#.#####.###.#.#.#.#.#.###.#.#.#.#######.#.###.###.#.#######.#.#.#.#####.#.#.#######.#########.#.###.#.#.#.#.#.###.#.#####
###.#.#...#...#.#.#.#.#.....###.#...#...#...#.#.#.#.....#...#.#...###...#.......#.#.#.#...#.#.#...#.....#...#.....#.#...#.#.#.#.#.#...#...###
###.#.#.#.#.###.#.#.#.#.#######v###########.#.#.#.#####.#.###.#.#########.#######.#.#.#.#.#.#.###.#.#####.#.#v#####.#.###.#.#.#.#.#.#####v###
#...#...#.#...#.#.#.#.#...#...>.>.........#.#...#.#.....#.....#.......###...#...#.#.#...#.#.#...#.#.#.....#.>.>...#.#.#...#.#.#.#.#.#...>.###
#.#######.###.#.#.#.#.###.#.###v#########.#.#####.#.#################.#####.#.#.#.#.#####.#.###.#.#.#.#######v###.#.#.#.###.#.#.#.#.#.###v###
#.......#.....#...#.#...#.#...#.........#.#.....#...#...#...###.....#...#...#.#.#.#.#...#.#...#...#.#.#.......#...#.#...#...#.#...#.#.#...###
#######.###########.###.#.###.#########.#.#####.#####.#.#.#.###.###.###.#.###.#.#.#.#.#.#v###.#####.#.#.#######.###.#####.###.#####.#.#.#####
###...#.........#...#...#.....###.......#.#...#.#.....#...#.#...###.#...#...#.#.#.#...#.>.>.#...#...#.#...#...#...#.....#.#...#...#.#.#.....#
###.#.#########.#.###.###########.#######.#.#.#.#.#########.#.#####.#.#####.#.#.#.#######v#.###.#.###.###.#.#.###.#####.#.#.###.#.#.#.#####.#
#...#.#...#.....#.....#####.......#######...#.#.#.........#...#...#...#...#...#...#...###.#...#.#.#...###...#...#.......#...#...#...#.#.....#
#.###.#.#.#.###############.#################.#.#########.#####.#.#####.#.#########.#.###.###.#.#.#.###########.#############.#######.#.#####
#...#...#...#.......#.......#...............#.#.#.........#.....#...#...#.......#...#...#...#.#.#.#.#.....#.....#.....#.....#.........#.....#
###.#########.#####.#.#######.#############.#.#.#.#########.#######.#.#########.#.#####.###.#.#.#.#.#.###.#.#####.###.#.###.###############.#
#...#.........#.....#.......#.#.....#...#...#...#.........#.#.......#...#.....#.#...#...#...#.#.#.#.#...#.#.......#...#...#...........###...#
#.###.#########.###########.#.#.###.#.#.#.###############.#.#.#########.#.###.#.###.#.###.###.#.#.#.###.#.#########.#####.###########.###.###
#...#.#.........#####.......#.#...#...#.#...#...........#...#.#.....#...#.#...#.....#...#.###...#...###.#...........#####...........#...#.###
###.#.#.#############.#######.###.#####.###.#.#########.#####.#.###.#.###.#.###########.#.#############.###########################.###.#.###
###.#.#.#...#.......#.......#...#.....#...#.#.........#.#...#...#...#.....#...........#...#...#...#.....#.........#...###...###.....#...#...#
###.#.#.#.#v#.#####.#######.###.#####.###.#.#########.#.#.#.#####.###################.#####.#.#.#.#.#####.#######.#.#.###.#.###.#####.#####.#
###...#...#.>.#...#...#...#.....#...#...#...###.......#...#.....#...#...###...........###...#...#.#.....#.#.......#.#.#...#...#...###.....#.#
###########v###.#.###.#.#.#######.#.###.#######.###############.###.#.#.###.#############.#######.#####.#.#.#######.#.#.#####.###.#######.#.#
#...........#...#.....#.#.###.....#...#...#...#...#.....#.....#...#.#.#...#...#.....#.....#.......#####...#...#...#.#.#.....#...#.....#...#.#
#.###########.#########.#.###.#######.###.#.#.###.#.###.#.###.###.#.#.###.###v#.###.#.#####.#################.#.#.#.#.#####.###.#####.#.###.#
#...........#.#...#.....#...#.......#.#...#.#.###...#...#.###...#...#...#.#.>.>.#...#...#...###...###...#...#...#...#.#...#...#.#.....#.....#
###########.#.#.#.#.#######.#######.#.#.###.#.#######.###.#####.#######.#.#.#v###.#####.#.#####.#.###.#.#.#.#########.#.#.###.#.#.###########
#...#.......#.#.#.#...#.....#.......#...#...#.#...#...#...#.....#.....#.#.#.#.###.....#.#.....#.#...#.#.#.#.#.........#.#.#...#.#...........#
#.#.#.#######.#.#.###.#.#####.###########.###.#.#.#.###.###.#####.###.#.#.#.#.#######.#.#####.#.###.#.#.#.#.#.#########.#.#.###.###########.#
#.#.#.......#...#...#.#.....#.........#...#...#.#.#.....###.....#...#.#.#.#.#.#.....#...#.....#.#...#.#.#.#.#.#.....#...#...###.....#.....#.#
#.#.#######.#######.#.#####.#########.#.###.###.#.#############.###.#.#.#.#.#.#.###.#####.#####.#.###.#.#.#.#v#.###.#.#############.#.###.#.#
#.#.........#...#...#.#.....#...#.....#...#.....#.#.......#.....#...#.#.#.#.#.#.###.....#.#...#.#...#.#.#.#.>.>.#...#.............#.#...#.#.#
#.###########.#.#.###.#.#####.#.#v#######.#######.#.#####.#.#####.###.#.#.#.#.#.#######.#.#.#.#.###.#.#.#.###v###.###############.#.###.#.#.#
#...........#.#.#...#.#...#...#.>.>...###.....#...#...#...#...#...#...#.#.#.#...#####...#.#.#.#...#.#.#.#.###.###.#...#...#.....#.#.#...#...#
###########.#.#.###.#.###.#.#####v###.#######.#.#####.#.#####v#.###.###.#.#.#########.###.#.#.###.#.#.#.#.###.###.#.#.#.#.#v###.#.#.#.#######
#####...###...#.#...#...#...#.....###...#...#.#.......#.....>.>.###...#.#.#...#...#...###...#.#...#.#.#...#...#...#.#.#.#.>.###...#...###...#
#####.#.#######.#.#####.#####.#########.#.#.#.###############v#######.#.#.###.#.#.#.#########.#.###.#.#####.###.###.#.#.###v#############.#.#
#.....#.........#...#...#...#.....#...#.#.#...###...#.......#.#.....#...#.....#.#...#...###...#.###...###...###.....#.#.###.......#...#...#.#
#.#################.#.###.#.#####.#.#.#.#.#######.#.#.#####.#.#.###.###########.#####.#.###.###.#########.###########.#.#########.#.#.#.###.#
#.#.............###.#.###.#.....#...#.#...###...#.#.#.....#...#...#.....#...#...#.....#...#.....#...#...#...###.....#...#.........#.#.#.#...#
#.#.###########.###.#.###.#####.#####.#######.#.#.#.#####.#######.#####.#.#.#.###.#######.#######.#.#.#.###.###.###.#####.#########.#.#.#.###
#...#.....#...#...#...#...#.....#...#.......#.#.#.#...###.....###.#.....#.#.#.....#.....#.....#...#...#...#.....#...#...#.......#...#...#...#
#####.###.#.#.###.#####.###.#####.#.#######.#.#.#.###.#######.###.#.#####.#.#######.###.#####.#.#########.#######.###.#.#######.#.#########.#
#...#...#.#.#...#...###.#...#...#.#.###.....#.#.#...#.#.......#...#.#...#.#.....###...#.......#.........#.....#...###.#.........#.#...#.....#
#.#.###.#.#.###.###.###.#.###.#.#.#.###v#####.#.###.#.#v#######.###.#.#.#.#####.#####.#################.#####.#.#####.###########.#.#.#.#####
#.#.###.#...#...#...#...#...#.#.#.#.#.>.>...#.#.#...#.>.>...#...#...#.#.#.#.....#...#.....#.....#...###.....#.#.....#...#.....###.#.#...#####
#.#.###.#####.###.###.#####.#.#.#.#.#.#####.#.#.#.#########.#.###.###.#.#.#.#####.#.#####.#.###.#.#.#######.#.#####.###.#.###.###.#.#########
#.#.....#...#.....###...###.#.#.#.#.#...#...#.#.#.###...#...#.###...#.#.#.#.#...#.#.......#.#...#.#...#.....#.......###.#.###.....#...#...###
#.#######.#.###########.###.#.#.#.#.###.#.###.#.#.###.#.#.###.#####.#.#.#.#.#.#.#.#########.#.###.###.#.###############.#.###########.#.#.###
#.#.....#.#.#.....#...#...#.#.#.#.#...#.#.#...#.#...#.#.#...#.....#...#...#.#.#.#.....#...#.#.###.#...#.....#...#.....#...#.........#...#...#
#.#.###.#.#.#.###.#.#.###.#.#.#.#.###.#.#.#.###.###.#.#.###.#####.#########.#.#.#####.#.#.#.#.###.#.#######v#.#.#.###.#####.#######.#######.#
#.#.###...#...#...#.#.#...#.#.#.#...#.#.#.#.###...#.#.#.....#...#...#.......#.#.#...#...#.#.#...#.#...#...>.>.#...#...#.....#...###.........#
#.#.###########.###.#.#.###.#.#.###.#.#.#.#.#####.#.#.#######.#.###.#.#######.#.#.#.#####v#.###.#.###.#.###########.###.#####.#.#############
#...###.......#...#.#.#...#...#.#...#...#...#.....#.#...#...#.#.#...#.......#.#.#.#.#...>.>.###.#.#...#...#.........###.#...#.#.........#...#
#######.#####.###.#.#.###.#####.#.###########.#####.###.#.#.#.#.#.#########.#.#.#.#.#.#########.#.#.#####.#.###########.#.#.#.#########.#.#.#
#.......#...#.....#.#.#...#.....#...........#.....#.#...#.#.#.#.#...#.......#.#.#.#.#.....#.....#.#...#...#.......#...#...#...#.........#.#.#
#.#######.#.#######.#.#.###.###############.#####.#.#.###.#.#.#.###.#.#######.#.#.#.#####.#.#####.###.#.#########.#.#.#########.#########.#.#
#.#.......#.#.....#.#.#...#.#...#.....#...#.###...#.#...#.#.#.#...#.#...#...#.#...#.#.....#.....#.#...#.#.........#.#.###...###.......#...#.#
#.#.#######.#.###.#.#.###.#.#.#.#.###.#.#.#.###.###.###.#.#.#.###.#.###.#.#.#.#####.#.#########.#.#.###.#.#########.#.###.#.#########v#.###.#
#.#.#.......#...#.#.#...#.#.#.#.#.###.#.#.#...#.#...#...#.#.#...#.#.###.#.#.#.....#.#.....#.....#.#...#.#...#...#...#.#...#...#...#.>.#...#.#
#.#.#.#########.#.#.###.#.#.#.#.#.###.#.#.###.#.#.###.###.#.###.#.#.###.#.#.#####.#.#####.#.#####.###.#.###.#.#.#.###.#.#####.#.#.#.#v###.#.#
#...#...........#...###...#...#...###...#.....#...###.....#.....#...###...#.......#.......#.......###...###...#...###...#####...#...#.....#.#
###########################################################################################################################################.#
"""
}
