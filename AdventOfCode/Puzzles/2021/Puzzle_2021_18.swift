//
//  Puzzle_2021_18.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/18

// https://github.com/gereons/AoC2021/blob/main/Sources/AdventOfCode/puzzle18.swift

import Foundation

public class Puzzle_2021_18: PuzzleBaseClass {
    private class Pair {
        var xNumber: Int?
        var xPair: Pair?
        var yNumber: Int?
        var yPair: Pair?

        var descriptionWithAddresses: String {
            var str = "["
            if let xNumber = xNumber {
                str += String(xNumber)
            } else if let xPair = xPair {
                str += xPair.description
            } else {
                str += "BIG PROBLEM"
            }

            str += ","
            if let yNumber = yNumber {
                str += String(yNumber)
            } else if let yPair = yPair {
                str += yPair.description
            } else {
                str += "BIG PROBLEM"
            }

            str += "] ("
            str += "\(Unmanaged.passUnretained(self).toOpaque())"
            str += ")"
            return str
        }

        var description: String {
            var str = "["
            if let xNumber = xNumber {
                str += String(xNumber)
            } else if let xPair = xPair {
                str += xPair.description
            } else {
                str += "BIG PROBLEM"
            }

            str += ","
            if let yNumber = yNumber {
                str += String(yNumber)
            } else if let yPair = yPair {
                str += yPair.description
            } else {
                str += "BIG PROBLEM"
            }

            str += "]"
            return str
        }
    }

    private var explosionOccurred = false

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1_BP() -> Int {
        solvePart1(str: Puzzle_Input.test2)
    }

    public func solvePart1() -> Int {
        let arr = Puzzle_Input.final.parseIntoStringArray()
        let nodes = arr.map { line in
            Parser.createNode(from: line)
        }

        var result = Node.add(nodes[0], nodes[1])
        result.reduce()
        for index in 2 ..< nodes.count {
            result = Node.add(result, nodes[index])
            result.reduce()
        }

        return result.magnitude()
    }

    public func solvePart2_BP() -> Int {
        0 // solvePart2(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        let arr = Puzzle_Input.final.parseIntoStringArray()
        let nodes = arr.map { line in
            Parser.createNode(from: line)
        }

        var maxMagnitude = 0
        for i in 0..<nodes.count {
            for j in 0..<nodes.count {
                if i == j { continue }
                let n = Node.add(nodes[i], nodes[j])
                n.reduce()
                maxMagnitude = max(maxMagnitude, n.magnitude())
            }
        }

        return maxMagnitude
    }

    private func parsePair(str: String) -> (Int, Pair) {
        // print("parse with string \(str)")
        var strIndex = 1
        var endFound = false
        var charsProcessed = 0
        var commaFound = false
        let pair = Pair()
        while !endFound {
            if str[strIndex] == "[" {
                // print("found [")
                let newStr = String(str[(strIndex)...])
                let (chars, newPair) = parsePair(str: newStr)
                if commaFound {
                    pair.yPair = newPair
                } else {
                    pair.xPair = newPair
                }

                charsProcessed += chars + 1
                strIndex += chars
                // print("advancing \(str) to index \(strIndex)")
            } else if str[strIndex] == "," {
                // print("comma found")
                commaFound = true
                charsProcessed += 1
            } else {
                // print("found \(str[strIndex])")
                if commaFound {
                    pair.yNumber = String(str[strIndex]).int
                } else {
                    pair.xNumber = String(str[strIndex]).int
                }

                charsProcessed += 1
            }

            strIndex += 1
            if strIndex == str.count {
                // print("end of string found")
                endFound = true
            } else if str[strIndex] == "]" {
                // print("end bracket found")
                endFound = true
                charsProcessed += 1
            }
        }

        // print("chars processed \(charsProcessed)")
        return (charsProcessed, pair)
    }

    private func explodePair(pair: inout Pair, parents: inout [Pair]) {
        if var xPair = pair.xPair {
            print("checking x pair \(xPair.description)")
            parents.append(pair)
            explodePair(pair: &xPair, parents: &parents)
        } else if var yPair = pair.yPair {
            print("checking y pair \(yPair.description)")
            parents.append(pair)
            explodePair(pair: &yPair, parents: &parents)
        } else if let xNumber = pair.xNumber {
            print("reached an x number of \(xNumber)")
            print("x parents count: \(parents.count)")
            if parents.count >= 4 {
                var xLeft: Int?
                var xRight: Int?
                for idx in stride(from: parents.count - 1, through: 0, by: -1) {
                    if let left = parents[idx].xNumber, xLeft == nil {
                        xLeft = left
                    }

                    if let right = parents[idx].yNumber, xRight == nil {
                        xRight = right
                    }
                }
                print("left \(xLeft ?? -1) right \(xRight ?? -1)")
                print("parent pair was \(parents[parents.count - 1].description)")
                parents[parents.count - 1].xPair = nil
                parents[parents.count - 1].yPair = nil
                if let xLeft = xLeft {
                    parents[parents.count - 1].xNumber = (pair.xNumber ?? 0) + xLeft
                    parents[parents.count - 1].yNumber = 0
                } else {
                    parents[parents.count - 1].xNumber = 0
                    parents[parents.count - 1].yNumber = (pair.yNumber ?? 0) + (xRight ?? 0)
                }
                // parents[parents.count - 1] = newPair
                print("parent pair now \(parents[parents.count - 1].description)")
                explosionOccurred = true
                return
            } else {
                print("found a number, not deep enough for an explosion")
                return
            }
        }

        return
    }

