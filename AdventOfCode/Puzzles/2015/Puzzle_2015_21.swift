//
//  Puzzle_2015_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 3/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2015_21: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        class Player {
            var hitPoints: Int = 0
            var damage: Int = 0
            var armor: Int = 0

            init (hitPoints: Int, damage: Int, armor: Int) {
                self.hitPoints = hitPoints
                self.damage = damage
                self.armor = armor
            }
        }

        class Item {
            var name: String = ""
            var cost: Int = 0
            var damage: Int = 0
            var armor: Int = 0

            init (name: String, cost: Int, damage: Int, armor: Int) {
                self.name = name
                self.cost = cost
                self.damage = damage
                self.armor = armor
            }
        }

        var weaponArray: [Item] = [ ]
        weaponArray.append(Item(name: "Dagger", cost: 8, damage: 4, armor: 0))
        weaponArray.append(Item(name: "Shortsword", cost: 10, damage: 5, armor: 0))
        weaponArray.append(Item(name: "Warhammer", cost: 25, damage: 6, armor: 0))
        weaponArray.append(Item(name: "Longsword", cost: 40, damage: 7, armor: 0))
        weaponArray.append(Item(name: "Greataxe", cost: 74, damage: 8, armor: 0))

        var armorArray: [Item] = [ ]
        armorArray.append(Item(name: "Air", cost: 0, damage: 0, armor: 0))
        armorArray.append(Item(name: "Leather", cost: 13, damage: 0, armor: 1))
        armorArray.append(Item(name: "Chainmail", cost: 31, damage: 0, armor: 2))
        armorArray.append(Item(name: "Splintmail", cost: 53, damage: 0, armor: 3))
        armorArray.append(Item(name: "Bandedmail", cost: 75, damage: 0, armor: 4))
        armorArray.append(Item(name: "Platemail", cost: 102, damage: 0, armor: 5))

        var ringArray: [Item] = [ ]
        ringArray.append(Item(name: "Damage +1", cost: 25, damage: 1, armor: 0))
        ringArray.append(Item(name: "Damage +2", cost: 50, damage: 2, armor: 0))
        ringArray.append(Item(name: "Damage +3", cost: 100, damage: 3, armor: 0))
        ringArray.append(Item(name: "Defense +1", cost: 20, damage: 0, armor: 1))
        ringArray.append(Item(name: "Defense +2", cost: 40, damage: 0, armor: 2))
        ringArray.append(Item(name: "Defense +3", cost: 60, damage: 0, armor: 3))

        func didIWin(me: Player, them: Player) -> Bool {
            var playerHits = true
            repeat {
                if playerHits {
                    let damage = max(me.damage - them.armor, 1)
                    them.hitPoints -= damage
                } else {
                    let damage = max(them.damage - me.armor, 1)
                    me.hitPoints -= damage
                }

                playerHits.toggle()
            } while me.hitPoints > 0 && them.hitPoints > 0

            return me.hitPoints > 0
        }

        func getOnBitCount(_ n: Int) -> Int {
            let str = String(n, radix: 2)
            let str1s = str.filter { $0 == "1" }
            return str1s.count
        }

        func getRingByIndex(_ idx: Int) -> Item {
            let ring = Item(name: "", cost: 0, damage: 0, armor: 0)
            for i in 0...5 {
                if idx & (1 << i) > 0 {
                    ring.cost += ringArray[i].cost
                    ring.damage += ringArray[i].damage
                    ring.armor += ringArray[i].armor
                }
            }

            return ring
        }

        var leastGold = Int.max
        var mostGold = 0

        for weapon in weaponArray {
            for armor in armorArray {
                for ringIndex in 0...63 {
                    if getOnBitCount(ringIndex) <= 2 {
                        var goldSpent = 0
                        let me = Player(hitPoints: 100, damage: 0, armor: 0)
                        goldSpent += weapon.cost
                        goldSpent += armor.cost
                        me.damage = weapon.damage
                        me.armor += armor.armor
                        let ring = getRingByIndex(ringIndex)
                        me.damage += ring.damage
                        me.armor += ring.armor
                        goldSpent += ring.cost
                        let them = Player(hitPoints: 104, damage: 8, armor: 1)
                        if didIWin(me: me, them: them) {
                            if goldSpent < leastGold {
                                leastGold = goldSpent
                            }
                        } else {
                            if goldSpent > mostGold {
                                mostGold = goldSpent
                            }
                        }
                    }
                }
            }
        }

        return (leastGold, mostGold)
    }
}
