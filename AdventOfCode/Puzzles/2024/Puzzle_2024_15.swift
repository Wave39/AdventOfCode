//
//  Puzzle_2024_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/18/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_15: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    private func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var gridArray = [String]()
        var moveArray = [CompassDirection]()
        for line in lines {
            if line.starts(with: "#") {
                gridArray.append(line)
            } else {
                for c in line {
                    if c == ">" {
                        moveArray.append(.East)
                    } else if c == "<" {
                        moveArray.append(.West)
                    } else if c == "^" {
                        moveArray.append(.North)
                    } else if c == "v" {
                        moveArray.append(.South)
                    } else {
                        print("Invalid direction")
                    }
                }
            }
        }

        var grid = (gridArray.joined(separator: "\n")).parseIntoCharacterMatrix()

        var position = grid.findInstancesOf("@").first!
        for move in moveArray {
            let antiMove = move.TurnLeft().TurnLeft()
            let nextPosition = position.moveForwardFromTopLeftOrigin(direction: move)
            let nextCharacter = grid.getCharacterAtCharacterGridPoint(nextPosition)
            if nextCharacter == "." {
                grid.setCharacterAtPoint(nextPosition, "@")
                grid.setCharacterAtPoint(position, ".")
                position = nextPosition
            } else if nextCharacter == "O" {
                var currentPosition = nextPosition
                while grid.getCharacterAtCharacterGridPoint(currentPosition) == "O" {
                    currentPosition = currentPosition.moveForwardFromTopLeftOrigin(direction: move)
                }

                let char = grid.getCharacterAtCharacterGridPoint(currentPosition)
                if char == "." {
                    while currentPosition != nextPosition {
                        grid.setCharacterAtPoint(currentPosition, "O")
                        currentPosition = currentPosition.moveForwardFromTopLeftOrigin(direction: antiMove)
                    }

                    grid.setCharacterAtPoint(nextPosition, "@")
                    grid.setCharacterAtPoint(position, ".")
                    position = nextPosition
                }
            }
        }

        let boxLocations = grid.getAllPointsMatchingCharacter("O")
        var retval = 0
        for boxLocation in boxLocations {
            retval += boxLocation.y * 100 + boxLocation.x
        }

        return retval
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    // https://github.com/sroebert/adventofcode/blob/main/Sources/advent-of-code/Solutions/Years/2024/Assignment202415.swift
    
    private enum Element {
        case empty
        case box
        case wall
        case robot
    }

    private typealias Map = [[Element]]

    private enum WideMapElement {
        case empty
        case boxLeft
        case boxRight
        case wall
        case robot
    }

    private typealias WideMap = [[WideMapElement]]

    private func widenMap(_ map: Map) -> WideMap {
        return map.map { row in
            row.flatMap { element -> [WideMapElement] in
                switch element {
                case .empty: [.empty, .empty]
                case .box: [.boxLeft, .boxRight]
                case .wall: [.wall, .wall]
                case .robot: [.robot, .empty]
                }
            }
        }
    }

    private func moveRobot(
        from robotLocation: inout Point2D,
        in direction: CompassDirection,
        on map: inout WideMap
    ) {
        let step = direction.step
        let isVertical = step.y != 0

        var boxesBeingMoved: [Point2D] = []

        var locationsToCheck = [robotLocation + step]
        while !locationsToCheck.isEmpty {
            var nextLocations: [Point2D] = []

            for location in locationsToCheck {
                switch map[location.y][location.x] {
                case .boxLeft:
                    boxesBeingMoved.append(location)
                    if isVertical {
                        nextLocations.append(location + step)
                    }
                    nextLocations.append(Point2D(x: location.x + 1, y: location.y) + step)

                case .boxRight:
                    let boxLeftLocation = Point2D(x: location.x - 1, y: location.y)
                    boxesBeingMoved.append(boxLeftLocation)
                    nextLocations.append(boxLeftLocation + step)
                    if isVertical {
                        nextLocations.append(location + step)
                    }

                case .wall:
                    // Cannot move
                    return

                default:
                    break
                }
            }

            locationsToCheck = nextLocations
        }

        for boxLocation in boxesBeingMoved.reversed() {
            map[boxLocation.y][boxLocation.x] = .empty
            map[boxLocation.y][boxLocation.x + 1] = .empty

            let newBoxLocation = boxLocation + step
            map[newBoxLocation.y][newBoxLocation.x] = .boxLeft
            map[newBoxLocation.y][newBoxLocation.x + 1] = .boxRight
        }

        map[robotLocation.y][robotLocation.x] = .empty
        robotLocation += step
        map[robotLocation.y][robotLocation.x] = .robot
    }

    private func getWarehouse(str: String) throws -> (map: Map, robotLocation: Point2D, moves: [CompassDirection]) {
        let parts = str.split(separator: "\n\n")
        guard parts.count == 2 else {
            throw InputError(message: "Invalid input")
        }

        var robotLocation: Point2D?

        let map: Map = try parts[0].split(separator: "\n").enumerated().map { y, line in
            try line.enumerated().map { x, character in
                switch character {
                case "#":
                    return .wall
                case "O":
                    return .box
                case "@":
                    robotLocation = Point2D(x: x, y: y)
                    return .robot
                case ".":
                    return .empty
                default:
                    throw InputError(message: "Invalid input")
                }
            }
        }

        guard let robotLocation else {
            throw InputError(message: "Invalid input")
        }

        let moves: [CompassDirection] = try parts[1].split(separator: "\n").flatMap { line in
            try line.map {
                switch $0 {
                case "^": .North
                case "<": .West
                case ">": .East
                case "v": .South
                default: throw InputError(message: "Invalid input")
                }
            }
        }

        return (map, robotLocation, moves)
    }

    private func summedGpsCoordinates(forBoxesOn map: WideMap) -> Int {
        var sum = 0
        for y in map.indices {
            for x in map[y].indices {
                if map[y][x] == .boxLeft {
                    sum += x + y * 100
                }
            }
        }
        return sum
    }

    private func solvePart2(str: String) -> Int {
        let (map, robotLocation, moves) = try! getWarehouse(str: str)
        var wideMap = widenMap(map)
        var wideRobotLocation = Point2D(x: robotLocation.x * 2, y: robotLocation.y)

        for direction in moves {
            moveRobot(from: &wideRobotLocation, in: direction, on: &wideMap)
        }

        return summedGpsCoordinates(forBoxesOn: wideMap)
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########

<^^>>>vv<v>>v<<
"""

    static let test2 = """
##########
#..O..O.O#
#......O.#
#.OO..O.O#
#..O@..O.#
#O#..O...#
#O..O..O.#
#.OO.O.OO#
#....O...#
##########

<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
"""

    static let final = """
##################################################
#..OO#...OO.#..OO......O...O.##...O.O...#..O.....#
#.#.O..O.##.O#.....O#.O.O.O..O.#............OOO.##
#OO....#..O...##OO.#O#OO...O..#...........OO.O..##
#.#.#..O.O...OO.OO#....O.OOO.O#..#......O......#O#
#.O#O..O..O#O..O...OOO#OOO...O...O.#OOO..OOO.....#
##.#..O....#.......##......OO.O.....O#..OO..O....#
#....OO...OO....#O....O..#..O........#.O....O.O..#
#O..O.#...O#......O#OOOO....#.............OO.#.#.#
#....#.##.#...O#...#...O..O#O..O.O.......O.OO.##.#
#...O..OO.#..O.O#.#.....O..O..O..O....OOO..OO#...#
#O..O...O...#.O.O.OO.O.O.O#..O..#.#OO.O.....O....#
#.O.#....O......O.OO#..O....O..O...O#..#O....O#..#
#O.......OO.....O...OO........OO.#.#O.OO.O.....O.#
#....OO....#O.O......O............O.OO.O....##.#.#
#...O...O.#OO...O.....OOO...#.O.O.O..O.....O...O.#
#....O.O.....O.O........#.O....O..#.O..OO.OOO...O#
#O.O..O.....OO.O.O....O.....OO..O.....#.......O.##
#..#.#........#.#......O.....O..O.......O....O...#
#........O#..#....#...O...O..O..O......##OOO.....#
#O....O..O......#..#..#.OOO..O....O....#.....#O..#
#O....O...#.O....O...O.O.#O.....O.............#O.#
#..O..O...O.OO..O....OO........OO#..#..OO.O.OO.O.#
##.OO.O.O.....O.O.O......O.O.O...#O.....O..O.....#
#....O..#O..#O..O.O.OO..@#OO#................OOO.#
#....O...#....O.#..#.O...#.....O..#.....#...O#O..#
#.#O....O..O.......O...O#..O.....O..#.#....OOO...#
#...O....O..O.....O...OOO.O...OO##..##OO#...O...O#
#....OO...O...#.O...O.OO.#...O.OOO....#........O.#
#.O#...OO.OO.....O.......O.....#...#.O...........#
#.OO.O..OO...##.O......#.OO...O#O.....OO...O...#O#
#O..O..OO....#....O...O#.OO....##...O.#...O..O..O#
#O...#.OOOO...##O..............O.O....O#....O..OO#
#.....O.O...O...O..#O..#.O...O..O.#.....O...O.OO.#
#...#O...O.O...O.O#OO.#.O.........O..O...O...O...#
#OOO.OOO.O...O..OOO........O.OO.....O..OOOO......#
#.#.##.O#...O.....OO#..O...OOO..OO.#.O..#..OO....#
#.#.....OOO...O#..O..O#O.......OO.OO.O.O..O.O....#
#..O.O.O.....O.#....#..O.O..OO..OO.#OO#..OO#...#O#
#.O##O..O......O.......O..#O...O..O.O.OO..O......#
#.#..#.........O.#O...OOO....O.#O....O.....O#O.OO#
#O.OO..#....#........O...OO.......O...#O.......O.#
#......#...#.#.O...........#.OO.O......#.O.OO#...#
#.O#...O......O.O..O.........O...#.O.O...........#
#..O...O#.O..O..O......O.##.OOOOOOO.#O........O..#
#...O..O....O.O.#..O.O#...#O...#OOOO...O#.O.....O#
#.....#.OOO.........O.OO.O#.O#O...OO.........O...#
#.O...#OO.O......OO..........O....OO.#..O....O..##
#.OO#..#.#O......O.O........#O..O.O....O..O.OO.#O#
##################################################

^>>^>v^<^^v<^^>^<v>><vvv>><<<>^^^>v<^>v><v^v>vv<^<<v^^v<^>v^^^<v^>>^<<>>>^<>v^v<<^v^<v^<><v><<v<vv^<v<^v^v<<<^v>^>>>^<^^v>v><v><<^<^^^v>v<<<<<><v><>>>^vv<v<<vvv>^>^<vv><v>><^<^<v><vv<<^<<<v^^vv<>^>>^>v<>>^^>>v>v<^v<v^<^^^>>>vvv^^v^vv><<^>^v<^v<v^v^^v^^><><<>vv^<<vvv<v><^>^>^<^<>>^v>vv^^v^>vv<<><>>v>><^^^<^^>>>v>^<^<>^^^<<><^<>^v><v^^^v^^<>vv>^vvvv^v<<^<^^>>v<><>vv^>^<>^v<^v<<>>^^^>>^^^<v<>^>>><vv>v^v^<vv<vvvvv^<<>v^v>^^<^>><^v^^<^v>>^<v^>^^>^^>>>^<<>^v<<^>^vv<^^^v^><vv^<^v^>^v^><<<<<^^^><<<<v^>^>><vv>^^>v>^<>^>^<><^>>v<<^^v^vvv^>v>v><><^^^>v^>>^<>^>v><^>>^>v>vv^v<^v<<^^>v^v<v>vv<^^>>^vv^v><^v>^^^v>>v<vvvv<>>>>v<>^v>>^^^v><^^^>v>^><>^>v<><v<>>^<^<^^vv><^<<^<v^>vv<>>vv>>v>>><<v<v>^<vv<<>v^v<<^^>><^^^<v<v^v^<vv^^v>><<<<<^^<^^<v<v<v<^>v^v^<v^<>^>vv>><^<<>>>^v^<<><^<^>^<<vv<^>v>v<><v<^<>vv>vv<v^^^<^><<v<<^v<>^^^><^><>^><v<^^v<v^^><>>^v^^^vv>^<><^v<><^^<>><>vvv^v>>>>v<<<>v<>vv>v<^vv<^><^v>>^^vv>^v^v^v^^>>^>^v^<^>^^v^<<><^^<^^^<^v^<<<<v^^^<<<>>v^^>v<vvv<v^v>^<>v^^v>^<<<><>v<v^^<<><v<<<><^<vvv
vv>^^^v<<^v^^^>v^^<<^<>>^vv<<>v<^>>^^^<^vv<v^<^><^<>^<^v^^vv^vv^><v^v<<v^<^^<^vv>vv<vvv>^v<^vv>^>vvvvv^v^^>^><<v<>>><^<^v^><<><>>^^>><>^<><v^^<v>^>v<vvvv><<v^^v><>vv^^<^v<>vvvv>^^^^<^<^<^^^v>v<v^><>v^v><vvvvv^v^<vv><v>^>^>v<<^<vv^>v^>v><>^vv<v>v>>><^v>^<^<><v>v<<v>>v>>^<<>v^<<v<^<^v^^<>^v><vv>^^<<^<<<^>>v<v>^<>v^^<<v^<<v^v^>vv<>v<><<<>>v<>v<^><v^^vv<v<^^<^v>v^><><>v^v><><<^><<v<^><>^^^v><^^<>>v>>>>v<>^^<^>^>^<^^<v^<<^vv>v^^<v^^<v^><v<^<>v>v>^^<v>>v<v>v>v^v><^>>^>><<^<>^^^^><<>>v><v<>^<<v>v^v<>^^^<<^^vv><v^>v>><<^>^^>v>^<vv^>>^><^<>>v^^^^<>^v^v><^v>^v^<v>><vv>^^vv^<>>v^<<<^v>v>v^v^^<<<<vv<>vv^^><<>^>vvvv>v>v>>>^v<^<>v<^<v>>^>>^v<v<^>><v>v<<v>>^^v>><>vv>^>>v<<>>vv^vvv<^^v><><^<v^>vv^<v><vv^>^v<>><vv<<>v<^<v><^^^<v<><>^^v<v<^>>^><v^^^>>^v^<>vvv>^v^<><><^v<<>><>>^vvv><>^<<>>vv>vv<^>^vv>v^><^<<v><><v>v^^<>vv^><>^v>^><^^<>>^^^<<^^v^<^>>v^<<^v>>^>^^<^<>^<v>^>vv<v<>^><v>v<<^>^<><<>>>>>>>v>^v>><v^<<^<>^v<v<v^><^^vv<><v^>^<>vv<^v^vv^^^<v><^<v<^>>v>>^^>^<<^<>v^vv^vv><>>^<v><<<^>^><^v><<v<>v><>v<<
<<<v^<^^v<^<<<><^^><^<^<^v>^<<^v^>^<>^^^^vvvv^>v>^^<v<<^>><^<^^>v^^<vvvvv>>>>^<>^>^>>^vv<^>><^><v>^>^>v>v>>><^vv>>^<<^^><^vv<^><<>^<vv<^^vv^^>>vv><v^<^v<v^vv<v^v>>^^<>>^^v><<vv<^><<<^^><<>>vv>>>>^<<>>><^>^<^<^<<<<vv<^v>>v>vv>^v<vv<>vvv<v<^>>v^>vv>^^>v>><v><v<>v^v<<><>^v>v<>vv^v<<>^>^v>^><v^^><>vv<^^>vv<^<>v^^>^v^>^v><v>>vvv^<^<^>v<^v^>v^^^^^v^^>>>><<^>^^v^><><v>v^<v<vv>^^<^>v<v<>>^<<<<^>v><>>vv>><>^^<<v>v>^^><vv<v>^v>><vv><^<><^^>^v<><vv^>><<<v<v<^<^<^^<v>v>vv>v<<^^v^<v>>^<v<>>v>^v<^v^vv<v<>>^><>v<v>v<<<v>^vvv><>^^vv>v>><>>^>^v^>^>>v>><>>>>>>>v<v<><v>>v^>vv<<^><^<v><^v<^v>^<v^>^^>>v^<^^>v<^v<>^^<v^>>>v^^>v><^<<^v^>^^v><>><^<^><><^v>^<<v><^v^><<^^<^<^<>><^^^><<vv^^v^vv><>vv<v><<<v<<>vvv^^><<^v<><>^><>v<^vv>v^v<<^^^^v>vv<^<v^<vv>^^^<<<<^<v><>><^v^><^>v>v<<<>^vvv<<<^<<v>v<v>v>v<<>v><vv<<^<>>v><<<<><^<><<<>^^<>^<vv>><>v^><><v<^vvv><v<>vvv><^<^v<v^v<v><^vvv>v^<<v^^>><<v^^<<^<>>><>>v<^><<><^<>>^^v<^v><>>>^^>><<>^<^v^<>><^v^><>>>v^v^v>><>>><^><^v<<^>^<<<^>>>v<><>v<<<^>^v><<^v>^<v>v^<>v^>>^^^^
^<<^<<^<^><v>vv<<>^>^<vv>>^>^v<v>>>>>>><^<^>^<><><<^>^vv<^^v>^<^v^>^<^v>^v^v>v>vv><v^^^<>^^>v<>vv^^v<^<v^<^^^><<v<^<v^^v<^v<<v^<<>v<>^v^><v>^><v^v>vv<<^^vvv^^<<><v^>vv^<^<^>>vvv^vvvv<<vv>v^v>^><<v<>v^^>^<vv>^>v^<<vvvv^^<v<>v>v^<>>vv^><<<<vv<v^<>v<<^<^<<<^v^v<^<>^^v<<v^><><^><^><><>v^vv<<<>>vv>v<^<<^^>^<^>>><>v^vv^>vv^<>vvv^^v>v<^^^^^v>>><v><<^v>><v<^^^>>v<>v<vv^^vv><^><v<^v<^>>v<^v>>v^>^>>>v<<v>>><^>>^>^>>^><>>^>^><^<^>v^><^v><<<<<<^>^<>^<<vv>^<>vv<<vv<v<<<v^^<^>vv<^<<<^<>vv^^^<<<>>v^^<<<^^<>>>^<<v>^v^^>v^<vv<v^>vv^vv<^^^vvv>>v<vv>v^>v<vv<vv<<v<>v<<^<v><v<<^<<^v^^<v^v>>>vv<><<>>^><><>><<v>^>^v>>^<^>><<>v^v>^<>v>><v^^^<><>^<<v>>>^v>>v<v<<<v>^^^>><vvv<><^>v>^<vvv<^>^v<>^>v^<<<<<^v<^v><><v>vv^<vv<>^><>^><>^v<>>^<^>v^<v><<<^>^^^>^^v^>^<>><^v<vv<>^vv<^>v^>>>><<^<v<>^v<<>>^v<>v<^<<<><>>v^vv<v>^><v^^v^<<^^v<^vvvv<^>v><<>^<^><^vvv>^vv<>^>vv>v^>^^<>vv>>>>^vvv<v^<>>>>v^<<>v>v^^^^<>^>v<^^<<<<^<<<>v^>v^<<vv>>vvv<v^^^<<<<>>v<>v^>^>vv<v>^^<<v^^<^vv^<vv>v>><v<^<^^<^>^>>>><v<>>^>>><vv>vv^v<>^^^<<>^v^<
<><^vvv^><<<vv<><<^<^v<>v^<vvv>^vv^^<^<^>>^><v<>>^>v<v<<<v^^v^v>>^>><^^vvv>v^<<v><<>><>><^<<v^v><v^><^>>^^<<<^>v^v>>vv^^^v^<^v><<v>>>>v>^^v^<>vvv^>><^>^^^>v<vv^<^^<>v<<<<v>>^^v>^v<<><^<<^v^vv^v^^v<>^v>^>v^v^vv^^>>v>v<<<v^>^>^v^<^^<<^<>^>>>>>>v>>v<^^<>>v^<>v<<^>^>^>^><^^v^<vv>^^^v>v^v<^>v<v^>^<><v^^<v^v^^>><v>v>^>v<^^>>^v^>v^>^^<v<>>v<^^v>v^>^<<v><^v>^v^<v><^^<^>^<<vv^v<v<^>>^<v<<vvv>^>^<>><^>^^>>^^v^v^>><><^><^<v^v^>v>^v<^<<<<v<^^vv><>v^>v<^^<><>^>>>^^^<^^v<^vv<vv<v><<^<^^v><v>><v<><>vv<v<^<^v>>>v<><^<^^^^<>>^><^^v<<^v>vv>>^>v<^^v<^^v<^<>^>v>>>>v^vv><>>>v<<^^><>>>v<v^v>^^v^v><v<^^<>^vv>^^<>>^<>>v>v^^><><v^v<v<>>><^^vvvv<<^v<<<^<<^<<^>v<^v<v<>^vv>>><<>v<^>v^v>><^v<>v<><<^<^v<^>>^^^<<<vvvv<><<<<v^<^>^v<<>v>><^vv<^^^<<<><>^<vv^<<<>vv^<v><v>v>^vv<v>vv>><>>vv>v<^<v^v^^>v<>>>v^>vv^^v<>>v><<^vv^>vv>v<<<vv<<^<<^<v<vv^v^v^v>><^><>>v^v^<^vv<v<<^^<v>><vv^v<vvvvv^<^<<<<^>^v><<vvvv<v>><^v>^<<v^^<^v<v><<v<v><><>^<^>^^v>v><>>^^<vv>>^>v>vv<v<<v^<v>vv^><v^v><>v>>>^^>><vv^><v^<>^<^vvvv^^<v^^<<>>^^^^<>^<
>v<v>^<^vvv><^<^>^^<>>^v<v<^<>vv<<>><<v<^v^<^>v^<v>v>vv<<^>v<>>^v>v<v><>v^<^^^^>>^<<<vv^>^v<<^>^vv<>^v<vv<vv<><<>^>vv<>v<v^<v<>v<<<v<^vvv>>^<<<>>><v>>^v<<>vvv>>v>vv<vvv>>^v^>><^^>>vvvv^^vv^^<v>v^v^>vv^v<><^^^^><<^v>>>vv<<><<>vv^>>>vv>v<v>vvvv<vv^^><^>^v<^v>>>><v^<v^^v>^<><<<<<v>v><^>v^^v<v><v<v^>^<v^^<<^<v<<^^>v<vvvv>>>v<><vvvvv<>><<vv^>v^^>>>vv^^vv>>v<^vv<v>>>^^>><^^<><^^<v>vv^v<^^<v>v^^>><^v<v^v<><^v<<<<<<^^^>^<>v<^><<^>>vv^v><<v^<<^>v<v<^<<v>^v>>^^v^^^^v>><^^>v>>>^<v^^^^>>^<vvv>>^v>>v>^v^>>^<>><>v^<>>v>^vv^<><v<v<<<^>>>>v<<<<<<^<v>^<>^>v<^vv>v^v^>>><^v>v>v<<>^v>^<^<^<>v>><<>^v^^><v<^><<<v<<<v<>>>v>v<v<<^^v<vv^>>vv^<>v^<^>>v^^<^>>^<<v^vvv^<<><^<><><vvvv>^v><v>^vvvv<<<v^><vvv<^>^<<^<^v^v>^v>^>>^^^<<^^vv<>><>>^<<>>^>v>v<>^><<v^>vv^>>vv^vvv<^^^>><<>^><<>v^v><<^vv<^v^<v^><^vvv^<><>^^>>><>v<^<<v<>>v<>vv<>>^<>>><><^v^<^^v^v<^^<<>>>^>^<<v<^<<<v^v^>>>v^><^<v>^<^^<>vv>^^<>^^>>v<v>^v<>v<>^^<v^>vvvv^<<vv^>v<^v^v^<^vvv^^>>>>v><v<<^v<^<>><v><<v^v<vv<<vvv^v<<<v^>^<vv<^^<>>^vvv<><^<<vv>>^>v>>>>>v>^
<><v>>^v^vv><v<v^^>^^>>^^v^^<>^^^>^^^^v^v^<>><>v><^<>>>^v<vv^>v^<>^^v>vv<<^<<vv<<<^<<vv<<v^^>^^^<>vv^^^<>v><^><<>v<>vv<v<v^<v>v<<<>v>^<<<^^v>^<^<>v>>><>>^v<<<^>v>><v^><vv><>^><^v>><>^v^>^<>>^><<^><>>^v<^>v<vvv><<>^^>>v<v>^vv>^^^<<v^^<v>v^>>^>^^v<<^^<<vvv>vv^>^vvv<><^>^v^^v<<<<^v><^><^vv^^v^^<^vv^v<v^>>^><^<^v^v<>^><>v^v<>>>^<v^v<v>^><v^^v^v<<<^v<>><<<>^><v<v<>>v<>^>^>><v^<v<>^^<v^<v<<>><><<vv^^<vv<<<>^^^v>^>v<^<^<^>>^><<>><v^<v>vv<^^^>>^<^^<^<<<>^<<vvv^>><v^^^>><<<>>^>vv><^^><><><<>>>>^<>>>>><<<^<>v<v><>v<>v^><v>vv^^^vvv>v><v>>^>vv>vvv<vv<^>v>vv>^<<v^^<><>^>^<<vv<^<^<^^^^^v<^v<<>vvv><>>^v^^^v<^>vv>^>vvv>>>>>^^^>^<vv>v<^<>v><<>>vv^^v>v<>^<>vv<<<>vvv>>^vv<<>^^>v^>>v><<^>^<vvv<^<<<<<^>vvv><<>vv>>v>vv>^<>>^><v><^><<><^>>>^<^^v^<<^^<><^>vv^>v><v^^>v><^^<<<>^>v^^<^v>^<^v^^><v>^<<^^>><v>>v^<^>^v^>vv<><^^><v<>v^<>^v>^<^>>v><^>><^^v<v>vvv<v^>>^^v<^^><^^^>><vv>^>^^v<><>v^<v>^^v^><<v^vv>^>v<vv>>v<^<>vv><<>vvv^^^>^<v>>vvv<<<v>^v>vv>><^<v<>^v<v<^>vv<v>^>^vv><v^^>><v^v>^v<^^>^<>^<>^>v^<^vv><<<^<<<v^
<^<v^v>vv<^vvv<<<v>><^<>^v^<><>>>^<^v><v<v<^<<v>v><<<<^^^<<^<>^v^v<>v^<v<>^>><>v>><^^>>v><>>^>^<>v<v<>v>v<<v^>^>vv^<vv^>^><^><<v^v<<>^<vv<v>^^v<v<>^^<>^^>^v<v^^<v^v><<>>v^^^vvv<<v^^v<v>>^>>><v><^v>><vv>^>^<<^^v^<^<^>^^^>^v>>v<>>>v^^><<>>>>>^v<v>vv^v^><>v>>vv>^^v>><>v<v^v^><v>v^><v^<>^<v<>><>>><<^<v^v^v>><>><>>v>><v^><<><><^>v<<>>>v^<v^>^vv^vv>v<^^vv>v<v>^v>>^<v^^v^v<<<>vv<><<v<v^>>v^><v>^v><<^>>v^^>^^^>><vv<>>><^v^v^^>^v>v><^<^<>^^<v^v>^>><^v<<>v^v>v^^vv^^<v^>^vv>^v^>v^><<<^<v>^<v>>^>>v<v>v<vv<^>>v>>^^>^>v^v<>v^>>v^^vv>vv<^v>><>vv<^^><vv<vvv^<v>>vv^<<v>>>v><<^<^v>>^>vv>^>><vv^v>><v^v<><>>v<^<^^^^v^>v^>><><^<<>vvv>>v^<<^>>^<^>v<<^v>>>>^v><v<vv<>v>>v^<<^>>^<>v^^>^<<<<v^v<v<^^><^^>^>>>v^v>^<<<v^<v^>v>^>>>><>>v><>>v>><>v^v<v^vvvvv<<^><^^>^<<<^<^^><^>v>^>v<v^>>v^<>>>vv<^>>v<>><^<<><<>^<>^^<^^v^<v><<>v<v^<<v><<v>vv^<^<v^<v<<^^vv>^><<>v>v^v<^v^>>>^^><v<<>^vv>><v<^<<>>vv^^>v>v<<>v<^<v>>^<^>>^<<vvv^^>><<>^<^v^<v>v^<<^^><>^<^^v<v>vv^v<<<<><<<<<<v^^>>v>v>^^<>^<^<<vv<^<><v><>^>^^v>^^^<>^>^^>>v>v<>
^>><^^^<v>v<><>^^<v<<<<^><>>^^<^>vv>^>>^>^v>v^vvvv>^<^>>^v><^v>>><<>><<>v^><>^>><^><v^v><<v^<vv^v>>vv<><<<^^<>>v^<<><>v>vv><<^><>^<v>v<>^<>^>^<v<vvv<>^vv<<vv><<^vvv>v^<^<^v>>><^>vv>>v<>>>>^^^^^<^<v<>v<v<v<<<><v>vv><<^v>v><vv<^>><^vvv><v<v>^^v<^^v^^>^^><^<<v<<>^>^v<<^>^v^v^>vv^v^<^><<>>^v><>>>><^v><>^^v<^vv><^^<<<v>v<v^v>v^>>^><><^^v>^vv>v^<>vvv^>vv<vv^v^v>v^<>vvv<>v><<^<v^^>>^v<<<<vv^>^^<>v<<><v^v<<v><^^>^>^<^>^v>>^<<^>^v>vv>^<<^^^<vv<^<v^^vv><^v>v^<v<v^vv^<<vv^>>v><v><<>^^><^>vv<^<>><>^v^^^><>v^<><v^^v<<<<<<><^^v>vvvv^^^<<>^v><^^^^^v^<^<v<^vv^>>v>^v^^<<><><<>>>>><^<>^v<v>v><^^<<^>^>^<^v<^v>>^v^^><^^v>^<>vv<><^<vvv<^<<v^>^>^v^^>>>^^v<>>^>>><^vv<^<<<>v^<v<<>v^v^^^<^v<v>^>^^<>v<>>vv>^><^v<>>^^v><<vv<^>>v<>>v><<^v^v>^>><<^vv<>v^>^<v^^><^>v^<>v^v<><^vv^^v>^<><>>v>^<^<^><v>v^>><<vv<v<v>><^^<>>v>>^^^v>>>v<<>^v^^v<<v^^^<>v<v>^<<><<^vv<<<>>^v<>>vv><><>^^v^vv>>^v><v^>v^><^>v^v<^><^<<^>^>^^v>v<><<v^<vv^>v>><v^>v<<<^>v^^<<><v^v>^<^^vv<vv>vv^>>>>v><^v^>><vvv^<^>vv^v<<^>vv<v<>^<^<vv^^>><^^<^v><^v<^
>v>>>^v<>v<v<>>>^^<<vv^>^<<^v>>>^^^v^<^v>vv^><^v^^^^^v^<vv^v>vv^>v<<v>>>>^<v<^<<<<<>>^>^<>^v>^><<^>><><>><^><^^v^^^^>^<v>>v<^vv><^^^v>><^>>>><>^>^><vv^v>>v>v<^>v^vv^<^v>^<^^>^>>^><<<^>><^^v^vv^^>v><<^<^^<v^>^^vv^<>vv<vv^>>^<v>v^^>><v^vv<^<<><^<<<<>>vvv<<>v><v>>^^<v>>^>><>>v><<^v>^^<v>^>v><vv^>^^vv>v>><v><v^^v<v><vv^<vv<><>><^v^<><>^v<><<^^vvv<<>v>>^<>v<<>v<v>v<>vv^^vvv^v^>>>^^<<^<^><^vv^>v<<>vv<<^>>>v<vv<><^>^<^><<v>vvvv<^^>vv<<^<v<<^>^v<<>>^>^><vv<^>>>><v^<<^>>v<vvv>^><v^<<v^v^v<<^v>><>v^^><<v<>v>>>v^<^<^^^>>v<v^>^>><<v^^^>^v<>v>^<^v<^>^v<><<<>^>^v^v>v^vv<<>>>>^<<>vv<^>>>^^^^>^v>v<v<^v^>><>>v<v><>>vv^^^^^>^>>^^v>^>>^v><>><^<^>^^^vv^v>v<^v^<>>vv^<v^^^><^<<>>^>vv<<<v><^^v^<<v<v^^>^<v<>>^^^<vv^><<^<><>><v>><<v^<^v<^>v^v<vvv^^<<><v<vv<<^<>><^<^v^>^>><<<^>>^<<^<vv>v<^<v<v^><><vv^v>^<^<^^<<>><<^vv<^^<<v<v<>>v<><v<><<><><><<v>v>^>v^<^v^>><>v>v<<>v<>^>vv^v<<><>>^<><v>>>>^v^v>>^v>vv>v^^<v<^<<v^^<^>v<>^^<>^^>>><^v><<>^vv<^vv><v<^>vv>>>>v<vvv<^^v^<<^>v>v<>v^>v<<>>v<>><<v^>>v^^<<<^^v^<v><^vv>vvv>
>v^v^v>>v<^^^<^<^>vv>^^><<>^>><v<<<<<v^>><>^v^^vv<vv^>v<>><^<v^vv>v>>>^^vv<<v^vv<<<<^>>^v^>^^^^<>^v^^><^^v>v><v>v><v>vv><^^<^<^v>^v<<v><v<^<<v><<<<^v<v^v<v<><><<>^<v^^v^>>>><^v^>^><<<^<<v^v<>>><v^^^><<<<^vv^v<^^>v^v>^v<<>>>>>>v<^>^>^^v^^>^<vvvv<<>><<>v>v<>v>vvvv<>v^>^^vv<^v>v^^v<^<v<^^<><vv<^<v^v^^<vv<^^^^v<^<<v^<<v<^<<<^<vv>><v>>>><>vv^<^v^<^<<vv<^^^<<v>vvv<v>v><v^v^<<^<v>v>^^<<>>vv^v<>v^>v<>^<^v><><>vv><<<<<<^v<>><><<>>>^>>><>vv>^>><<^^>><v<^^^<v^<>^>^>>>v^v>v^v^^>v><^v^<v>^^^^>^v^<<^>>^<>^<><><<v<^^<vvv^^v>^^>><>^>v<<vv<<>><<^<>^>>vv<^>>v<><<>^<<v^^v<<<<<^><^v^>vv^v^<^vv^>>^<<^^^vv<vv^^>v<>><<<^^<v^<^<^>^v^<v^<v^><v^^^^>vv<vv<<v><>v^^>^<^<^<^^^v>^>>>>^^<^v^<>vvv<<<v<>v>v<^^^><><^><><<<<^><v<^^>vv<>^<^<v>v><<v>>>>v<<<>v<^v<v>^><<v^^>v<v>><<<vv>v>v>v<vv^^<>^^v><><<v><^^<v^><><<vv^^v^>v>^>>v>^^^<<^><^v>v>>^^v^vv^^^^v^v<<><>><<vv^vv<^>>^>>^<^^<<<<>^^><>>v<^^^^v^<>v>>v^^v<v^^>v>>^v<>>^<<^v^v^^v>^vvv^<v^>^<>v^^^v>^<v>>v^vv^<^>>>><>>^<^<<^>v>vvvvv<v<<<><<<vv><>^^^v>^>^>><<<><^<v>>^<><v^^><
>>><><^^^^v<>>v^^>^^^^v<>^<^v<>vvv^^>^v><vv><><>^^v^^v><<<<^v>>^>^<>v><^^v^v^>><v>v^>v<v>^v^<vvvvv<vv>v>><v^vv^^^v><>^v<>^^^>><vv<>><<<v<vvv^<<^v^v>^vv^<^>>v>^v<>v^v^><^>v^<vv^<>vv>>v^>^v>v<vv^^vv>>v<^<<^vv<<^^><^vv^>>><>^v<^<<v<>>^^v><^^v<^v^<v^><<<v<<>^<><^vvv<><<v^<v><>^>v^v>v>^^<<<>^^>><>v>^v<^<>v>v><<vv<>^^>>>^vvv<^v><vv>v^<vv^v<vv^^vv<^v^<>v><<v<v><v<vv^v^vv^^^^vvv^v>^^>v<^^v>v>>>v>>>>vvv>^<^>>^v>^<v<>>vv><^>v>^>^^><vvvv>>>>^<<<<>^^v^<^^^v<<>>^v^<v^^<<<>>^v>vv^^v>>>>^<v>^^<v>v<<>^v^v^><>>^<v>v>v^><vv<^v^^>^>v>^v^><^>v<^v^vvv^^^<<<vv<^>><v<>>>vvv<v>v>^>^>><<>vv^^vv>v^>><^^>^^v><v<>vvv<>vv^^^^<^<vv>>^^v^<^>v^><^vv>>>^<^<<^^<^<><<^v<^<<>^><>v><vvv^>^><^<vvvv^^<<v<v<v<>v>><^v<v>v^vv<<>^v>>v^^^v>v<^^^<>vv>v^vv^>v<^vv><^v^^>^^vv>^^>>v><><vv><v>v^v>v<vv><^^^vv<>vv<v^^^>^^>v>^<^><>^^>vvv^>v<^<v^v^<<v><^^^<v>v>v^>v<><>v>^>v>>v<^v<<><>>>>^>v<v^v<<<v><<>>v>><<v><v>^>>^><^v><^^v<>v<^^>v^v<<<><^>><>vvv>vv<^>v>><v>>>^^>v<<<>v^v>^^^v^vv>vvv>>^><<vv<^v<<<>v^^>>^vv^<><<^v>^^>vv>>>v^>v>^>^vv^^>>v>
v>><v<^v<>^>>v<v>^>v<^>^<<>^vv<v><^^v^<^^<^<<^<^>v<><>v<<>v<>><><vv^^<v><^^><v^^<<^^<<>v>vvv>vv<>^v^<><^^v^>v>^^v<><vv<>>v><<vv><<>>>^^^<vv>>v<>^v^<vv^v>^^vvvv^^v^<^^><><><<^>^>v<<>^^v>vv><<<v^>^>^<^v<^v^vv^<vvv>>v<>^^<v^vvv<><<v><>>^v<^<>v>^^>v^<v>>^><>^^^>>>^>^<<^^>^v^>^vv><v<v<>v^<v<<^v^^^>^^<>>^>^^v>v<<<>>v<>v<^^>vv<^<vv^<^<v<<>^<>v>>><>vvv<>^>^<<>><>^>><<>^>>v>v>v<^v>^>>>^>v^^<^v>v<<><^<^^<^>^^>vv>>>>^^<^v>v^<<>^>>^>>>^>v<v^<<<vv^<^>^<<v<vv<><^>>>^^v>>^^^vv><v><v>^^<>>v^^>^>vvv<>v<^v<^<>^^^^v^>v^<v^>^^^<<^<v^v<><v>^v<v^^><<><<^>>v<>v>v>^<^^^<v>>^^v<>>>^vv><<>v^v><<>>v>>^>v>>><>v^>v<vv<^>^<^v><vv^><>v><><>^>vvv^vv^<v^vv<vv^>v^v><>^><^>vv<>>>v>^>^v<^<<v<^>^^>vv<><>>v<<><<>>v>vv^^>^^v^^>>>^>v>>>^^<<<^<<<v^<>>>v>><><^<<>v<<><v<>>v<v<<^<v^>>^>^<>^<<vv^vv^><v^<^<>>>vv>v^<^vv>>^v><>><>>>><>vv^v>vvv>>vv<<v<>v>v>><^vv^<><>^^<^<>^><>>v>v^v>v^>^>v^<^>v^v^^^<v>vv^<<<v>vv<v<^<^v<^^>><^>^v<<^v<vv<><^^v><^<>vv<>v>>^<^^>>vvvv^^^<>>v^>^^v<>v>vvv><v<<<vv^v^^v^^<^>^<vvv><<<<>^>^v^^>><><vvv<v<^<>^^>^
v<v^v>^>^^vv<>v>^><v>^v<<>>^>v<^vv>^<v^>>>><<vvvvv><^v<vv<^<<vv<><<>^vv^>^^^>>>>>>v^<v>v><><<^<>v<>^<v<>><>><>v>^<vv<><>v<<v>^^<>>^v<^<v>><^<v^vv>>v^vv^>v<<<<^v^v><^<^<>v^>^><>^^vv<^vv<>^<v^><>^<^>^^<vv^>^>^^^<vvvv^vv<vv<<v>^><v>v^vv^vv^><vvv^<v^^v^^<v<v><>^v><v<v^<>>><^^v^^>^^v<><^^^><vv>><v<<^<v>>vv>^^><><>v>>^^>>vv>^v<v<>v<^><vv><<v^<vv^>^>^^><^>>^^>^vv^v^^v<>v^<<v^^v<<^v^v>^^v<^<v<<<^>><v>>^^v><>^v^>^v<^^^^<>v^^v>^<v>^<<>><>>^^><vvv<<><^vv^^^v><v>^v<<>v>^<<v><<>^<>v<vv^vv<v^<>v>v>^^<>v<><>v>^<<>vv>><^<^<vv^<v^^<<<^^^>vvv><^v><>v>^<^>v<^v<<><^<vvvv^<v<<<^vv>v<v<v><^>>vv>^>>^>>>><<v^v^^<^v<^>vv<><^^<>v<vv>v^>v<^<><<<>vvv<>^vv^v^>v<v^>vv<><v^>v><>^^>v^>>>vv>><^^>v^^^><v>>v^<>>^vvv>^^v>vv>v>^^^^vv>>>^<><^>^v^v><><v>^^v<>>v^vv^>v^vv^<v^v<^v^^>v<<>^<<<vvv><^<<<<^><<<<<v^^>v^>^>>^vv<><<>vv><><>^v^>^>^v^^v<v><vv<<<>^^v><^<^<<<><>vv><v<^>v<^>v><v>^>>^<v<^^^><<^>vv^>v^<^>>>^<<v>v<>>>^<^<vv^^<>><<v><vv><v<^v><^^^<<>vv>v><^^>v<<v^v>^vv><>vvv<<^<>vv><v^^>>^vvv<>^^<>>v<<>^vv>>>>v>^^vv>>v<^<^>v<^
vvvv^<<^v<^vv^^><v>>^vvvvv^^^>^>^<>^><<<vv>>><^vv>>>vvv><^>v<^>^<vv^^^^^><v<>^>^>^<vv^>>v>vv<<>>^v<^^<><<v<><>><<><>>><v<v^<>>>v^<^>>>>>v^>^v>^v><^<>^v><>v^^<<><v^^^><<>^^vvvv><<v^>>^^<>v^>>^>^^<^><v<vvv^>vv^^><v^<<vv^>v<>>>>^>vv<>vv<^<v^v^^v<>^>^^>vv>^<<^^>>v>v>^^><<<v><<<<^^>>v<<vvv<>>^^vv<v>v^>>^vv><^<^>>^>>^<^>>^<>><^<<<<<^v<v^>^^vv>^vv>v<>>^v<^^^v^^v<><<<^^v>>v>>^<<><v>vvv^>^^<^>v^^>v>v^vv<^v^vv<^v>^>>^>v<>v^<vvvv>v><<v>><v>^^<^^<^vv>^vvv^v<v><<^v^>>>>><><v>^^^vv>^v^><<^>^^v<<<>v^<vvv>^<^^^><^v<^^><vvv>^>>v>vv>vv^^>>v><^v<>^v<^^^<<^>v^v>>v<^v><<>>^^v<v^^^v<^vv<v^^<><<<vvv<>^<v<vv^^^><<>><v<v^<<<v<<<<>>v>vv>vvvv<vvvv<>v<><>>>>^vvv<<vv><^^>>v^<<^><^v>><v<<><<<^v^>><vv<<>^<^^^v<>^<><^v>v>vv^^><^>>v<^^vv^v>>v<<^^<^>><vv^^<^^>>v^><^vv>v><vvv>^vv^<^><^<^>v>v>v^>>^vv<<^<>>>>v<^^<v><^v^<^vvv>v><>^^^^vv>>^>>v<^vvv>v<v^v>^^<v^>^v^v<<<<^<v<^<^>^^vv^v<^^v^>>^>v<><<><>^<v>>^<<^<>^<>><^vv><><<vv<<vv^v^<vv>^>v<^^><>v^<>v<^<>v>>^vv>v^v<^>v^><^^>>><<v><v>><>>v<v^>^v>v<v^><^>^^^<<<>v^><<v^^v>v^^^v^
^>v<v<v>><>>^vv>>>>^>^>><vv<>v>>><^>^><vv^<<>^<vv^>v>>^<^v^<^v^v<>>>><><<>>^^^v^^>>>vv<<<v<<^vv^>^>^<><v^><>>>vv^^<<v<vv^>^vv<><v>^<^^>v>v><<^vvv>>><<v^v>>v<^vv^v<<v^<^^v>vvv<<>>v>><>>v<>^^<<>>><^<^v^^^v<^<^>v><<>v<<^>><^<^>><vv^^v<^v<><<^^<>^v<>v^v><>^>>>^><>^^>v<>^<<^v>v>><^vv<<>^><>^<v>^<vv<><<<<>^<><^v^v>^<<^><v<<>>^>v<v^^^v<^><^<v<^^<>^^v><>><>>>v>><>^>><v<^v<vv><<<>><><>v^<v><<<>>>>^<>>^<<v<<v<>>>^^<<>v<v<^^v<v>v>>v>>v>><^>vv^v><^v>v^v<<^<vv<v^<>^<>v>><^<^v>v>v^<^v>v^>v^><<>>^>vv<^<>>>^v<^v<v^vv><<^>^^<>>v>^^v^vv>^^^^>>vv<<<v<^^><>^v^^^^>>^>^v^v^v<v<^v^vvv<<><>^<<>>vv^>>>>v><<v<v<>><v^vvv^v<>>^v<<<v^^<<>><^<^v^v<v>>>vvvv^vv><<><>>^<^vvv>>><^v<>>^v^^^<>>^^><<v^v>>^<^>>v><<>vv>><^v^vv<^^<<>v^v><^^<^<^^><>^v^^>v>v>^^<><v^<^^v<><v>>vv^v^>^v><<<^v>v>>^>v>v<^<>>v><^^<^v^v^<<vv><^^>^>v<>^^<v>vv<>>>>^><<>>vv<^^<v>>>^v>v<<v^>^>>>^^^v>v^^>>^^^>^v><^>vv>vv<>^><v>^>vv^>^<<<<v^>v^>^^vv<<>><><<^^<^^v^vvv<<^<<v^^^<^v^v>>v<>v^v><^v^>^>v^v^v^<><<vv>><<<v^<v^vv><^<^<^<>>>>v<vv>^vvv^>^v<^^<v>>^v><v
><v>>>^^>^v>vv^v^v^><^v<v<>vv^>>^>>vv><>vv^^>^><>^^v<v^><v><^^^v><>><<v<vvv<^><^><>^^v<>vv<v^<>^>^<^vv^^<^<>^>^v<vv^<<^^<<v>^>>vvv>^v<><vvv>>>>><<v^<^<<<^><^>^>v^^><<<v<v^<<v<>v><<>vvv<<<v>vv>vv^>^>><>>^>><v^<<v>^^><^v<<^<^>>^^>^vvv<<v>>^<>>^>^><v><^<>v<<<^><^^^>^^>>^<^<>>^^<<vvvv<>^>>^v<>^v^v<><v<vv^<^<^^>v<^>^<<<<<>^<^>><v^<v^^<<>^v^>^<<><><>^<<vv^<^v>v<><><v>^^v<v>v>>vv^>>><<><^^^><^<v^><^vvv<>v>>^<>>vv<v<<>^^><^^^^^^<vv>^><^^><>>>^<^^v<<v>v^<>>^v><^><v^^vv<>v>>^v^vv^>>^<^vv><><>^^<vv^^<vv^v^^^vv^<<^^^>v<vv><>^>^>vv<^^^^^^<vv^^<<>^v<v^<^>vv><>>><><>^<v>v^v^vvvvvv^^><<<<><^^^^>^<v<vv^v^>v^v<<>v<>^>>^<><^^>v<<v^<<<<^>v<>v<^<<v>v<vv^>^>>v<^^v<vv<^<^v^><>^<v^<<><<>^^>^>>^^v^v><^<>v^<>v<<><><v^>>v>vvvvv<>^<<><^v<<<><<<v>>^<^<<^><^>v>v<>^v<v>^<v^^^<<<vv^<v<^v^<>>>v<^^^^^><^v^v^<v^<v>v<v<>vv^vv<>vv<v>>vvv>><>^v>v^<vvvv>^><<v>vv^v<v>^v>v^><>^>v^>v>v<vvv<>v^>v<^>^vvv<<vvv^<v^>v^>><v^<<^>^><><v>^<>^v>v^vvvvvvv>v<>v^<>>>^^>v>vv^>v^>><<<><<vv^<>^vvv^>v^^>>>^>v<^v>^^<>v<^v^^><^v<vv>>^v<><vv^v<><
^v><v<^v^^v^>v><<>v^>vv>v^vv^<^^><<^<<<<>>>><^^>v><vv<vv<<^>><>>>>v^^^>v^v^v^vv<^vvv^><<v>v<<vvv<v>>v<^><vv^>v<v>v^<<<v^>^v><^^>^>^vv>v<<<>v><>><>v^v^>vv<v^>v^vv>vvvv<>>^>^vv<<<^^^^v^<>^^<v>^><v^^><^v>v<v>>><^>>vv>^^>>>v<v<v<^^vv^>^<>v<><v^><v>>v<^v^>v^v><<>v^^^^^^^v^>^^^<^vv<<^>><<vvv>^>^>v<v<<>^<><<>>^>vv>vv>^>v<vv<^^>>^>^v>^v>><<><^^^^<v^<>>>^v^<v>^v<>>>v<v<v<<>vv^v<v<><v<><vv>>v>v<vv>^<>vvv<<>>v^<v><><^v><^^^vv^v<<<>vv<<vv^v<v^>v>^^v^>>><v^><<<<<^^<^^><<v^v>^v<^<v^<<><v<^<><<v>^v^<<^^<><v>><v^>^^<<<><>v<v>>vvv<<>>><^<v>>^^v>^vv^>v^<<^^^^>>>v^^<>><^<><vv^>>^vvv<^v<<>>^><^^v^<<^^^^<v>>><<<v^v<>>^v>><v<>>vvv^>><^vvv>v>^v^^v<>><^>><^>><<^>>v><>^>>^>v^>v<v<<<>v^vv<^vv>>v<v><^vv>v<^^>v>v>v^v<v^vvv^>v^<^v<v<>v^>>^<>v><>^><<>><v<>vv>^^<><^<><><<<>^>^^vv<><vvv>^>>><^v^<><<<v>v>v<^>>v<><^<^<^>v>^<vv<v^>^^^>^><<^>>>v<v<v<v>v>>vvv^>v>v<<^>^v^<^^^<<<<<^<^^><v>v^<v<>>>><v>v^<><v>^^<vv<vvv<vv^^<><><^><v<><vv^^^<^<<<>^vv<<^<v>^v>><v<vvv<^^v>^v^^v^vv^v^^><v<v^<>^<^v^>v<vv>v<v>^>vvv^>^<v<^^><>>v<<<v
^>^v<<>^<v<v^^<v>>vvvv^<v^v><>v>>v^^v>>><>>v^<><^>v><<v^>^>>><>v>vv^<v^>>>^<^^<><><v<>v^^>v><v<<vvvvv<v><vv<<v<v^^v<>v<^v^<^^><^^<v^<v><<^<>^^vvvv>^v<>^^<^v<v^v><v>>vv><v^>^>v<^^<^^>>v^v^^^v>^v^>^>>^vv^v>^<v<<vv><<>^><^^^v>v^><>>v<v^<v^^v>v>><vv^<v><>v<>>vvv^><>><v<<vv^<<^<<^>>^^>v^v<<<>v>v<<v>^>v><><<^>><<^>^>v><v>v^<^v><<v<^>vv^<<vvv<vv<>^>>^<v><<>v^^>>>vv^>^<>^^<<^^><>^<>^^><<^^<><>><<>>^^^<^^>v<>^^>>^<><<<v^^v<v>^vv^>v<<^>v^>^<><<v<><<>><^^^>>^><^v^<^<vv>>>v<vvv^^^<^v>v>^^vv^<v<>>^vv<>><><^>v>^><><^v><v<v^v<<<<>vvv<<^>^^^v>v^>^>v>^>^^<>v<<^<^<^><vv<v^v<v<<>>^><<>v^^><<^<<<vv<>vv><^^>><>vv<^>^>>><<^v><<^>vvv<^>vv>>>^^vv<><<^><^><>^>v><<^>^^^<>v>v<vv>^><v>^>v^><>>^<v^><<<vv>^<^vv<<<^v^<>^<<>^>v>>><<^^v>>v<v^v<<<vv^v^v>>v^^>vv<v^vv^v<vv>v^<<^<^^^v>>^>^>>v^<v^>^^vv>v<^>>^<v^>^^v<^^>vv<^v><>>vv<>>^>v>vv^v^^^>^v^^>^<<^<<^>>v<v<<>vv<v<v<^^v<v^^v<>><<<v>^>>vv<v>^^^><vv^<<><>^<<v^<><><>^>^vvv>><<<v^<<v^^<<v<<^<v<^<<<><^vvv><<vvv<v<<<>^>^<>v<^^v><<^><^><>v><^<^<>vv^^<vv^v>v^^^<>><vv^>vvvv<v^
^v<>vv>v<v<vv>>>v^^>>^vv>v>^v^^v><><<^<>>^v^>v<v><^v>^v<>^>>>>^>v>>v^>^<^^>v^^^vvv^v>^>v^^^^vv^^><v<v<>^<v^<vvv^<^>v^<>><^<<<><^^^v^v>v^<><<>^<>^vv<vv<^^^<><^^v><>v><v>v<<^<^v>^v>vv^^>vv<><<^>^<<v>>>v^<v<<>vv^<<v>v>><^<<v>><^<vv<v>>>>^<<><^<v<>^<><>vv><>v>v<><>^^<vv^<>>>^^vv^v<>vv<>vv<^v^>v<v^^v>^>^<^>^<^>v<><^v<>v^>>^<v<^v<v>>>v<vvv<^^<vv>>v<<>v<><<><<>^^<<^<v>^^>v^v>>v^vvv^<^>^v^^>^v>>^v^v^^^vv^^<<>^<<^<<v^vv>^>>^<<<^>vvvv<<>>>^<<>vvv^v>^>vv<<^>^>vv<vv>>v<v><vvv^^v^<<><><<^^^^^v<^<v^^^^vv<^>>><v>vvvvv^>^>>v<^>><>v<vv><^<<<v>v^<^>^^^<>>^^v><<>v<>v<^^<>>^><>>>^v^^v<<<<^<<<v^^v>^>v<>v>>^>v>^^<v>><<><<^>v^^^>^<^>v>v^>v<<^v<^<^v<><>>^>v^<<v>>^><<<^<<vvv<<vv><^>^>>>>>vv^v<v<^<v^<<<v<>v<vv>^>>>v>>^<<>>>>>><>vv>><vvv<><v<v^^>vv^<^>>v<>>^<>^v<>>v<>><^>^^^^<>v<v^>^^vvv>^^><^v>v^v<v<>>>>v><^^>^<><>>v^<^^^<^<<^v^v^vv>>v^<<^>^<>^^v^>^>v^^^>^^^<vvv<<<>v>><<>>^vv^^v^^><<>^>^>>^vv^v>^^<>^v^^^<>^v<^>v^^^><<v^^^>>^><<<^v<^v^v>v^>^<<><vv<<>^>^<v<^v<^><<^>v^<v<<>>><>^v^>v^^<^<vv><><><<^v<<<><v>>vv>^>^><
"""
}