    private func reducePair(pair: inout Pair) {
        var pairModified = false
        repeat {
            pairModified = false
            var parents = [Pair]()
            explosionOccurred = false
            explodePair(pair: &pair, parents: &parents)

            if explosionOccurred {
                print("pair after explosion: \(pair.description)")
                pairModified = true
                print("-------------------------------------------------------")
                explosionOccurred = false
            }
        } while pairModified
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        for line in arr {
            print("==========================================================")
            var (_, pair) = parsePair(str: line)
            print("line: \(line)")
            print("pair: \(pair.description)")
            reducePair(pair: &pair)
            print("reduced pair: \(pair.description)")
        }

        return arr.count
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        for line in arr {
            print("==========================================================")
            let (_, pair) = parsePair(str: line)
            print("line: \(line)")
            print("pair: \(pair.description)")
        }

        return arr.count
    }
}

// swiftlint:disable all

extension Puzzle_2021_18 {
    class Node {
        var value: Int
        var left: Node?
        var right: Node?

        init(value: Int) {
            self.value = value
        }

        init(left: Node, right: Node) {
            self.value = 0
            self.left = left
            self.right = right
        }

        // recursively copy the tree
        func copy() -> Node {
            if let left = left, let right = right {
                return Node(left: left.copy(), right: right.copy())
            }
            return Node(value: value)
        }

        static func add(_ n1: Node, _ n2: Node) -> Node {
            Node(left: n1.copy(), right: n2.copy())
        }

        func magnitude() -> Int {
            if let left = left, let right = right {
                return (3 * left.magnitude()) + (2 * right.magnitude())
            } else {
                return value
            }
        }

        private func addToLeftmost(_ add: Int?) {
            guard let add = add else { return }
            if let left = left {
                left.addToLeftmost(add)
            } else if let right = right {
                right.addToLeftmost(add)
            }
            value += add
        }

        private func addToRightmost(_ add: Int?) {
            guard let add = add else { return }
            if let right = right {
                right.addToRightmost(add)
            } else if let left = left {
                left.addToRightmost(add)
            }
            value += add
        }

        @discardableResult
        func explode(_ depth: Int = 0) -> (Int?, Int?)? {
            if depth >= 4 {
                if left == nil && right == nil {
                    return nil
                }
                let result = (left!.value, right!.value)
                self.value = 0
                self.left = nil
                self.right = nil
                return result
            }

            if let left = left, let right = right {
                if let (addLeft, addRight) = left.explode(depth + 1) {
                    right.addToLeftmost(addRight)
                    return (addLeft, nil)
                }
                if let (addLeft, addRight) = right.explode(depth + 1) {
                    left.addToRightmost(addLeft)
                    return (nil, addRight)
                }
            }
            return nil
        }

        @discardableResult
        func split() -> Bool {
            if let left = left, let right = right {
                if left.split() { return true }
                if right.split() { return true }
            } else {
                if value > 9 {
                    left = Node(value: value/2)
                    right = Node(value: value - value/2)
                    value = 0
                    return true
                }
            }

            return false
        }

        func reduce() {
            while true {
                if self.explode() != nil { continue }
                if self.split() { continue }
                break
            }
        }

        func dump(inner: Bool = false) {
            if let left = left, let right = right {
                print("[", terminator: "")
                left.dump(inner: true)
                print(",", terminator: "")
                right.dump(inner: true)
                print("]", terminator: inner ? "" : "\n" )
            } else {
                if left != nil || right != nil {
                    fatalError()
                }
                print(value, terminator: "")
            }
        }
    }

    enum TokenType {
        case obracket
        case cbracket
        case integer
        case comma
    }

    struct Token {
        let type: TokenType
        let value: Character
    }

