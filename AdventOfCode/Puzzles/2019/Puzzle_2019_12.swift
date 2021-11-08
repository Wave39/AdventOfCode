//
//  Puzzle_2019_12.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_12: PuzzleBaseClass {
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_12_Input.puzzleInput, stepCount: 1_000)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_12_Input.puzzleInput)
    }

    func solvePart1(str: String, stepCount: Int) -> Int {
        let arr = str.parseIntoStringArray()
        var moons: [Particle3D] = []
        for line in arr {
            let components = line.capturedGroups(withRegex: "<x=(.*), y=(.*), z=(.*)>", trimResults: true).map { $0.int }
            moons.append(Particle3D(x: components[0], y: components[1], z: components[2], deltaX: 0, deltaY: 0, deltaZ: 0))
        }

        for _ in 1...stepCount {
            // gravity
            for (i, _) in moons.enumerated() {
                for m0 in moons {
                    if moons[i] != m0 {
                        if m0.x > moons[i].x {
                            moons[i].deltaX += 1
                        } else if m0.x < moons[i].x {
                            moons[i].deltaX -= 1
                        }

                        if m0.y > moons[i].y {
                            moons[i].deltaY += 1
                        } else if m0.y < moons[i].y {
                            moons[i].deltaY -= 1
                        }

                        if m0.z > moons[i].z {
                            moons[i].deltaZ += 1
                        } else if m0.z < moons[i].z {
                            moons[i].deltaZ -= 1
                        }
                    }
                }
            }

            // apply velocity
            for (i, _) in moons.enumerated() {
                moons[i].x += moons[i].deltaX
                moons[i].y += moons[i].deltaY
                moons[i].z += moons[i].deltaZ
            }
        }

        var retval = 0
        for m in moons {
            retval += (abs(m.x) + abs(m.y) + abs(m.z)) * (abs(m.deltaX) + abs(m.deltaY) + abs(m.deltaZ))
        }

        return retval
    }

    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var moons: [Particle3D] = []
        for line in arr {
            let components = line.capturedGroups(withRegex: "<x=(.*), y=(.*), z=(.*)>", trimResults: true).map { $0.int }
            moons.append(Particle3D(x: components[0], y: components[1], z: components[2], deltaX: 0, deltaY: 0, deltaZ: 0))
        }

        var xPositions = moons.map { $0.x }
        var yPositions = moons.map { $0.y }
        var zPositions = moons.map { $0.z }
        let initialXPosition = xPositions
        let initialYPosition = yPositions
        let initialZPosition = zPositions
        var xVelocities = [0, 0, 0, 0]
        var yVelocities = [0, 0, 0, 0]
        var zVelocities = [0, 0, 0, 0]
        var ctr = 0, xCtr = 0, yCtr = 0, zCtr = 0
        repeat {
            ctr += 1
            for i in 0...3 {
                for j in 0...3 {
                    if i != j {
                        if xPositions[j] > xPositions[i] {
                            xVelocities[i] += 1
                        } else if xPositions[j] < xPositions[i] {
                            xVelocities[i] -= 1
                        }

                        if yPositions[j] > yPositions[i] {
                            yVelocities[i] += 1
                        } else if yPositions[j] < yPositions[i] {
                            yVelocities[i] -= 1
                        }

                        if zPositions[j] > zPositions[i] {
                            zVelocities[i] += 1
                        } else if zPositions[j] < zPositions[i] {
                            zVelocities[i] -= 1
                        }
                    }
                }
            }

            for i in 0...3 {
                xPositions[i] += xVelocities[i]
                yPositions[i] += yVelocities[i]
                zPositions[i] += zVelocities[i]
            }

            if xCtr == 0 && xPositions[0] == initialXPosition[0] && xPositions[1] == initialXPosition[1] && xPositions[2] == initialXPosition[2] && xPositions[3] == initialXPosition[3] && xVelocities[0] == 0 && xVelocities[1] == 0 && xVelocities[2] == 0 && xVelocities[3] == 0 {
                xCtr = ctr
            }

            if yCtr == 0 && yPositions[0] == initialYPosition[0] && yPositions[1] == initialYPosition[1] && yPositions[2] == initialYPosition[2] && yPositions[3] == initialYPosition[3] && yVelocities[0] == 0 && yVelocities[1] == 0 && yVelocities[2] == 0 && yVelocities[3] == 0 {
                yCtr = ctr
            }

            if zCtr == 0 && zPositions[0] == initialZPosition[0] && zPositions[1] == initialZPosition[1] && zPositions[2] == initialZPosition[2] && zPositions[3] == initialZPosition[3] && zVelocities[0] == 0 && zVelocities[1] == 0 && zVelocities[2] == 0 && zVelocities[3] == 0 {
                zCtr = ctr
            }
        } while xCtr == 0 || yCtr == 0 || zCtr == 0

        var retval = 0
        do {
            retval = try lcm(xCtr, yCtr)
            retval = try lcm(retval, zCtr)
        } catch {
            dump(error)
        }

        return retval
    }
}

private class Puzzle_2019_12_Input: NSObject {
    static let puzzleInput_test1 = """
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>
"""

    static let puzzleInput_test2 = """
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>
"""

    static let puzzleInput = """
<x=-5, y=6, z=-11>
<x=-8, y=-4, z=-2>
<x=1, y=16, z=4>
<x=11, y=11, z=-4>
"""
}
