//
//  Puzzle_2018_02.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2018_02: NSObject {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        let puzzleInput = Puzzle_2018_02_Input.puzzleInput
        let array = puzzleInput.parseIntoStringArray()
        return solvePart1(arr: array)
    }

    public func solvePart2() -> String {
        let puzzleInput = Puzzle_2018_02_Input.puzzleInput
        let array = puzzleInput.parseIntoStringArray()
        return solvePart2(arr: array)
    }

    private func solvePart1(arr: [String]) -> Int {
        var counterOfTwos = 0
        var counterOfThrees = 0
        for s in arr {
            if s.hasConsecutiveCharacters(num: 2) {
                counterOfTwos += 1
            }

            if s.hasConsecutiveCharacters(num: 3) {
                counterOfThrees += 1
            }
        }

        return counterOfTwos * counterOfThrees
    }

    private func solvePart2(arr: [String]) -> String {
        var minDifference = Int.max
        var minI = 0
        var minJ = 0

        for i in 0..<(arr.count - 1) {
            for j in (i + 1)..<arr.count {
                let diff = arr[i].charactersDifferentFrom(str: arr[j])
                if diff < minDifference {
                    minDifference = diff
                    minI = i
                    minJ = j
                }
            }
        }

        return arr[minI].commonCharactersWith(str: arr[minJ])
    }
}

private class Puzzle_2018_02_Input: NSObject {
    static let puzzleInput_test = """
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab
"""

    static let puzzleInput_test2 = """
abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
"""

