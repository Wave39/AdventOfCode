//
//  Puzzle_2016_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/12/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

enum ElementType: Int {
    case Cobalt = 1
    case Curium
    case Dilithium
    case Elerium
    case Hydrogen
    case Lithium
    case Promethium
    case Plutonium
    case Ruthenium
}

let kElementDict: Dictionary<ElementType, String> = [
    .Cobalt: "Co",
    .Curium: "Cm",
    .Dilithium: "Di",
    .Elerium: "El",
    .Hydrogen: "H",
    .Lithium: "L",     // yes, it's not the elemental symbol, but it looks better formatted into the diagram
    .Promethium: "Pm",
    .Plutonium: "Pu",
    .Ruthenium: "Ru"
]

enum DeviceType: Int {
    case Microchip = 1
    case Generator
}

let kDeviceDict: Dictionary<DeviceType, String> = [
    .Microchip: "M",
    .Generator: "G"
]

class Puzzle_2016_11: PuzzleBaseClass {
    enum ElevatorDirection: Int {
        case Up = 1
        case Down
    }

    struct Device {
        var elementType: ElementType
        var deviceType: DeviceType

        func description() -> String {
            "\(kElementDict[self.elementType] ?? "")\(kDeviceDict[self.deviceType] ?? "") "
        }

        static func == (lhs: Device, rhs: Device) -> Bool {
            lhs.elementType == rhs.elementType && lhs.deviceType == rhs.deviceType
        }
    }

    struct BuildingStatus {
        var movesSoFar: Int
        var elevatorFloor: Int
        var floorArray: [[Device]]
        var history: String

        func devicesDescription(devices: [Device]) -> String {
            var s = ""
            let sorted = devices.sorted { [$0.elementType.rawValue, $0.deviceType.rawValue].lexicographicallyPrecedes([$1.elementType.rawValue, $1.deviceType.rawValue]) }

            for d in sorted {
                s += d.description()
            }

            return s
        }

        func diagram(includeMoveCounter: Bool) -> String {
            var s = ""
            for i in (0...3).reversed() {
                s += "\(i + 1) "
                if i == elevatorFloor {
                    s += "E "
                } else {
                    s += "- "
                }

                s += devicesDescription(devices: floorArray[i])
                s += "\n"
            }

            if includeMoveCounter {
                s += "Moves so far: \(movesSoFar)\n"
            }

            return s
        }
    }

    struct Move {
        var elevatorDirection: ElevatorDirection
        var devicesToCarry: [Device]

        func description() -> String {
            var s = (elevatorDirection == .Up ? "Up " : "Down ")
            let sorted = devicesToCarry.sorted { [$0.elementType.rawValue, $0.deviceType.rawValue].lexicographicallyPrecedes([$1.elementType.rawValue, $1.deviceType.rawValue]) }

            for d in sorted {
                s += d.description()
            }

            return s
        }
    }

    struct BuildingState {
        var floorArray: [[Int]]
        var elevatorFloor: Int

        func description() -> String {
            "\(floorArray) \(elevatorFloor)"
        }

        static func getBuildingState(building: BuildingStatus) -> String {
            var buildingState = BuildingState(floorArray: [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]], elevatorFloor: 0)
            for i in 0...3 {
                for j in building.floorArray[i] {
                    if j.deviceType == .Microchip {
                        let d = Device(elementType: j.elementType, deviceType: .Generator)
                        if !building.floorArray[i].contains(where: { $0 == d }) {
                            buildingState.floorArray[i][0] += 1
                        } else {
                            buildingState.floorArray[i][2] += 1
                        }
                    } else {
                        let d = Device(elementType: j.elementType, deviceType: .Microchip)
                        if !building.floorArray[i].contains(where: { $0 == d }) {
                            buildingState.floorArray[i][1] += 1
                        }
                    }
                }
            }

            buildingState.elevatorFloor = building.elevatorFloor

