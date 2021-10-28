//
//  Puzzle_2018_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/4/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

// ===================================================================================================
//
// I had to give up on my own solution for this one, so I ripped off this solution:
// https://github.com/tellowkrinkle/AdventOfCode/blob/master/2018/2018Day15.swift
//
// ===================================================================================================

extension Collection {
    func get(_ index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

class Puzzle_2018_15: NSObject {

    struct Point: Hashable, Comparable {
        var x: Int
        var y: Int

        static func + (lhs: Point, rhs: Point) -> Point {
            return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
        }

        static func += (lhs: inout Point, rhs: Point) {
            lhs = lhs + rhs
        }

        static func < (lhs: Point, rhs: Point) -> Bool {
            return lhs.y != rhs.y ? lhs.y < rhs.y : lhs.x < rhs.x
        }

        var adjacent: [Point] {
            return [(0, -1), (-1, 0), (1, 0), (0, 1)].map({ Point(x: x + $0.0, y: y + $0.1) })
        }

        func range(in field: [[Space]]) -> [Point] {
            return adjacent.filter { field.get($0.y)?.get($0.x) == .open }
        }

        func distances(in field: [[Space]]) -> [Point: Int] {
            var queue = adjacent.map { ($0, 1) }
            var out: [Point: Int] = [self: 0]
            while let (next, distance) = queue.first {
                queue.remove(at: 0)
                guard field.get(next.y)?.get(next.x) == .open && out[next] == nil else { continue }
                out[next] = distance
                queue.append(contentsOf: next.adjacent.lazy.map({ ($0, distance + 1) }))
            }
            return out
        }
    }

    enum Space: Character {
        case wall = "#", open = ".", elf = "E", goblin = "G"
    }

    class Being {
        enum Race: Character {
            case elf = "E", goblin = "G"
        }
        var race: Race
        var coord: Point
        var attackPower = 3
        var hitpoints = 200

        init(race: Race, at: Point, attack: Int) {
            self.race = race
            self.coord = at
            attackPower = attack
        }

        func attackables(in field: [[Space]]) -> [Point] {
            return coord.adjacent.filter {
                let space = field.get($0.y)?.get($0.x)
                return race == .elf && space == .goblin || race == .goblin && space == .elf
            }
        }
    }

    func fieldString(_ field: [[Space]]) -> String {
        return field.lazy.map({ String($0.lazy.map({ $0.rawValue })) }).joined(separator: "\n")
    }

    func aocD15(_ input: [[Space]], beings: [Being], printFields: Bool) -> Bool {
        var input = input
        var beings = beings

        if printFields { print(fieldString(input)) }
        var rounds = 0
        outerWhile: while true {
            beings.sort(by: { $0.coord < $1.coord })
            var action = false
            defer {
                if printFields {
                    print(fieldString(input))
                    for being in beings where being.hitpoints > 0 {
                        print("\(being.race == .elf ? "   Elf" : "Goblin") at \(being.coord): \(being.hitpoints)")
                    }
                }
            }
            for being in beings where being.hitpoints > 0 {
                input[being.coord.y][being.coord.x] = .open
                let targets = beings.filter({ being.race != $0.race && $0.hitpoints > 0 })
                if targets.isEmpty {
                    break outerWhile
                }
                let inRange = targets.flatMap({ $0.coord.range(in: input) })
                if !inRange.contains(being.coord) {
                    let distances = being.coord.distances(in: input)
                    let inRangeDistances = inRange.compactMap({ spot in distances[spot].map({ (spot, $0) }) })
                    if let nearestDistance = inRangeDistances.min(by: { $0.1 < $1.1 })?.1 {
                        let best = inRangeDistances.filter({ $0.1 == nearestDistance }).min(by: { $0.0 < $1.0 })!
                        let targetDistances = best.0.distances(in: input)
                        let step = being.coord.adjacent
                            .compactMap({ point in targetDistances[point].flatMap({ $0 < targetDistances[being.coord]! ? point : nil }) })
                            .min()!
                        being.coord = step
                        action = true
                    }
                }
                input[being.coord.y][being.coord.x] = Space(rawValue: being.race.rawValue)!

                let possibleTargets = being.attackables(in: input).lazy.map { point in beings.lazy.filter({ $0.hitpoints > 0 && point == $0.coord }).first! }
                if !possibleTargets.isEmpty {
                    action = true
                    let target = possibleTargets.min(by: { $0.hitpoints < $1.hitpoints })!
                    target.hitpoints -= being.attackPower
                    if target.hitpoints <= 0 {
                        input[target.coord.y][target.coord.x] = .open
                    }
                }
            }
            if !action { break }
            rounds += 1
        }
        let remainingHealth = beings.map({ $0.hitpoints }).filter({ $0 > 0 }).reduce(0, +)
        print("\(rounds) rounds, \(remainingHealth) health, \(rounds * remainingHealth)")
        if beings.lazy.filter({ $0.race == .elf && $0.hitpoints <= 0 }).isEmpty {
            print("No dead elves")
            return true
        }
        return false
    }

    func solve() {
        let str = Puzzle_2018_15_Input.puzzleInput

        var beings: [Being] = []

        let input = str.split(separator: "\n").enumerated().map { y, line in
            line.enumerated().compactMap { x, space -> Space? in
                if let race = Being.Race(rawValue: space) {
                    beings.append(Being(race: race, at: Point(x: x, y: y), attack: 3))
                }
                return Space(rawValue: space)
            }
        }

        for power in 3...200 {
            let newBeings = beings.map({ Being(race: $0.race, at: $0.coord, attack: $0.race == .goblin ? 3 : power) })
            print("Power: \(power)")
            if aocD15(input, beings: newBeings, printFields: false) {
                break
            }
        }
    }

    // ===================================================================================================
    //
    // this solution was working on the test data, but on the larger playfield, it was too slow... :(
    //
    // ===================================================================================================

    class Unit: CustomStringConvertible {
        var unitType: Character = "?"
        var location: Point2D = Point2D()
        var attackPower: Int = 3
        var hitPoints: Int = 200
        var description: String {
            // return "[\(unitType) (\(location.x),\(location.y)) (\(attackPower), \(hitPoints))"
            return "\(unitType)(\(hitPoints))"
        }
    }

    var playfield: [[Character]] = []
    var units: [Unit] = []
    var pointToPointShortestPath: [[Point2D]] = []
    var shortestPathLength = 0

    func solve_old() {
        let puzzleInput = Puzzle_2018_15_Input.puzzleInput

        let part1 = solvePart1(str: puzzleInput)
        print("Part 1 solution: \(part1)")
        // let part2 = solvePart2(str: puzzleInput)
        // print("Part 2 solution: \(part2)")
    }

    func playfieldToString(_ playfield: [[Character]], _ units: [Unit]?) -> String {
        var playfieldCopy = playfield

        if units != nil {
            for unit in units! {
                playfieldCopy[unit.location.y][unit.location.x] = unit.unitType
            }
        }

        var retval = ""
        for line in playfieldCopy {
            retval += (String(line) + "\n")
        }

        return retval
    }

    func unitReadingOrder(left: Unit, right: Unit) -> Bool {
        if left.location.y != right.location.y {
            return left.location.y < right.location.y
        } else {
            return left.location.x < right.location.x
        }
    }

    func point2DReadingOrder(left: Point2D, right: Point2D) -> Bool {
        if left.y != right.y {
            return left.y < right.y
        } else {
            return left.x < right.x
        }
    }

    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var x = 0, y = 0
        // parse the input into the playfield and the units
        for line in lines {
            var lineArray: [Character] = []
            x = 0
            for c in line {
                if c == "G" || c == "E" {
                    let unit = Unit()
                    unit.unitType = c
                    unit.location = Point2D(x: x, y: y)
                    units.append(unit)
                    lineArray.append(".")
                } else {
                    lineArray.append(c)
                }

                x += 1
            }

            playfield.append(lineArray)
            y += 1
        }

        print("Initial status")
        print(playfieldToString(playfield, units))
        print("Units: \(units.sorted(by: unitReadingOrder))")

        var roundsCompleted = 0
        var gameOver = false

        repeat {
            // sort units into reading order to begin iterating through turns
            units.sort(by: unitReadingOrder)

            for unit in units {
                if unit.hitPoints > 0 {
                    // print("Current unit: \(unit)")
                    let enemies = units.filter { $0.unitType != unit.unitType && $0.hitPoints > 0 }
                    // print("Enemies: \(enemies)")
                    if enemies.count == 0 {
                        // there are no enemies, thy game is over
                        gameOver = true
                        return roundsCompleted * units.filter { $0.hitPoints > 0 }.map { $0.hitPoints } .reduce(0, +)
                    }

                    var targetLocations: [Point2D] = []
                    for enemy in enemies {
                        targetLocations.append(contentsOf: enemy.location.adjacentLocations())
                    }

                    // only consider target locations that are floors (disregard walls)
                    targetLocations = targetLocations.filter { playfield[$0.y][$0.x] == "." }

                    // remove target locations that have a unit there
                    for u in units {
                        if u.hitPoints > 0 && targetLocations.contains(u.location) {
                            targetLocations.removeAll { $0.x == u.location.x && $0.y == u.location.y }
                        }
                    }

                    // see if there are any target locations already adjacent to the unit
                    var targetsInRange = enemies.filter {
                        $0.location.manhattanDistanceTo(pt: unit.location) == 1
                    }.sorted(by: unitReadingOrder)

                    if targetsInRange.count == 0 && targetLocations.count == 0 {
                        continue
                    }

                    if targetsInRange.count == 0 {
                        // move
                        var allPaths: [[Point2D]] = []
                        allPaths.append([ unit.location ])

                        var completeLoops: [[Point2D]] = []
                        var leaveLoop = false
                        while !leaveLoop {
                            var newPaths: [[Point2D]] = []
                            for p in allPaths {
                                let steps = findAvailableSteps(location: p.last!)
                                for s in steps {
                                    if !p.contains(s) {
                                        var newP = p
                                        newP.append(s)
                                        newPaths.append(newP)
                                    }
                                }
                            }

                            if newPaths.count == 0 {
                                print("No new paths")
                                completeLoops = []
                                leaveLoop = true
                            } else {
                                allPaths = newPaths
                                if allPaths.count > 200000 {
                                    leaveLoop = true
                                }

                                for p in allPaths {
                                    if targetLocations.contains(p.last!) {
                                        completeLoops.append(p)
                                    }
                                }

                                if completeLoops.count > 0 {
                                    print("Found complete loops in \(completeLoops[0].count) steps")
                                    leaveLoop = true
                                }
                            }
                        }

                        var movePositionSet: Set<Point2D> = Set()
                        for p in completeLoops {
                            movePositionSet.insert(p[1])
                        }

//                        pointToPointShortestPath = []
//                        shortestPathLength = Int.max
//                        for target in targetLocations {
//                            print("Looking for paths from \(unit.location) to \(target)")
//                            findShortestPaths(previousPath: [], nextStep: unit.location, dest: target)
//                        }
//
//                        //print("Shortest paths to a target: \(pointToPointShortestPath)")
//                        var movePositionSet: Set<Point2D> = Set()
//                        for p in pointToPointShortestPath {
//                            movePositionSet.insert(p[1])
//                        }

                        if movePositionSet.count > 0 {
                            let mp = Array(movePositionSet.sorted(by: point2DReadingOrder))
                            // print("Move positions: \(mp)")
                            unit.location = mp[0]
                            // print(playfieldToString(playfield, units))

                            // recalculate the targets in range as the unit has moved
                            targetsInRange = enemies.filter {
                                $0.location.manhattanDistanceTo(pt: unit.location) == 1
                                }.sorted(by: unitReadingOrder)
                        }
                    }

                    // attack
                    // print("Targets in range: \(targetsInRange)")
                    if targetsInRange.count > 0 {
                        let minHitPoints = targetsInRange.map { $0.hitPoints }.min()
                        let attackTargets = targetsInRange.filter { $0.hitPoints == minHitPoints }.sorted(by: unitReadingOrder)
                        // print("Targets to attack: \(attackTargets)")
                        attackTargets[0].hitPoints -= unit.attackPower
                    }
                }

            }

            roundsCompleted += 1
            units = units.filter { $0.hitPoints > 0 }
            print("After round: \(roundsCompleted)")
            print(playfieldToString(playfield, units))
            print("Units: \(units.sorted(by: unitReadingOrder))")
            print("====================================================================================")

            // remove dead units
        } while !gameOver
    }

    func findAvailableSteps(location: Point2D) -> [Point2D] {
        var retval: [Point2D] = []
        let up = Point2D(x: location.x, y: location.y - 1)
        if playfield[up.y][up.x] == "." && !(units.contains { $0.location.x == up.x && $0.location.y == up.y && $0.hitPoints > 0 }) {
            retval.append(up)
        }
        let left = Point2D(x: location.x - 1, y: location.y)
        if playfield[left.y][left.x] == "." && !(units.contains { $0.location.x == left.x && $0.location.y == left.y && $0.hitPoints > 0 }) {
            retval.append(left)
        }
        let right = Point2D(x: location.x + 1, y: location.y)
        if playfield[right.y][right.x] == "." && !(units.contains { $0.location.x == right.x && $0.location.y == right.y && $0.hitPoints > 0 }) {
            retval.append(right)
        }
        let down = Point2D(x: location.x, y: location.y + 1)
        if playfield[down.y][down.x] == "." && !(units.contains { $0.location.x == down.x && $0.location.y == down.y && $0.hitPoints > 0 }) {
            retval.append(down)
        }

        return retval
    }

    func findShortestPaths(previousPath: [Point2D], nextStep: Point2D, dest: Point2D) {
        var newPath = previousPath
        newPath.append(nextStep)

        if nextStep == dest {
            // print("Destination reached with path \(newPath)")
            if pointToPointShortestPath.count == 0 {
                pointToPointShortestPath = [ newPath ]
                shortestPathLength = newPath.count
                print("New shortest path length of \(shortestPathLength)")
            } else {
                if newPath.count < pointToPointShortestPath[0].count {
                    pointToPointShortestPath = [ newPath ]
                    shortestPathLength = newPath.count
                    print("New shortest path length of \(shortestPathLength)")
                } else if newPath.count == pointToPointShortestPath[0].count {
                    pointToPointShortestPath.append(newPath)
                    print("Appending another path of length \(shortestPathLength)")
                }
            }

            return
        }

        if newPath.count > shortestPathLength {
            return
        }

        // print("findShortestPaths from \(nextStep) to \(dest)")
        let nextSteps = findAvailableSteps(location: nextStep)
        // print("nextSteps: \(nextSteps)")
        for n in nextSteps {
            if !newPath.contains(n) {
                findShortestPaths(previousPath: newPath, nextStep: n, dest: dest)
            }
        }
    }

}

private class Puzzle_2018_15_Input: NSObject {

