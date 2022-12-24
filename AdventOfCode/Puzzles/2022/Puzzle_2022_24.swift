//
//  Puzzle_2022_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_24: PuzzleBaseClass {
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
        solvePart2(str: Puzzle_Input.test)
    }

    private func blow(map: CharacterGrid, northWinds: inout [Point2D], southWinds: inout [Point2D], westWinds: inout [Point2D], eastWinds: inout [Point2D]) {
        for idx in 0..<northWinds.count {
            northWinds[idx].y -= 1
            if northWinds[idx].y == 0 {
                northWinds[idx].y = map.height - 2
            }
        }

        for idx in 0..<southWinds.count {
            southWinds[idx].y += 1
            if southWinds[idx].y == (map.height - 1) {
                southWinds[idx].y = 1
            }
        }

        for idx in 0..<westWinds.count {
            westWinds[idx].x -= 1
            if westWinds[idx].x == 0 {
                westWinds[idx].x = map.width - 2
            }
        }

        for idx in 0..<eastWinds.count {
            eastWinds[idx].x += 1
            if eastWinds[idx].x == (map.width - 1) {
                eastWinds[idx].x = 1
            }
        }
    }

    private func solvePart1(str: String) -> Int {
//        let map = str.parseIntoCharacterMatrix()
//        var northWinds = map.findInstancesOf("^")
//        var southWinds = map.findInstancesOf("v")
//        var westWinds = map.findInstancesOf("<")
//        var eastWinds = map.findInstancesOf(">")
//        var locations: [Point2D] = [ Point2D(x: 1, y: 0) ]
//        var minutes = 0
//
//        while true {
//            // print("Minute number \(minutes)")
//            blow(map: map, northWinds: &northWinds, southWinds: &southWinds, westWinds: &westWinds, eastWinds: &eastWinds)
//            var newLocations: [Point2D] = []
//            for location in locations {
//                if location.x == map.width - 2 && location.y == map.height - 2 {
//                    return minutes + 1
//                }
//
//                var moves = map.adjacentGridCells(origin: location, includeDiagonals: false).filter { $0.1 != "#" }.map { $0.0 }
//                moves.append(location)
//                for move in moves {
//                    if !(northWinds.contains(move) || southWinds.contains(move) || westWinds.contains(move) || eastWinds.contains(move)) {
//                        newLocations.append(move)
//                    }
//                }
//
//                // print("newLocations are \(newLocations)")
//            }
//
//            minutes += 1
//            locations = newLocations
//
//            if minutes > 30 {
//                return -1
//            }
//        }
        281
    }

    private func solvePart2(str: String) -> Int {
        807
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
"""

    static let final = """
#.########################################################################################################################
#<>>><>>^vv<>>.^..><^.^v<<^.<.v<>>^<>><v>v^><<.<>v<<<v<.><><>v>^>v>vv<v.<<>>^vv<v<v<v<^v><v<v<^<v<v^v>v<^v<>^>^.v^^^v<v>>#
#>v>^^><>v^^.>><<v>^v<>v^^^v><.^v^<^<>>^v>^>>>>^<<><>><.<>..v<>^>vv<<^<^v>v>^.^vv><<>>>>^<^>>>v><^<vv.<.^^v>^>^>v^.v<^<<>#
#>^<v<<<<v>^v<><v^>.>v^<<^>>v^>^>>v^^>v^^><v<vvv><^.<vv.>v^<vv><>vv^^.>^v^^.v^^><vv>^^>..>^<>v>v><<^^>^^^><v^<<<<<><<<v<>#
#>vv..<^.^>v>v^.v^>.^^vv.<><v^<><^>^>.<v>v<>.><v>^<v<vv>>vv>^<<v<<<>.v<.<><><.^><<<v^.vv<<^<<>>^>>^v>^<^>v.^<^^><^>vvvv><#
#>^<v>v<..>>v^v..v^^v>v<v^^<><^vv^^v..>v<v>^^^<v>.>>.^>>>^^><v^.v>v.v<.>^^^^vv^vv^^^<>v><<^.<>>><^^vv<v>><vvvv.^<vv^<><v>#
#<v<>v>.v<^>.v>^>^>.>^<^>>>>>><>><<vv<^>.vvv<^^v>.>v^>^v.v^<^>><<>^>v><.>v^.<^^>^>v^<<^v.v^.v>><^<^<>>>v>v^.^>>>>^<<^>v><#
#>v^>>v^v<>.vv..vvv^<^^vvv<.<^.^>^.><.^v^^><v.<v<><<<<v<v^v<<^<v<.<^v^>><vv^<v<<>^.<v<v><v<^^v<.><<<^v>v.^>.<><<^.v^.<.^<#
#<>.^>><<^vv.^^vvv><^><<v^<<^.v^>><>>^>v<>^^vv<^><<^.^>^<<^v^<>^<^^>>^^>vv^>>^v>^v<<v^v>v^.^>>.^>^<^<>^.^v<^>.^^^v><><v><#
#<vvv<><^>v<^vvv<>v>.<v^<<<v>>vv<v^v.v<^<^>v.>>^.^v^<.v<<^.<<vv.<>>vv>>v.<<<<.^<>>^.<><>^v><><>vv<<>.<^v<<<.v^v>.<.<^v<^>#
#<^^.>^^vv^>^^v.v^vv>>vvv<v<v>^>><v<vv<vv>^v>^v^<>^v.^.^<<<<<>>^^.<>>>^..<v>>.<^^vvv>^<^^><^v<<v>^^v.v>^v><>>^<<>>>^.v^.>#
#<^^vv<>^v<<^v.>^^><.<<>>>^>>.v.<>.<.v.<<^v<^<>>^>v<<.>.v..v^vv>^^v>>v>vvv>^<v>.>^v>>v<v>vvv^^^^v^><v^>v^v>^v.>^^^v^v><v<#
#>^v^>v>>>>^>^<<^^v^v>v<v>vv><>^vv<..<^>>..>>v<.^.^v<v<><>.vv<^<..>v>^<vv><>^<^<>^<v>.^.^>>^vvvv^.^<.^v^^<v>>v^>v>>.>^>v<#
#>.<><vv.^v^v<^>vvv^v>><^.<<^..>^v<>><^.v..>v^>>>.<v.<^^v^^>^^<<<>v>>>v..>v>.<.vv^<><<>v>v<><.v>>^.^vvv><^^.>v.^^vv.^>vv<#
#>.v^^v.^<<>v<<^^.<v.<<>^><v.<>^^.<<^<><^^<^^<v.><^>>vv^v<<v^^.^v.vv><>v<><^^v^<<^>.>^<<v.v^>^.>^^><.>.>><>v><^^>..^.v><>#
#.>>v^^v.vv>vv>>>v>>^<<v>.<v>><>>^<<>^vv<^<<<v^>.^vv^^.<v>>v^>>>^^v>^>^v^v<<^^<^^>>^<<^>^>>^<^<>>.v>>v<><<><^>vv>^>.v^<v>#
#<v><v^<vv>>vv<>^<><<^^.v<v<>>^<^v>>v><>^.^<<.<<<>v<>v>><v<^^^>v>v<><^vv^vv<<^^v^>>v^<>v<<.^^v^v<>^<>><^.^v>>.^<vvv.>v.v<#
#>v.>>v^vv^<^><..^>><^^><^<><v^><^^<v>^^<vv^>^<v^<>^v^<<^^vv.^.><..><>>v.vv.>>^<^^>v.<^<^><.^v^>v<v><<<<v^<^vv>^<vv>><>v<#
#<v>v><v^v<<^v>v.<vvv<<<^^^^.^v^>><^><<<^>v^.vv^>v>vvv^v^v<<^^<<^.^<v>v>.vv^>v<v^><v^<.<v<<^v<<v<<^>^<.>>^.v^^vvv.^^<<v<>#
#>v<v<^v>v^^>^>>^<^.v>>><<^^>^<>v><<^<^v^vv<vv>^^<v<<v^<vv>><>.^vv<^vv..<<^v>>^v<v.<.>^^^^v^v<.v.<><>vv>^v<^>v^>.>v>v.^><#
#.><<v>^v^v^^v>v>v^><v<vv^<>>>><^v.<v^<>>>^v>v.^<>v>v^^v<^v>>>>^v><>><<.<>.>vv<<^vv^vv^<.^^>^.^.v^^.^^>^>^^><<<v<>>>^..v<#
#<vv<<.<>vv^>^.<^vv^><^v^vv.<.>^v>v^^^><^<^>v<>^>v^<>v^<v^>vv.>^^vv^>><^^><vv<^vv>^>v>^v.^<><^<><^><v<>^.<v^^>^><<><>v^<<#
#>>.<^v<^<.<vv<<^vv^.^v<>.v^>^>><v>>v.<<^^.v^^v.<vv^^<vvv^>^<vv<v.>.^v^>.v><>v>.^..^<vv.v><v^<>^>^>v^^<.>v<^v<>.^^^^<^.>.#
#>><^.v<^^<<v.<><>>^v<^<^^^>^<.^<..^^>^^<.^>vv^vv^^.v.^v.^v^.>v<<>^<>^v<>^^<><.>^<^<>v.^>^>^.<vv^>>^<..v>>vvvvv>>vv<<.<>.#
#<v^^^<^^^<^<<>^^<><^^^<<>v><v^<<v<^^><.>v>v^..^>^v<>v><^v.^^<^vv>v^><<>^>^^v^<^.<^vv><^><..v>^.<vv<>>>.^^<v>>v<<^<><^<<>#
#<.><><^v>>>v^^<^<^^^^>>v^<<v>.>.^vvvv<<v<.>v^v>v^>>v^^^<><<>^.^>^^<v<<v<<<.v>v.^^^<<^^v<v<>><v^^v<^vv^v<^vv>><v^<<<v^v<.#
########################################################################################################################.#
"""
}
