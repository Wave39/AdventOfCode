//
//  Puzzle_2021_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/17

import Foundation

public class Puzzle_2021_17: PuzzleBaseClass {
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

    private func checkTrajectory(xVelocity: Int, yVelocity: Int, xRange: ClosedRange<Int>, yRange: ClosedRange<Int>) -> (Bool, Int) {
        var x = 0
        var y = 0
        var deltaX = xVelocity
        var deltaY = yVelocity
        var highestY = 0
        while x <= xRange.upperBound && y >= yRange.lowerBound {
            x += deltaX
            y += deltaY
            if y > highestY {
                highestY = y
            }

            if xRange.contains(x) && yRange.contains(y) {
                return (true, highestY)
            }

            if deltaX > 0 {
                deltaX -= 1
            } else if deltaX < 0 {
                deltaX += 1
            }

            deltaY -= 1
        }

        return (false, 0)
    }

    private func parseInputData(str: String) -> (ClosedRange<Int>, ClosedRange<Int>) {
        let components = str.capturedGroups(withRegex: "target area: x=(.*)\\.\\.(.*), y=(.*)\\.\\.(.*)", trimResults: true).map { Int($0) ?? 0 }
        let xRange = components[0]...components[1]
        let yRange = components[2]...components[3]
        return (xRange, yRange)
    }

    private func solvePart1(str: String) -> Int {
        let (xRange, yRange) = parseInputData(str: str)
        var highestY = 0
        for x in 1...xRange.upperBound {
            for y in 0...1_000 {
                let (findsTarget, maxY) = checkTrajectory(xVelocity: x, yVelocity: y, xRange: xRange, yRange: yRange)
                if findsTarget {
                    if maxY > highestY {
                        highestY = maxY
                    }
                }
            }
        }

        return highestY
    }

    private func solvePart2(str: String) -> Int {
        let (xRange, yRange) = parseInputData(str: str)
        var count = 0
        for x in 0...xRange.upperBound {
            for y in yRange.lowerBound...1_000 {
                let (findsTarget, _) = checkTrajectory(xVelocity: x, yVelocity: y, xRange: xRange, yRange: yRange)
                if findsTarget {
                    count += 1
                }
            }
        }

        return count
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
target area: x=20..30, y=-10..-5
"""

    static let final = """
target area: x=235..259, y=-118..-62
"""
}
