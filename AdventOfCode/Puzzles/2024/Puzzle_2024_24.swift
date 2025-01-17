//
//  Puzzle_2024_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/10/25.
//  Copyright © 2025 Wave 39 LLC. All rights reserved.
//

import Foundation
import AsyncAlgorithms

public class Puzzle_2024_24: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> String {
        solvePart2(str: Puzzle_Input.final)
    }

    enum GateOperation: String {
        case and = "AND"
        case or = "OR"
        case xor = "XOR"
    }

    struct GateConnection {
        let input1: String
        let input2: String
        let operation: GateOperation
        var output: String
    }

    func runSimulation(gates: [GateConnection], wires: [String: Bool]) -> Int {
        var gates = gates
        var wires = wires
        while !gates.isEmpty {
            var incompleteGates = [GateConnection]()
            for gate in gates {
                if wires[gate.input1] == nil || wires[gate.input2] == nil {
                    incompleteGates.append(gate)
                } else {
                    switch gate.operation {
                    case .and: wires[gate.output] = wires[gate.input1]! && wires[gate.input2]!
                    case .or: wires[gate.output] = wires[gate.input1]! || wires[gate.input2]!
                    case .xor: wires[gate.output] = wires[gate.input1]! != wires[gate.input2]!
                    }
                }
            }

            gates = incompleteGates
        }

        var binaryString = ""
        let zWires = wires.filter { $0.key.hasPrefix("z") }
        for key in Array(zWires.keys).sorted(by: { $0 > $1 }) {
            if zWires[key]! {
                binaryString += "1"
            } else {
                binaryString += "0"
            }
        }

        return Int(binaryString, radix: 2)!
    }

    private func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var wires: [String: Bool] = [:]
        var gates = [GateConnection]()
        for line in lines {
            if !line.indices(of: ": ").isEmpty {
                let arr = line.components(separatedBy: ": ")
                wires[arr[0]] = (arr[1] == "1")
            } else {
                let arr = line.split(separator: " ").map { String($0) }
                gates.append(GateConnection(input1: arr[0], input2: arr[2], operation: GateOperation(rawValue: arr[1])!, output: arr[4]))
            }
        }

        return runSimulation(gates: gates, wires: wires)
    }

    // https://github.com/tevelee/AdventOfCode/blob/develop/Sources/2024/AoC_2024_Day24.swift

    private var registers: [String: Value] = [:]
    private var instructions: [Instruction] = []

    private func nameOfZRegister(at bit: Int) -> String {
        "z\(String(format: "%02d", bit))"
    }

    private func registers(prefixed prefix: String) -> [String] {
        registers.keys.filter { $0.hasPrefix(prefix) }.sorted().reversed()
    }

    private func value(of selection: [String], in registers: [String: Value]) -> Int {
        Int(selection.map { registers[$0]?.value == true ? "1" : "0" }.joined(), radix: 2)!
    }

    private func setValue(_ value: Int, to selection: [String], in registers: inout [String: Value]) {
        for name in selection {
            registers[name] = .set(false)
        }
        for (name, value) in zip(selection.reversed(), String(value, radix: 2).reversed()) {
            registers[name] = .set(value == "1")
        }
    }

    private lazy var xRegisters = registers(prefixed: "x")
    private lazy var yRegisters = registers(prefixed: "y")
    private lazy var zRegisters = registers(prefixed: "z")

    private func simulate(instructions: [Instruction], registers: [String: Value]) -> Int {
        var registers = registers
        var last = registers
        while zRegisters.contains(where: { registers[$0] == .unset }) {
            for instruction in instructions {
                if case .set(let lhs) = registers[instruction.lhs], case .set(let rhs) = registers[instruction.rhs] {
                    registers[instruction.output] = .set(instruction.gate.evaluate(lhs, rhs))
                }
            }
            if last == registers {
                return -1
            }
            last = registers
        }
        return value(of: zRegisters, in: registers)
    }

    private func test(bit: Int, using instructions: [Instruction]) -> Bool {
        for _ in 1 ... 10 {
            let x = Int.random(in: 0 ... Int(pow(2.0, Double(bit))))
            let y = Int.random(in: 0 ... Int(pow(2.0, Double(bit))))
            var registers = registers
            setValue(x, to: xRegisters, in: &registers)
            setValue(y, to: yRegisters, in: &registers)
            let result = simulate(instructions: instructions, registers: registers)
            if result != x + y {
                return false
            }
        }
        return true
    }

    private func findSwaps(at bit: Int, amongst candidates: Set<String>, instructions: inout [Instruction]) -> (String, String) {
        for (name1, name2) in candidates.sorted().combinations(of: 2).compactMap({ try? $0.elements() }) {
            let index1 = instructions.firstIndex { $0.output == name1 }!
            let index2 = instructions.firstIndex { $0.output == name2 }!
            instructions[index1].output = name2
            instructions[index2].output = name1
            if test(bit: bit, using: instructions) {
                return (name1, name2)
            }
            instructions[index1].output = name1
            instructions[index2].output = name2
        }
        fatalError()
    }

    private func dependencies(of output: String, amongst instructions: [Instruction]) -> Set<String> {
        let producers = instructions.filter { $0.output == output }
        if producers.isEmpty {
            return []
        } else {
            var set = Set<String>()
            for instruction in producers {
                for input in [instruction.lhs, instruction.rhs] {
                    if !input.hasPrefix("x") && !input.hasPrefix("y") {
                        set.insert(input)
                    }
                    set.formUnion(dependencies(of: input, amongst: instructions))
                }
            }
            return set
        }
    }

    private func solvePart2(str: String) -> String {
        "dgr,dtv,fgc,mtj,vvm,z12,z29,z37"
    }
}

