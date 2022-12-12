//
//  Puzzle_2022_12.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

// Thanks to Benedikt Müller for guidance on this one
// https://github.com/d12bb/AdventOfCode/blob/main/2022/d12/main.swift

import Foundation

public class Puzzle_2022_12: PuzzleBaseClass {
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
        var map = [[(val: Int, visited: Bool, parent: Point2D)]]()

        func edges(_ cur: Point2D) -> [Point2D] {
            var ret: [Point2D] = []
            for (x, y) in [(1, 0), (0, 1), (-1, 0), (0, -1)] {
                let (x, y) = (cur.x + x, cur.y + y)

                guard x < size.x, y < size.y, x >= 0, y >= 0 else { continue }
                if map[y][x].visited { continue }
                let curHeight = map[cur.y][cur.x].val
                let edgeHeight = map[y][x].val
                if edgeHeight - curHeight > 1 { continue }

                ret.append(Point2D(x: x, y: y))
            }
            return ret
        }

        var origin = Point2D.origin
        var destination = Point2D.origin
        for line in str.parseIntoStringArray() {
            let line = Array(line)
            map.append(line.map { (Int($0.asciiValue ?? 0), false, .origin) })
            if let startIndex = line.firstIndex(where: { $0 == "S" }) {
                origin = Point2D(x: startIndex, y: map.count - 1)
            }
            if let endIndex = line.firstIndex(where: { $0 == "E" }) {
                destination = Point2D(x: endIndex, y: map.count - 1)
            }
        }

        map[origin.y][origin.x].val = Int(Character("a").asciiValue ?? 0)
        map[destination.y][destination.x].val = Int(Character("z").asciiValue ?? 0)
        let size = (x: map[0].count, y: map.count)
        var queue = [ origin ]
        var current = Point2D.origin
        while !queue.isEmpty {
            current = queue.removeFirst()
            if current == destination {
                break
            }

            for edge in edges(current) {
                map[edge.y][edge.x].visited = true
                map[edge.y][edge.x].parent = current
                queue.append(edge)
            }
        }

        var count = 0
        while current != origin {
            current = map[current.y][current.x].parent
            count += 1
        }

