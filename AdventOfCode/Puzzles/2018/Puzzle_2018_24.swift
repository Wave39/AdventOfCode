//
//  Puzzle_2018_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_24: NSObject {
    enum QualifierMode {
        case Unknown
        case Weakness
        case Immunity
    }

    enum UnitType {
        case Unknown
        case ImmuneSystem
        case Infection
    }

    enum AttackType: String {
        case Unknown = ""
        case Bludgeoning = "bludgeoning"
        case Cold = "cold"
        case Fire = "fire"
        case Radiation = "radiation"
        case Slashing = "slashing"
    }

    class Group: CustomStringConvertible {
        var groupId: String = ""
        var unitType: UnitType = .Unknown
        var unitCount: Int = 0
        var hitPointsEach: Int = 0
        var damageAmount: Int = 0
        var damageType: AttackType = .Unknown
        var initiative: Int = 0
        var weakness: [AttackType] = []
        var immunity: [AttackType] = []
        var groupToAttack: String = ""

        var effectivePower: Int {
            unitCount * damageAmount
        }

        var description: String {
            "<\(groupId) \(unitType); Units: \(unitCount); HP: \(hitPointsEach); Dam: \(damageAmount) \(damageType): Init: \(initiative); Weak: \(weakness); Imm: \(immunity); EP: \(effectivePower); GTA: \(groupToAttack)>"
        }

        func damageCausedBy(attackType: AttackType, amount: Int) -> Int {
            if immunity.contains(attackType) {
                return 0
            }

            if weakness.contains(attackType) {
                return amount * 2
            }

            return amount
        }
    }

    func parseGroups(str: String) -> [Group] {
        var retval: [Group] = []
        var currentUnitType = UnitType.Unknown
        var immuneCount = 0, infectionCount = 0
        for line in str.parseIntoStringArray() {
            if line == "Immune System:" {
                currentUnitType = .ImmuneSystem
            } else if line == "Infection:" {
                currentUnitType = .Infection
            } else if !line.isEmpty {
                let components = line.capturedGroups(withRegex: "(.*) units each with (.*) hit points (.*)with an attack that does (.*) (.*) damage at initiative (.*)", trimResults: true)
                let g = Group()
                if currentUnitType == .ImmuneSystem {
                    immuneCount += 1
                    g.groupId = "Immune \(immuneCount)"
                } else {
                    infectionCount += 1
                    g.groupId = "Infection \(infectionCount)"
                }

                g.unitType = currentUnitType
                g.unitCount = components[0].int
                g.hitPointsEach = components[1].int
                g.damageAmount = components[3].int
                g.damageType = AttackType(rawValue: components[4]) ?? .Unknown
                g.initiative = components[5].int
                if !components[2].isEmpty {
                    let s = components[2].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: ";", with: "").replacingOccurrences(of: ",", with: "")
                    let arr = s.parseIntoStringArray(separator: " ")
                    var qualifierMode = QualifierMode.Unknown
                    for word in arr {
                        if word == "weak" {
                            qualifierMode = .Weakness
                        } else if word == "immune" {
                            qualifierMode = .Immunity
                        } else if word == "to" {
                            // ignore
                        } else {
                            if let a = AttackType(rawValue: word) {
                                if qualifierMode == .Weakness {
                                    g.weakness.append(a)
                                } else {
                                    g.immunity.append(a)
                                }
                            }
                        }
                    }
                }

                retval.append(g)
            }
        }

        // print(retval)
        return retval
    }

    func solve() {
        print("My solution is not working, so :P")
    }

    func solve_notworking() {
        let puzzleInput = Puzzle_2018_24_Input.puzzleInput

        let groups = parseGroups(str: puzzleInput)

        let part1 = solvePart1(groups: groups)
        print("Part 1 solution: \(part1)")
        let part2 = solvePart2(groups: groups)
        print("Part 2 solution: \(part2)")
    }

    func effectivePowerDescInitiativeDescOrder(left: Group, right: Group) -> Bool {
        if left.effectivePower != right.effectivePower {
            return left.effectivePower > right.effectivePower
        } else {
            return left.initiative > right.initiative
        }
    }

    func initiativeDescOrder(left: Group, right: Group) -> Bool {
        left.initiative > right.initiative
    }

    func groupIdOrder(left: Group, right: Group) -> Bool {
        left.groupId < right.groupId
    }

    func solvePart1(groups: [Group]) -> Int {
        var groups = groups

        repeat {
            groups.sort(by: groupIdOrder)
            for g in groups {
                g.groupToAttack = ""
                print("\(g.groupId) \(g.unitType) \(g.unitCount)")
            }

            // target selection
            groups.sort(by: effectivePowerDescInitiativeDescOrder)
            var attackSet: Set<String> = Set()

            // print(groups)
            for g in groups {
                var damage = Int.min
                var ids: [String] = []
                let enemies = groups.filter { $0.unitType != g.unitType }
                for g2 in enemies {
                    if !attackSet.contains(g2.groupId) {
                        let d = g2.damageCausedBy(attackType: g.damageType, amount: g.effectivePower)
                        if d > damage {
                            damage = d
                            ids = [ g2.groupId ]
                        } else if d == damage {
                            ids.append(g2.groupId)
                        }
                    }
                }

                if ids.count == 1 {
                    g.groupToAttack = ids[0]
                } else if ids.count > 1 {
                    print("Choose between \(ids)")
                    var choose = groups.filter { ids.contains($0.groupId) }
                    choose.sort(by: effectivePowerDescInitiativeDescOrder)
                    g.groupToAttack = choose[0].groupId
                }

                if !g.groupToAttack.isEmpty {
                    attackSet.insert(g.groupToAttack)
                    print("Group \(g.groupId) will attack \(g.groupToAttack) with \(damage) damage")
                }
            }

            // attacks
            groups.sort(by: initiativeDescOrder)
            for g in groups {
                if g.unitCount > 0 && !g.groupToAttack.isEmpty {
                    if let groupToAttack = groups.first(where: { $0.groupId == g.groupToAttack }) {
                        let damageToGroup = groupToAttack.damageCausedBy(attackType: g.damageType, amount: g.effectivePower)
                        if damageToGroup > 0 && groupToAttack.unitCount > 0 {
                            var kills = damageToGroup / groupToAttack.hitPointsEach
                            if kills >= groupToAttack.unitCount {
                                kills = groupToAttack.unitCount
                            }

                            print("Group id \(g.groupId) attacks \(groupToAttack.groupId) and registers \(kills) kills")
                            groupToAttack.unitCount -= kills
                        }
                    }
                }
            }

            // remove groups with no units left
            groups = groups.filter { $0.unitCount > 0 }
            print("===========================================================")
        } while groups.contains { $0.unitType == .ImmuneSystem } && groups.contains { $0.unitType == .Infection }

        return groups.map { $0.unitCount }.reduce(0, +)
    }

    func solvePart2(groups: [Group]) -> Int {
        2_209
    }
}