    struct Tokenizer {
        static func tokenize(code: String) -> [Token] {
            var tokens = [Token]()
            for ch in code {
                switch ch {
                case "[": tokens.append(Token(type: .obracket, value: ch))
                case "]": tokens.append(Token(type: .cbracket, value: ch))
                case ",": tokens.append(Token(type: .comma, value: ch))
                case "0"..."9": tokens.append(Token(type: .integer, value: ch))
                default:
                    continue
                }
            }
            return tokens
        }
    }

    class Parser {
        private var tokens: [Token]

        init(tokens: [Token]) {
            self.tokens = tokens
        }

        func parse() -> Node {
            return node()
        }

        static func createNode(from string: String) -> Node {
            let parser = Parser(tokens: Tokenizer.tokenize(code: string))
            return parser.parse()
        }

        private func node() -> Node {
            consume(.obracket)
            let lhs = intOrPair()
            consume(.comma)
            let rhs = intOrPair()
            consume(.cbracket)

            return Node(left: lhs, right: rhs)
        }

        private func intOrPair() -> Node {
            if peek(.integer) {
                var value = 0
                while peek(.integer) {
                    value *= 10
                    let i = Int(String(consume(.integer).value))!
                    value += i
                }
                return Node(value: value)
            } else {
                return node()
            }
        }

        private func peek(_ expected: TokenType) -> Bool {
            guard !tokens.isEmpty else { return false }
            return tokens[0].type == expected
        }

        @discardableResult
        private func consume(_ expected: TokenType) -> Token {
            if tokens[0].type == expected {
                return tokens.remove(at: 0)
            } else {
                fatalError("expected \(expected), got \(tokens[0].type)")
            }
        }
    }
}
private class Puzzle_Input: NSObject {
    static let test1 = """
[1,2]
[[1,2],3]
[9,[8,7]]
[[1,9],[8,5]]
[[[[1,2],[3,4]],[[5,6],[7,8]]],9]
[[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]
[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]
"""

    static let test2 = """
[[[[[9,8],1],2],3],4]
[7,[6,[5,[4,[3,2]]]]]
[[6,[5,[4,[3,2]]]],1]
"""

