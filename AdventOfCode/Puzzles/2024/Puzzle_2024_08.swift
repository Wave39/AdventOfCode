//
//  Puzzle_2024_08.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_08: PuzzleBaseClass {
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

    private func solvePart1(str: String) -> Int {
        let grid = str.parseIntoCharacterMatrix()
        let characterMap = grid.getCharacterMap(ignorePeriods: true)
        var antinodes = Set<Point2D>()
        for key in characterMap.keys {
            let points = characterMap[key]!
            let combinations = points.combinations(of: 2)
            for combination in combinations {
                let diff0 = combination[0] - combination[1]
                let antinode0 = combination[0] + diff0
                if grid.pointIsValid(antinode0) {
                    antinodes.insert(antinode0)
                }
                let diff1 = combination[1] - combination[0]
                let antinode1 = combination[1] + diff1
                if grid.pointIsValid(antinode1) {
                    antinodes.insert(antinode1)
                }
            }
        }

        return antinodes.count
    }

    private func solvePart2(str: String) -> Int {
        let grid = str.parseIntoCharacterMatrix()
        let characterMap = grid.getCharacterMap(ignorePeriods: true)
        var antinodes = Set<Point2D>()
        for key in characterMap.keys {
            let points = characterMap[key]!
            if points.count > 1 {
                let combinations = points.combinations(of: 2)
                for combination in combinations {
                    antinodes.insert(combination[0])
                    antinodes.insert(combination[1])
                    let diff0 = combination[0] - combination[1]
                    var antinode0 = combination[0] + diff0
                    while grid.pointIsValid(antinode0) {
                        antinodes.insert(antinode0)
                        antinode0 += diff0
                    }

                    let diff1 = combination[1] - combination[0]
                    var antinode1 = combination[1] + diff1
                    while grid.pointIsValid(antinode1) {
                        antinodes.insert(antinode1)
                        antinode1 += diff1
                    }
                }
            }
        }

        return antinodes.count
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
"""

    static let final = """
.............................R......p.......7.....
.........................L........................
................4.................................
..............Nr......4...........................
............D.....................................
..........................U......................b
..f..........................L......J.............
.f...................X.4.......U..................
..................u..............U......K.........
.........D..........X......j...R..................
.........u.......................................p
....D............Q..R.q................d....F.....
............N...6...........L.....................
...............................................K..
.........N........RQ..X...............17.b.V......
93....f.......................................7...
...f...................X..................b.......
............................u............7........
..............j........d...q.....B..........k.....
.................2......jN.............B.....p....
.............3....................U..J......V.....
............2....xl..1d.......................k.V.
..3....4..........Qj..x..D...l.................h..
................x..........V.8......Q.............
...............6........d.8.......A...............
..........3......6L...........8..l..1.b.J.........
...................1.F............................
.................................O.......M........
.....x....2.......................................
........6.h.......r......n.......J.......k..K..a..
...I............F.....................a...........
.................F...P....z....q..................
....................l.................B.......P...
..........................5.....O........Z......M.
..i.......zn........q.............................
.....................9............m...............
.......................r......n..............Z....
........................n..........5..............
.o..............................h.M...............
...............H.........................h......a.
............r................v....O.....0..M...k..
.....i..o.............H................A.......0..
.........i....m....8..............................
..........i........v..B.......................A.Z.
............I....z....92.O....v..................0
...o......I.....................P.................
........................H......5..................
..........................v......m..............0.
..o............................9.....P.mZ.........
.........z...I....................................
"""
}