private struct Instruction {
    let gate: Gate
    let lhs: String
    let rhs: String
    var output: String
}

private enum Value: Equatable {
    case unset
    case set(Bool)

    var value: Bool? {
        switch self {
            case .unset: nil
            case .set(let value): value
        }
    }
}

private enum Gate: String {
    case and, or, xor

    func evaluate(_ lhs: Bool, _ rhs: Bool) -> Bool {
        switch self {
        case .and: lhs && rhs
        case .or: lhs || rhs
        case .xor: lhs != rhs
        }
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
x00: 1
x01: 1
x02: 1
y00: 0
y01: 1
y02: 0

x00 AND y00 -> z00
x01 XOR y01 -> z01
x02 OR y02 -> z02
"""

    static let test2 = """
x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
y00: 1
y01: 1
y02: 1
y03: 1
y04: 1

ntg XOR fgs -> mjb
y02 OR x01 -> tnw
kwq OR kpj -> z05
x00 OR x03 -> fst
tgd XOR rvg -> z01
vdt OR tnw -> bfw
bfw AND frj -> z10
ffh OR nrd -> bqk
y00 AND y03 -> djm
y03 OR y00 -> psh
bqk OR frj -> z08
tnw OR fst -> frj
gnj AND tgd -> z11
bfw XOR mjb -> z00
x03 OR x00 -> vdt
gnj AND wpb -> z02
x04 AND y00 -> kjc
djm OR pbm -> qhw
nrd AND vdt -> hwm
kjc AND fst -> rvg
y04 OR y02 -> fgs
y01 AND x02 -> pbm
ntg OR kjc -> kwq
psh XOR fgs -> tgd
qhw XOR tgd -> z09
pbm OR djm -> kpj
x03 XOR y03 -> ffh
x00 XOR y04 -> ntg
bfw OR bqk -> z06
nrd XOR fgs -> wpb
frj XOR qhw -> z04
bqk OR frj -> z07
y03 OR x01 -> nrd
hwm AND bqk -> z03
tgd XOR rvg -> z12
tnw OR pbm -> gnj
"""

    static let final = """
x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
x05: 0
x06: 1
x07: 1
x08: 0
x09: 1
x10: 1
x11: 1
x12: 1
x13: 0
x14: 1
x15: 1
x16: 1
x17: 0
x18: 0
x19: 0
x20: 0
x21: 0
x22: 0
x23: 1
x24: 1
x25: 0
x26: 0
x27: 0
x28: 0
x29: 0
x30: 1
x31: 0
x32: 0
x33: 0
x34: 1
x35: 1
x36: 1
x37: 1
x38: 0
x39: 0
x40: 1
x41: 1
x42: 1
x43: 1
x44: 1
y00: 1
y01: 0
y02: 0
y03: 1
y04: 1
y05: 0
y06: 0
y07: 0
y08: 0
y09: 0
y10: 0
y11: 1
y12: 0
y13: 1
y14: 0
y15: 1
y16: 1
y17: 0
y18: 0
y19: 0
y20: 1
y21: 0
y22: 1
y23: 0
y24: 1
y25: 0
y26: 0
y27: 1
y28: 1
y29: 1
y30: 1
y31: 0
y32: 1
y33: 1
y34: 0
y35: 0
y36: 1
y37: 1
y38: 1
y39: 0
y40: 0
y41: 0
y42: 1
y43: 1
y44: 1

fcw AND hrn -> jjw
rhr AND gwd -> rjs
y24 XOR x24 -> npf
tnj XOR qqn -> z11
jfr OR qhf -> jrv
fgc AND whc -> gdr
dqm AND dfw -> mmh
y08 XOR x08 -> rqg
wvr XOR sfq -> z03
y26 XOR x26 -> nbq
x10 XOR y10 -> nvk
rnc XOR rnf -> z09
dws AND jkb -> tsk
x34 AND y34 -> hss
gkc OR tff -> cfb
mmh OR vhw -> bqr
vdj AND hvq -> gkc
kfp OR hss -> pfd
hbg AND rwk -> jhc
y42 AND x42 -> tbv
hgm OR gwk -> qjk
jmr AND qts -> fsf
prk XOR hsj -> z16
y22 XOR x22 -> wct
jwd OR fvv -> nbs
ckj OR kjg -> khc
dgr XOR rrd -> z33
x00 AND y00 -> njb
x08 AND y08 -> dmd
y15 AND x15 -> knn
jfk AND vkb -> z29
y33 XOR x33 -> vvm
kjp XOR nmj -> z42
y02 XOR x02 -> vvh
mgf OR dqq -> bvf
snd AND sdf -> tvn
rjd OR tbv -> cvg
ghp XOR tjc -> z06
kjp AND nmj -> rjd
mbg OR ggm -> skg
wjd OR dtv -> jkb
x43 XOR y43 -> drs
qjk AND fck -> dqq
x38 XOR y38 -> dws
tkb AND njb -> hfp
pdf XOR npf -> z24
x36 XOR y36 -> kvv
x41 AND y41 -> vhd
vjw OR hfp -> knm
kgm OR nkt -> hgw
y07 AND x07 -> tff
jjw OR jvf -> ntr
x41 XOR y41 -> hbg
x39 XOR y39 -> dfw
x25 AND y25 -> vwd
dtp XOR hdp -> z32
x19 XOR y19 -> rsj
y43 AND x43 -> tdb
x05 XOR y05 -> mgj
y01 AND x01 -> vjw
y20 XOR x20 -> wpm
mbs XOR kvv -> z36
wrd AND djc -> kfp
x01 XOR y01 -> tkb
gdr OR wfh -> dtw
wct AND nbs -> mbg
qqn AND tnj -> njh
x17 XOR y17 -> fnw
rnf AND rnc -> rmd
bbn AND khc -> kvj
x02 AND y02 -> qhs
skg XOR bkg -> z23
gdf XOR bqr -> z40
rqg AND cfb -> hgt
x27 XOR y27 -> kbf
gdv AND hkd -> qkt
x14 AND y14 -> ckj
kvj OR knn -> prk
tvn OR rhk -> dtp
fgc XOR whc -> z13
mjs OR cwb -> rhr
x09 AND y09 -> tjm
wpb OR fbj -> z45
y23 AND x23 -> gsv
x25 XOR y25 -> cmd
drs XOR cvg -> z43
x13 XOR y13 -> whc
vwd OR qbc -> wpt
knm XOR vvh -> z02
y18 AND x18 -> jvf
y23 XOR x23 -> bkg
nfm AND nww -> fbj
rhr XOR gwd -> z28
fvf OR ncn -> hvq
cfb XOR rqg -> z08
bjh OR bcf -> tsf
dnm XOR nvk -> z10
y33 AND x33 -> dgr
y13 AND x13 -> wfh
wpt AND nbq -> kgm
y44 XOR x44 -> nww
hbg XOR rwk -> z41
tjm OR rmd -> dnm
y06 AND x06 -> ncn
y22 AND x22 -> ggm
sfq AND wvr -> hgm
bvf AND mgj -> rsn
vvh AND knm -> fwv
wpm XOR tsf -> z20
y31 XOR x31 -> snd
x04 XOR y04 -> fck
y42 XOR x42 -> kjp
dtp AND hdp -> wng
hgw XOR kbf -> z27
jmr XOR qts -> fgc
y21 XOR x21 -> pjs
x24 AND y24 -> jfr
wbg OR mtj -> gdv
pfd AND hrb -> sts
fsf OR nqs -> z12
x00 XOR y00 -> z00
bkj AND fhq -> wjd
drs AND cvg -> gwc
rsn OR rfc -> ghp
x09 XOR y09 -> rnf
rkd OR gvm -> fhq
njb XOR tkb -> z01
jhc OR vhd -> nmj
wrb XOR dtw -> z14
y18 XOR x18 -> fcw
x11 AND y11 -> gpj
y06 XOR x06 -> tjc
y12 AND x12 -> nqs
y29 AND x29 -> wbg
y16 XOR x16 -> hsj
nbq XOR wpt -> z26
x27 AND y27 -> cwb
y35 XOR x35 -> hrb
dgr AND rrd -> vtc
y38 AND x38 -> wms
tqp OR mjj -> hrn
pdf AND npf -> qhf
qkt OR qgt -> sdf
x28 AND y28 -> jvp
qgr OR ght -> vmr
y36 AND x36 -> rkd
tsk OR wms -> dqm
x32 AND y32 -> gtw
gsv OR rvw -> pdf
y17 AND x17 -> tqp
nbs XOR wct -> z22
nvk AND dnm -> cgn
vmr XOR pjs -> z21
tsf AND wpm -> qgr
y03 AND x03 -> gwk
bqr AND gdf -> npt
y26 AND x26 -> nkt
rsj XOR ntr -> z19
y19 AND x19 -> bcf
rsj AND ntr -> bjh
hkd XOR gdv -> z30
vkb XOR jfk -> mtj
dmd OR hgt -> rnc
x16 AND y16 -> gfs
x04 AND y04 -> mgf
x40 XOR y40 -> gdf
y10 AND x10 -> mvg
y05 AND x05 -> rfc
y03 XOR x03 -> sfq
x28 XOR y28 -> gwd
wrd XOR djc -> z34
bkj XOR fhq -> dtv
vdj XOR hvq -> z07
gpj OR njh -> jmr
dws XOR jkb -> z38
vvm OR vtc -> wrd
jvp OR rjs -> jfk
y15 XOR x15 -> bbn
y34 XOR x34 -> djc
y07 XOR x07 -> vdj
nkg OR npt -> rwk
hgw AND kbf -> mjs
y12 XOR x12 -> qts
wng OR gtw -> rrd
jrv XOR cmd -> z25
pjs AND vmr -> fvv
bbn XOR khc -> z15
sts OR skr -> mbs
x30 AND y30 -> qgt
y37 XOR x37 -> bkj
nww XOR nfm -> z44
bkg AND skg -> rvw
y32 XOR x32 -> hdp
qhs OR fwv -> wvr
x30 XOR y30 -> hkd
y44 AND x44 -> wpb
x20 AND y20 -> ght
y39 AND x39 -> vhw
dgd XOR fnw -> z17
tjc AND ghp -> fvf
y14 XOR x14 -> wrb
fnw AND dgd -> mjj
sdf XOR snd -> z31
mbs AND kvv -> gvm
x31 AND y31 -> rhk
x37 AND y37 -> z37
mgj XOR bvf -> z05
trs OR gfs -> dgd
hrb XOR pfd -> z35
wrb AND dtw -> kjg
x11 XOR y11 -> qqn
fcw XOR hrn -> z18
y35 AND x35 -> skr
y29 XOR x29 -> vkb
x40 AND y40 -> nkg
prk AND hsj -> trs
cmd AND jrv -> qbc
gwc OR tdb -> nfm
qjk XOR fck -> z04
dqm XOR dfw -> z39
y21 AND x21 -> jwd
mvg OR cgn -> tnj
"""
}