    static let final = """
[[6,[[9,4],[5,5]]],[[[0,7],[7,8]],[7,0]]]
[[[[2,1],[8,6]],[2,[4,0]]],[9,[4,[0,6]]]]
[[[[4,2],[7,7]],4],[3,5]]
[8,[3,[[2,3],5]]]
[[[[0,0],[4,7]],[[5,5],[8,5]]],[8,0]]
[[[[5,2],[5,7]],[1,[5,3]]],[[4,[8,4]],2]]
[[5,[[2,8],[9,3]]],[[7,[5,2]],[[9,0],[5,2]]]]
[[9,[[4,3],1]],[[[9,0],[5,8]],[[2,6],1]]]
[[0,6],[6,[[6,4],[7,0]]]]
[[[9,[4,2]],[[6,0],[8,9]]],[[0,4],[3,[6,8]]]]
[[[[3,2],0],[[9,6],[3,1]]],[[[3,6],[7,6]],[2,[6,4]]]]
[5,[[[1,6],[7,8]],[[6,1],[3,0]]]]
[2,[[6,[7,6]],[[8,6],3]]]
[[[[0,9],1],[2,3]],[[[7,9],1],7]]
[[[[1,8],3],[[8,8],[0,8]]],[[2,1],[8,0]]]
[[2,9],[[5,1],[[9,3],[4,0]]]]
[9,[8,4]]
[[[3,3],[[6,2],8]],5]
[[[9,[4,8]],[[1,3],[6,7]]],[9,[[4,4],2]]]
[[[[1,3],6],[[5,6],[1,9]]],[9,[[0,2],9]]]
[7,[[[0,6],[1,2]],4]]
[[[[5,0],[8,7]],[[7,3],0]],[[6,7],[0,1]]]
[[[[5,4],7],[[8,2],1]],[[[7,0],[6,9]],0]]
[[[3,[5,6]],[[9,5],4]],[[[9,4],[8,1]],[5,[7,4]]]]
[[[3,[7,5]],[[8,1],8]],[[[6,3],[9,2]],[[5,7],7]]]
[8,[[2,0],[[2,6],8]]]
[[[[5,8],9],1],[9,6]]
[[[9,9],[8,8]],[[[3,5],[8,0]],[[4,6],[3,2]]]]
[[5,[[5,1],6]],[[5,8],9]]
[[7,[[1,6],6]],[[[8,6],7],[6,6]]]
[[0,[[9,5],0]],[4,[[7,9],[4,9]]]]
[[[[4,3],[3,5]],[[1,9],[7,6]]],[3,[[6,4],[6,0]]]]
[[[2,6],6],[6,3]]
[[[[1,5],[3,7]],0],[3,7]]
[4,[[[5,5],4],[[5,5],[9,3]]]]
[[3,[8,6]],[8,[7,7]]]
[8,[9,5]]
[[[6,3],[2,[3,6]]],[[[6,0],[0,2]],[[8,7],5]]]
[[[8,[1,2]],2],7]
[[[[8,4],[2,7]],[[3,9],7]],[[4,[8,8]],[[7,4],9]]]
[[[8,[2,5]],[3,[1,2]]],[[4,[5,0]],3]]
[[8,[0,3]],[[5,1],[1,1]]]
[[[8,[3,6]],6],[[7,[1,5]],[[4,8],9]]]
[[[5,0],[0,3]],[[2,[7,8]],[1,[4,8]]]]
[9,[4,[9,4]]]
[[[9,[0,4]],2],3]
[[9,[7,[8,9]]],3]
[[[8,6],[[3,5],[9,2]]],[[3,[9,7]],5]]
[[6,[[7,4],2]],[2,[7,[6,0]]]]
[1,[[[2,2],6],8]]
[[[6,[1,8]],[[9,3],[1,8]]],[[[8,2],[9,3]],[[8,2],[9,9]]]]
[[[[2,9],[1,7]],[[4,0],8]],[[8,9],[6,3]]]
[[[[2,4],[6,1]],[[5,4],[2,8]]],[8,[1,[2,4]]]]
[[[4,6],[1,6]],[3,[1,1]]]
[[[[8,3],8],8],[1,[[4,2],3]]]
[[[9,[8,7]],[5,9]],[8,[[5,6],[4,5]]]]
[[[[4,1],2],[[7,8],4]],[0,6]]
[[[9,7],[[8,6],[6,9]]],[[8,[8,4]],[[9,0],2]]]
[[[8,5],[1,9]],[[[2,4],5],6]]
[[[9,[9,3]],[9,[2,3]]],[7,7]]
[[[8,[7,4]],[2,6]],[[[4,5],[9,9]],[0,[5,2]]]]
[7,[2,2]]
[[[[1,8],[5,2]],3],[0,[2,[4,5]]]]
[[5,[[4,8],[5,5]]],[4,[[3,4],[6,0]]]]
[[3,1],[4,[3,[8,2]]]]
[[3,7],[3,[[6,1],[0,2]]]]
[[4,[6,2]],[[3,9],8]]
[[[[2,9],3],[[5,6],4]],[8,2]]
[[4,[[7,9],[4,9]]],[[4,3],[7,[0,7]]]]
[[[3,[8,9]],[[3,4],[9,5]]],3]
[0,[[[3,0],[8,7]],[[0,9],[9,1]]]]
[[[5,[9,9]],2],[4,8]]
[[[[4,4],4],5],[3,4]]
[[[3,[2,2]],7],[[3,2],0]]
[[[[0,5],[5,2]],2],[2,[[1,2],2]]]
[[[4,6],6],[[0,1],6]]
[2,[[[3,9],7],[[9,8],8]]]
[[7,9],[7,[[3,0],9]]]
[[[1,[6,2]],[0,8]],[[[7,2],4],9]]
[[[[4,7],[1,5]],[5,9]],[[2,[0,4]],[7,[7,0]]]]
[[1,[[2,0],[0,4]]],[[[4,6],9],[[6,8],[0,1]]]]
[[[[6,0],7],[7,[9,6]]],[[7,[4,9]],[9,4]]]
[[[5,[4,6]],[[1,9],[5,8]]],[[[3,6],[2,6]],[[7,3],7]]]
[[[6,0],[6,6]],[2,8]]
[[[4,[7,2]],[[5,6],[2,4]]],[[[6,8],5],[4,6]]]
[[[[9,0],9],[4,0]],[[[9,1],8],[6,4]]]
[[6,3],[1,[[5,0],[9,9]]]]
[[[2,7],[5,6]],[[6,[1,4]],[9,9]]]
[[[[0,5],3],[8,7]],[[[9,9],[6,2]],[0,7]]]
[[[5,6],[1,7]],[[[0,4],9],9]]
[[[7,3],3],[6,[0,[8,9]]]]
[[[0,6],[[8,5],[4,6]]],[[[2,7],[4,2]],[[8,7],[0,5]]]]
[[[8,[7,3]],1],8]
[[8,[8,[8,2]]],[[5,4],[1,[2,6]]]]
[[[[1,1],[8,6]],5],9]
[[[[2,4],[5,7]],[[5,8],[3,1]]],7]
[[4,[[0,1],9]],[[3,8],[4,2]]]
[3,2]
[[3,4],[8,[[6,5],[6,6]]]]
[[[[7,0],[3,8]],[[3,3],[2,6]]],[[8,0],9]]
"""
}
