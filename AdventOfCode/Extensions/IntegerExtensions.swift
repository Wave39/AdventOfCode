//
//  IntegerExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/8/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

extension FixedWidthInteger where Self: UnsignedInteger {
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
