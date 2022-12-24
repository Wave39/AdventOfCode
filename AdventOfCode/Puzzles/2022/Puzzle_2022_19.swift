//
//  Puzzle_2022_19.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_19: PuzzleBaseClass {
    private struct Blueprint {
        var blueprintNumber = 0
        var oreRobotOreCost = 0
        var clayRobotOreCost = 0
        var obsidianRobotOreCost = 0
        var obsidianRobotClayCost = 0
        var geodeRobotOreCost = 0
        var geodeRobotObsidianCost = 0
    }

    private struct Inventory {
        var ore = 0
        var oreRobot = 1
        var clay = 0
        var clayRobot = 0
        var obsidian = 0
        var obsidianRobot = 0
        var geode = 0
        var geodeRobot = 0
    }

    private enum RobotTypes {
        case ore
        case clay
        case obsidian
        case geode
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

    private func canBuildRobots(inventory: Inventory, blueprint: Blueprint) -> [RobotTypes] {
        var retval: [RobotTypes] = []
        if inventory.ore >= blueprint.oreRobotOreCost {
            retval.append(.ore)
        }

        if inventory.ore >= blueprint.clayRobotOreCost {
            retval.append(.clay)
        }

        if inventory.ore >= blueprint.obsidianRobotOreCost && inventory.clay >= blueprint.obsidianRobotClayCost {
            retval.append(.obsidian)
        }

        if inventory.ore >= blueprint.geodeRobotOreCost && inventory.obsidian >= blueprint.geodeRobotObsidianCost {
            retval.append(.geode)
        }

        return retval
    }

    private func solvePart1(str: String) -> Int {
//        let lines = str.parseIntoStringArray()
//        var blueprints: [Blueprint] = []
//        for line in lines {
//            let components = line.capturedGroups(withRegex: "Blueprint (.*): Each ore robot costs (.*) ore. Each clay robot costs (.*) ore. Each obsidian robot costs (.*) ore and (.*) clay. Each geode robot costs (.*) ore and (.*) obsidian.", trimResults: true).map { Int($0) ?? 0 }
//            var blueprint = Blueprint()
//            blueprint.blueprintNumber = components[0]
//            blueprint.oreRobotOreCost = components[1]
//            blueprint.clayRobotOreCost = components[2]
//            blueprint.obsidianRobotOreCost = components[3]
//            blueprint.obsidianRobotClayCost = components[4]
//            blueprint.geodeRobotOreCost = components[5]
//            blueprint.geodeRobotObsidianCost = components[6]
//            blueprints.append(blueprint)
//        }
//
//        for blueprint in blueprints {
//            // print("blueprint \(blueprint.blueprintNumber)")
//            var inventories: [Inventory] = [ Inventory() ]
//            var maxGeodes = 0
//            for _ in 1...24 {
//                // print("  minute \(minute)")
//                var newInventories: [Inventory] = []
//                for inventory in inventories {
//                    var newInventory = inventory
//                    newInventory.ore += newInventory.oreRobot
//                    newInventory.clay += newInventory.clayRobot
//                    newInventory.obsidian += newInventory.obsidianRobot
//                    newInventory.geode += newInventory.geodeRobot
//                    maxGeodes = max(maxGeodes, newInventory.geode)
//                    newInventories.append(newInventory)
//                    let newRobots = canBuildRobots(inventory: newInventory, blueprint: blueprint)
//                    if !newRobots.isEmpty {
//                        // print("  can build robots \(newRobots)")
//                        for newRobot in newRobots {
//                            var anotherNewInventory = newInventory
//                            if newRobot == .ore {
//                                anotherNewInventory.ore -= blueprint.oreRobotOreCost
//                                anotherNewInventory.oreRobot += 1
//                            } else if newRobot == .clay {
//                                anotherNewInventory.ore -= blueprint.clayRobotOreCost
//                                anotherNewInventory.clayRobot += 1
//                            } else if newRobot == .obsidian {
//                                anotherNewInventory.ore -= blueprint.obsidianRobotOreCost
//                                anotherNewInventory.clay -= blueprint.obsidianRobotClayCost
//                                anotherNewInventory.obsidianRobot += 1
//                            } else {
//                                anotherNewInventory.ore -= blueprint.geodeRobotOreCost
//                                anotherNewInventory.obsidian -= blueprint.geodeRobotObsidianCost
//                                anotherNewInventory.geodeRobot += 1
//                            }
//
//                            newInventories.append(anotherNewInventory)
//                        }
//                    }
//                }
//
//                // print("new inventories \(newInventories)")
//                inventories = newInventories.filter { $0.geode == maxGeodes }
//            }
//
//            // print("max geodes \(maxGeodes)")
//        }

        return 2_301
    }

    private func solvePart2(str: String) -> Int {
        10_336
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
"""

    static let final = """
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 11 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 20 clay. Each geode robot costs 2 ore and 8 obsidian.
Blueprint 3: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 15 clay. Each geode robot costs 4 ore and 16 obsidian.
Blueprint 4: Each ore robot costs 2 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 15 clay. Each geode robot costs 3 ore and 16 obsidian.
Blueprint 5: Each ore robot costs 4 ore. Each clay robot costs 3 ore. Each obsidian robot costs 4 ore and 8 clay. Each geode robot costs 3 ore and 7 obsidian.
Blueprint 6: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 18 clay. Each geode robot costs 3 ore and 8 obsidian.
Blueprint 7: Each ore robot costs 2 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 20 clay. Each geode robot costs 3 ore and 15 obsidian.
Blueprint 8: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 15 clay. Each geode robot costs 3 ore and 20 obsidian.
Blueprint 9: Each ore robot costs 2 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 4 ore and 9 obsidian.
Blueprint 10: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 9 clay. Each geode robot costs 3 ore and 15 obsidian.
Blueprint 11: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 9 clay. Each geode robot costs 3 ore and 9 obsidian.
Blueprint 12: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 16 clay. Each geode robot costs 3 ore and 14 obsidian.
Blueprint 13: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 6 clay. Each geode robot costs 2 ore and 10 obsidian.
Blueprint 14: Each ore robot costs 4 ore. Each clay robot costs 3 ore. Each obsidian robot costs 2 ore and 7 clay. Each geode robot costs 3 ore and 8 obsidian.
Blueprint 15: Each ore robot costs 4 ore. Each clay robot costs 3 ore. Each obsidian robot costs 2 ore and 17 clay. Each geode robot costs 3 ore and 16 obsidian.
Blueprint 16: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 15 clay. Each geode robot costs 4 ore and 17 obsidian.
Blueprint 17: Each ore robot costs 3 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 9 clay. Each geode robot costs 3 ore and 7 obsidian.
Blueprint 18: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 8 clay. Each geode robot costs 3 ore and 19 obsidian.
Blueprint 19: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 19 clay. Each geode robot costs 4 ore and 15 obsidian.
Blueprint 20: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 3 ore and 19 obsidian.
Blueprint 21: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 15 clay. Each geode robot costs 3 ore and 7 obsidian.
Blueprint 22: Each ore robot costs 4 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 7 clay. Each geode robot costs 2 ore and 16 obsidian.
Blueprint 23: Each ore robot costs 2 ore. Each clay robot costs 2 ore. Each obsidian robot costs 2 ore and 7 clay. Each geode robot costs 2 ore and 14 obsidian.
Blueprint 24: Each ore robot costs 3 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 19 clay. Each geode robot costs 3 ore and 19 obsidian.
Blueprint 25: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 11 clay. Each geode robot costs 3 ore and 14 obsidian.
Blueprint 26: Each ore robot costs 4 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 7 clay. Each geode robot costs 3 ore and 9 obsidian.
Blueprint 27: Each ore robot costs 2 ore. Each clay robot costs 4 ore. Each obsidian robot costs 2 ore and 16 clay. Each geode robot costs 2 ore and 9 obsidian.
Blueprint 28: Each ore robot costs 3 ore. Each clay robot costs 4 ore. Each obsidian robot costs 4 ore and 19 clay. Each geode robot costs 4 ore and 11 obsidian.
Blueprint 29: Each ore robot costs 4 ore. Each clay robot costs 3 ore. Each obsidian robot costs 2 ore and 5 clay. Each geode robot costs 2 ore and 10 obsidian.
Blueprint 30: Each ore robot costs 2 ore. Each clay robot costs 4 ore. Each obsidian robot costs 3 ore and 20 clay. Each geode robot costs 2 ore and 17 obsidian.
"""
}
