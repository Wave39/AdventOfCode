//
//  StringExtensions.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import CommonCrypto
import CryptoKit
import Foundation

public extension String {
    static var clearConsole: String { "\u{001b}[H" }

    var asciiArray: [UInt32] {
        unicodeScalars.filter { $0.isASCII }.map { $0.value }
    }

    var asciiValue: UInt32 {
        let c = self.unicodeScalars.first
        return c?.value ?? 0
    }

    var binaryToInt: Int {
        guard let retval = Int(self, radix: 2) else {
            return 0
        }
        return retval
    }

    var digitsOnly: String {
        let str = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return str
    }

    var double: Double {
        guard let retval = Double(self.trim()) else {
            return 0.0
        }
        return retval
    }

    var hexadecimalToInt: Int {
        guard let retval = Int(self, radix: 16) else {
            return 0
        }
        return retval
    }

    var int: Int {
        guard let retval = Int(self.trim()) else {
            return 0
        }
        return retval
    }

    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        // return computed.map { String(format: "%02hhx", $0) }.joined() // very slow
        return Data(computed).hexEncodedString()
    }

    var point2D: Point2D {
        let arr = self.parseIntoIntArray(separator: ",")
        if arr.count == 2 {
            return Point2D(x: arr[0], y: arr[1])
        } else {
            return .origin
        }
    }

    var uniqueCharacters: String {
        var set = Set<Character>()
        return String(filter { set.insert($0).inserted })
    }

    static func commonCharacters(str1: String, str2: String) -> String {
        let dict = (str1 + str2).characterCounts()
        let str = String(dict.filter { $0.value == 2 }.map { $0.key })
        return str
    }

    static func uncommonCharacters(str1: String, str2: String) -> String {
        let dict = (str1 + str2).characterCounts()
        let str = String(dict.filter { $0.value != 2 }.map { $0.key })
        return str
    }

    func capturedGroups(withRegex pattern: String, trimResults: Bool = false) -> [String] {
        var results = [String]()

        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }

        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))

        guard let match = matches.first else {
            return results
        }

        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else {
            return results
        }

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

    func characterCounts() -> [Character: Int] {
        self.reduce([:]) { d, c -> [Character: Int] in
            var d = d
            let i = d[c] ?? 0
            d[c] = i + 1
            return d
        }
    }

    func consecutiveCharacterCounts() -> [(Character, Int)] {
        if self.isEmpty {
            return []
        }

        var retval = [ (self.first!, 1) ]
        var arrCtr = 1
        var lastCharacter = self.first!
        for idx in 1..<self.count {
            if self[idx] != lastCharacter {
                lastCharacter = self[idx]
                retval.append((lastCharacter, 1))
                arrCtr += 1
            } else {
                retval[arrCtr - 1].1 += 1
            }
        }

        return retval
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

    func condenseCharacters(char: Character) -> String {
        let components = self.components(separatedBy: CharacterSet(charactersIn: String(char)))
        return components.filter { !$0.isEmpty }.joined(separator: String(char))
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
            let v = String(c).hexadecimalToInt
            var b = v.binaryString()
            while b.count < 4 {
                b = "0" + b
            }

            retval += b
        }

        return retval
    }

    func hasBracket() -> Bool {
        self.contains("[") || self.contains("]")
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
        firstIndex(of: char)?.utf16Offset(in: self)
    }

    func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex, to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex, to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound, offsetBy: offset, limitedBy: endIndex) else { break }
            position = index(after: after)
        }

        return indices
    }

    func isStringNumeric() -> Bool {
        if !self.isEmpty {
            var numberCharacters = NSCharacterSet.decimalDigits.inverted
            numberCharacters.remove(charactersIn: "-")
            return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
        }

        return false
    }

    func isStringHexadecimal() -> Bool {
        if !self.isEmpty {
            for c in self {
                if !c.isHexDigit {
                    return false
                }
            }

            return true
        }

        return false
    }

    func matchesForRegexInText(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let results = regex.matches(
                in: self,
                options: [],
                range: NSMakeRange(0, nsString.length)
            )
            return results.map { nsString.substring(with: $0.range) }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
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

    func pad(with: String, toSize: Int, onTheLeft: Bool) -> String {
        if with.count != 1 {
            return self
        }

        var padded = self
        for _ in 0..<(toSize - padded.count) {
            if onTheLeft {
                padded = with + padded
            } else {
                padded += with
            }
        }

        return padded
    }

    func padLeft(with: String, toSize: Int) -> String {
        pad(with: with, toSize: toSize, onTheLeft: true)
    }

    func padRight(with: String, toSize: Int) -> String {
        pad(with: with, toSize: toSize, onTheLeft: false)
    }

    func parseIntoIntArray() -> [Int] {
        parseIntoIntArray(separator: "\n")
    }

    func parseIntoIntArray(separator: Character) -> [Int] {
        let arr = self.split(separator: separator)
        var retval: [Int] = []
        for s in arr {
            retval.append(s.int)
        }

        return retval
    }

    func parseIntoPoint2D(separator: Character = ",") -> Point2D {
        let arr = self.split(separator: separator)
        return Point2D(x: arr[0].int, y: arr[1].int)
    }

    func parseIntoDigitMatrix() -> [[Int]] {
        var allLines: [[Int]] = []
        let lineArray = self.split(separator: "\n")
        for line in lineArray {
            var thisLine: [Int] = []
            for element in line {
                thisLine.append(element.int)
            }

            allLines.append(thisLine)
        }

        return allLines
    }

    func parseIntoMatrix() -> [[String]] {
        var allLines: [[String]] = []
        let lineArray = self.split(separator: "\n")
        for line in lineArray {
            var thisLine: [String] = []
            let elementArray = line.split(separator: " ")
            for element in elementArray {
                thisLine.append(String(element))
            }

            allLines.append(thisLine)
        }

        return allLines
    }

    func parseIntoCharacterMatrix() -> [[Character]] {
        var allLines: [[Character]] = []
        let lineArray = self.split(separator: "\n")
        for line in lineArray {
            var thisLine: [String] = []
            let elementArray = line.split(separator: " ")
            for element in elementArray {
                thisLine.append(String(element))
            }

            allLines.append(Array(line))
        }

        return allLines
    }

    func parseIntoStringArray(omitBlankLines: Bool = true) -> [String] {
        parseIntoStringArray(separator: "\n", omitEmptyStrings: omitBlankLines)
    }

    func parseIntoStringArray(separator: Character, omitEmptyStrings: Bool = true) -> [String] {
        let arr = self.split(separator: separator, omittingEmptySubsequences: omitEmptyStrings)
        var retval: [String] = []
        for s in arr {
            retval.append(String(s))
        }

        return retval
    }

    func rangesOfString(searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        let count = searchString.count
        return _indices.map { index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + count) }
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

    func replaceFirst(of pattern: String, with replacement: String) -> String {
        if let range = self.range(of: pattern) {
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
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
        substring(from: range.lowerBound, to: range.upperBound)
    }

    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func words(with charset: CharacterSet = .alphanumerics) -> [String] {
        self.unicodeScalars.split { substring in
            !charset.contains(substring)
        }
        .map(String.init)
    }

    func allLines() -> [String] {
        return components(separatedBy: .newlines)
    }

    func parseGrid2D<Tile>(_ mapping: (_ character: String, _ point: Point2D) -> Tile?) -> [Point2D: Tile] {
        var grid: [Point2D: Tile] = [:]

        for (y, line) in allLines().enumerated() {
            for (x, character) in line.enumerated() {
                let point = Point2D(x: x, y: y)

                if let tile = mapping(String(character), point) {
                    grid[point] = tile
                }
            }
        }

        return grid
    }

    var paragraphs: [[String]] {
        split(separator: "\n", omittingEmptySubsequences: false).split(separator: "").map { $0.map(String.init) }
    }
}

public extension StringProtocol {
    var string: String { String(self) }

    subscript(offset: Int) -> Element {
        self[index(startIndex, offsetBy: offset)]
    }

    subscript(_ range: CountableRange<Int>) -> SubSequence {
        prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }

    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }

    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        prefix(range.upperBound.advanced(by: 1))
    }

    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        prefix(range.upperBound)
    }

    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        suffix(Swift.max(0, count - range.lowerBound))
    }
}

public extension Substring {
    var double: Double {
        guard let retval = Double(self) else {
            return 0.0
        }
        return retval
    }

    var int: Int {
        guard let retval = Int(self) else {
            return 0
        }
        return retval
    }

    var string: String { String(self) }
}