    static let puzzleInput_test1 =
    """
#######
#.G...#
#...EG#
#.#.#G#
#..G#E#
#.....#
#######
"""

    static let puzzleInput_test2 =
    """
#######
#G..#E#
#E#E.E#
#G.##.#
#...#E#
#...E.#
#######
"""

    static let puzzleInput_test3 =
    """
#######
#E..EG#
#.#G.E#
#E.##E#
#G..#.#
#..E#.#
#######
"""

    static let puzzleInput_test4 =
    """
#######
#E.G#.#
#.#G..#
#G.#.G#
#G..#.#
#...E.#
#######
"""

    static let puzzleInput_test5 =
    """
#######
#.E...#
#.#..G#
#.###.#
#E#G#G#
#...#G#
#######
"""

    static let puzzleInput_test6 =
    """
#########
#G......#
#.E.#...#
#..##..G#
#...##..#
#...#...#
#.G...G.#
#.....G.#
#########
"""

    static let puzzleInput =
"""
################################
###########################..###
##########################...###
#########################..#####
####...##################.######
#####..################...#.####
#..G...G#########.####G.....####
#.......########.....G.......###
#.....G....###G....#....E.....##
####...##......##.............##
####G...#.G...###.G...........##
####G.......................####
####.........G#####.........####
####...GG#...#######.......#####
###.........#########G....######
###.G.......#########G...#######
###.G.......#########......#####
####.....G..#########....E..####
#####.......#########..E....####
######...##G.#######........####
######.#.#.G..#####.....##..####
########....E...........##..####
########....E#######........####
########......######E....##..E.#
########......#####.....#......#
########.....######............#
##################...#.E...E...#
##################.............#
###################.......E#####
####################....#...####
####################.###########
################################
"""

}
