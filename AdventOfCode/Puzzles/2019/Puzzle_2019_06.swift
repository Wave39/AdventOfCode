//
//  Puzzle_2019_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_06: PuzzleBaseClass {

    class OrbitalRelationship: CustomStringConvertible {
        var center: String
        var orbiter: String
        init(_ c: String, _ o: String) {
            center = c
            orbiter = o
        }

        var description: String {
            return "center: \(center); orbiter: \(orbiter)"
        }
    }

    class PlanetaryInfo: CustomStringConvertible {
        var name: String
        var stepCount: Int
        init(_ n: String, _ c: Int) {
            name = n
            stepCount = c
        }

        var description: String {
            return "name: \(name); step count: \(stepCount)"
        }
    }

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_06_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_06_Input.puzzleInput)
    }

    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        var orbitalRelationships: [OrbitalRelationship] = []
        for line in arr {
            let components = line.parseIntoStringArray(separator: ")")
            orbitalRelationships.append(OrbitalRelationship(components[0], components[1]))
        }

        var orbitCount = 0

        func WalkPlanets(_ p: String, _ stepCount: Int) {
            orbitCount += stepCount
            let orbiters = orbitalRelationships.filter { $0.center == p }
            for o in orbiters {
                WalkPlanets(o.orbiter, stepCount + 1)
            }
        }

        let mainOrbiters = orbitalRelationships.filter { $0.center == "COM" }
        for o in mainOrbiters {
            WalkPlanets(o.orbiter, 1)
        }

        return orbitCount
    }

    func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var orbitalRelationships: [OrbitalRelationship] = []
        for line in lines {
            let components = line.parseIntoStringArray(separator: ")")
            orbitalRelationships.append(OrbitalRelationship(components[0], components[1]))
        }

        var planets: [PlanetaryInfo] = []

        func WalkPlanets(_ p: String, _ stepCount: Int) {
            planets.append(PlanetaryInfo(p, stepCount))
            let orbiters = orbitalRelationships.filter { $0.center == p }
            for o in orbiters {
                WalkPlanets(o.orbiter, stepCount + 1)
            }
        }

        let mainOrbiters = orbitalRelationships.filter { $0.center == "COM" }
        for o in mainOrbiters {
            WalkPlanets(o.orbiter, 1)
        }

        let you = planets.first(where: { $0.name == "YOU" })!
        let san = planets.first(where: { $0.name == "SAN" })!
        var youOrbits: [PlanetaryInfo] = []

        var pName = orbitalRelationships.first(where: { $0.orbiter == "YOU" })!.center
        while pName != "COM" {
            youOrbits.append(planets.first(where: { $0.name == pName })!)
            pName = orbitalRelationships.first(where: { $0.orbiter == pName })!.center
        }

        pName = orbitalRelationships.first(where: { $0.orbiter == "SAN" })!.center
        while pName != "COM" {
            let planetMatch = youOrbits.first(where: { $0.name == pName })
            if planetMatch != nil {
                break
            }

            pName = orbitalRelationships.first(where: { $0.orbiter == pName })!.center
        }

        let commonPlanet = planets.first(where: { $0.name == pName })!
        return (you.stepCount - commonPlanet.stepCount - 1) + (san.stepCount - commonPlanet.stepCount - 1)
    }
}

private class Puzzle_2019_06_Input: NSObject {

