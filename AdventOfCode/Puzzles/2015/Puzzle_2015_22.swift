//
//  Puzzle_2015_22.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 3/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

private enum EffectType {
    case Shield
    case Poison
    case Recharge
}

private class Effect {
    var type: EffectType
    var turns: Int = 0

    init (type: EffectType, turns: Int) {
        self.type = type
        self.turns = turns
    }
}

private enum EffectResultType {
    case Armor
    case Damage
    case Mana
}

private class EffectResult {
    var type: EffectResultType
    var amount: Int = 0

    init (type: EffectResultType, amount: Int) {
        self.type = type
        self.amount = amount
    }
}

private enum SpellType {
    case None
    case MagicMissile
    case Drain
    case Shield
    case Poison
    case Recharge
}

private class Spell {
    var type: SpellType
    var manaCost: Int = 0
    var damage: Int = 0
    var healing: Int = 0
    var effect: Effect?
    var effectResult: EffectResult?

    init (type: SpellType, manaCost: Int, damage: Int, healing: Int, effect: Effect?, effectResult: EffectResult?) {
        self.type = type
        self.manaCost = manaCost
        self.damage = damage
        self.healing = healing
        self.effect = effect
        self.effectResult = effectResult
    }
}

private class GameState {
    var iteration: Int = 0
    var nextSpell: Spell?
    var playerHitPoints: Int = 0
    var playerCurrentMana: Int = 0
    var playerSpentMana: Int = 0
    var playerArmor: Int = 0
    var bossHitPoints: Int = 0
    var bossDamage: Int = 0
    var shieldTimer: Int = 0
    var poisonTimer: Int = 0
    var rechargeTimer: Int = 0
    var difficultyHard = false

    init (playerHitPoints: Int, playerCurrentMana: Int, bossHitPoints: Int, bossDamage: Int, difficultyHard: Bool) {
        self.playerHitPoints = playerHitPoints
        self.playerCurrentMana = playerCurrentMana
        self.bossHitPoints = bossHitPoints
        self.bossDamage = bossDamage
        self.difficultyHard = difficultyHard
    }

    func playerLoses() -> Bool {
        self.playerHitPoints <= 0
    }

    func bossLoses() -> Bool {
        self.bossHitPoints <= 0
    }

    func copy() -> GameState {
        let c = GameState(playerHitPoints: self.playerHitPoints, playerCurrentMana: self.playerCurrentMana, bossHitPoints: self.bossHitPoints, bossDamage: self.bossDamage, difficultyHard: self.difficultyHard)
        c.iteration = self.iteration
        c.playerSpentMana = self.playerSpentMana
        c.playerArmor = self.playerArmor
        c.shieldTimer = self.shieldTimer
        c.poisonTimer = self.poisonTimer
        c.rechargeTimer = self.rechargeTimer
        return c
    }

    func checkGameEndMana(part1LeastAmountOfMana: inout Int, part2LeastAmountOfMana: inout Int) {
        if bossLoses() {
            if difficultyHard {
                if playerSpentMana < part2LeastAmountOfMana {
                    part2LeastAmountOfMana = playerSpentMana
                }
            } else {
                if playerSpentMana < part1LeastAmountOfMana {
                    part1LeastAmountOfMana = playerSpentMana
                }
            }
        }
    }
}