    static let puzzleInput = """
bvhfawknyoqsudzrpgslecmtkj
bpufawcnyoqxldzrpgsleimtkj
bvhfawcnyoqxqdzrplsleimtkf
bvhoagcnyoqxudzrpgsleixtkj
bxvfgwcnyoqxudzrpgsleimtkj
bvqfawcngoqxudzrpgsleiktkj
bvhfawcnmoqxuyzrpgsleimtkp
bvheawcnyomxsdzrpgsleimtkj
bcdfawcnyoqxudzrpgsyeimtkj
bvhpawcnyoqxudzrpgsteimtkz
bxhfawcnyozxudzrpgsleimtoj
bvhfdwcnyozxudzrposleimtkj
bvpfawcnyotxudzrpgsleimtkq
bvhfpwccyoqxudzrpgslkimtkj
bvhfawcnyoqxudirpgsreimtsj
bvhfawcnyoqxudzppgbleemtkj
bvhzawcnyoqxudqrpgslvimtkj
bvhfawclyoqxudirpgsleimtka
bvhgawfnyoqxudzrpguleimtkj
bvhfazcnytqxudzrpgslvimtkj
bvhfawcnygxxudzrpgjleimtkj
bxhfawcnyoqxudzipgsleimtxj
bvhptwcnyoqxudzrpgsleimtmj
bzhfawcgyooxudzrpgsleimtkj
bvhjlwcnyokxudzrpgsleimtkj
bvhfawcnyoqxudbrmgslesmtkj
bvhfawcnysixudzwpgsleimtkj
bvhflwcnymqxxdzrpgsleimtkj
bvifawcnyoyxudzrpgsleimtvj
bvhfawcnyofxudlrpgsheimtkj
bvhbawcmyoqxudzrpggleimtkj
bhhxgwcnyoqxudzrpgsleimtkj
bvhfawgnyoqxbdzrpgsleimfkj
bvhfawcnyoqxudcrngsleimykj
bvhfawcnyofxudzrpgslebgtkj
bvhfaocnybqxudzapgsleimtkj
bvhxawcnyodxudzrpfsleimtkj
bchfawcnyoqxudrrtgsleimtkj
bvhfawcqyoqxudzdpgsltimtkj
bvhfawknyoqxudzrpnsleimtbj
cihfawcnyoqxudirpgsleimtkj
bvlfawpnyoqxudzrpgslgimtkj
bulfawcnyoqbudzrpgsleimtkj
bvhfajcnyoqkudzrpgsoeimtkj
bvhrakcnyoqxudzrpgsleimjkj
bvbftwcnyoqxuvzrpgsleimtkj
bvhfhwcnyoqxudzrpgslelmtbj
bvhyawcntoqxudzrpgsleimtuj
xvhuawcnyoqxuqzrpgsleimtkj
pvhfawcnyoqxudzdpglleimtkj
bvhfawsnyoqxudzrpgvlefmtkj
bvhfawcnyoqxudzrpgepeiwtkj
bvhfawcnyoqxudzrphsleittkr
dvhfawcnyoqxudzrpkslzimtkj
bvhfawpnyoqxudzrpgmlcimtkj
bvhsawcnyzqxudzrpgsaeimtkj
bdhfawcnyoqxudzrpasleiwtkj
bvhfawbnyoqxpdbrpgsleimtkj
mvhfawwnyoqxujzrpgsleimtkj
bvafawcnyoyxudzrpgsleidtkj
bvhyawcnyoqxudztpgzleimtkj
besfawcnyoqxudzrpgsleimdkj
bvhfawcnyoqxudrrpgsjeimjkj
xvhfkwcnyoqxudzcpgsleimtkj
bvhfawcnyeqdudzrpgzleimtkj
bvhfuwcnybqxudzrpgsleimttj
lvhfawcnyoqhudzdpgsleimtkj
bvhfawcnyoqxudzrpgslevwtnj
bvhfadcnzoqxxdzrpgsleimtkj
bvsfawcnyoqxpdzrpgileimtkj
bzhfaycnyoqxudzrpgsxeimtkj
bwhfdwcnyoqxudzrpgsleimtkz
bvhfawcnyoqxudzrpgsjlimtkm
bvhfawcnyoqxudsrwgsleimtlj
bbhfalynyoqxudzrpgsleimtkj
bvhfawcnyeqxudzrpglleimtkr
bvhfawnnboqxurzrpgsleimtkj
yvhfawcnyoqxudzrpgslzimtpj
bvhfjwcnyoqxqdxrpgsleimtkj
bthfawcnyoqfudzrpgslhimtkj
bvhfawchuoqxudzqpgsleimtkj
bvhfawcndoqxudzrugsleimrkj
bvhfawcnnoqxjdzrpgsleidtkj
bvhpawcnyoqkudzrpgsleimtzj
bvhfaiinyoqxudzopgsleimtkj
bvhfawcnyxqxuizrigsleimtkj
bvnfawcnyoqxudzqpgsleimbkj
bvnfawcnyoeyudzrpgsleimtkj
bvhfawcnyoqxudarpgsieimtoj
bthcawcnyoqxudlrpgsleimtkj
bvhfnwcnyozxudzrpgsleomtkj
bpwfawcnyoqxudzrpgskeimtkj
bvhfapcnyoqxudnrpgsxeimtkj
bvhfdwcnyoqxubzrxgsleimtkj
fvhfawcnyoqxjdzrpgsleirtkj
bvhfawcneoqxudzrvzsleimtkj
bvhaawcnyoqxudzrpgsleimtex
bvhfawcnyojxudvrpgsleimckj
bvlfawcnyoqxddzrpgsleimtko
bvhfawclfoqxudzrpgsleiktkj
bvhfawciyobxudzrpgkleimtkj
bvhfpwcnyoqxudzrpgsqeimtkd
bvhyawcnyyqxudzrkgsleimtkj
bvhfawcncoqxudzrphsaeimtkj
bvhfawmnyoqxudzrpgifeimtkj
bvhfawcjyoqxudzjpgszeimtkj
bohfawcnwoqxudzrpgsleimwkj
bvhfaucnyoqxudzrpgfluimtkj
bvhfawlnyoqgudzrpgwleimtkj
bmhfawcnyoqxndzrpgsleymtkj
bvhfawcngoqxudzrpzxleimtkj
bihfawcnyoqxudrrpgsleimokj
lvhfawcnylqxudzrpgsleintkj
bvhfawcnyoqvugzrqgsleimtkj
bvhfawcnyoqxudzgpgslqimtij
bvhfawcnyoqludzrpgslnimtcj
hvhfawcnyolxudzrpgsmeimtkj
nvhfawcdkoqxudzrpgsleimtkj
bvhfawcnyoqxkdzrggsneimtkj
bvhfawnnyoqxudzrpgqleibtkj
bvhfawyuyoqxudzrhgsleimtkj
wvhfbwcnyoqxtdzrpgsleimtkj
bvhfawcnyoqxedzzpgoleimtkj
bvhfawcnioqxunzrpgsleimtnj
bvhfawctyoqxudzrpgsldkmtkj
bvhfawcnyonxudzrpgsleitpkj
bvefawcnyoqaudzhpgsleimtkj
bvhfawcnyxqxudzrpgslelmbkj
bvhfamrnyoqxudzrpgsleimgkj
bvhfaqcnyoqxudzrpgsaeimekj
bvhfawcnyoqcidzrpgsleimvkj
bvhfawcnnorxudzrpgsmeimtkj
bvroawcnyoqxudzrpgsleiwtkj
bvhfwwcnyoqxudzrpaslewmtkj
bvsfawcnyoqxudzcpgszeimtkj
bkhfmwcnyoqjudzrpgsleimtkj
bvtfawcnyoqxudzrcgslecmtkj
bvhfawcnypzxudzrpgsleimtkv
bvhfawcnyoqzudzrfgtleimtkj
bvhpawcnyoqxudhrpgsleimtko
tvhfawcnyoqxudzxpfsleimtkj
bvhfawccyofxudzrpqsleimtkj
bvnfawtnyoqxuzzrpgsleimtkj
bvhfamcnuwqxudzrpgsleimtkj
bvhfawcfyoqxudjrpgsleimrkj
bvhpalcnyoqxudzrpgslexmtkj
bvhfawcnjsqxudzlpgsleimtkj
bvhfafcnioqxydzrpgsleimtkj
bvzfawcnyxqxudzgpgsleimtkj
bvhzawcnyoqxudzrpgslewctkj
bvhiawcnhoqrudzrpgsleimtkj
bvhfawcnyoqxuszrggslenmtkj
bvhfowcnyoqxudzrptseeimtkj
behfawfnyoqxudzrpgsleimlkj
lvhfawcnyoqxudsrpgvleimtkj
bvhfawnnyaqxudzrpgsqeimtkj
lvhfawcnfoqxvdzrpgsleimtkj
svhxawcnyoqxudzrpqsleimtkj
bvhfawqnfoqxudzrpgsleimkkj
bvhfafcnyoqcudzrpgsleimtcj
bvhfyfcntoqxudzrpgsleimtkj
bvhfpwcnyoqxudzrpgsleimumj
bvhfawccyoqxudzrqgrleimtkj
bvhfawqnyoqxudzbpgsleimkkj
bvhflwcnyoqxudzrpxsleemtkj
bvhfawcnyoqxuezrpgslehrtkj
bvhfawceyoqxudzrpgsleimswj
bvhfawcncohgudzrpgsleimtkj
bahfawcnyoqxgdzrpgsleamtkj
yvhfawcnyoqxudzrppslrimtkj
fvhfawcmyoqxudzrpgskeimtkj
bvylawsnyoqxudzrpgsleimtkj
bvhfswcnyyqxedzrpgsleimtkj
fvrfawcnyoqxudzrpgzleimtkj
bvhfawcnyoqxuvzrpgslermtks
bvhkawccyoqxudzcpgsleimtkj
bvhfaobnyoqxudzrprsleimtkj
bvbfawcnyoqxudirpgsleimhkj
bvhfawcnyoqxudzvpgsueimtgj
bvhxawcnyoqxudzrpgsleimtgi
svhfawcjyoqxuszrpgsleimtkj
bvnfawcnyoeyudzrpgsldimtkj
bvhfawcnyoqxuhzrpgsleimcki
bvhfvwcnyoqxudzizgsleimtkj
bvhfapznyohxudzrpgsleimtkj
bvhfaelnyosxudzrpgsleimtkj
xvhfawcnmoqxuhzrpgsleimtkj
bjhfawcnyaqxutzrpgsleimtkj
bvhfawcnyohxudzrpgslgnmtkj
bvhfawcnyoqxudzrppsreimtkx
fvhfapcnyoqyudzrpgsleimtkj
qvhfafcnyoqxudorpgsleimtkj
bvhfawcnyoqxedzrwgsleimtvj
bvhfawgnyoqxudzupgqleimtkj
bvhfowctyoqxudzrpgbleimtkj
bvhwawcnyoqxudzapgslvimtkj
bvhfadcnyoqxudzrugsleimtuj
bvhfawcnyosxudzlpgsleamtkj
bvhfawcnywqxuqzrpgsloimtkj
bvhfawcnyoqxumzrpgvlfimtkj
bvhfawcgyoqxbdzrpgsleomtkj
bvhfahcnyoqwudzrfgsleimtkj
gvbfawcnyrqxudzrpgsleimtkj
svhfawcnyoqxudlrpgsleimtkx
avhfafcnyoqxuhzrpgsleimtkj
bvhfawcsyoqxuazrpgsleimtej
bvofawcnyoqxudzrpgsteimtkf
bvhfajcnyoqxudzqpgszeimtkj
bvhfawcsyoqxudzrmgsleiktkj
mvhfawcnyoqxudzrpgkluimtkj
bvhfawcnhoqxudzrpgslwhmtkj
bmhaawsnyoqxudzrpgsleimtkj
bvhfawcnyoqxudzhpgsleimhyj
bvhfxwcnyoqxsdzypgsleimtkj
bvhpawcyyoqxuczrpgsleimtkj
bvomawcnyovxudzrpgsleimtkj
bvhfawcnjvqxudzrpgsleimtkt
nvhfawcnyqqxudzrpgsleittkj
bvhiawcnyzqxudzrpysleimtkj
bvhdawcnyoqxukzrpgsleimtuj
bvhfawcnyyxxudzrpgslzimtkj
hvhfawcnyoqxudzupgslemmtkj
byhfawknyoqxudzrpgsleimtkb
bvhfawcnyoqxudzrpasleihakj
bvafahcnyaqxudzrpgsleimtkj
bkhfawcnyoqxudzrpgllepmtkj
bghfawcnycqxuzzrpgsleimtkj
bvhfawcnyoqxudzrbgeleimtkl
bvhfascnyoqgudzrpgsveimtkj
bvhfawnnyoqxudzrpgsleimtdl
bvhqawcnyoqxudzrpgsleimgrj
bvhsawdwyoqxudzrpgsleimtkj
bvhfawcnyoqxudzrpgaleipttj
bvhfawcnrlqxudzrbgsleimtkj
bvhfdwcnyoqxudzqpcsleimtkj
bvhfawcnyoqxudzopgslexmokj
bvhfawcoyoqxudzrpghlewmtkj
bvhfozcnykqxudzrpgsleimtkj
bvhfawcnyoqxuvzrpgslrimtkr
bvhfrncnyoqrudzrpgsleimtkj
bvhfawcnyocxuizrpgslefmtkj
bvhfawywyoqxudzrpgsleimxkj
bvhfawcnyoqxugzrpgslrimtij
bvtfawcnyoqxudzcpgsleimtfj
bvhfawcnyoqxuzzspgsleimtkz
bvhfawcnzoqxvdzrpgslsimtkj
bvhfzwcnyoqxudzrpgslenmhkj
bvhfkccnyoqxudzrpgzleimtkj
bvhfawcnyoqzudzrpgslhimwkj
bzhfawvnyooxudzrpgsleimtkj
"""
}
