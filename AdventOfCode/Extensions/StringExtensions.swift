//
//  StringExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
    
    var asciiValue: UInt32 {
        let c = self.unicodeScalars.first
        return c?.value ?? 0
    }
    
    func capturedGroups(withRegex pattern: String, trimResults: Bool = false) -> [String] {
        var results = [String]()
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        
        guard let match = matches.first else { return results }
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            if trimResults {
                results.append(matchedString.trim())
            } else {
                results.append(matchedString)
            }
        }
        
        return results
    }
    
    func charactersDifferentFrom(str: String) -> Int {
        var retval = 0
        for idx in 0..<self.count {
            if self[idx] != str[idx] {
                retval += 1
            }
        }
        
        return retval
    }
    
    static var clearConsole: String { return "\u{001b}[H" }
    
    func commonCharactersWith(str: String) -> String {
        var retval = ""
        for idx in 0..<self.count {
            if self[idx] == str[idx] {
                retval += String(self[idx])
            }
        }
        return retval
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func convertBinaryToHashesAndDots() -> String {
        var retval = ""
        
        for c in self {
            if c == "0" {
                retval += "."
            } else {
                retval += "#"
            }
        }
        
        return retval
    }
    
    func convertHexToBinary() -> String {
        var retval = ""
        
        for c in self {
            var b = String(Int(String(c), radix: 16)!, radix: 2)
            while b.count < 4 {
                b = "0" + b
            }
            
            retval = retval + b
        }
        
        return retval
    }
    
    func hasBracket() -> Bool {
        return self.contains("[") || self.contains("]")
    }
    
    func hasConsecutiveCharacters(num: Int) -> Bool {
        let uniqueSelf = self.uniqueCharacters
        for c in uniqueSelf {
            let ctr = self.filter { $0 == c }
            if ctr.count == num {
                return true
            }
        }
        
        return false
    }
    
    func indexOf(char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
    
    func isStringNumeric() -> Bool {
        if !self.isEmpty {
            var numberCharacters = NSCharacterSet.decimalDigits.inverted
            numberCharacters.remove(charactersIn: "-")
            return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
        }
        
        return false
    }
    
    func matchesInCapturingGroups(pattern: String) -> [String] {
        var results = [String]()
        
        let textRange = NSMakeRange(0, self.lengthOfBytes(using: String.Encoding.utf8))
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: textRange)
            
            for index in 1..<matches[0].numberOfRanges {
                results.append((self as NSString).substring(with: matches[0].range(at: index)))
            }
            return results
        } catch {
            return []
        }
    }
    
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }

    func parseIntoIntArray() -> [Int] {
        return parseIntoIntArray(separator: "\n")
    }
    
    func parseIntoIntArray(separator: Character) -> [Int] {
        let arr = self.split(separator: separator)
        var retval: [Int] = []
        for s in arr {
            retval.append(Int(String(s))!)
        }
        
        return retval
    }
    
    func parseIntoMatrix() -> [[String]] {
        var allLines : [[String]] = []
        let lineArray = self.split(separator: "\n")
        for line in lineArray {
            var thisLine : [String] = []
            let elementArray = line.split(separator: " ")
            for element in elementArray {
                thisLine.append(String(element))
            }
            
            allLines.append(thisLine)
        }
        
        return allLines
    }
    
    func parseIntoStringArray() -> [String] {
        return parseIntoStringArray(separator: "\n")
    }
    
    func parseIntoStringArray(separator: Character) -> [String] {
        let arr = self.split(separator: separator)
        var retval: [String] = []
        for s in arr {
            retval.append(String(s))
        }
        
        return retval
    }
    
    mutating func removeAtIndex(idx: Int) {
        if let index = self.index(self.startIndex, offsetBy: idx, limitedBy: self.endIndex) {
            self.remove(at: index)
        }
    }
    
    func removeCharacters(startIdx: Int, charLength: Int) -> String {
        var newStr = self
        for _ in 0..<charLength {
            let idx0 = newStr.index(newStr.startIndex, offsetBy: startIdx)
            newStr.remove(at: idx0)
        }
        
        return newStr
    }
    
    func replace(index: Int, newChar: Character) -> String {
        var chars = Array(self)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    mutating func rotate(amount: Int, left: Bool) {
        let strLen = self.count
        if left {
            for _ in 1...amount {
                let c = self[0]
                self = self.substring(from: 1) + String(c)
            }
        } else {
            for _ in 1...amount {
                let c = self[strLen - 1]
                self = String(c) + self.substring(from: 0, to: strLen - 1)
            }
        }
    }

    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: self.count - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    func toInt() -> Int {
        guard let retval = Int(self.trim()) else { return 0 }
        return retval
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var uniqueCharacters: String {
        var set = Set<Character>()
        return String(filter{ set.insert($0).inserted })
    }
    
}

extension StringProtocol {
    
    var string: String { return String(self) }
    
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
    
}

extension Substring {
    
    var string: String { return String(self) }
    
}