    static let puzzleInput_test1 = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
"""

    static let puzzleInput_test2 = """
COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN
"""

    static let puzzleInput = """
XR3)N91
YB5)2BZ
K71)3LC
7NR)88C
FBR)NRN
D4W)SXX
M6G)QX1
43Y)134
F72)WJ3
TRV)WPR
DJQ)6SZ
6L8)RSP
X6F)DN9
WK9)BX8
L4Y)1ZT
J2F)173
GJY)VBR
V59)L52
XHL)DXN
3M2)VH8
41P)4GL
KN2)VSJ
DBZ)NN2
6W2)MX4
Q41)3FX
757)KXZ
F93)8PL
F4L)2FL
BKH)1DP
3CN)DDN
RQ2)QV7
Q62)PF3
QL3)B5Y
9K7)L8T
4HB)49L
L8T)CYY
949)GN6
MXW)2ZX
BDX)CR4
63D)68J
6N1)GXN
8K8)FZ8
SN2)V3L
ZZ6)MS5
CZT)KW9
9CF)LHY
JSL)S5L
ZKQ)276
KL5)3JM
GN4)CQT
G56)WRD
C5X)RVC
YMD)4NN
652)CXN
726)K75
XDK)59D
3MQ)JST
9CP)7BR
CV1)BF7
FDL)PDF
PDF)X7L
HTM)9YY
8R9)YYW
FQD)8FL
482)99N
57D)1FN
6N8)18R
B4Z)N2T
F1H)9BG
Y7X)ZKQ
Y82)X1R
KL5)V9F
DJW)SC6
6GC)731
65B)VXX
TJH)P96
T6G)17V
FDQ)S76
HQ1)P6W
1JB)9D2
Q69)MK9
H8P)DBZ
DD2)RTB
N9P)683
SJF)6SX
XDP)XPL
HGH)CG8
1BZ)MF2
JJW)SFN
PZD)TG1
T6T)WG4
W5R)DV6
SZG)MF6
HVD)PQC
BQZ)NH7
1KS)6JB
4CW)5NP
YKR)R2M
7NQ)Q6G
YGZ)14M
RG3)H7P
WF3)KGT
5PP)5Y2
3DD)X68
Y3G)KN8
MFZ)JQ7
3H3)Q8G
QB8)7JL
9ND)4XH
TVK)5Z2
BBY)9D7
HM2)6JW
B3R)JH8
CHN)SZR
DRJ)4PG
H8T)SYK
DNN)7Y8
BS1)BF6
HMM)5QZ
K4L)FKW
4P3)VHN
C4C)XRQ
4Q9)PG9
BLS)87J
TX9)ZY8
V4B)72Q
WNQ)8DK
38X)5GY
L52)175
ZH9)C5W
6CP)G45
JDT)T7H
NV3)8JZ
XHF)JY7
YPK)F9W
BNR)TYB
K4L)RNM
MR1)K1F
KZL)JTC
43Y)669
H7V)P7L
KGT)N6K
2Z2)FC4
P13)M5C
FC9)7NT
HZC)ZJ4
X3P)VYC
Q4H)YY2
7NT)58N
B3F)B1Y
FJ6)YKK
QDJ)2W4
QYN)7CP
JMX)HYZ
KVL)8FP
1DP)CNB
XKQ)GRN
D75)P8J
CPR)3RX
5Y9)QXK
72Q)QT2
CJB)J9H
48Y)YZB
MSH)4NV
HMM)B7H
8YG)HX3
MVP)88Z
JBB)RGW
QFW)L8W
119)SPN
4VP)L4S
DSS)W4L
6QX)4HG
C8R)ZY1
2ZC)J4D
RM2)XCZ
DBW)X4Q
82C)75X
4VS)TXY
WBJ)62R
Z12)K9Q
JW5)95P
341)FX2
3ZM)NBY
3ST)6TZ
RKY)BSR
VYC)57S
8QZ)7LW
RB2)NGW
4WQ)TQF
BBC)MCW
9V4)P4N
Y99)H37
J41)CHN
69G)J38
QB8)SJF
9G2)PXQ
SP4)C7W
2BZ)7MY
91V)DHB
8RB)NWQ
7CX)8F4
2YZ)L7D
JKL)5LW
1B2)7VF
GQQ)QG2
LHY)CJV
RW4)38X
B5Y)2HC
5T3)19L
5M2)419
KW2)WZ9
ZPT)JGQ
NJB)SKM
R7K)8JK
S5L)Q24
K1G)438
GYM)LRB
764)4FJ
6VW)4TP
65R)JSL
QQW)F72
RZQ)DD2
F27)ZH9
MF2)ZPT
ZJ8)K64
FZ3)MT6
TJW)15H
TZV)RQ2
6F8)KN2
819)B3J
1RB)LS5
3X3)5RM
5J9)9CF
692)J8T
GYF)4MW
GY4)99W
XNN)WN1
Y5T)D11
MX4)8XN
XZL)QB8
LYM)H7S
S76)7G7
CR4)HGH
QSF)TLL
RKB)4CY
4XV)965
YCZ)HVJ
7P9)JTS
SK3)XTL
HZM)R8X
Z46)F18
V9F)7GT
989)Z5B
NV3)NY9
CJB)BBC
692)KVL
37V)XJ5
TR5)Z75
TBB)8QZ
BDY)TR5
7J8)6GC
H78)GZH
96F)25Q
XHV)GC9
ZJV)BFB
NHM)82C
T8M)5WV
WHG)856
86B)H6G
LRP)GBT
L52)H7V
XK3)14K
SKM)XZH
4N5)33D
BX6)HVN
JL9)ZCW
S4J)VTC
XVP)F93
2BG)821
CXN)LTQ
QTY)W4F
7JL)119
C7W)TJ6
ZY1)DHY
6SX)RKM
FD1)C2G
X3D)4BN
H5N)X7Z
3HL)YK5
NSG)PVG
2WH)LSH
HX4)DSS
T46)SK3
4CN)CRG
7N5)CP7
PTJ)95G
FTF)TPT
26N)NZG
X29)K3V
97L)MH8
ZYB)C53
5NR)CYV
2TS)1VX
H7S)CXK
BF3)XHF
DN9)WG9
4RR)M1H
6WQ)136
3JM)TVK
LTQ)QQW
GFD)FKY
HXQ)4LL
MJK)1HG
89J)RM2
GSY)9GN
MRP)GYZ
3LS)4WQ
1Y5)HCP
CFR)BQZ
XRP)CL8
FZD)ZSV
8PL)VQL
17V)89Q
DV6)H1G
KFW)4S5
DSW)F4X
HCP)XXV
XZH)VZK
D4H)WS2
WZC)3V4
8XN)YMD
P6J)MTY
P3S)DSW
FGL)7L3
F4X)1ZC
6QX)35X
B3J)RZD
L7H)STV
1JJ)4W8
2NT)C57
QX1)8S5
H37)RXN
T73)PTJ
841)JZL
RZD)DLK
KWL)8P2
H2Z)MSZ
WNL)2L4
VV4)G7L
6PP)52Y
J3T)YNK
WRD)T8M
C16)XWC
KR9)ZVH
Q6G)2R9
T68)6YG
D4Z)P3S
WGY)KF6
7T6)WV2
NMV)L3M
D4D)X3D
DJS)DNN
FDC)KZ7
G3L)6PP
DHY)1RB
KB5)9G2
QH6)8YG
NTN)QDP
8TX)91Q
NJ6)W8X
FWF)KX4
58B)QPV
NCD)MNQ
T23)L65
3S7)QYG
N1K)QPS
PG9)Q49
RQG)381
ZKP)L5P
RPP)2V4
F5F)M96
6FZ)PBW
NNF)YQP
C3C)546
LKZ)K69
FM4)MRP
WHD)FSV
8FP)NTC
RH4)GWX
3S5)QS9
DZN)BNT
57S)841
9R7)J48
2L4)YLP
J9H)948
ZY8)XKY
R6N)YV9
6YG)4TG
F4J)9DQ
63G)2VX
PRF)MZ9
88Z)V82
8WS)KQ8
G98)FKV
1KF)S8N
FL8)K8K
1RD)5ZY
669)M8S
2ZS)1L1
RSH)H2S
RD8)J5S
PSH)YFY
4Z1)CFD
PXQ)CV1
VF3)HNC
M5C)NWF
COM)PY1
91Q)VWL
B2M)4FZ
XD4)HNV
9Q8)3LS
KSN)1NC
XJG)QTY
QYC)P94
6ZM)GTC
ZYK)5QP
C91)N76
Q3G)1G9
JG1)7NQ
S28)WYY
Q4R)TBB
LRB)MKJ
PHC)S8F
PVB)W82
4YT)MXM
3XP)FZM
9X9)3G9
R74)QX9
MS5)XDR
2RY)ZZ6
5QZ)JQ8
R2M)9YP
5YW)HCF
99M)418
KL3)9CH
K49)HCH
7MY)KM3
CH6)6N1
P2V)X1Q
NY9)PHC
M8S)661
MTY)ZMN
LZX)6HS
B1Y)YQX
VSK)J45
2XV)Q5T
NW8)SBP
NKZ)5RT
4S5)QFW
KQ8)FZH
T53)NCJ
FW9)X96
LNT)KW2
PLF)HPG
L6K)9K7
4NV)8MT
RPP)3B9
FKY)2MB
1X6)NK6
C9T)FJH
68Q)MX6
N67)T1S
T1Q)5ZK
LTZ)PLF
826)YF2
KV4)61H
MH8)32B
GG2)84F
K8R)WPZ
CRG)K8R
SZD)Y9Q
25Q)GMP
YFY)FZ3
9S7)RXS
C7G)CZT
M5B)RBV
JZT)BBY
GSJ)ZKP
BDF)P13
DD2)KCV
QT2)19R
MPV)D81
MWK)K17
QQ7)1ZN
86W)RL7
SC6)FHD
8GH)YHG
NK6)JRT
8T8)SBD
S5H)63X
KZ7)K1G
SFM)P3H
S8F)CDC
L7D)WYP
DDS)6F3
MHR)QFR
X7Z)SCN
BDX)151
KW9)T53
2V8)RHP
C53)KDD
8DK)SBF
TG1)2PN
S96)JBB
HJ4)T1R
ML9)WV8
781)WNL
3KJ)4F3
GYZ)LZX
S3D)43Y
3NS)6B9
WYB)D4D
FJH)CVB
X96)3CN
PKJ)QWV
9DQ)TQR
JGM)9S7
7L3)8LT
6X5)Y74
WCN)8ZN
8TT)1SY
JH8)3D9
B5S)7C2
T9W)TYM
6JW)MTF
CNB)7Q7
YH7)XJH
5YH)41P
WXW)Y22
KFT)CYF
4XW)GTD
WRR)BKH
HCH)CJS
B5B)YBC
5MF)8P1
TJ6)H4X
NVZ)TZK
15S)XZL
S96)XXS
RFH)FDL
RGW)24Q
DL7)7QX
8QJ)NKZ
RS6)SFV
JQ7)588
TYM)72J
8LT)HZM
J8T)RSH
BNT)67Z
C36)NW5
Z75)N36
7T7)PKJ
VWL)Q69
B59)8GH
N6K)N9P
VPQ)LKJ
679)N67
S9Q)M4X
SWX)NHM
5YD)THF
MXM)6QX
821)SJM
419)FW9
9K2)JVN
KZD)QBG
P86)6GG
1S8)8XW
XKY)HS2
MXF)TSV
52T)LQD
149)QR6
CP7)9X9
NS5)W6C
GML)SS2
NWM)FXK
49L)X56
PY1)6SW
S4X)CDQ
VSJ)DN1
FX2)MR1
GKF)YPK
LLR)FM4
RSN)RKY
Z3T)JSC
ZJ4)SSP
4BC)B2M
WPR)R6N
1ZN)P75
QYG)LTZ
NZG)3ST
TTS)XCX
6QM)B69
3Q8)RSN
C62)2W2
NWQ)NJ6
37V)9Y7
D3X)ZVF
N3P)LHB
V67)482
WYS)KFW
856)JL8
FGV)5VH
MSY)NQ7
SPD)XS7
ZKQ)VC1
6KJ)WRR
P8K)Q4R
TSV)FBP
Z48)7DX
FY6)CPR
8PZ)MSY
KQ8)LHH
JH4)S19
2HC)MBR
H1G)5WG
Z6R)WB6
H65)RS6
QS9)35K
72Q)4KR
1QY)28Q
W8X)TH5
6GG)K33
DVV)V34
FX7)ZYB
TC1)LBJ
J5Z)3Q8
149)16G
DXT)NFF
J98)55P
PCX)J1T
NGY)VGJ
588)V2H
JN4)4GV
X1R)4ST
35K)DZN
HFQ)VD6
981)QQ7
BF4)65R
L9H)Z2Z
89Q)V69
PG9)PBM
NDB)6QM
CYW)7PH
LRB)GQQ
Y8G)L2K
132)51T
LHH)NCP
WZ9)Y3G
JRT)FYV
8T8)B21
CFD)NMV
TQP)NWM
5ND)5Z5
BFC)YT4
RFK)TYG
4G7)Z3G
1FN)6FZ
BXP)T3V
51T)327
TGM)NDB
BGD)BDF
T7H)YFH
82S)53L
K64)BFC
DF8)8MB
G4T)P8N
794)J46
DP1)CRV
CQL)3R4
S82)ZTW
SPN)LKZ
K8K)142
C5W)L1X
NH7)8ZG
YZB)2Y3
3WF)FCJ
NDT)579
NWF)Q7H
GBT)Q41
MYT)N1K
VMG)XHG
J4M)7HN
Z46)R42
3R4)FD1
6T7)6W7
B2J)FY6
PBW)69B
ZG5)HM2
N67)SP4
VTC)GYF
P48)V5C
T1L)M5B
LHB)HKZ
X3Y)DDS
RNM)5PP
ZVF)NGY
2ZP)J3T
LK5)RG7
HT8)X85
FXK)7WG
5HY)HLH
8XW)C7J
QWV)WP7
Y36)YKW
NWY)H2H
HYL)T12
4P3)DPK
4TG)VV4
KCV)WYB
9M6)Y36
418)T95
MWN)GFD
VKB)MBC
5VH)7T7
T1S)Q1G
JRH)72G
Z7Z)7N5
TX9)WHG
GP8)FY8
C1Z)HCG
4WQ)LRC
XK2)TPV
2NT)RFK
18R)39Z
DTD)1JJ
412)6T7
S6F)XKQ
N6F)GN4
4GV)CTX
P6W)8TT
N76)M6G
4FN)MFZ
KRX)2DG
NYJ)YST
3K6)XZ9
XNP)WJM
5NR)HQV
F1J)H65
WPZ)5MF
2PN)P4Q
XTG)6VW
2CN)JH4
MSZ)B1T
V9S)MR2
TH5)YWS
93H)XR3
QX9)NCD
9R7)LJC
TZF)ZL3
MX6)WYS
MSH)Y7X
H9L)WX4
HNV)JJY
WV2)B2J
X1Q)3LY
CYY)F5Y
GKM)2CN
GTC)55Q
RBS)GQJ
V34)F5F
CYF)4HB
QPV)GSY
V2H)V59
RMV)ZJV
X85)774
8FL)3TZ
XXV)DBW
Z5B)Y18
HXQ)NG4
GZH)TB2
GZ9)N3P
SYK)CFR
M12)DFG
9GN)NYJ
DLK)BY4
XJH)T1Q
F18)RQG
L4V)F1Y
VHN)PSH
H3R)2Z2
CXK)GHG
CLV)VFY
64G)J4M
G45)5PQ
ZGY)25J
RMP)68Q
Q23)FW1
PB6)38F
24M)M39
8MB)ML9
V82)5Y9
NR2)S4J
NN2)L43
63J)L6K
GRN)B5B
YND)1RD
B1T)YKR
LX3)KRX
LKJ)Z1X
M4X)24M
24M)RNP
XN7)VLP
QGD)VF3
ZVH)2YF
14M)FHN
76L)TD7
L65)RG3
3R1)1Y5
KJT)C5X
XTL)BHX
XQP)KV4
QV7)JQC
QBG)F4L
2ZX)HBX
5QH)5GK
KXF)HYL
7PH)Y64
V7W)N96
V95)KWL
2GS)GZ9
Z7F)NW8
FD3)KR9
95P)WNQ
X6D)2YL
YF2)NMW
ZDV)8N1
BY4)T55
15H)679
MCW)XQP
BNR)M38
L43)P6L
LZX)8R9
7NQ)VKB
QLP)99M
Y64)KZL
V69)69W
X9H)T1L
HS6)XDS
4TP)FZD
YLC)SDL
KZD)8WS
5GK)DJQ
DHB)HVD
RXY)FX7
LRC)7W7
B7H)QSF
GCF)TZV
FZ8)Z7F
9HC)XJG
Q49)132
J4D)NVZ
B6B)7DB
R1C)2ZS
55Q)Z12
PVG)LSB
YF2)GY4
T55)HJ4
JY7)GKM
H77)7NF
L8W)7WC
D81)794
JQC)5YH
HX3)YGZ
B6N)92N
3F2)65B
MZ9)LH1
6TM)BS1
5V6)3H3
PCP)L9Z
8F4)PZD
VPW)G56
JJY)GCN
6W7)CQF
KYZ)RMV
7DT)DSM
J5Z)V4B
B69)ZYK
MMZ)PQL
276)6L8
VGW)C8R
1S8)FDC
WWP)KB5
CDC)QQ4
HVJ)VPW
134)FGQ
151)TZF
CX5)7B7
C2G)KS6
75X)L9H
381)3YF
BKH)C91
P8N)3F2
JS3)2ZC
HML)B3F
S53)XVP
F4B)STZ
P6L)XDK
HNY)XTD
SBD)QLP
CYV)9HC
S99)4VS
MWT)NR2
66P)G8Q
FT2)Q3G
77Y)JJW
B6N)989
PSV)WWP
YKW)76K
69B)K2T
7FK)4BC
JCK)BRB
3YF)8SQ
3BL)GP8
CT2)3M2
WYY)RKB
2TY)TGM
69W)G47
VGJ)4Z1
35K)BH1
JGQ)77Y
4M4)FTN
GN6)P2V
99N)J98
ZKP)W2B
XRQ)L51
P13)57D
8JZ)819
MKJ)MXW
2F2)XGR
94T)HKK
RSP)91V
48C)37V
FKX)74Y
7BR)Z6R
5DY)5J9
VPW)CJ4
LB8)CLY
BDF)T73
X21)JS3
L9J)YDX
QQQ)764
5CM)V95
LVZ)61Z
ZB2)8TX
K2T)W23
27K)VSK
2B9)XF5
P2P)YD6
C4W)1X6
FKW)HTM
F9W)PNP
12F)R2G
NW5)D3X
7VF)85D
L4V)NWY
CTX)XCV
173)XDP
8SQ)Y2Z
3FK)5HY
796)QGD
P8P)ZC4
9YY)7P9
327)9SR
5LW)FD3
FKV)NTN
V7Z)XLP
WFB)PCP
5V3)X29
9YP)GSJ
1CH)MWT
J38)NJB
1ZL)2B9
8JK)1GF
RHL)86B
3YC)CJX
MBC)3XP
5R4)Q3V
64P)MWS
M1H)F1J
ZP4)GG2
41P)P48
C5W)229
YV9)RMJ
969)MDV
CWV)2TY
131)JQL
HTC)3S5
K5M)FWF
KLV)FC3
8YG)14G
FCJ)69G
V59)4P3
M96)Y14
69T)GKF
74Y)NDT
683)JVB
BH1)12F
NFF)412
LZM)8PH
RSM)94J
84F)FJ6
VZG)JHS
1ZC)Y82
2YL)RZQ
WZC)P6J
2DG)W9M
4M4)L83
CBF)CYW
CLY)WLF
JQ8)8VY
VBR)ZZD
W6C)8H3
R7Z)8VZ
JTC)8T8
4GL)89J
TZK)4CW
5ZY)33J
9D2)YJJ
FBP)1CH
GQJ)PXX
76K)GML
NRN)YZJ
7DX)9R7
RL7)6H1
R1X)K5M
XQ7)6WQ
ZC4)LYY
92N)GX1
RKM)MMZ
8SB)ZP4
341)6F8
KN8)RHL
PG5)R2W
T1S)6ZM
76B)5QH
791)PVB
LYY)NSV
5SH)NW1
9D2)BLS
PSH)44X
63G)KD1
TLL)XJP
Q8G)5SG
HKK)716
T68)HT8
4LL)DJS
HPG)MXF
6JQ)146
57B)S99
TQR)G3P
RMJ)3X1
DJB)YTJ
YDZ)HMV
7G7)3S7
NCJ)T6G
5RM)7NP
DDN)3DV
YWS)KPP
9Y7)4LK
53L)HXQ
TYB)82S
GTC)P8K
L83)TZG
DGS)M4S
K69)DP1
WG4)2F2
3FX)T96
XF5)DL3
WX4)7MB
XLP)2KS
QFW)X21
SS2)2SB
2MB)XZP
7DB)QYC
6B9)MHR
6DL)T9W
MDZ)X9H
KF6)VZG
P7L)FQD
YYQ)5M2
16G)LM9
L3M)1S8
19L)CJB
BF6)JR4
F1R)7NR
C95)KQC
HVN)51V
LJC)WGY
8PH)NSG
BJD)K3K
BGD)LK5
6JB)C62
N74)T6J
ZDR)89M
D6L)CQL
327)Z7Z
6GH)DYM
W4F)5RZ
K33)1YN
6F3)XD4
JQL)157
QR6)DJB
T6N)YB5
5RT)BX6
ZZD)3CB
GMP)ZQP
FZM)QWJ
VXX)MXZ
DM4)NV3
G3P)D4W
YK5)DC9
1G9)DGS
P3H)5T3
TZG)F1H
WN1)MPV
L1X)MP4
FGV)HZC
6L3)D6L
1JJ)149
4XH)9CP
4W8)58B
4HG)5CM
WLF)5ND
X6F)KFT
175)M61
Z1X)HX4
JL8)RZK
7B7)H78
ZV7)Q62
MYT)TC1
CQT)5YD
JST)WFB
N96)6XN
TH5)XTG
JWX)PMJ
MKJ)D4H
39Z)8RB
8P1)JCK
HKZ)6BJ
5Z2)LZM
KDD)63J
5QJ)JWX
8VZ)CN5
N97)K4L
2YP)H8M
QWV)969
W4L)H85
1L1)6KJ
G6V)J5T
7WC)CZL
Q5T)HCS
SFM)GJY
CX5)5DY
4CY)179
KR2)S96
77V)H82
XKY)L4V
3RX)GX5
VC1)4YT
KM3)BGD
DL3)JW5
B7S)G98
56C)Q4H
YHG)341
2SM)KLV
T49)JGM
9D7)NNF
GX5)CH6
FYV)RB2
7Q9)64G
Y36)6N8
NGS)L85
XDR)C36
JS5)7CX
716)DRJ
5Z5)2M5
WYP)XRP
BFB)RMP
JZL)YOU
VFY)H5N
BHX)8PZ
F5Y)2V8
FQH)MYZ
XZ9)B4Z
ZQP)V7Z
RXN)WCN
V5C)FBR
1ZL)3LB
33D)FLN
55P)LB8
DN1)4K1
438)1T8
CZL)77V
Z75)HS6
546)3X3
TXY)R7Z
ZCW)SMZ
RV1)RBS
6WQ)5NR
RHP)BYK
TLC)JRH
55N)R82
3LY)7TF
99W)8S3
DC9)2RY
R2G)48R
87Z)RPP
YLP)1KS
7NP)WBJ
3V4)K49
K1K)V9S
FLN)2NT
HQV)H7N
F18)652
RG7)GH4
T3V)T6N
142)3Y6
J5T)3BL
9BG)S53
7HN)4M4
N91)SG8
L83)4XV
CRG)H4R
N2T)WZP
XTD)DCK
1T8)G6V
X7N)CNS
63X)F4B
856)XX4
1VX)14F
2VX)V3K
BRX)K74
H4X)131
NTC)B59
CJS)57B
FRK)DLM
DYM)DXT
7FF)5QJ
K9Q)QZT
W9M)27K
KQC)FT2
2PS)C9T
J1T)MT4
94J)FGV
7Z8)ZJ8
C7J)7Z8
TPV)1BZ
NM1)S28
G7L)5SH
2Y3)D75
YBC)Z3T
7CB)G3L
Q1G)52T
QSF)4CN
Z3G)B7S
PXX)ZPV
PF3)7FF
GWX)QQQ
RXS)K71
NWY)PSV
52Y)QL3
NBY)X6F
PBM)6W2
3K6)BRX
J4Z)VMG
43N)J5Z
KDD)SWX
QG2)HTC
8Q4)7Q9
X7Y)X12
35X)2V7
87J)3YC
Z2N)4N5
3CB)TQP
YB5)NKS
H8M)3FK
J7T)Q9V
8H3)YVP
136)ZS9
CJV)C4C
K1F)2GS
RDB)LNT
TB2)NND
146)DTD
CXN)BD5
5WG)MWN
LZS)SMR
SBF)P87
W2B)RJV
TPT)YDZ
5MC)FGL
HCG)K1K
Z8P)48C
SMZ)W51
WG9)14X
H82)KSN
DBN)ZGY
3B9)LX3
4FJ)9ND
2FL)5V3
BYK)XSH
QWJ)H3R
SFN)26N
3DV)VDQ
H2H)PB6
J48)3P3
14F)Y5T
HNC)QM2
L2K)SFM
P94)63D
WZP)L9J
MXZ)DJW
CJX)781
NCD)8K8
7W7)KKJ
H7N)XM4
836)87Z
DSM)QXQ
WZP)BF3
5NP)74C
R1C)CPD
HS2)SYT
K3K)3KJ
BX8)CCX
M9G)66P
M38)JDT
1GF)BXP
2PN)M9G
XJ5)HMP
45G)F1R
99N)949
QPS)3R1
3Q8)XK3
89M)Z2N
RNP)56C
MT4)BDX
9SR)R7K
QDP)YLC
P48)VPQ
STZ)B5S
52T)45G
N9P)MVP
M39)T23
WS2)JN4
VSJ)KGL
652)55N
2WH)Z46
43W)SZG
XS7)XQ7
J5S)JKL
CGG)S3D
7PH)4GM
D35)FDQ
NMW)BDK
LWR)JJK
ZZL)2YP
33J)CB1
YQP)XNN
XJP)8Q4
Q24)LRP
LM9)2WH
J5T)1QY
QX1)T6Q
C9T)CWV
5ZK)9Z9
J46)RW4
ZMN)R1X
8VY)MYT
7Y8)FH6
XHG)826
S8N)J7T
3DK)86W
YKK)HMM
KFN)9DS
RJV)P8P
CRH)MJK
51V)B6B
WP7)94T
1CX)X3P
2RY)4G7
BSR)QBC
T12)FL8
RS6)F27
QPT)LLR
GTD)LWR
4FZ)R1C
579)B6N
8S5)981
X56)M62
25J)WZ4
JHS)Q23
FC3)VGW
XCX)SPD
NXT)791
CXL)FC9
PQL)FRK
K74)2B5
SYT)XHV
S19)3MQ
2SB)H9L
8PZ)TTS
87J)WF3
WV8)3HL
P4P)7DT
RSM)Y99
CFQ)RFH
4K1)S6F
KV4)C95
2X2)7J8
731)N6F
K17)XHL
8TT)QPT
LSB)5Y7
2V4)L4Y
YWS)YND
LS5)BDY
4ST)J2F
L5P)2PS
MWS)757
661)DM4
V95)6DL
6TZ)D4Z
W23)3DD
7C2)3WF
FY8)CT2
6VW)2SM
CPD)Y3H
NXT)7CB
Q7H)C16
BRB)LL6
CJ4)ZDV
NKS)T68
69T)BJD
Y82)C4W
68J)JG1
R82)F22
MTF)2XV
K5M)ZG5
NQ7)MWK
MXW)6GH
72G)4VP
XCZ)QDJ
1Y5)82G
32B)6X5
V3K)WK9
62R)MHF
WJM)P4P
FH6)KFN
2KS)GYM
JJK)CGG
J5S)LFF
3LB)97L
44X)2YZ
LCN)S82
F22)NS5
SDL)1JB
CDQ)933
XWC)X3Y
H4R)JMX
KD1)3K6
4F3)8QJ
WJ3)HFQ
G47)S4X
ZTW)HNY
NX3)TLC
NCP)796
35X)YH7
Y18)ZZW
HCH)GCF
HMV)S3S
PMJ)D3T
CQF)KBN
ZH9)DVV
VH8)P2P
VD6)QXP
HYZ)1CX
67Z)3ZM
ZS9)KJT
R8X)H8P
R7Z)CXL
SJM)SAN
XZL)DL7
WF3)CX5
CVB)MSH
MP4)KXF
N36)JS5
1SY)B3R
3P3)JZT
TYG)RV1
P4N)KR2
3TZ)T6T
KX4)4FN
T6J)TX9
8ZG)H2Z
146)N74
MT6)X7Y
74C)RDB
2M8)9K2
ZZW)2ZP
2W2)5R4
NCP)KYZ
YNK)JGB
BD5)WHS
LQD)RD8
8MT)SZD
XX4)836
QXQ)Z48
NSV)2BG
14K)2M8
P8P)YYQ
T96)D35
8S3)L7H
GXN)W5R
4HB)Y8G
THF)C1Z
9CH)R5J
C57)PRF
TBB)4XW
2B5)V67
DFG)ZZL
5GY)FQH
YYW)PCX
T6Q)LYM
661)H77
R42)KK4
WB6)7T6
WHS)76B
7CP)9M6
948)726
V3L)RH4
ZY1)LVZ
TD7)692
88G)34X
H1G)XNP
933)WZC
KXZ)69T
KBN)35V
L2K)MDZ
JGB)BF4
S3S)S9Q
CL8)XY1
61H)PG5
8FL)76L
YTJ)V7W
FHD)H8T
2R9)544
THF)C7G
GX1)T87
8N1)NX3
544)X6D
YT4)L5V
9DS)NGS
58N)CLV
QXK)R74
XM4)3DK
QZT)HML
KKJ)N97
JVB)JL9
1ZT)6CP
G8Q)5YW
MDV)X7N
229)LCN
WZ4)64P
KS6)5V6
VLP)1B2
D11)TJW
179)1KF
LFF)QH6
ZL3)KL5
KRS)48Y
8SB)9V4
8XW)2X2
179)4RR
X4Q)V6H
6SW)T46
9K7)S5H
MF6)Y6H
ZSV)NXT
3X1)KSH
7QX)DF8
4KR)SFR
DXN)RSM
HMP)XK2
KK4)3NS
PNP)JRJ
B21)7FK
NW1)K6V
ZZD)CBF
MYZ)KZD
XXS)WHD
SG8)SN2
76L)HQ1
GH4)ZB2
T87)LZS
48R)Z8P
95G)6L3
CNS)63G
14G)43W
XKQ)FTF
W82)FKX
C8R)ZDR
GCN)WXW
M61)DBN
4MW)J41
QYC)2TS
FZH)8SB
SSP)CRH
HBX)6TM
794)XN7
F1Y)43N
K6V)DZQ
24Q)T49
7TF)15S
SZR)G4T
5SG)6JQ
RZK)YCZ
D3T)M12
BF3)TJH
82S)ZV7
VQL)RXY
SFR)CFQ
7DB)96F
95G)C3C
Y2Z)JPN
NGW)4Q9
965)KRS
J45)93H
LBJ)1ZL
P96)F4J
8P2)TRV
DPK)9Q8
CRV)5MC
4XV)J4Z
4TG)NM1
YJJ)P86
LH1)QMV
4LK)KL3
Q3V)QYN
KPP)BNR
Q9V)88G
"""

}