            return buildingState.description()
        }
    }

    // The first floor contains a promethium generator and a promethium-compatible microchip.
    // The second floor contains a cobalt generator, a curium generator, a ruthenium generator, and a plutonium generator.
    // The third floor contains a cobalt-compatible microchip, a curium-compatible microchip, a ruthenium-compatible microchip, and a plutonium-compatible microchip.
    // The fourth floor contains nothing relevant.
    let puzzleInputPart1: [[Device]] = [
        [ Device(elementType: .Promethium, deviceType: .Generator), Device(elementType: .Promethium, deviceType: .Microchip) ],
        [ Device(elementType: .Cobalt, deviceType: .Generator), Device(elementType: .Curium, deviceType: .Generator), Device(elementType: .Ruthenium, deviceType: .Generator), Device(elementType: .Plutonium, deviceType: .Generator) ],
        [ Device(elementType: .Cobalt, deviceType: .Microchip), Device(elementType: .Curium, deviceType: .Microchip), Device(elementType: .Ruthenium, deviceType: .Microchip), Device(elementType: .Plutonium, deviceType: .Microchip) ],
        [ ]
    ]

    // Upon entering the isolated containment area, however, you notice some extra parts on the first floor that weren't listed on the record outside:
    // An elerium generator.
    // An elerium-compatible microchip.
    // A dilithium generator.
    // A dilithium-compatible microchip.

    let puzzleInputPart2: [[Device]] = [
        [ Device(elementType: .Promethium, deviceType: .Generator), Device(elementType: .Promethium, deviceType: .Microchip), Device(elementType: .Elerium, deviceType: .Generator), Device(elementType: .Elerium, deviceType: .Microchip), Device(elementType: .Dilithium, deviceType: .Generator), Device(elementType: .Dilithium, deviceType: .Microchip) ],
        [ Device(elementType: .Cobalt, deviceType: .Generator), Device(elementType: .Curium, deviceType: .Generator), Device(elementType: .Ruthenium, deviceType: .Generator), Device(elementType: .Plutonium, deviceType: .Generator) ],
        [ Device(elementType: .Cobalt, deviceType: .Microchip), Device(elementType: .Curium, deviceType: .Microchip), Device(elementType: .Ruthenium, deviceType: .Microchip), Device(elementType: .Plutonium, deviceType: .Microchip) ],
        [ ]
    ]

    var buildingsAlreadySeen: Set<String> = Set()

    func microchipsAndGeneratorsAreSafe(devices: [Device]) -> Bool {
        let microchips = devices.filter { $0.deviceType == .Microchip }
        let generators = devices.filter { $0.deviceType == .Generator }
        var ok = true
        for microchip in microchips {
            var matchingGenerator = false
            var otherGenerator = false
            for generator in generators {
                if microchip.elementType == generator.elementType {
                    matchingGenerator = true
                } else {
                    otherGenerator = true
                }
            }

            if otherGenerator && !matchingGenerator {
                ok = false
            }
        }

        return ok
    }

    func isMoveValid(building: BuildingStatus, move: Move) -> Bool {
        // check the devices being left on the current floor when the elevator leaves
        var remainingDevices = building.floorArray[building.elevatorFloor]
        for d in move.devicesToCarry {
            if let idx = remainingDevices.firstIndex(where: { $0 == d }) {
                remainingDevices.remove(at: idx)
            }
        }

        if !microchipsAndGeneratorsAreSafe(devices: remainingDevices) {
            return false
        }

        // check the next floor devices
        let nextFloor = building.elevatorFloor + (move.elevatorDirection == .Up ? 1 : -1)
        var nextFloorDevices = building.floorArray[nextFloor]
        nextFloorDevices.append(contentsOf: move.devicesToCarry)
        let ok = microchipsAndGeneratorsAreSafe(devices: nextFloorDevices)

        let nextBuilding = findNextBuilding(building: building, move: move)
        let nextBuildingString = BuildingState.getBuildingState(building: nextBuilding)
        if buildingsAlreadySeen.contains(nextBuildingString) {
            return false
        } else {
            buildingsAlreadySeen.insert(nextBuildingString)
        }

        return ok
    }

    func findValidMoves(building: BuildingStatus) -> [Move] {
        var v = Array<Move>()

        var elevatorDirections: [ElevatorDirection] = []
        if building.elevatorFloor == 0 {
            elevatorDirections.append(.Up)
        } else if building.elevatorFloor == 1 {
            elevatorDirections.append(.Up)
            if !building.floorArray[0].isEmpty {
                elevatorDirections.append(.Down)
            }
        } else if building.elevatorFloor == 2 {
            elevatorDirections.append(.Up)
            if !building.floorArray[0].isEmpty || !building.floorArray[1].isEmpty {
                elevatorDirections.append(.Down)
            }
        } else {
            elevatorDirections.append(.Down)
        }

        // do the one at a time moves first
        let deviceArray = building.floorArray[building.elevatorFloor]
        for device in deviceArray {
            for ed in elevatorDirections {
                let m = Move(elevatorDirection: ed, devicesToCarry: [device])
                if isMoveValid(building: building, move: m) {
                    v.append(m)
                }
            }
        }

        // now consider moving 2 devices at a time
        if deviceArray.count >= 2 {
            for i in 0...deviceArray.count - 2 {
                for j in i + 1...deviceArray.count - 1 {
                    let chipsOK = (deviceArray[i].deviceType == deviceArray[j].deviceType || deviceArray[i].elementType == deviceArray[j].elementType)
                    if chipsOK {
                        for ed in elevatorDirections {
                            let m = Move(elevatorDirection: ed, devicesToCarry: [ deviceArray[i], deviceArray[j] ])
                            if isMoveValid(building: building, move: m) {
                                v.append(m)
                            }
                        }
                    }
                }
            }
        }

        return v
    }

    func findNextBuilding(building: BuildingStatus, move: Move) -> BuildingStatus {
        var nextBuilding = building
        nextBuilding.history += "Move: \(move.description())\n"

        nextBuilding.movesSoFar += 1
        let previousFloor = building.elevatorFloor
        let nextFloor = building.elevatorFloor + (move.elevatorDirection == .Up ? 1 : -1)

        for d in move.devicesToCarry {
            if let idx = nextBuilding.floorArray[previousFloor].firstIndex(where: { $0 == d }) {
                nextBuilding.floorArray[previousFloor].remove(at: idx)
                nextBuilding.floorArray[nextFloor].append(d)
            }
        }

        nextBuilding.elevatorFloor = nextFloor
        nextBuilding.history += nextBuilding.diagram(includeMoveCounter: true)

        return nextBuilding
    }

    func findSolution(initialConfiguration: [[Device]], totalNumberOfDevices: Int) -> Int {
        buildingsAlreadySeen = Set()
        var initialBuilding = BuildingStatus(movesSoFar: 0, elevatorFloor: 0, floorArray: initialConfiguration, history: "")
        initialBuilding.history = initialBuilding.diagram(includeMoveCounter: true)
        var foundSolutionAtMove = 0
        var currentBuildingArray = [ initialBuilding ]
        while foundSolutionAtMove == 0 {
            var nextBuildingArray: [ BuildingStatus ] = []
            for bldg in currentBuildingArray {
                let validMoves = findValidMoves(building: bldg)
                for move in validMoves {
                    let nextBuilding = findNextBuilding(building: bldg, move: move)
                    nextBuildingArray.append(nextBuilding)
                    if nextBuilding.floorArray[3].count == totalNumberOfDevices {
                        foundSolutionAtMove = nextBuilding.movesSoFar
                    }
                }
            }

            currentBuildingArray = nextBuildingArray
        }

        return foundSolutionAtMove
    }

    func solve() {
        let (part1Solution, part2Solution) = solveBothParts()
        print("Part 1 solution: \(part1Solution)")
        print("Part 2 solution: \(part2Solution)")
    }

    func solveBothParts() -> (Int, Int) {
        let part1Solution = findSolution(initialConfiguration: puzzleInputPart1, totalNumberOfDevices: 10)
        let part2Solution = findSolution(initialConfiguration: puzzleInputPart2, totalNumberOfDevices: 14)
        return (part1Solution, part2Solution)
    }
}
