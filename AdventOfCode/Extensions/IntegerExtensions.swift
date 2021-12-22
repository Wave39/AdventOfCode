//
//  IntegerExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/8/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

public extension FixedWidthInteger where Self: UnsignedInteger {
    var bytes: [UInt8] {
        var _endian = littleEndian
        let bytePtr = withUnsafePointer(to: &_endian) { ptr in
            ptr.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout<Self>.size) { start in
                UnsafeBufferPointer(start: start, count: MemoryLayout<Self>.size)
            }
        }
        return [UInt8](bytePtr)
    }
}

public extension Int {
    static func swap(_ int1: inout Int, _ int2: inout Int) {
        let temp = int1
        int1 = int2
        int2 = temp
    }

    func binaryString(padLength: Int = 0) -> String {
        var binaryValue = String(self, radix: 2)
        while binaryValue.count < padLength {
            binaryValue = "0" + binaryValue
        }

        return binaryValue
    }

    func hexadecimalString(padLength: Int = 0) -> String {
        var hexadecimalValue = String(self, radix: 16)
        while hexadecimalValue.count < padLength {
            hexadecimalValue = "0" + hexadecimalValue
        }

        return hexadecimalValue
    }
}
