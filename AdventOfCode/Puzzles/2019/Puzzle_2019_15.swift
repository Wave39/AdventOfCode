//
//  Puzzle_2019_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/16/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_15 : PuzzleBaseClass {

    var globalRenderFlag = false
    
    enum TileType: Int {
        case Hallway = 1
        case Wall = 0
        case Oxygen = 2
        case StartingLocation = 3
        case CurrentLocation = 4
        case Unknown = -1
    }
    
    enum MovementDirection: Int {
        case North = 1
        case South = 2
        case East = 4
        case West = 3
        case Unknown = 5
        
        func reverse() -> MovementDirection {
            if self == .North {
                return .South
            } else if self == .South {
                return .North
            } else if self == .West {
                return .East
            } else {
                return .West
            }
        }
    }
    
    struct MoveInformation {
        var location: Point2D = Point2D()
        var direction: MovementDirection = .North
    }
    
    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
       
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func ProcessProgram(program: inout [Int], inputSignal: Int, programCounter: inout Int, relativeBase: inout Int, expandedMemory: inout Dictionary<Int, Int>) -> (Int, Bool) {
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
                
                return expandedMemory[pointer]!
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
            if program[programCounter] / 1000 % 10 == 1 {
                bParameterMode = .immediate
            } else if program[programCounter] / 1000 % 10 == 2 {
                bParameterMode = .relative
            } else {
                bParameterMode = .position
            }
            
            var aParameterMode: ParameterMode
            if program[programCounter] / 10000 % 10 == 1 {
                aParameterMode = .immediate
            } else if program[programCounter] / 10000 % 10 == 2 {
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
                SetParameterValues(1, 1)
                SetMemory(p1, inputSignal)
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                //print (retval)
                programCounter += 2
                return (p1, true)
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
                print ("Unknown opcode \(opcode) at program counter \(programCounter)")
                return (-2, false)
            }
        }
        
        return (-1, false)
    }

    func drawBoard(_ originalTileDict: Dictionary<Point2D, TileType>) {
        if !globalRenderFlag {
            return
        }
        
        var tileDict = originalTileDict
        tileDict[Point2D(x: 0, y: 0)] = .StartingLocation

        let k = tileDict.keys
        let minX = k.map { $0.x }.min()!
        let maxX = k.map { $0.x }.max()!
        let minY = k.map { $0.y }.min()!
        let maxY = k.map { $0.y }.max()!
        print ("")
        
        let w = maxX - minX + 1
        let h = maxY - minY + 1
        var board: [[Character]] = []
        
        for _ in 0..<h {
            var lineArray: [Character] = []
            for _ in 0..<w {
                lineArray.append("⬜️")
            }
            
            board.append(lineArray)
        }
         
        for k in tileDict.keys {
            let x = k.x - minX
            let y = (h - 1) - (k.y - minY)
            let tile = tileDict[k]!
            let c: Character
            if tile == .Wall {
                c = "⬜️"
            } else if tile == .Oxygen {
                c = "🟦"
            } else if tile == .StartingLocation {
                c = "🟥"
            } else if tile == .CurrentLocation {
                c = "🟥"
            } else {
                c = "⬛️"
            }
            
            board[y][x] = c
        }
        
        for line in board {
            print (String(line))
        }
    }
    
    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_15_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_15_Input.puzzleInput)
    }
    
    func solvePart1(str: String) -> Int {
        let tileDict = createMap(str: str, render: false)
        
        var movementDict = tileDict.filter { $0.value == .Hallway || $0.value == .StartingLocation }.map { $0.key }
        let oxygenPoint = tileDict.filter { $0.value == .Oxygen }.first!.key
        
        var pathHeaders: [Point2D] = [ oxygenPoint ]
        var stepCount = 0
        var foundOxygen = false
        
        while !foundOxygen && pathHeaders.count > 0 {
            var nextPathHeaders: [Point2D] = []
            for header in pathHeaders {
                let neighbors = header.adjacentLocations()
                let nextMoves = movementDict.filter { neighbors.contains($0) }
                movementDict = movementDict.filter { $0 != header }
                if nextMoves.count >= 1 {
                    nextPathHeaders.append(contentsOf: nextMoves)
                }
            }
            
            pathHeaders = nextPathHeaders
            stepCount += 1
            if pathHeaders.contains(Point2D(x: 0, y: 0)) {
                foundOxygen = true
            }
        }
        
        return stepCount
    }
    
    func solvePart2(str: String) -> Int {
        let tileDict = createMap(str: str, render: false)
        
        var movementDict = tileDict.filter { $0.value == .Hallway || $0.value == .StartingLocation }.map { $0.key }
        let oxygenPoint = tileDict.filter { $0.value == .Oxygen }.first!.key
        
        var pathHeaders: [Point2D] = [ oxygenPoint ]
        var stepCount = 0
        
        while movementDict.count > 0 {
            var nextPathHeaders: [Point2D] = []
            for header in pathHeaders {
                let neighbors = header.adjacentLocations()
                let nextMoves = movementDict.filter { neighbors.contains($0) }
                movementDict = movementDict.filter { $0 != header }
                if nextMoves.count >= 1 {
                    nextPathHeaders.append(contentsOf: nextMoves)
                }
            }
            
            pathHeaders = nextPathHeaders
            stepCount += 1
        }
        
        return stepCount - 1
    }
    
    func createMap(str: String, render: Bool) -> [ Point2D : TileType ] {
        globalRenderFlag = render
        var arr = str.parseIntoIntArray(separator: ",")
        var programCounter = 0
        var relativeBase = 0
        var expandedMemory: [ Int : Int ] = [:]
        
        let robotPosition = Point2D(x: 0, y: 0)
        var tileDict: [ Point2D : TileType ] = [:]
        tileDict[robotPosition] = .StartingLocation
        var moveSteps: [MoveInformation] = []

        func checkPosition(_ position: Point2D) -> [MovementDirection] {
            var validDirections: [MovementDirection] = []
            var results: TileType

            // north
            let northPoint = Point2D(x: position.x, y: position.y + 1)
            if tileDict[northPoint] == nil {
                let r = ProcessProgram(program: &arr, inputSignal: MovementDirection.North.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                results = TileType(rawValue: r.0)!
                if results == .Wall {
                    tileDict[northPoint] = .Wall
                    drawBoard(tileDict)
                } else {
                    validDirections.append(.North)
                    if results == .Oxygen {
                        tileDict[northPoint] = .Oxygen
                    } else {
                        tileDict[northPoint] = .Hallway
                    }

                    drawBoard(tileDict)
                    let _ = ProcessProgram(program: &arr, inputSignal: MovementDirection.South.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                }
            }

            // east
            let eastPoint = Point2D(x: position.x + 1, y: position.y)
            if tileDict[eastPoint] == nil {
                let r = ProcessProgram(program: &arr, inputSignal: MovementDirection.East.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                results = TileType(rawValue: r.0)!
                if results == .Wall {
                    tileDict[eastPoint] = .Wall
                    drawBoard(tileDict)
                } else {
                    validDirections.append(.East)
                    if results == .Oxygen {
                        tileDict[eastPoint] = .Oxygen
                    } else {
                        tileDict[eastPoint] = .Hallway
                    }

                    drawBoard(tileDict)
                    let _ = ProcessProgram(program: &arr, inputSignal: MovementDirection.West.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                }
            }

            // west
            let westPoint = Point2D(x: position.x - 1, y: position.y)
            if tileDict[westPoint] == nil {
                let r = ProcessProgram(program: &arr, inputSignal: MovementDirection.West.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                results = TileType(rawValue: r.0)!
                if results == .Wall {
                    tileDict[westPoint] = .Wall
                    drawBoard(tileDict)
                } else {
                    validDirections.append(.West)
                    if results == .Oxygen {
                        tileDict[westPoint] = .Oxygen
                    } else {
                        tileDict[westPoint] = .Hallway
                    }

                    drawBoard(tileDict)
                    let _ = ProcessProgram(program: &arr, inputSignal: MovementDirection.East.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                }
            }

            // south
            let southPoint = Point2D(x: position.x, y: position.y - 1)
            if tileDict[southPoint] == nil {
                let r = ProcessProgram(program: &arr, inputSignal: MovementDirection.South.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                results = TileType(rawValue: r.0)!
                if results == .Wall {
                    tileDict[southPoint] = .Wall
                    drawBoard(tileDict)
                } else {
                    validDirections.append(.South)
                    if results == .Oxygen {
                        tileDict[southPoint] = .Oxygen
                    } else {
                        tileDict[southPoint] = .Hallway
                    }

                    drawBoard(tileDict)
                    let _ = ProcessProgram(program: &arr, inputSignal: MovementDirection.North.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
                }
            }

            return validDirections
        }

        func moveToDirection(_ originalPosition: Point2D, _ direction: MovementDirection) {
            var position = originalPosition
            if direction == .North {
                position.y += 1
            } else if direction == .South {
                position.y -= 1
            } else if direction == .East {
                position.x += 1
            } else {
                position.x -= 1
            }

            moveSteps.append(MoveInformation(location: position, direction: direction))

            let _ = ProcessProgram(program: &arr, inputSignal: direction.rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)

            let newDirections = checkPosition(position)
            for dir in newDirections {
                moveToDirection(position, dir)
            }

            // return to the old spot
            if direction == .North {
                position.y -= 1
            } else if direction == .South {
                position.y += 1
            } else if direction == .East {
                position.x -= 1
            } else {
                position.x += 1
            }

            let _ = ProcessProgram(program: &arr, inputSignal: direction.reverse().rawValue, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
        }
        
        let directions = checkPosition(robotPosition)
        for dir in directions {
            moveToDirection(robotPosition, dir)
        }

        drawBoard(tileDict)
        
        return tileDict
    }
                
}

fileprivate class Puzzle_2019_15_Input: NSObject {

    static let puzzleInput = """
3,1033,1008,1033,1,1032,1005,1032,31,1008,1033,2,1032,1005,1032,58,1008,1033,3,1032,1005,1032,81,1008,1033,4,1032,1005,1032,104,99,1001,1034,0,1039,102,1,1036,1041,1001,1035,-1,1040,1008,1038,0,1043,102,-1,1043,1032,1,1037,1032,1042,1105,1,124,1001,1034,0,1039,1001,1036,0,1041,1001,1035,1,1040,1008,1038,0,1043,1,1037,1038,1042,1106,0,124,1001,1034,-1,1039,1008,1036,0,1041,101,0,1035,1040,101,0,1038,1043,1001,1037,0,1042,1105,1,124,1001,1034,1,1039,1008,1036,0,1041,102,1,1035,1040,102,1,1038,1043,102,1,1037,1042,1006,1039,217,1006,1040,217,1008,1039,40,1032,1005,1032,217,1008,1040,40,1032,1005,1032,217,1008,1039,39,1032,1006,1032,165,1008,1040,1,1032,1006,1032,165,1102,1,2,1044,1105,1,224,2,1041,1043,1032,1006,1032,179,1101,1,0,1044,1105,1,224,1,1041,1043,1032,1006,1032,217,1,1042,1043,1032,1001,1032,-1,1032,1002,1032,39,1032,1,1032,1039,1032,101,-1,1032,1032,101,252,1032,211,1007,0,53,1044,1105,1,224,1101,0,0,1044,1105,1,224,1006,1044,247,1002,1039,1,1034,1002,1040,1,1035,1001,1041,0,1036,1002,1043,1,1038,102,1,1042,1037,4,1044,1106,0,0,75,19,3,12,33,54,92,8,21,31,54,5,92,12,60,36,59,17,50,64,6,67,13,45,33,33,6,76,60,41,97,33,8,19,78,23,28,64,22,49,25,77,58,85,19,83,48,69,66,27,18,23,60,25,13,52,71,49,88,74,21,93,89,22,60,89,12,78,8,17,98,68,14,29,57,90,31,57,13,2,48,60,18,17,80,6,96,37,55,99,44,64,67,79,27,61,96,36,97,47,48,82,96,19,19,99,35,78,41,90,21,6,87,86,6,44,49,14,88,79,42,65,73,96,8,3,13,17,80,68,35,21,54,71,49,2,48,4,95,83,24,43,74,24,70,37,47,98,92,47,76,42,39,94,86,1,64,47,83,11,71,21,90,44,58,95,67,28,23,58,58,39,52,82,18,95,83,4,91,22,91,59,32,75,64,51,99,19,79,74,22,65,34,28,77,37,13,67,18,63,16,73,33,72,20,97,41,83,26,64,81,42,75,97,36,59,25,45,75,2,47,88,98,48,52,67,6,72,24,56,96,65,19,37,10,83,91,15,86,25,16,46,45,90,31,76,18,49,82,49,99,91,49,7,33,55,94,23,13,92,27,19,96,65,26,50,90,2,79,19,28,90,5,60,15,84,33,85,9,69,84,77,34,39,54,64,8,6,79,85,17,78,69,99,49,64,8,86,72,10,80,10,97,38,6,42,79,84,12,70,75,12,45,6,9,62,45,90,46,39,67,44,92,56,29,96,94,38,40,66,8,4,27,66,34,40,59,38,99,97,48,45,89,72,62,47,73,51,43,90,10,11,55,69,36,99,86,46,90,20,20,43,1,32,70,20,24,31,63,15,90,74,51,97,60,94,17,30,76,57,7,25,75,9,20,8,75,11,84,10,31,71,46,34,83,7,76,68,74,75,14,63,76,54,26,79,71,67,67,14,93,69,46,32,21,21,91,2,48,84,36,88,2,80,34,75,57,47,74,19,74,47,56,11,29,81,28,23,98,7,57,50,21,88,85,33,46,40,24,17,60,79,80,22,79,72,38,80,92,90,52,88,79,80,43,5,65,47,27,92,94,7,84,97,9,44,68,61,12,60,54,51,6,54,30,64,20,75,68,10,54,52,54,92,1,43,78,41,98,42,83,7,7,77,55,44,14,24,97,15,48,35,63,4,91,54,22,69,26,47,56,35,74,34,82,61,7,68,41,32,72,19,36,70,68,21,44,78,18,40,63,63,34,93,16,87,45,52,99,81,49,77,21,98,12,35,9,62,25,64,59,36,76,82,86,44,37,96,79,38,62,89,14,35,56,3,72,68,81,30,9,44,43,31,37,90,55,29,15,62,65,85,13,76,59,99,9,26,75,82,43,72,3,41,12,92,32,45,84,14,36,54,68,3,91,23,41,6,98,18,58,33,94,30,23,27,23,70,48,25,68,35,57,51,96,28,92,94,8,38,59,48,67,93,4,45,66,91,41,72,61,17,20,83,36,90,51,58,62,90,37,72,26,3,58,66,88,19,77,97,41,82,37,67,35,11,75,15,45,92,38,10,86,17,83,60,48,43,45,72,29,60,74,45,97,96,14,62,13,90,81,51,12,47,91,34,65,60,31,30,92,46,18,64,85,22,77,94,42,32,68,80,94,47,1,81,98,88,31,12,54,20,96,90,31,9,99,50,70,51,83,68,40,99,26,65,19,66,93,68,49,92,36,96,6,66,48,95,57,76,14,85,12,98,32,61,36,71,58,72,15,74,19,90,49,69,7,58,18,57,0,0,21,21,1,10,1,0,0,0,0,0,0
"""

}