class Puzzle_2015_22: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let noSpell = Spell(type: .None, manaCost: 0, damage: 0, healing: 0, effect: nil, effectResult: nil)
        let magicMissileSpell = Spell(type: .MagicMissile, manaCost: 53, damage: 4, healing: 0, effect: nil, effectResult: nil)
        let drainSpell = Spell(type: .Drain, manaCost: 73, damage: 2, healing: 2, effect: nil, effectResult: nil)
        let shieldSpell = Spell(type: .Shield, manaCost: 113, damage: 0, healing: 0, effect: Effect(type: .Shield, turns: 6), effectResult: EffectResult(type: .Armor, amount: 7))
        let poisonSpell = Spell(type: .Poison, manaCost: 173, damage: 0, healing: 0, effect: Effect(type: .Poison, turns: 6), effectResult: EffectResult(type: .Damage, amount: 3))
        let rechargeSpell = Spell(type: .Recharge, manaCost: 229, damage: 0, healing: 0, effect: Effect(type: .Recharge, turns: 5), effectResult: EffectResult(type: .Mana, amount: 101))

        var part1LeastAmountOfMana = Int.max
        var part2LeastAmountOfMana = Int.max
        var difficultyHard = false

        func getSpellOptions(gameState: GameState) -> [Spell] {
            var spellOptions: [Spell] = []

            if gameState.playerCurrentMana >= magicMissileSpell.manaCost {
                spellOptions.append(magicMissileSpell)
            }

            if gameState.playerCurrentMana >= drainSpell.manaCost {
                spellOptions.append(drainSpell)
            }

            if gameState.playerCurrentMana >= shieldSpell.manaCost && gameState.shieldTimer <= 1 {
                spellOptions.append(shieldSpell)
            }

            if gameState.playerCurrentMana >= poisonSpell.manaCost && gameState.poisonTimer <= 1 {
                spellOptions.append(poisonSpell)
            }

            if gameState.playerCurrentMana >= rechargeSpell.manaCost && gameState.rechargeTimer <= 1 {
                spellOptions.append(rechargeSpell)
            }

            return spellOptions
        }

        func applySpell(gameState: GameState) {
            guard let nextSpell = gameState.nextSpell else {
                return
            }

            gameState.playerCurrentMana -= nextSpell.manaCost
            gameState.playerSpentMana += nextSpell.manaCost

            if nextSpell.type == .MagicMissile {
                gameState.bossHitPoints -= 4
            } else if nextSpell.type == .Drain {
                gameState.playerHitPoints += 2
                gameState.bossHitPoints -= 2
            } else if nextSpell.type == .Shield {
                gameState.shieldTimer = nextSpell.effect?.turns ?? 0
                gameState.playerArmor = nextSpell.effectResult?.amount ?? 0
            } else if nextSpell.type == .Poison {
                gameState.poisonTimer = nextSpell.effect?.turns ?? 0
            } else if nextSpell.type == .Recharge {
                gameState.rechargeTimer = nextSpell.effect?.turns ?? 0
            }
        }

        func checkTimers(gameState: GameState) {
            if gameState.shieldTimer > 0 {
                gameState.shieldTimer -= 1
                gameState.playerArmor = gameState.shieldTimer == 0 ? 0 : (shieldSpell.effectResult?.amount ?? 0)
            }

            if gameState.poisonTimer > 0 {
                gameState.poisonTimer -= 1
                gameState.bossHitPoints -= (poisonSpell.effectResult?.amount) ?? 0
            }

            if gameState.rechargeTimer > 0 {
                gameState.rechargeTimer -= 1
                gameState.playerCurrentMana += rechargeSpell.effectResult?.amount ?? 0
            }
        }

        func beginPlayerTurn(gameState: GameState) {
            if gameState.nextSpell == nil {
                return
            }

            if gameState.playerLoses() || gameState.bossLoses() {
                gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                return
            }

            if difficultyHard {
                gameState.playerHitPoints -= 1
                if gameState.playerLoses() {
                    gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                    return
                }
            }

            // player turn
            checkTimers(gameState: gameState)

            if gameState.playerLoses() || gameState.bossLoses() {
                gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                return
            }

            // apply spell
            applySpell(gameState: gameState)

            if gameState.playerLoses() || gameState.bossLoses() {
                gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                return
            }

            if difficultyHard {
                if gameState.playerSpentMana > part2LeastAmountOfMana {
                    gameState.playerHitPoints = 0
                    return
                }
            } else {
                if gameState.playerSpentMana > part1LeastAmountOfMana {
                    gameState.playerHitPoints = 0
                    return
                }
            }

            // boss turn
            checkTimers(gameState: gameState)

            if gameState.playerLoses() || gameState.bossLoses() {
                gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                return
            }

            let bossDamage = max(1, (gameState.bossDamage - gameState.playerArmor))
            gameState.playerHitPoints -= bossDamage

            if gameState.playerLoses() || gameState.bossLoses() {
                gameState.checkGameEndMana(part1LeastAmountOfMana: &part1LeastAmountOfMana, part2LeastAmountOfMana: &part2LeastAmountOfMana)
                return
            }
        }

        func processGameState(gameState: GameState) {
            if let nextSpell = gameState.nextSpell {
                if nextSpell.type == .None {
                    let initialSpells = getSpellOptions(gameState: gameState)
                    for spell in initialSpells {
                        let newGameState = gameState.copy()
                        newGameState.nextSpell = spell
                        processGameState(gameState: newGameState)
                    }

                    return
                }
            }

            beginPlayerTurn(gameState: gameState)
            if gameState.playerLoses() || gameState.bossLoses() {
                return
            }

            let spellOptions = getSpellOptions(gameState: gameState)
            if spellOptions.isEmpty {
                gameState.playerHitPoints = 0
            } else {
                for spell in spellOptions {
                    let newGameState = gameState.copy()
                    newGameState.nextSpell = spell
                    newGameState.iteration = gameState.iteration + 1
                    processGameState(gameState: newGameState)
                }
            }
        }

        difficultyHard = false
        let initialGameState = GameState(playerHitPoints: 50, playerCurrentMana: 500, bossHitPoints: 51, bossDamage: 9, difficultyHard: false)
        initialGameState.nextSpell = noSpell
        processGameState(gameState: initialGameState)

        difficultyHard = true
        initialGameState.difficultyHard = true
        processGameState(gameState: initialGameState)

        return (part1LeastAmountOfMana, part2LeastAmountOfMana)
    }
}
