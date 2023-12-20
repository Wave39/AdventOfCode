//
//  Puzzle_2023_20.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2023_20: PuzzleBaseClass {
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

    enum ModuleType {
        case broadcaster
        case flipFlop
        case conjunction
    }

    enum PulseType {
        case low
        case high
    }

    struct PulseInfo {
        var type: PulseType
        var source: String
        var destination: String

        var description: String {
            return "\(source) \(type) -> \(destination)"
        }
    }

    struct BroadcastModuleInfo: Hashable {
        var type: ModuleType
        var destinations: [String]
        var currentState: PulseType = .low
        var memory: [String: PulseType] = [:]
    }

    private func solvePart1(str: String) -> Int {
        var modules = [String : BroadcastModuleInfo]()
        let arr = str.parseIntoStringArray()
        for line in arr {
            let components = line.capturedGroups(withRegex: "(.*) -> (.*)")
            let destinations = components[1].parseIntoStringArray(separator: ",").map { $0.trim() }
            let c = components[0].first!
            if c == "%" {
                modules[components[0].substring(from: 1)] = BroadcastModuleInfo(type: .flipFlop, destinations: destinations)
            } else if c == "&" {
                modules[components[0].substring(from: 1)] = BroadcastModuleInfo(type: .conjunction, destinations: destinations)
            } else {
                modules[components[0]] = BroadcastModuleInfo(type: .broadcaster, destinations: destinations)
            }
        }

        for key in modules.keys {
            if modules[key]!.type == .conjunction {
                for innerKey in modules.keys {
                    if modules[innerKey]!.destinations.contains(key) {
                        modules[key]!.memory[innerKey] = .low
                    }
                }
            }
        }

        var pulses = [PulseInfo]()
        var lowPulses = 0
        var highPulses = 0
        for _ in 1...1000 {
            pulses.append(PulseInfo(type: .low, source: "button", destination: "broadcaster"))
            while pulses.count > 0 {
                let currentPulse = pulses[0]
                if currentPulse.type == .low {
                    lowPulses += 1
                } else {
                    highPulses += 1
                }

                if let currentModule = modules[currentPulse.destination] {
                    if currentModule.type == .broadcaster {
                        for destination in currentModule.destinations {
                            pulses.append(PulseInfo(type: .low, source: currentPulse.destination, destination: destination))
                        }
                    } else if currentModule.type == .flipFlop {
                        if currentPulse.type == .low {
                            var newState = PulseType.low
                            if currentModule.currentState == .low {
                                newState = .high
                            }

                            modules[currentPulse.destination]!.currentState = newState
                            for destination in currentModule.destinations {
                                pulses.append(PulseInfo(type: newState, source: currentPulse.destination, destination: destination))
                            }
                        }
                    } else {
                        modules[currentPulse.destination]!.memory[currentPulse.source] = currentPulse.type
                        let memoryCount = modules[currentPulse.destination]!.memory.values.count
                        let highCount = modules[currentPulse.destination]!.memory.values.filter { $0 == .high }.count
                        let outputType = memoryCount == highCount ? PulseType.low : PulseType.high
                        for destination in currentModule.destinations {
                            pulses.append(PulseInfo(type: outputType, source: currentPulse.destination, destination: destination))
                        }
                    }
                }

                pulses.removeFirst()
            }
        }

        return lowPulses * highPulses
    }

    // https://github.com/gereons/AoC2023/blob/main/Sources/Day20/Day20.swift

    private func solvePart2(str: String) -> Int {
        enum Pulse {
            case high, low
        }

        struct Message: CustomStringConvertible {
            let pulse: Pulse
            let from: String
            let destination: String

            var description: String {
                "\(from) -\(pulse)-> \(destination)"
            }
        }

        class CommunicationsModule {
            let name: String
            let destinations: [String]

            init(name: String, destinations: [String]) {
                self.name = name
                self.destinations = destinations
            }

            func receive(_ pulse: Pulse, from name: String) -> [Message] { [] }

            func reset() {}

            static func make(from string: String) -> CommunicationsModule {
                let parts = string.components(separatedBy: " -> ")
                let prefix = parts[0].prefix(1)
                let name = String(parts[0].dropFirst(["%", "&"].contains(prefix) ? 1 : 0))
                let destinations = parts[1].components(separatedBy: ", ")

                switch prefix {
                case "%": return Flipflop(name: name, destinations: destinations)
                case "&": return Conjunction(name: name, destinations: destinations)
                default: return Broadcaster(name: name, destinations: destinations)
                }
            }
        }

        final class Flipflop: CommunicationsModule {
            private var state: Bool = false

            override func reset() {
                state = false
            }

            override func receive(_ pulse: Pulse, from name: String) -> [Message] {
                if pulse == .high {
                    return []
                }

                state.toggle()
                let pulse: Pulse = state ? .high : .low
                return destinations.map {
                    Message(pulse: pulse, from: self.name, destination: $0)
                }
            }
        }

        final class Conjunction: CommunicationsModule {
            private var inputs = [String: Pulse]()
            private(set) var triggered = false

            func addInput(_ name: String) {
                inputs[name] = .low
            }

            override func reset() {
                triggered = false
                inputs.keys.forEach {
                    inputs[$0] = .low
                }
            }

            override func receive(_ pulse: Pulse, from name: String) -> [Message] {
                inputs[name] = pulse
                var send = Pulse.high
                if inputs.values.allSatisfy({ $0 == .high }) {
                    send = .low
                }
                if !triggered {
                    triggered = send == .high
                }
                return destinations.map {
                    Message(pulse: send, from: self.name, destination: $0)
                }
            }
        }

        final class Broadcaster: CommunicationsModule {
            override func receive(_ pulse: Pulse, from name: String) -> [Message] {
                destinations.map { Message(pulse: pulse, from: self.name, destination: $0) }
            }
        }

        class Output: CommunicationsModule {
        }

        let lines = str.parseIntoStringArray()
        let rawModules = lines.map { CommunicationsModule.make(from: $0) }

        let conjunctions = rawModules.compactMap { $0 as? Conjunction }
        for con in conjunctions {
            for module in rawModules {
                if module.destinations.contains(con.name) {
                    con.addInput(module.name)
                }
            }
        }

        var modules = rawModules.mapped(by: \.name)
        for module in rawModules {
            for dest in module.destinations {
                if modules[dest] == nil {
                    modules[dest] = Output(name: dest, destinations: [])
                }
            }
        }

        modules.values.forEach { $0.reset() }

        // find the input to rx
        let rxSender = modules.values.first { $0.destinations == ["rx" ] }!

        // find its input conjunctions so we can monitor them
        let inputs = modules.values.filter { $0.destinations.contains(rxSender.name) }.compactMap { $0 as? Conjunction }
        var counts = [String: Int]()

        let broadcaster = modules["broadcaster"]!

    loop:
        for presses in 1 ..< Int.max {
            var messages = broadcaster.receive(.low, from: "btn")

            while !messages.isEmpty {
                var next = [Message]()
                for msg in messages {
                    let msgs = modules[msg.destination]!.receive(msg.pulse, from: msg.from)
                    next.append(contentsOf: msgs)
                    for input in inputs {
                        if input.triggered && counts[input.name] == nil {
                            counts[input.name] = presses
                        }
                    }
                    if counts.count == inputs.count {
                        break loop
                    }
                }
                messages = next
            }
        }

        return counts.values.reduce(1, *)
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
"""

    static let test2 = """
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output
"""

    static let final = """
%fl -> tf, gz
%xb -> hl, tl
%mq -> tf, fl
%px -> hl, tm
%dp -> xv
broadcaster -> js, ng, lb, gr
&ql -> rx
%gk -> hm
%vp -> vf, sn
%fp -> xb
&lr -> ss, rm, dc, js, gk, dp, bq
%xl -> gx, lr
%xx -> hb
%cb -> jg
&hl -> nj, lb, tl, xx, hb, fp, mf
%vr -> tf, hq
%bq -> gk
%jg -> qn
%hb -> qk
%qk -> hs, hl
%gz -> tf
%rm -> hj
&tf -> cb, jg, fz, gr, zj, qn, kb
%qn -> td
%js -> lr, dc
%qb -> nc
%zj -> vr
%td -> tf, zj
%tl -> kg
%gx -> lr
%hm -> lr, rd
&fh -> ql
%nj -> xx
%hq -> kb, tf
%kg -> px, hl
%dc -> dp
%vf -> th, sn
&mf -> ql
%tm -> hl
&fz -> ql
%xd -> tn, sn
%ng -> vp, sn
%th -> qb
%rd -> xl, lr
%bt -> xd, sn
%tv -> sn
%nl -> bt
%hs -> fp, hl
%xv -> rm, lr
%tn -> sn, tv
%hj -> lr, bq
&ss -> ql
%sd -> nl
&sn -> sd, fh, th, qb, nl, ng, nc
%kb -> mq
%lb -> nj, hl
%gr -> tf, cb
%nc -> sd
"""
}
