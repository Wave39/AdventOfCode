//
//  Puzzle_2019_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/19/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_17: PuzzleBaseClass {
    private enum TileType: Int {
        case Path = 35
        case EmptySpace = 46
        case RobotUp = 94
        case RobotDown = 118
        case RobotLeft = 60
        case RobotRight = 62
    }

    private enum TurnDirection {
        case Left
        case Right
    }

    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_17_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_17_Input.puzzleInput)
    }

    private func solvePart1(str: String) -> Int {
        var arr = str.parseIntoIntArray(separator: ",")
        var programCounter = 0
        var relativeBase = 0
        var expandedMemory: [ Int: Int ] = [:]
        var inputSignal: [Int] = []
        let results = ProcessProgram(program: &arr, inputSignal: &inputSignal, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)

        var board: [[TileType]] = []
        var lineArray: [TileType] = []
        for r in results.0 {
            if r == 10 {
                if !lineArray.isEmpty {
                    board.append(lineArray)
                    lineArray = []
                }
            } else {
                lineArray.append(TileType(rawValue: r) ?? .RobotUp)
            }
        }

        // these lines of code print out the representation of the world
//        let resultsString = String(results.0.map { Character(UnicodeScalar($0)!) })
//        let resultsLines = resultsString.components(separatedBy: "\n").filter { $0.count > 0 }
//        print(resultsLines.joined(separator: "\n"))

        let height = board.count
        let width = board[0].count
        var total = 0
        for y in 1...(height - 2) {
            for x in 1...(width - 2) {
                if board[y][x] == .Path {
                    if board[y - 1][x] == .Path && board[y + 1][x] == .Path && board[y][x - 1] == .Path && board[y][x + 1] == .Path {
                        total += (x * y)
                    }
                }
            }
        }

        return total
    }

    private func solvePart2(str: String) -> Int {
        var arr = str.parseIntoIntArray(separator: ",")
        var programCounter = 0
        var relativeBase = 0
        var expandedMemory: [ Int: Int ] = [:]
        var inputSignal: [Int] = []
        let results = ProcessProgram(program: &arr, inputSignal: &inputSignal, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)

        var board: [[TileType]] = []
        var lineArray: [TileType] = []
        for r in results.0 {
            if r == 10 {
                if !lineArray.isEmpty {
                    board.append(lineArray)
                    lineArray = []
                }
            } else {
                lineArray.append(TileType(rawValue: r) ?? .RobotUp)
            }
        }

        let boardHeight = board.count
        let boardWidth = board[0].count
        var robotLocation = Point2D(x: 0, y: 0)
        var robotDirection = CompassDirection.North
        for y in 0..<boardHeight {
            for x in 0..<boardWidth {
                if board[y][x] == .RobotUp {
                    robotLocation = Point2D(x: x, y: y)
                    robotDirection = .North
                } else if board[y][x] == .RobotDown {
                    robotLocation = Point2D(x: x, y: y)
                    robotDirection = .South
                } else if board[y][x] == .RobotLeft {
                    robotLocation = Point2D(x: x, y: y)
                    robotDirection = .West
                } else if board[y][x] == .RobotRight {
                    robotLocation = Point2D(x: x, y: y)
                    robotDirection = .East
                }
            }
        }

        func canRobotProceed(from: Point2D, previousDirection: CompassDirection) -> Bool {
            var retval = false

            if previousDirection == .North {
                if from.y > 0 {
                    if board[from.y - 1][from.x] == .Path {
                        retval = true
                    }
                }
            }

            if previousDirection == .South {
                if from.y < boardHeight - 1 {
                    if board[from.y + 1][from.x] == .Path {
                        retval = true
                    }
                }
            }

            if previousDirection == .West {
                if from.x > 0 {
                    if board[from.y][from.x - 1] == .Path {
                        retval = true
                    }
                }
            }

            if previousDirection == .East {
                if from.x < boardWidth - 1 {
                    if board[from.y][from.x + 1] == .Path {
                        retval = true
                    }
                }
            }
            return retval
        }

        func findPossibleMoves(from: Point2D, previousDirection: CompassDirection) -> [CompassDirection] {
            var retval: [CompassDirection] = []

            if previousDirection != .South {
                if from.y > 0 {
                    if board[from.y - 1][from.x] == .Path {
                        retval.append(.North)
                    }
                }
            }

            if previousDirection != .North {
                if from.y < boardHeight - 1 {
                    if board[from.y + 1][from.x] == .Path {
                        retval.append(.South)
                    }
                }
            }

            if previousDirection != .East {
                if from.x > 0 {
                    if board[from.y][from.x - 1] == .Path {
                        retval.append(.West)
                    }
                }
            }

            if previousDirection != .West {
                if from.x < boardWidth - 1 {
                    if board[from.y][from.x + 1] == .Path {
                        retval.append(.East)
                    }
                }
            }

            return retval
        }

        func getNextDirection(oldDirection: CompassDirection, newDirection: CompassDirection) -> TurnDirection {
            switch oldDirection {
            case .North:
                return newDirection == .West ? .Left : .Right
            case .South:
                return newDirection == .West ? .Right : .Left
            case .West:
                return newDirection == .South ? .Left : .Right
            case .East:
                return newDirection == .South ? .Right : .Left
            default:
                return .Left
            }
        }

        func getNextPosition(oldPosition: Point2D, direction: CompassDirection) -> Point2D {
            switch direction {
            case .North:
                return Point2D(x: oldPosition.x, y: oldPosition.y - 1)
            case .South:
                return Point2D(x: oldPosition.x, y: oldPosition.y + 1)
            case .West:
                return Point2D(x: oldPosition.x - 1, y: oldPosition.y)
            case .East:
                return Point2D(x: oldPosition.x + 1, y: oldPosition.y)
            default:
                return Point2D()
            }
        }

        var movementString: [Character] = []
        var stayInLoop = true
        while stayInLoop {
            let canMove = canRobotProceed(from: robotLocation, previousDirection: robotDirection)
            if canMove {
                movementString.append(">")
                robotLocation = getNextPosition(oldPosition: robotLocation, direction: robotDirection)
            } else {
                let next = findPossibleMoves(from: robotLocation, previousDirection: robotDirection)
                if next.isEmpty {
                    stayInLoop = false
                } else {
                    let turn = getNextDirection(oldDirection: robotDirection, newDirection: next.first ?? .North)
                    movementString.append(turn == .Left ? "L" : "R")
                    robotDirection = next.first ?? .North
                }
            }
        }

        var path = ""
        var runCounter = 0
        for c in movementString {
            if c == ">" {
                runCounter += 1
            } else {
                if runCounter > 0 {
                    if runCounter == 12 {
                        path += "Y"
                    } else if runCounter == 10 {
                        path += "X"
                    } else {
                        path += "\(runCounter)"
                    }

                    runCounter = 0
                }

                path += String(c)
            }
        }

        if runCounter > 0 {
            path += "\(runCounter)"
            runCounter = 0
        }

        var aPath = ""
        var bPath = ""
        var cPath = ""
        var compression = ""

        outerloop: for x in 4...10 {
            let symbolsA = Array(path)
            let a = String(symbolsA[0..<x])
            for y in 4...10 {
                let compressed = path.replacingOccurrences(of: String(a), with: "A")
                let symbolsB = compressed.replacingOccurrences(of: "A", with: "")
                let b = String(symbolsB[0..<min(y, symbolsB.count)])
                if b.count > 20 || b.contains("A") { break }
                for z in 4...10 {
                    var moreCompressed = compressed.replacingOccurrences(of: b, with: "B")
                    var symbolsC = moreCompressed.replacingOccurrences(of: "A", with: "")
                    symbolsC = symbolsC.replacingOccurrences(of: "B", with: "")
                    let c = String(symbolsC[0..<min(z, symbolsC.count)])
                    if c.count > 20 || c.contains("A") || c.contains("B") { break }
                    moreCompressed = moreCompressed.replacingOccurrences(of: c, with: "C")
                    if moreCompressed.count <= 20 && !moreCompressed.contains("L") && !moreCompressed.contains("R") && !moreCompressed.contains("X") && !moreCompressed.contains("Y") {
                        compression = moreCompressed
                        aPath = String(a)
                        bPath = String(b)
                        cPath = String(c)
                        break outerloop
                    }
                }
            }
        }

        func getValidPath(_ str: String) -> String {
            var retval = String((Array(str).map { String($0) + "," }).joined().dropLast())
            retval = retval.replacingOccurrences(of: "X", with: "10")
            retval = retval.replacingOccurrences(of: "Y", with: "12")
            return retval
        }

        func getAsciiArray(_ str: String) -> [Int] {
            Array(str + "\n").map { Int(String($0).asciiValue) }
        }

        aPath = getValidPath(aPath)
        bPath = getValidPath(bPath)
        cPath = getValidPath(cPath)
        compression = getValidPath(compression)

        var inputArray: [Int] = getAsciiArray(compression)
        inputArray += getAsciiArray(aPath)
        inputArray += getAsciiArray(bPath)
        inputArray += getAsciiArray(cPath)
        inputArray += getAsciiArray("n")

        arr = str.parseIntoIntArray(separator: ",")
        arr[0] = 2
        programCounter = 0
        relativeBase = 0
        expandedMemory = [:]
        let finalResults = ProcessProgram(program: &arr, inputSignal: &inputArray, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)

        return finalResults.0.last ?? 0
    }

    private func ProcessProgram(program: inout [Int], inputSignal: inout [Int], programCounter: inout Int, relativeBase: inout Int, expandedMemory: inout Dictionary<Int, Int>) -> ([Int], Bool) {
        enum ParameterMode {
            case position
            case immediate
            case relative
        }

        func GetMemory(_ pointer: Int) -> Int {
            if pointer < program.count {
                return program[pointer]
            } else {
                if expandedMemory[pointer] == nil {
                    expandedMemory[pointer] = 0
                }

                return expandedMemory[pointer] ?? 0
            }
        }

        func SetMemory(_ pointer: Int, _ value: Int) {
            if pointer < program.count {
                program[pointer] = value
            } else {
                expandedMemory[pointer] = value
            }
        }

        func GetValue(_ parameterMode: ParameterMode, _ value: Int, _ writeParameter: Bool) -> Int {
            if parameterMode == .relative {
                return writeParameter ? value + relativeBase : GetMemory(value + relativeBase)
            } else if parameterMode == .position {
                return writeParameter ? value : GetMemory(value)
            } else {
                return value
            }
        }

        var outputArray: [Int] = []
        while program[programCounter] != 99 {
            let opcode = program[programCounter] % 100
            var cParameterMode: ParameterMode
            if program[programCounter] / 100 % 10 == 1 {
                cParameterMode = .immediate
            } else if program[programCounter] / 100 % 10 == 2 {
                cParameterMode = .relative
            } else {
                cParameterMode = .position
            }

            var bParameterMode: ParameterMode
            if program[programCounter] / 1_000 % 10 == 1 {
                bParameterMode = .immediate
            } else if program[programCounter] / 1_000 % 10 == 2 {
                bParameterMode = .relative
            } else {
                bParameterMode = .position
            }

            var aParameterMode: ParameterMode
            if program[programCounter] / 10_000 % 10 == 1 {
                aParameterMode = .immediate
            } else if program[programCounter] / 10_000 % 10 == 2 {
                aParameterMode = .relative
            } else {
                aParameterMode = .position
            }

            var p1 = 0, p2 = 0, p3 = 0

            func SetParameterValues(_ numberOfParameters: Int, _ writeParameter: Int) {
                if numberOfParameters >= 1 {
                    p1 = GetValue(cParameterMode, program[programCounter + 1], writeParameter == 1)
                }

                if numberOfParameters >= 2 {
                    p2 = GetValue(bParameterMode, program[programCounter + 2], writeParameter == 2)
                }

                if numberOfParameters >= 3 {
                    p3 = GetValue(aParameterMode, program[programCounter + 3], writeParameter == 3)
                }
            }

            if opcode == 1 {
                SetParameterValues(3, 3)
                SetMemory(p3, p1 + p2)
                programCounter += 4
            } else if opcode == 2 {
                SetParameterValues(3, 3)
                SetMemory(p3, p1 * p2)
                programCounter += 4
            } else if opcode == 3 {
                if inputSignal.isEmpty {
                    print("Ran out of input")
                    return ([], false)
                }

                SetParameterValues(1, 1)
                SetMemory(p1, inputSignal.first ?? 0)
                inputSignal.remove(at: 0)
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                // print(p1)
                outputArray.append(p1)
                programCounter += 2
            } else if opcode == 5 {
                SetParameterValues(2, 0)
                if p1 != 0 {
                    programCounter = p2
                } else {
                    programCounter += 3
                }
            } else if opcode == 6 {
                SetParameterValues(2, 0)
                if p1 == 0 {
                    programCounter = p2
                } else {
                    programCounter += 3
                }
            } else if opcode == 7 {
                SetParameterValues(3, 3)
                SetMemory(p3, (p1 < p2 ? 1 : 0))
                programCounter += 4
            } else if opcode == 8 {
                SetParameterValues(3, 3)
                SetMemory(p3, (p1 == p2 ? 1 : 0))
                programCounter += 4
            } else if opcode == 9 {
                SetParameterValues(1, 0)
                relativeBase += p1
                programCounter += 2
            } else {
                print("Unknown opcode \(opcode) at program counter \(programCounter)")
                return ([], false)
            }
        }

        return (outputArray, true)
    }
}

