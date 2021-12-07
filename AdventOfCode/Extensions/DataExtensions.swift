//
//  DataExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// I found a faster implementation for producing a hex string from bytes, which was causing a bottleneck
// https://stackoverflow.com/a/40089462

import Foundation

extension Data {
    // swiftlint:disable all
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    // swiftlint:enable all

    // swiftlint:disable all
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let hexDigits = options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef"
        let utf8Digits = Array(hexDigits.utf8)
        return String(unsafeUninitializedCapacity: 2 * self.count) { (ptr) -> Int in
            var p = ptr.baseAddress!
            for byte in self {
                p[0] = utf8Digits[Int(byte / 16)]
                p[1] = utf8Digits[Int(byte % 16)]
                p += 2
            }
            return 2 * self.count
        }
    }
    // swiftlint:enable all

}
