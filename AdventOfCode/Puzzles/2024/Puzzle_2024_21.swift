//
//  Puzzle_2024_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/7/25.
//  Copyright © 2025 Wave 39 LLC. All rights reserved.
//

import Collections
import Foundation

public class Puzzle_2024_21: PuzzleBaseClass {
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

    // https://github.com/rbruinier/AdventOfCode/blob/main/Sources/Solutions/2024/Days/Day21.swift

    struct KeyFromTo: Hashable {
        let from: Character
        let to: Character
    }

    typealias Path = [Character]
    var keyPathsCache: [KeyFromTo: [Path]] = [:]
    var solveMemoization: [Int: Int] = [:]

    private static func pathsOnKeyPath(from: Character, to: Character, coordinates: [Character: Point2D]) -> [[Character]] {
        let validCoordinates: Set<Point2D> = Set(coordinates.values)

        var paths: [Path] = []

        struct Node {
            let startPosition: Point2D
            let position: Point2D
            let visitedPositions: Set<Point2D>
            let path: Path
        }

        let startPosition = coordinates[from]!
        let endPosition = coordinates[to]!

        let manhattanDistance = endPosition.manhattanDistanceTo(pt: startPosition)

        var nodes: Deque<Node> = [.init(startPosition: startPosition, position: startPosition, visitedPositions: [startPosition], path: [])]

        while let node = nodes.popFirst() {
            if node.position == endPosition {
                paths.append(node.path)

                continue
            }

            if node.visitedPositions.count > manhattanDistance {
                continue
            }

            for neighbor in node.position.adjacentLocations() where validCoordinates.contains(neighbor) {
                guard !node.visitedPositions.contains(neighbor) else {
                    continue
                }

                let action: Character

                switch neighbor - node.position {
                case Point2D(x: -1, y: 0): action = "<"
                case Point2D(x: 1, y: 0): action = ">"
                case Point2D(x: 0, y: -1): action = "^"
                case Point2D(x: 0, y: 1): action = "v"
                default: preconditionFailure()
                }

                nodes.append(Node(
                    startPosition: node.startPosition,
                    position: neighbor,
                    visitedPositions: node.visitedPositions.union([neighbor]),
                    path: node.path + [action]
                ))
            }
        }

        return paths
    }

    private func setupPathsCache() {
        let numericPadCoordinates: [Character: Point2D] = [
            "7": Point2D(x: 0, y: 0),
            "8": Point2D(x: 1, y: 0),
            "9": Point2D(x: 2, y: 0),
            "4": Point2D(x: 0, y: 1),
            "5": Point2D(x: 1, y: 1),
            "6": Point2D(x: 2, y: 1),
            "1": Point2D(x: 0, y: 2),
            "2": Point2D(x: 1, y: 2),
            "3": Point2D(x: 2, y: 2),
            "0": Point2D(x: 1, y: 3),
            "A": Point2D(x: 2, y: 3),
        ]

        let directionPadCoordinates: [Character: Point2D] = [
            "^": Point2D(x: 1, y: 0),
            "A": Point2D(x: 2, y: 0),
            "<": Point2D(x: 0, y: 1),
            "v": Point2D(x: 1, y: 1),
            ">": Point2D(x: 2, y: 1),
        ]

        let numericKeys = "0123456789A"
        let directionKeys = "^v<>A"

        for a in numericKeys {
            for b in numericKeys {
                let paths = Self.pathsOnKeyPath(from: a, to: b, coordinates: numericPadCoordinates)
                keyPathsCache[KeyFromTo(from: a, to: b)] = paths
            }
        }

        for a in directionKeys {
            for b in directionKeys {
                let paths = Self.pathsOnKeyPath(from: a, to: b, coordinates: directionPadCoordinates)
                keyPathsCache[KeyFromTo(from: a, to: b)] = paths
            }
        }
    }

    func extractSequences(from path: Path, index: Int, previousKey: Character, parentPath: [Character], result: inout [[Character]]) {
        guard index < path.count else {
            result.append(parentPath)
            return
        }

        for newPath in keyPathsCache[KeyFromTo(from: previousKey, to: path[index])]! {
            extractSequences(from: path, index: index + 1, previousKey: path[index], parentPath: parentPath + newPath + ["A"], result: &result)
        }
    }

    func solveDirectionRobots(path: Path, depth: Int) -> Int {
        struct MemoizationKey: Hashable {
            let path: Path
            let depth: Int
        }

        guard depth >= 1 else {
            return path.count
        }

        let cacheHash = MemoizationKey(path: path, depth: depth).hashValue

        if let cachedResult = solveMemoization[cacheHash] {
            return cachedResult
        }

        var subdividedPaths: [Path] = [[]]

        for key in path {
            subdividedPaths[subdividedPaths.count - 1].append(key)
            if key == "A" {
                subdividedPaths.append([])
            }
        }

        var total = 0

        for subPath in subdividedPaths where !subPath.isEmpty {
            var result: [Path] = []
            extractSequences(from: subPath, index: 0, previousKey: "A", parentPath: [], result: &result)

            var shortestSequenceLength = Int.max
            for sequence in result {
                shortestSequenceLength = min(shortestSequenceLength, solveDirectionRobots(path: sequence, depth: depth - 1))
            }

            total += shortestSequenceLength
        }

        solveMemoization[cacheHash] = total
        return total
    }

    func solveWithInputs(inputs: [String], numberOfDirectionRobots: Int) -> Int {
        var result = 0
        for inputKeys in inputs {
            let numericPart = Int(inputKeys.replacingOccurrences(of: "A", with: ""))!
            var rootPaths: [[Character]] = []
            extractSequences(from: Array(inputKeys), index: 0, previousKey: "A", parentPath: [], result: &rootPaths)

            var shortestSequenceLength = Int.max
            for path in rootPaths {
                shortestSequenceLength = min(shortestSequenceLength, solveDirectionRobots(path: path, depth: numberOfDirectionRobots))
            }

            result += numericPart * shortestSequenceLength
        }

        return result
    }

    private func solvePart1(str: String) -> Int {
        setupPathsCache()
        let lines = str.parseIntoStringArray()
        return solveWithInputs(inputs: lines, numberOfDirectionRobots: 2)
    }

    private func solvePart2(str: String) -> Int {
        setupPathsCache()
        let lines = str.parseIntoStringArray()
        return solveWithInputs(inputs: lines, numberOfDirectionRobots: 25)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
029A
980A
179A
456A
379A
"""

    static let final = """
129A
176A
169A
805A
208A
"""
}
