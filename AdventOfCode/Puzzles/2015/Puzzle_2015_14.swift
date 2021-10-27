//
//  Puzzle_2015_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/28/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_14: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        class ReindeerInfo {
            var name: String = ""
            var speed: Int = 0
            var flightTime: Int = 0
            var restTime: Int = 0
        }

        var reindeerArray: [ReindeerInfo] = []
        for puzzleLine in puzzleInputLineArray {
            let components = puzzleLine.split {$0 == " "}.map(String.init)
            let r = ReindeerInfo()
            r.name = components[0]
            r.speed = Int(components[3])!
            r.flightTime = Int(components[6])!
            r.restTime = Int(components[13])!
            reindeerArray.append(r)
        }

        let seconds = 2503
        var maxDistance = 0
        for reindeer in reindeerArray {
            let flightAndRestTime = reindeer.flightTime + reindeer.restTime
            let totalCycles = seconds / flightAndRestTime
            let leftoverSeconds = seconds % flightAndRestTime
            let totalFlightSeconds = totalCycles * reindeer.flightTime + min(leftoverSeconds, reindeer.flightTime)
            let distance = totalFlightSeconds * reindeer.speed
            if distance > maxDistance {
                maxDistance = distance
            }
        }

        class ReindeerStatus {
            var reindeer: ReindeerInfo = ReindeerInfo()
            var points: Int = 0
            var distanceTraveled: Int = 0
            var flightTimeRemaining: Int = 0
            var restTimeRemaining: Int = 0
        }

        var reindeerStatusArray: [ReindeerStatus] = []
        for reindeer in reindeerArray {
            let r = ReindeerStatus()
            r.reindeer = reindeer
            r.flightTimeRemaining = reindeer.flightTime
            r.restTimeRemaining = reindeer.restTime
            reindeerStatusArray.append(r)
        }

        for _ in 1...seconds {
            var leadingDistance = 0
            for reindeerStatus in reindeerStatusArray {
                if reindeerStatus.flightTimeRemaining > 0 {
                    reindeerStatus.distanceTraveled += reindeerStatus.reindeer.speed
                    reindeerStatus.flightTimeRemaining -= 1
                } else {
                    reindeerStatus.restTimeRemaining -= 1
                    if reindeerStatus.restTimeRemaining == 0 {
                        reindeerStatus.flightTimeRemaining = reindeerStatus.reindeer.flightTime
                        reindeerStatus.restTimeRemaining = reindeerStatus.reindeer.restTime
                    }
                }

                if reindeerStatus.distanceTraveled > leadingDistance {
                    leadingDistance = reindeerStatus.distanceTraveled
                }
            }

            for reindeerStatus in reindeerStatusArray {
                if reindeerStatus.distanceTraveled == leadingDistance {
                    reindeerStatus.points += 1
                }
            }
        }

        var highestScore = 0
        for reindeerStatus in reindeerStatusArray {
            if reindeerStatus.points > highestScore {
                highestScore = reindeerStatus.points
            }
        }

        return (maxDistance, highestScore)
    }

}

private class PuzzleInput: NSObject {
    static let final = """
Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.
"""
}
