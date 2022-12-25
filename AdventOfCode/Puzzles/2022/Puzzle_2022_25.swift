//
//  Puzzle_2022_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_25: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
    }

    public func solvePart1() -> String {
        solvePart1(str: Puzzle_Input.final)
    }

    private func snafuToInteger(_ snafu: String) -> Int {
        var retval = 0
        var power = 1
        for char in snafu.reversed() {
            let charValue: Int
            if char == "=" {
                charValue = -2
            } else if char == "-" {
                charValue = -1
            } else {
                charValue = Int(String(char)) ?? 0
            }

            retval += (power * charValue)
            power *= 5
        }

        return retval
    }

    private func integerToSnafu(_ value: Int) -> String {
        let fromDigit: [Int: String] = [ 2: "2", 1: "1", 0: "0", -1: "-", -2: "=" ]
        if value == 0 {
            return ""
        }

        let mod5 = value % 5
        switch mod5 {
        case 0, 1, 2:
            return integerToSnafu(value / 5) + (fromDigit[mod5] ?? "")
        case 3, 4:
            return integerToSnafu(value / 5 + 1) + (fromDigit[mod5 - 5] ?? "")
        default:
            fatalError("Unknown mod 5 value")
        }
    }

    private func solvePart1(str: String) -> String {
        let lines = str.parseIntoStringArray()
        var sum = 0
        for line in lines {
            let lineValue = snafuToInteger(line)
            sum += lineValue
            print("\(line) -> \(lineValue)")
        }

        return integerToSnafu(sum)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
"""

    static let final = """
1=21
12120-2211===-
1-2
2=2112-211-
1=0=-=22
112=022==0=--011=
22==-0-2-00-
2=20=2202=
1-22
220-==
2=11=0012
1-0=0
1=
1-1
1000-00=11-20-2
11
100-1
1-=-11
1211
1-=2
10=--00-=10-02
1=11==-20=11-1-2-
21
10=
10=212112==200=
10-=22-10
1-0211=-
10=-==221
1110022=1111-
10=2
1=1=2-0-0111=
1-=-=2=0=--
1=2=1=-0221===
1=--101=
2-000=0-21212=1-12
1===01==2=
1-==2122
100=--11-02=
1=120==1-0
201-10222-0=
11102--0=-=121-1=-
101
1=-1-00=0-12-0-120
10=--=20101==
1=0--000=
1=1==00=1-2011222
2=1-2=221-122=-==22
1--2100=1=22-=-11011
10-102-010020=
1=2=0100-22=12-2
1-=001-=220-00-02
1-2=121
2----0-
2=--022-=0-
10-22=002=-
2-=21=01
2=01-
2=1-2=--01202=2
112=20-1=-21101=
102212===201-
2-=2=21
1=-2=2--001=211==12
10=111222=-2022=12
1-12012=-10-==0==
1=1=2200=211-=
1-2-1===-00=21
2=1
12000=1
1=10=0=-1
1=2002=1-2=--0
1=2
112=0=20
1=0-2-
1-1=02
1=2==-00110
102-1-=12-==2212221
1--20--=-==021=121
11-=200==
11=010
2-00--0112102
1---=
1-=11=1-=-=0-=
2==-=22=12012-
20-=-=
12-10002-11
1=021=
1-00
1====0=2--
122
1==-02=112-0-10
1=1-11=2=--2
11211=21
1=-2-11-1100011001
2=-02101
11=1201=21=0
12100=
1-1-2==
2-1=-2=10001-=2
2==20-0=1=0=
11--112000-=11210
1-22-1-=
2111021-
102==
2002-
12=1--21-20
11=22-0-101221
101=01=----01
102--21
1---0-=-
2-==-01-202110=
"""
}
