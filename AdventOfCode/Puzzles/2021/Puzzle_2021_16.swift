//
//  Puzzle_2021_16.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/16

import Foundation

public class Puzzle_2021_16: PuzzleBaseClass {
    private var versionTotal = 0

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

    private func processPacket(str: String) -> (Int, Int) {
        let versionString = str[0...2]
        let version = Int(versionString, radix: 2) ?? 0
        versionTotal += version
        let typeIdString = str[3...5]
        let typeId = Int(typeIdString, radix: 2) ?? 0
        var digitsProcessed = 6

        if typeId == 4 {
            var characterIndex = 6
            var leaveLoop = false
            var literalBinaryString = ""
            repeat {
                let chunk = str[characterIndex...(characterIndex + 4)]
                digitsProcessed += 5
                literalBinaryString += chunk[1...]
                if chunk[0] == "0" {
                    leaveLoop = true
                } else {
                    characterIndex += 5
                }
            } while !leaveLoop

            let literalValue = Int(literalBinaryString, radix: 2) ?? 0
            return (digitsProcessed, literalValue)
        } else {
            let lengthTypeIdString = str[6]
            digitsProcessed += 1
            let lengthTypeId = Int(String(lengthTypeIdString), radix: 2) ?? 0
            var literalValues = [Int]()
            if lengthTypeId == 0 {
                let numberOfBitsString = str[7...21]
                digitsProcessed += 15
                var numberOfBits = Int(numberOfBitsString, radix: 2) ?? 0
                digitsProcessed += numberOfBits
                var characterIndex = 22
                while numberOfBits > 0 {
                    let bits = processPacket(str: String(str[characterIndex...]))
                    numberOfBits -= bits.0
                    characterIndex += bits.0
                    literalValues.append(bits.1)
                }
            } else {
                let numberOfSubpacketsString = str[7...17]
                digitsProcessed += 11
                let numberOfSubpackets = Int(numberOfSubpacketsString, radix: 2) ?? 0
                var characterIndex = 18
                var numberOfBits = 0
                for _ in 1...numberOfSubpackets {
                    let bits = processPacket(str: String(str[characterIndex...]))
                    numberOfBits += bits.0
                    characterIndex += bits.0
                    literalValues.append(bits.1)
                }

                digitsProcessed += numberOfBits
            }

            let returnValue: Int
            if typeId == 0 {
                returnValue = literalValues.reduce(0, +)
            } else if typeId == 1 {
                returnValue = literalValues.reduce(1, *)
            } else if typeId == 2 {
                returnValue = literalValues.min() ?? -1
            } else if typeId == 3 {
                returnValue = literalValues.max() ?? -1
            } else if typeId == 5 {
                returnValue = (literalValues[0] > literalValues[1]) ? 1 : 0
            } else if typeId == 6 {
                returnValue = (literalValues[0] < literalValues[1]) ? 1 : 0
            } else if typeId == 7 {
                returnValue = (literalValues[0] == literalValues[1]) ? 1 : 0
            } else {
                returnValue = -1
            }

            return (digitsProcessed, returnValue)
        }
    }

    private func getBinaryString(str: String) -> String {
        var binaryString = ""
        for digit in str {
            let hexValue = Int(String(digit), radix: 16) ?? 0
            binaryString += hexValue.binaryString(padLength: 4)
        }

        return binaryString
    }

    private func solvePart1(str: String) -> Int {
        let binaryString = getBinaryString(str: str)
        versionTotal = 0
        _ = processPacket(str: binaryString)
        return versionTotal
    }

    private func solvePart2(str: String) -> Int {
        let binaryString = getBinaryString(str: str)
        let (_, part2) = processPacket(str: binaryString)
        return part2
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = "D2FE28"
    static let test2 = "38006F45291200"
    static let test3 = "EE00D40C823060"
    static let test4 = "8A004A801A8002F478"
    static let test5 = "620080001611562C8802118E34"
    static let test6 = "C0015000016115A2E0802F182340"
    static let test7 = "A0016C880162017C3686B18A3D4780"
    static let test8 = "C200B40A82"
    static let test9 = "04005AC33890"
    static let test10 = "880086C3E88112"
    static let test11 = "CE00C43D881120"
    static let test12 = "D8005AC2A8F0"
    static let test14 = "F600BC2D8F"
    static let test15 = "9C005AC2F8F0"
    static let test16 = "9C0141080250320F1802104A08"

    static let final = """
220D4B80491FE6FBDCDA61F23F1D9B763004A7C128012F9DA88CE27B000B30F4804D49CD515380352100763DC5E8EC000844338B10B667A1E60094B7BE8D600ACE774DF39DD364979F67A9AC0D1802B2A41401354F6BF1DC0627B15EC5CCC01694F5BABFC00964E93C95CF080263F0046741A740A76B704300824926693274BE7CC880267D00464852484A5F74520005D65A1EAD2334A700BA4EA41256E4BBBD8DC0999FC3A97286C20164B4FF14A93FD2947494E683E752E49B2737DF7C4080181973496509A5B9A8D37B7C300434016920D9EAEF16AEC0A4AB7DF5B1C01C933B9AAF19E1818027A00A80021F1FA0E43400043E174638572B984B066401D3E802735A4A9ECE371789685AB3E0E800725333EFFBB4B8D131A9F39ED413A1720058F339EE32052D48EC4E5EC3A6006CC2B4BE6FF3F40017A0E4D522226009CA676A7600980021F1921446700042A23C368B713CC015E007324A38DF30BB30533D001200F3E7AC33A00A4F73149558E7B98A4AACC402660803D1EA1045C1006E2CC668EC200F4568A5104802B7D004A53819327531FE607E118803B260F371D02CAEA3486050004EE3006A1E463858600F46D8531E08010987B1BE251002013445345C600B4F67617400D14F61867B39AA38018F8C05E430163C6004980126005B801CC0417080106005000CB4002D7A801AA0062007BC0019608018A004A002B880057CEF5604016827238DFDCC8048B9AF135802400087C32893120401C8D90463E280513D62991EE5CA543A6B75892CB639D503004F00353100662FC498AA00084C6485B1D25044C0139975D004A5EB5E52AC7233294006867F9EE6BA2115E47D7867458401424E354B36CDAFCAB34CBC2008BF2F2BA5CC646E57D4C62E41279E7F37961ACC015B005A5EFF884CBDFF10F9BFF438C014A007D67AE0529DED3901D9CD50B5C0108B13BAFD6070
"""
}