private class Puzzle_2019_17_Input: NSObject {
    static let puzzleInput = """
1,330,331,332,109,3612,1102,1182,1,16,1102,1,1477,24,101,0,0,570,1006,570,36,1001,571,0,0,1001,570,-1,570,1001,24,1,24,1106,0,18,1008,571,0,571,1001,16,1,16,1008,16,1477,570,1006,570,14,21101,0,58,0,1105,1,786,1006,332,62,99,21101,0,333,1,21102,1,73,0,1105,1,579,1102,0,1,572,1102,0,1,573,3,574,101,1,573,573,1007,574,65,570,1005,570,151,107,67,574,570,1005,570,151,1001,574,-64,574,1002,574,-1,574,1001,572,1,572,1007,572,11,570,1006,570,165,101,1182,572,127,1001,574,0,0,3,574,101,1,573,573,1008,574,10,570,1005,570,189,1008,574,44,570,1006,570,158,1106,0,81,21101,0,340,1,1105,1,177,21101,477,0,1,1105,1,177,21102,1,514,1,21102,1,176,0,1105,1,579,99,21102,184,1,0,1105,1,579,4,574,104,10,99,1007,573,22,570,1006,570,165,102,1,572,1182,21101,0,375,1,21102,1,211,0,1106,0,579,21101,1182,11,1,21102,222,1,0,1105,1,979,21102,388,1,1,21101,0,233,0,1105,1,579,21101,1182,22,1,21102,244,1,0,1105,1,979,21101,401,0,1,21101,0,255,0,1106,0,579,21101,1182,33,1,21101,0,266,0,1106,0,979,21101,0,414,1,21102,277,1,0,1105,1,579,3,575,1008,575,89,570,1008,575,121,575,1,575,570,575,3,574,1008,574,10,570,1006,570,291,104,10,21102,1182,1,1,21102,313,1,0,1106,0,622,1005,575,327,1102,1,1,575,21102,327,1,0,1105,1,786,4,438,99,0,1,1,6,77,97,105,110,58,10,33,10,69,120,112,101,99,116,101,100,32,102,117,110,99,116,105,111,110,32,110,97,109,101,32,98,117,116,32,103,111,116,58,32,0,12,70,117,110,99,116,105,111,110,32,65,58,10,12,70,117,110,99,116,105,111,110,32,66,58,10,12,70,117,110,99,116,105,111,110,32,67,58,10,23,67,111,110,116,105,110,117,111,117,115,32,118,105,100,101,111,32,102,101,101,100,63,10,0,37,10,69,120,112,101,99,116,101,100,32,82,44,32,76,44,32,111,114,32,100,105,115,116,97,110,99,101,32,98,117,116,32,103,111,116,58,32,36,10,69,120,112,101,99,116,101,100,32,99,111,109,109,97,32,111,114,32,110,101,119,108,105,110,101,32,98,117,116,32,103,111,116,58,32,43,10,68,101,102,105,110,105,116,105,111,110,115,32,109,97,121,32,98,101,32,97,116,32,109,111,115,116,32,50,48,32,99,104,97,114,97,99,116,101,114,115,33,10,94,62,118,60,0,1,0,-1,-1,0,1,0,0,0,0,0,0,1,2,0,0,109,4,1201,-3,0,587,20102,1,0,-1,22101,1,-3,-3,21102,1,0,-2,2208,-2,-1,570,1005,570,617,2201,-3,-2,609,4,0,21201,-2,1,-2,1106,0,597,109,-4,2105,1,0,109,5,1201,-4,0,629,21002,0,1,-2,22101,1,-4,-4,21102,0,1,-3,2208,-3,-2,570,1005,570,781,2201,-4,-3,652,21001,0,0,-1,1208,-1,-4,570,1005,570,709,1208,-1,-5,570,1005,570,734,1207,-1,0,570,1005,570,759,1206,-1,774,1001,578,562,684,1,0,576,576,1001,578,566,692,1,0,577,577,21101,702,0,0,1106,0,786,21201,-1,-1,-1,1105,1,676,1001,578,1,578,1008,578,4,570,1006,570,724,1001,578,-4,578,21101,731,0,0,1106,0,786,1105,1,774,1001,578,-1,578,1008,578,-1,570,1006,570,749,1001,578,4,578,21101,0,756,0,1106,0,786,1105,1,774,21202,-1,-11,1,22101,1182,1,1,21101,774,0,0,1106,0,622,21201,-3,1,-3,1105,1,640,109,-5,2106,0,0,109,7,1005,575,802,20102,1,576,-6,20101,0,577,-5,1105,1,814,21101,0,0,-1,21101,0,0,-5,21101,0,0,-6,20208,-6,576,-2,208,-5,577,570,22002,570,-2,-2,21202,-5,35,-3,22201,-6,-3,-3,22101,1477,-3,-3,1202,-3,1,843,1005,0,863,21202,-2,42,-4,22101,46,-4,-4,1206,-2,924,21102,1,1,-1,1105,1,924,1205,-2,873,21102,35,1,-4,1105,1,924,2102,1,-3,878,1008,0,1,570,1006,570,916,1001,374,1,374,1201,-3,0,895,1101,2,0,0,1201,-3,0,902,1001,438,0,438,2202,-6,-5,570,1,570,374,570,1,570,438,438,1001,578,558,921,21001,0,0,-4,1006,575,959,204,-4,22101,1,-6,-6,1208,-6,35,570,1006,570,814,104,10,22101,1,-5,-5,1208,-5,61,570,1006,570,810,104,10,1206,-1,974,99,1206,-1,974,1101,0,1,575,21101,973,0,0,1105,1,786,99,109,-7,2105,1,0,109,6,21102,0,1,-4,21101,0,0,-3,203,-2,22101,1,-3,-3,21208,-2,82,-1,1205,-1,1030,21208,-2,76,-1,1205,-1,1037,21207,-2,48,-1,1205,-1,1124,22107,57,-2,-1,1205,-1,1124,21201,-2,-48,-2,1105,1,1041,21102,1,-4,-2,1105,1,1041,21102,-5,1,-2,21201,-4,1,-4,21207,-4,11,-1,1206,-1,1138,2201,-5,-4,1059,1202,-2,1,0,203,-2,22101,1,-3,-3,21207,-2,48,-1,1205,-1,1107,22107,57,-2,-1,1205,-1,1107,21201,-2,-48,-2,2201,-5,-4,1090,20102,10,0,-1,22201,-2,-1,-2,2201,-5,-4,1103,2101,0,-2,0,1106,0,1060,21208,-2,10,-1,1205,-1,1162,21208,-2,44,-1,1206,-1,1131,1106,0,989,21101,0,439,1,1105,1,1150,21102,477,1,1,1105,1,1150,21101,0,514,1,21102,1,1149,0,1105,1,579,99,21102,1157,1,0,1105,1,579,204,-2,104,10,99,21207,-3,22,-1,1206,-1,1138,2101,0,-5,1176,2102,1,-4,0,109,-6,2106,0,0,2,7,34,1,34,1,34,1,34,1,34,1,26,9,26,1,34,1,34,1,34,1,34,1,34,1,34,1,34,1,34,1,34,5,34,1,34,1,34,1,34,1,34,1,34,11,34,1,34,1,11,9,14,1,11,1,22,1,11,1,22,1,11,1,22,1,11,1,22,1,11,1,16,7,11,1,16,1,17,1,16,1,17,1,16,1,17,1,8,7,1,1,11,7,8,1,5,1,1,1,11,1,14,1,5,1,1,1,11,1,14,1,5,1,1,1,11,1,14,1,5,1,1,1,3,5,3,1,14,1,5,1,1,1,3,1,3,1,3,1,14,9,3,1,3,1,3,1,20,1,5,1,3,1,3,1,20,11,3,1,26,1,7,1,18,5,3,1,1,7,18,1,3,1,3,1,1,1,24,1,3,1,3,1,1,1,24,1,3,1,3,1,1,1,24,13,26,1,3,1,1,1,1,1,24,7,1,1,1,1,24,1,1,1,5,1,1,1,24,1,1,1,1,11,20,1,1,1,1,1,3,1,1,1,3,1,14,9,1,1,3,1,1,11,8,1,5,1,3,1,3,1,5,1,5,1,8,1,5,1,3,5,5,1,5,1,8,1,5,1,13,1,5,1,8,1,5,1,13,1,5,1,8,1,5,1,13,1,5,1,8,7,13,7,8
"""
}