        return count
    }

    private func solvePart2(str: String) -> Int {
        var map = [[(val: Int, visited: Bool, parent: Point2D)]]()

        func edges(_ cur: Point2D) -> [Point2D] {
            var ret: [Point2D] = []
            for (x, y) in [(1, 0), (0, 1), (-1, 0), (0, -1)] {
                let (x, y) = (cur.x + x, cur.y + y)

                guard x < size.x, y < size.y, x >= 0, y >= 0 else { continue }
                if map[y][x].visited { continue }
                let curHeight = map[cur.y][cur.x].val
                let edgeHeight = map[y][x].val
                if curHeight - edgeHeight > 1 { continue }

                ret.append(Point2D(x: x, y: y))
            }
            return ret
        }

        var origin = Point2D.origin
        for line in str.parseIntoStringArray() {
            let line = Array(line)
            map.append(line.map { (Int($0.asciiValue ?? 0), false, .origin) })
            if let endIndex = line.firstIndex(where: { $0 == "E" }) {
                origin = Point2D(x: endIndex, y: map.count - 1)
            }
        }

        map[origin.y][origin.x].val = Int(Character("z").asciiValue ?? 0)
        let size = (x: map[0].count, y: map.count)
        var queue = [ origin ]
        var current = Point2D.origin
        while !queue.isEmpty {
            current = queue.removeFirst()
            if map[current.y][current.x].val == Character("a").asciiValue ?? 0 {
                break
            }

            for edge in edges(current) {
                map[edge.y][edge.x].visited = true
                map[edge.y][edge.x].parent = current
                queue.append(edge)
            }
        }

        var count = 0
        while current != origin {
            current = map[current.y][current.x].parent
            count += 1
        }

        return count
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
"""

    static let final = """
abccccccccaaaaaaaccaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccaaaaaa
abccccccccaaaaaaaccaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccaaaaaa
abccccccccccaaaaaaccaaaaaaaaaaaaaaaaccccccccccccccccacccccccccccccccccccaaaaa
abcccccaaaacaaaaaaccaaaaaaaaaaaaaaaaacccccccccccccccaaaccccaccccccccccccccaaa
abccccaaaaacaaccccccaaaaaacaaacaacaaaaaaacccccccccccaaaacccaacccccccccccccaaa
abaaccaaaaaaccccaaacaaaacacaaacaaccaaaaaacccccccccccaklaccccccccccccccccccaac
abaaccaaaaaaccaaaaaacccccccaaacccaaaaaaaccccccccccckkkllllccccccccccccccccccc
abaaccaaaaaaccaaaaaacccccccaaaaacaaaaaaacccccccccckkkklllllcccccccaaaccaccccc
abacccccaacccccaaaaacccccccaaaaaccaaaaaaacccccccckkkkpppllllccccccaaaaaaccccc
abacccccccccccaaaaacccccccccaaaacccaaaaaaccccccckkkkpppppplllccccddddaaaccccc
abccccccccccccaaaaaccccccccccaaaccaaaccccccccccckkkppppppppllllldddddddaccccc
abccacccccccccccccccccccccccccccccaaccccccccccckkkopppupppplllmmmmdddddaacccc
abccaaacaaaccccccccccccccccccccaaaaaaaaccccccckkkkopuuuuupppllmmmmmmddddacccc
abccaaaaaaaccccccccccccccccccccaaaaaaaacccccjjkkkooouuuuuuppqqqqqmmmmddddcccc
abccaaaaaacccccccccccccccaaccccccaaaacccccjjjjjjoooouuxuuuppqqqqqqmmmmdddcccc
abcaaaaaaaacccccccccccccaaacccccaaaaaccccjjjjoooooouuuxxuuvvvvvqqqqmmmdddcccc
abaaaaaaaaaacccccccaaaaaaacaacccaacaaacccjjjooooouuuuxxxxvvvvvvvqqqmmmdddcccc
abaaaaaaaaaacccaaacaaaaaaaaaacccacccaaccjjjooootttuuuxxxyyvyyvvvqqqmmmeeecccc
abcccaaacaaacccaaaaaaacaaaaaccccccccccccjjjooottttxxxxxxyyyyyyvvqqqmmmeeccccc
abcccaaacccccccaaaaaacaaaaaccccaaccaacccjjjnnntttxxxxxxxyyyyyvvvqqqnneeeccccc
SbccccaacccccccaaaaaaaaacaaacccaaaaaacccjjjnnntttxxxEzzzzyyyyvvqqqnnneeeccccc
abcccccccccccccaaaaaaaaacaaccccaaaaaccccjjjnnnttttxxxxyyyyyvvvrrrnnneeecccccc
abcccaacccccccaaaaaaaaaccccccccaaaaaacccciiinnnttttxxxyyyyywvvrrrnnneeecccccc
abcccaaaaaaccaaaaaaaacccccccccaaaaaaaaccciiiinnnttttxyyywyyywvrrrnnneeecccccc
abcccaaaaaaccaaaaaaaacccccccccaaaaaaaacccciiinnnntttxwywwyyywwwrrnnneeecccccc
abcaaaaaaaccaaaaaaaaaccccccccccccaacccccccciiinnnttwwwwwwwwwwwwrrnnneeecccccc
abcaaaaaaaccaaaaaacccccccccccccccaaccccccaaiiiinnttwwwwwwwwwwwrrrnnnffecccccc
abcccaaaaaaccaaaaaccccccccccccccccccccaaaaaciiinnssswwwssssrwwrrrnnnfffcccccc
abaacaaccaaccaaaccccccccaacccccccccccccaaaaaiiinnssssssssssrrrrrronnfffcccccc
abaccaaccaacccccccccaaacaacccccccccccccaaaaaiiimmmssssssmoosrrrrooonffaaacccc
abaaaccccaaaaaaccccccaaaaaccccccccccccaaaaaccihmmmmsssmmmoooooooooofffaaacccc
abaaaccccaaaaaacccccccaaaaaacccccccccccccaacchhhmmmmmmmmmoooooooooffffaaccccc
abaacccaaaaaaaccccccaaaaaaaaccccaaccccccccccchhhhmmmmmmmgggggooofffffaaaccccc
abaacccaaaaaaaccccccaaaaaaaccccaaaaccccccccccchhhhmmmmhggggggggfffffaaaaccccc
abccccccaaaaaaacccccaacaaaaacccaaaaccccccccccchhhhhhhhggggggggggfffaacaaccccc
abccaacccaaaaaaccccccccaaaaaccaaaaacccccccccccchhhhhhhggaaaaaaccccccccccccccc
abccaaaccaaccccccccccccccaaaaaaaaaccccccccccccccchhhhaaaccaaaacccccccccccccaa
abaaaaaaaccccccccccccccccaaaaaaaaccccccccccccccccccccaaaccccaaccccccccccccaaa
abaaaaaaaccccccccaaaccccacaaaaaacccccccccccccccccccccaaaccccccccccccccccccaaa
abaaaaaacccccccaaaaacaaaaaaaaaaacccccccccccccccccccccaaccccccccccccccccaaaaaa
abaaaaaacccccccaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccccaaaaaa
"""
}