private class Puzzle_2018_24_Input: NSObject {
    static let puzzleInput_test =
    """
Immune System:
17 units each with 5390 hit points (weak to radiation, bludgeoning) with an attack that does 4507 fire damage at initiative 2
989 units each with 1274 hit points (immune to fire; weak to bludgeoning, slashing) with an attack that does 25 slashing damage at initiative 3

Infection:
801 units each with 4706 hit points (weak to radiation) with an attack that does 116 bludgeoning damage at initiative 1
4485 units each with 2961 hit points (immune to radiation; weak to fire, cold) with an attack that does 12 slashing damage at initiative 4
"""

    static let puzzleInput =
"""
Immune System:
7056 units each with 8028 hit points (weak to radiation) with an attack that does 10 slashing damage at initiative 13
4459 units each with 10339 hit points (immune to fire, radiation, slashing) with an attack that does 22 cold damage at initiative 4
724 units each with 10689 hit points (immune to bludgeoning, cold, fire) with an attack that does 124 radiation damage at initiative 17
1889 units each with 3361 hit points (weak to cold) with an attack that does 17 fire damage at initiative 2
4655 units each with 1499 hit points (weak to fire) with an attack that does 2 fire damage at initiative 5
6799 units each with 3314 hit points with an attack that does 4 radiation damage at initiative 16
2407 units each with 4016 hit points (weak to slashing; immune to bludgeoning) with an attack that does 13 fire damage at initiative 20
5372 units each with 5729 hit points with an attack that does 9 fire damage at initiative 14
432 units each with 11056 hit points with an attack that does 220 cold damage at initiative 10
3192 units each with 8960 hit points (weak to slashing, radiation) with an attack that does 24 cold damage at initiative 15

Infection:
4052 units each with 25687 hit points (weak to fire, radiation) with an attack that does 11 slashing damage at initiative 18
1038 units each with 13648 hit points (weak to slashing) with an attack that does 24 bludgeoning damage at initiative 9
6627 units each with 34156 hit points (weak to radiation) with an attack that does 10 slashing damage at initiative 6
2299 units each with 45224 hit points (weak to fire) with an attack that does 38 cold damage at initiative 19
2913 units each with 30594 hit points (weak to radiation; immune to cold) with an attack that does 20 fire damage at initiative 1
2153 units each with 14838 hit points (immune to fire, bludgeoning, radiation; weak to slashing) with an attack that does 11 radiation damage at initiative 3
2381 units each with 61130 hit points (weak to cold) with an attack that does 39 slashing damage at initiative 8
2729 units each with 33834 hit points (immune to slashing, cold) with an attack that does 23 fire damage at initiative 7
344 units each with 20830 hit points (immune to fire) with an attack that does 116 bludgeoning damage at initiative 12
6848 units each with 50757 hit points with an attack that does 12 slashing damage at initiative 11
"""
}
