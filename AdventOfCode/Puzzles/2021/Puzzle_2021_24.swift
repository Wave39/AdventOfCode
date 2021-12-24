//
//  Puzzle_2021_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/24

import Foundation

public class Puzzle_2021_24: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        92_915_979_999_498
    }

    public func solvePart2() -> Int {
        21_611_513_911_181
    }
}

// Kudos to David Philipson for his amazing analysis
// https://github.com/dphilipson/advent-of-code-2021/blob/master/src/days/day24.rs

// The values below are for my input, your will of course be different

// check, offset
// 12,4     push input[0] + 4
// 11,11    push input[1] + 11
// 13,5     push input[2] + 5
// 11,11    push input[3] + 11
// 14,14    push input[4] + 14
// -10,7    pop must have input[5] = popped - 10
// 11,11    push input[6] + 11
// -9,4     pop must have input[7] = popped - 9
// -3,6     pop must have input[8] = popped - 3
// 13,5     push input[9] + 5
// -5,9     pop must have input[10] = popped - 5
// -10,12   pop must have input[11] = popped - 10
// -4,14    pop must have input[12] = popped - 4
// -5,14    pop must have input[13] = popped - 5

//                              large   small
// input[5] = input[4] + 4      9/5     5/1
// input[7] = input[6] + 2      9/7     3/1
// input[8] = input[3] + 8      9/1     9/1
// input[10] = input[9]         9/9     1/1
// input[11] = input[2] - 5     4/9     1/6
// input[12] = input[1] + 7     9/2     8/1
// input[13] = input[0] - 1     8/9     1/2

//                    1111
//          01234567890123
// largest  92915979999498
// smallest 21611513911181

private class Puzzle_Input: NSObject {
    static let final = """
inp w
mul x 0
add x z
mod x 26
div z 1
add x 12
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 4
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 11
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 5
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 11
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 14
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 7
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 11
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -9
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 4
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -3
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 1
add x 13
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 5
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -5
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 9
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -4
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
inp w
mul x 0
add x z
mod x 26
div z 26
add x -5
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 14
mul y x
add z y
"""
}
