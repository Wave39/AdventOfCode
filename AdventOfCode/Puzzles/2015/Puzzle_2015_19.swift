//
//  Puzzle_2015_19.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/29/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2015_19: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        let replacementLineArray = PuzzleInput.final.parseIntoStringArray()
        let targetMolecule = PuzzleInput.targetMolecule

        struct Molecule {
            var moleculeString: String = ""
            var generation: Int = 0
        }

        var replacementArray: [(searchFor: String, replaceWith: String)] = []
        for replacementLine in replacementLineArray {
            let components = replacementLine.split { $0 == " " }.map(String.init)
            replacementArray.append((components[0], components[2]))
        }

        var moleculeDict = [String: Int]()
        for replacement in replacementArray {
            let ranges = targetMolecule.rangesOfString(searchString: replacement.searchFor)
            for r in ranges {
                let newMolecule = targetMolecule.replacingCharacters(in: r, with: replacement.replaceWith)
                if moleculeDict.keys.contains(newMolecule), let moleculeCount = moleculeDict[newMolecule] {
                    moleculeDict[newMolecule] = moleculeCount + 1
                } else {
                    moleculeDict[newMolecule] = 1
                }
            }
        }

        let part1 = moleculeDict.keys.count

        var foundAtGeneration: Int = 0

        let moleculeTrimCount = 5

        func getReverseReplacements(originalMolecule: Molecule, trim: Bool) -> [Molecule] {
            var moleculeSet: Set<String> = Set()
            for replacement in replacementArray {
                let nsString = originalMolecule.moleculeString as NSString
                var r = nsString.range(of: replacement.replaceWith)
                let c = nsString.length

                while r.length > 0 {
                    let x = r.location + r.length
                    moleculeSet.insert(nsString.replacingCharacters(in: r, with: replacement.searchFor))
                    r = nsString.range(of: replacement.replaceWith, options: .literal, range: NSMakeRange(x, c - x))
                }
            }

            var moleculeArray: [Molecule] = []
            for m in moleculeSet {
                var newMolecule = Molecule()
                newMolecule.moleculeString = m
                newMolecule.generation = originalMolecule.generation + 1
                moleculeArray.append(newMolecule)
            }

            if trim {
                moleculeArray.sort { $0.moleculeString.count < $1.moleculeString.count }
                if moleculeArray.count > moleculeTrimCount {
                    let slice = moleculeArray[0..<moleculeTrimCount]
                    moleculeArray = Array(slice)
                }
            }

            return moleculeArray
        }

        func getNextGenerationOfReverseReplacements(originalMoleculeArray: [Molecule]) -> [Molecule] {
            var moleculeArray: [Molecule] = []
            for molecule in originalMoleculeArray {
                let reverseMolecules = getReverseReplacements(originalMolecule: molecule, trim: true)
                moleculeArray.append(contentsOf: reverseMolecules)
            }

            moleculeArray.sort { $0.moleculeString.count < $1.moleculeString.count }
            if moleculeArray.count > moleculeTrimCount {
                let slice = moleculeArray[0..<moleculeTrimCount]
                moleculeArray = Array(slice)
            }

            return moleculeArray
        }

        var part2Molecule = Molecule()
        part2Molecule.moleculeString = targetMolecule
        part2Molecule.generation = 1
        var molecules = getReverseReplacements(originalMolecule: part2Molecule, trim: false)
        while foundAtGeneration == 0 {
            molecules = getNextGenerationOfReverseReplacements(originalMoleculeArray: molecules)
            for m in molecules {
                if m.moleculeString == "e" {
                    foundAtGeneration = m.generation - 1
                    break
                }
            }
        }

        let part2 = foundAtGeneration

        return (part1, part2)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
Al => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg
"""

    static let targetMolecule = "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr"
}
