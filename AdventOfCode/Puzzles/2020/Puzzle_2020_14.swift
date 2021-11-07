//
//  Puzzle_2020_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_14: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    func binaryString(_ v: Int, padLength: Int) -> String {
        var binaryValue = String(v, radix: 2)
        while binaryValue.count < padLength {
            binaryValue = "0" + binaryValue
        }

        return binaryValue
    }

    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var bitmask = ""
        let maskRegex = "mask = (.*)"
        let memRegex = "mem\\[(.\\d*)\\] = (.\\d*)"
        var memoryValues: Dictionary<Int, Int> = [:]
        for line in lines {
            let arr = line.parseIntoStringArray(separator: "=")
            if line.starts(with: "mask") {
                let mask = line.matchesInCapturingGroups(pattern: maskRegex)
                bitmask = mask[0]
            } else if line.starts(with: "mem") {
                let mem = line.matchesInCapturingGroups(pattern: memRegex)
                let addr = mem[0].int
                if memoryValues[addr] == nil {
                    memoryValues[addr] = 0
                }

                let binaryValue = binaryString(mem[1].int, padLength: 36)
                var newBinaryValue = ""
                for idx in 0..<36 {
                    if bitmask[idx] == "0" || bitmask[idx] == "1" {
                        newBinaryValue += bitmask.substring(from: idx, to: idx + 1)
                    } else {
                        newBinaryValue += binaryValue.substring(from: idx, to: idx + 1)
                    }
                }

                memoryValues[addr] = Int(newBinaryValue, radix: 2) ?? 0
            } else {
                print("Unknown input: \(arr[0])")
            }
        }

        var total = 0
        for (_, v) in memoryValues {
            total += v
        }

        return total
    }

    func getMemoryAddresses(originalAddress: Int, bitmask: String) -> [Int] {
        var retval: [Int] = []

        let binaryValue = binaryString(originalAddress, padLength: 36)
        let xCount = bitmask.filter { $0 == "X" }.count
        if xCount > 0 {
            let pow = (2 << xCount)
            for idx in 0..<pow {
                var powString = binaryString(idx, padLength: xCount)
                var newAddress = ""
                for idx in 0..<36 {
                    if bitmask[idx] == "0" {
                        newAddress += binaryValue.substring(from: idx, to: idx + 1)
                    } else if bitmask[idx] == "1" {
                        newAddress += "1"
                    } else {
                        newAddress += String(powString.first ?? " ")
                        powString.remove(at: powString.startIndex)
                    }
                }

                retval.append(Int(newAddress, radix: 2) ?? 0)
            }
        }

        return retval
    }

    func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var bitmask = ""
        let maskRegex = "mask = (.*)"
        let memRegex = "mem\\[(.\\d*)\\] = (.\\d*)"
        var memoryValues: Dictionary<Int, Int> = [:]
        for line in lines {
            let arr = line.parseIntoStringArray(separator: "=")
            if line.starts(with: "mask") {
                let mask = line.matchesInCapturingGroups(pattern: maskRegex)
                bitmask = mask[0]
            } else if line.starts(with: "mem") {
                let mem = line.matchesInCapturingGroups(pattern: memRegex)
                let addr = mem[0].int
                let value = mem[1].int

                let memoryAddresses = getMemoryAddresses(originalAddress: addr, bitmask: bitmask)
                for addr in memoryAddresses {
                    memoryValues[addr] = value
                }
            } else {
                print("Unknown input: \(arr[0])")
            }
        }

        var total = 0
        for (_, v) in memoryValues {
            total += v
        }

        return total
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""

    static let puzzleInput_test2 = """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""

    static let puzzleInput = """
mask = 0111X10100100X1111X10010X000X1000001
mem[50907] = 468673978
mem[22295] = 3337449
mem[58474] = 56418393
mem[15362] = 243184
mem[65089] = 110688658
mask = 010X010XX110X01X01X10X001001011X110X
mem[21952] = 950257
mem[44861] = 522064487
mem[38886] = 28536885
mask = 01X1X1010XX0011X110XX100101010X01011
mem[34148] = 165121
mem[25371] = 1910147
mem[4508] = 873
mask = 0X0101000110X0X1X10110X01001X1101000
mem[40376] = 353253497
mem[38808] = 420210682
mem[36684] = 460134256
mem[36954] = 13018
mem[31204] = 1570641
mem[64427] = 794804
mask = 010X0X10X110011X111110X101010X011100
mem[33555] = 5817
mem[50762] = 19301
mem[34148] = 45831
mem[49609] = 20953
mask = 0101111X001XX1X1XX110X0011001X0110X1
mem[40890] = 19341
mem[805] = 3763307
mem[29028] = 46964025
mem[49148] = 1011
mem[60594] = 412
mask = 01011X100X10010111110000X100001011X1
mem[23450] = 91209
mem[20844] = 957554
mem[27874] = 190
mem[12076] = 4121857
mask = 010X1111X1X00X0001X00010X00XX11X0010
mem[16319] = 2783
mem[21567] = 17723
mem[28695] = 119006159
mem[17010] = 1490805
mask = X10X01100X100X1X1111XX000000X1000100
mem[38076] = 10721
mem[5612] = 33835318
mem[50215] = 32666
mem[54776] = 742717
mem[50081] = 7142
mem[10888] = 9627
mem[27683] = 3233
mask = 110X11X00X1X011101X10100000100X01100
mem[47415] = 26142
mem[6104] = 1611
mem[13666] = 2172
mem[37461] = 246745
mask = XXX1010000100111X101X10X001X1X01111X
mem[5950] = 28347
mem[23723] = 3781160
mem[24119] = 61730631
mem[9465] = 195
mem[38852] = 368
mask = 000111X0X010X001001X0XX001X0100X0001
mem[22174] = 10779416
mem[27094] = 3877
mem[27240] = 119114179
mem[29382] = 49553968
mem[13018] = 81614
mem[12705] = 105661
mask = 011X0X000010X1X111X100X10010XX111010
mem[15728] = 1119
mem[53872] = 3320246
mem[1403] = 1103
mem[55544] = 6704
mem[19075] = 434540275
mem[53453] = 65839517
mem[65089] = 456346
mask = 011X0X0000100111XX011001111XX1101XX0
mem[28177] = 64811587
mem[52145] = 129822
mem[23338] = 17363
mem[2847] = 55060289
mem[15265] = 4306484
mask = 01010100001X0111X10X100101111XXX10X0
mem[41518] = 83447
mem[32741] = 239294
mem[40395] = 13271982
mem[50232] = 54532
mem[50438] = 7507
mem[39262] = 18171
mask = 110XX10000100X0111X1XX011000100X10XX
mem[13329] = 1657
mem[9465] = 182174
mem[17833] = 36371
mem[44063] = 2023777
mem[35070] = 175898
mem[11835] = 21265680
mem[59883] = 4549
mask = 010101XX00X0001110X1011110X1X100X010
mem[2352] = 1257
mem[20972] = 1407839
mem[44004] = 46044
mem[42964] = 14608802
mem[50782] = 127374
mem[9030] = 1192
mem[53872] = 527761815
mask = 0001X100001X0111110110010100100X10X0
mem[17100] = 791
mem[35116] = 24043959
mem[59031] = 495660
mask = 001101010XX001111101X10XX10X11100X0X
mem[49217] = 1364476
mem[40395] = 26461
mem[10597] = 6036
mask = 1X010X000010X1110101X100010100110110
mem[7256] = 13581
mem[54776] = 137273
mem[18056] = 2650
mem[17436] = 1589
mem[24338] = 14945
mem[24563] = 380
mask = 0X01010X00100XX11XX101XX0X1011100110
mem[9465] = 853288
mem[50270] = 648352720
mem[51640] = 6653
mem[12204] = 171
mask = 0X1101000X1X011101X101011XX1XX011110
mem[54147] = 464360322
mem[17191] = 873213614
mem[8506] = 114827104
mem[5436] = 710
mask = 0001100000100000001001000100X0X0X1X1
mem[4227] = 12304
mem[46645] = 14410395
mem[48137] = 14329225
mask = 0101X1X0011000X1X1X10100100110XX0110
mem[295] = 186
mem[12389] = 1341
mask = 01010XX00XX100X111110100XXX000000000
mem[7339] = 2997
mem[4013] = 864002
mem[62626] = 41651819
mem[4169] = 2885
mem[26933] = 1865
mem[34277] = 4294222
mask = 0X0X01100X100010111XX00100011110X100
mem[59657] = 607
mem[21996] = 11680
mem[23680] = 6829359
mem[24252] = 3575739
mem[41518] = 903
mem[30194] = 2133
mask = 0111010X0010011X1101XXX10X11XXX11110
mem[43862] = 166301
mem[24088] = 15627668
mem[6763] = 2866562
mem[42635] = 816335559
mem[4426] = 14810075
mem[20940] = 141967
mask = X101010000110111010000X00X01110X0X10
mem[31920] = 53034702
mem[11498] = 6110224
mem[46990] = 238620
mem[39724] = 839
mem[24096] = 148589
mask = X0110X0000100111X1010000X1111010010X
mem[24338] = 6902
mem[11301] = 146085100
mem[16670] = 241293
mem[39056] = 28465500
mask = 0100111001100001011X01111XX1X110000X
mem[10597] = 2955
mem[3526] = 5645
mem[38272] = 1393278
mem[63734] = 16989989
mem[32589] = 1998889
mask = 1101110001XX0X11011100000X10X100X001
mem[7109] = 4012400
mem[3730] = 4340
mem[55473] = 37054781
mem[17575] = 28244143
mask = 1101XX000010010111110X0X010X1X0100XX
mem[164] = 1090
mem[44971] = 87374
mem[35957] = 69917
mem[48137] = 37681
mem[16907] = 9
mem[55055] = 4857988
mem[62050] = 4538397
mask = 0111010100100X1X11X0X1X0X1X0010011X0
mem[17767] = 218080
mem[64739] = 5445064
mem[18403] = 33120
mem[28015] = 1181
mem[27255] = 94833
mem[55707] = 4034965
mask = 0100011X01101110011110110001XX1XX00X
mem[29976] = 1829
mem[21782] = 140408214
mask = 11X1X10000X001X1X1X10X000110001111X0
mem[45597] = 195279796
mem[3940] = 8724
mem[5600] = 99763
mask = 000101X0001XX00XX01X11001X1110101010
mem[35164] = 539599
mem[33] = 6828
mem[338] = 361
mem[26055] = 280498
mem[5979] = 423
mask = X1X1X1X00100011101X100X0X11001101001
mem[20334] = 576099261
mem[164] = 470088
mem[37338] = 260
mem[24666] = 86628206
mem[38177] = 70429459
mem[19079] = 33310471
mask = 010101001010001XX1110101X1100100X10X
mem[47415] = 474737
mem[50667] = 923519906
mem[8525] = 291892
mask = 0011010X001001111X010X0X110X0XX10110
mem[3081] = 1994776
mem[22817] = 48165
mem[65043] = 1015796726
mem[2002] = 931073
mask = X11101000010X11111XX01X1X01XX1X01010
mem[53878] = 426269051
mem[58836] = 458776
mem[51632] = 3349
mem[1951] = 25839
mask = 1101000000100101111X00XX001010X11000
mem[1688] = 36794
mem[38076] = 8690250
mem[48682] = 12759
mem[59102] = 17947
mask = 0XX1111000111X01011101001X1101100001
mem[2380] = 23727
mem[20127] = 50725
mem[55966] = 279
mem[28904] = 94832222
mem[17300] = 793430
mask = 0101111000111X111111X0XX1XXX10X11X00
mem[31683] = 1571
mem[1497] = 26118620
mem[62990] = 6087
mask = 01XX11100011111111110000110100101X1X
mem[1745] = 930154
mem[39612] = 194652
mem[7348] = 24292
mem[36443] = 8831986
mask = 0101011001X0X011011X0101000010X00010
mem[18437] = 8885133
mem[51571] = 25947220
mem[24684] = 100343
mem[61233] = 65629221
mask = X10100000010X101111X00110101X000X010
mem[57904] = 858
mem[7126] = 26205833
mem[42675] = 23594416
mem[6132] = 69746846
mask = XX0111111XXX0X000110X0100X100010X100
mem[4175] = 59045186
mem[51044] = 45563
mem[65093] = 14538461
mask = 001X01010X1001XXX101X1000001100X0000
mem[32228] = 48985791
mem[19808] = 7963
mem[33555] = 1897
mem[6036] = 110245
mask = 1X01X10010100XXX11010001111010110100
mem[3940] = 180997393
mem[18897] = 102885
mem[21547] = 45355906
mem[11384] = 1092
mem[16907] = 74900995
mem[18273] = 792
mask = XX1X00000XX00111111100X1101X11010XX0
mem[38886] = 117201470
mem[57617] = 1650
mem[60198] = 528557
mask = 00X00X010X1101X1111X110111010X111001
mem[39417] = 26329479
mem[9836] = 3920
mask = 1X0111100010X1110XX10100110010010XX0
mem[27577] = 5734250
mem[24592] = 40150964
mem[7348] = 577807833
mem[39157] = 2216961
mask = 010101X001100011X111010X0X0X10100100
mem[16907] = 9911284
mem[6763] = 7845
mem[53378] = 16664801
mem[23591] = 1238
mem[23884] = 686
mem[34023] = 109445253
mem[26629] = 4910
mask = 1111110X0010X10101X100XX0111X0101010
mem[26629] = 902809352
mem[16043] = 247905220
mem[25435] = 4437
mem[12658] = 13392649
mem[50281] = 78445
mem[6132] = 121843
mask = 000101X10010001X1X0101XX011001101101
mem[52701] = 9996138
mem[22174] = 1105789
mem[34530] = 635830
mem[24563] = 189076832
mask = 0X0001X00110X110X1111011X0010111X0XX
mem[64006] = 3404359
mem[11106] = 870291581
mem[1388] = 4365021
mem[56627] = 2310
mask = 0X11010X0010011111010XX0X10X11X0000X
mem[26441] = 3006974
mem[22099] = 267743
mem[13410] = 226289
mem[11127] = 5468342
mem[25471] = 444
mem[2842] = 19968291
mem[49569] = 8100777
mask = 1XX101100100X111X111XX00001011001XX1
mem[40759] = 969559
mem[43461] = 170810
mem[22759] = 122156893
mem[9249] = 315038
mem[9017] = 535254
mask = 01XX0X00X0100111X10100110010001X11XX
mem[14193] = 300623996
mem[3042] = 58988
mem[5866] = 500068
mem[26340] = 568957
mem[9226] = 115146
mem[45014] = 1027
mask = 01X101X00X10001101X1XX10110X10000000
mem[9232] = 5846390
mem[28623] = 62795306
mem[8672] = 5330
mem[44719] = 12
mask = X11101000XX00111X101001101101101111X
mem[37856] = 3114
mem[11465] = 670194083
mem[33668] = 125194807
mem[53757] = 474126
mem[37271] = 6734
mem[21689] = 80
mask = 01010X10XX1000X1010X010XX0011X000111
mem[30935] = 1951970
mem[5542] = 163839
mem[58286] = 4804
mem[22759] = 15704559
mem[34729] = 69038452
mask = 11X1X100001001011111000X00110110X000
mem[7348] = 698
mem[7540] = 13006832
mem[55499] = 55312
mem[40165] = 10172139
mask = 0X11010X00X0011111X1X100XX010X000000
mem[54304] = 128679
mem[17738] = 37787
mem[49568] = 23845916
mask = X101X1100X1X0XX1X111010011001000XX00
mem[21547] = 41837207
mem[41959] = 1287497
mem[10388] = 557833173
mem[40939] = 59258
mem[59635] = 160415060
mask = 00001110X11000010011X11X01001000X011
mem[11012] = 933
mem[9226] = 322778
mem[2708] = 15241
mem[51604] = 1232396
mem[37704] = 549235
mem[53394] = 118650
mask = 1111010000X0011111X10111XX10X11X1001
mem[8719] = 865
mem[42780] = 9404
mem[7714] = 490968892
mem[27411] = 178429
mem[4013] = 778256751
mem[24646] = 224993
mem[24119] = 12948893
mask = 110101100011010111X101X1X00X10X000X1
mem[22200] = 11701561
mem[19493] = 6946
mem[21547] = 707
mem[62141] = 5531
mask = 0001010000X001111X010X000110101000X0
mem[18873] = 7124
mem[62690] = 390
mem[14650] = 1597312
mem[33518] = 97271197
mem[17726] = 123
mem[53868] = 496183
mask = 010011XX01X0X00X01100110XXX0X0000010
mem[40759] = 568531
mem[26050] = 118632
mem[27506] = 1757276
mem[1794] = 9437
mem[42971] = 3247467
mask = 011101010010XXXX11X1100XX0X000110011
mem[55443] = 1926868
mem[20253] = 310390
mem[40051] = 10098004
mem[49602] = 74457614
mem[35999] = 293411388
mask = 00000X00011X0110011X0X1101010X11X001
mem[17029] = 19099
mem[16319] = 48219
mem[7926] = 881
mem[42635] = 43370920
mem[50489] = 44446491
mask = 0111010000X0011XX1011100001100011X10
mem[38158] = 13958
mem[7540] = 56463
mem[62426] = 261236
mem[17737] = 68210
mem[23036] = 1212588
mask = 010X11100X1100111XX10000XX10011X1011
mem[39572] = 18806
mem[53737] = 107424
mem[34701] = 51036531
mem[51044] = 370881
mem[57322] = 171713754
mem[9931] = 68303
mask = X00X0101001X010111X11X011X001101XX00
mem[7998] = 8196
mem[58439] = 715569
mem[20011] = 33959
mem[22817] = 2951331
mem[9284] = 360266
mem[20587] = 7479
mask = 1011X10000100XX1X101X100011011011101
mem[17167] = 1273
mem[39792] = 184
mem[40414] = 423
mem[29780] = 10021
mask = 01XX1X100X100X01X111XX1010110X000111
mem[64138] = 247002
mem[34607] = 11573789
mem[49831] = 252109698
mem[17496] = 2025
mem[53331] = 29407
mem[53757] = 1146170
mask = 0101X11000X01101101X1101111X00100X11
mem[15584] = 109310
mem[18788] = 514
mem[44841] = 10362
mem[39867] = 162
mem[21782] = 648
mask = 01110000XX10X111111101X0X01XX1010011
mem[55633] = 2403171
mem[50246] = 17873286
mem[23210] = 123878
mem[7324] = 1272
mem[52572] = 187
mem[7411] = 129047
mask = 0001010100100111X001110X001X011111X0
mem[7780] = 5943
mem[17118] = 159757637
mask = 01110X0000100XX011011000X0111X1XX111
mem[6802] = 1409620
mem[57157] = 61417503
mem[46419] = 170670
mask = 11X10100X0100111010X01001110101111X1
mem[35] = 1062
mem[40395] = 3284
mem[61838] = 10344532
mem[25489] = 24209
mem[58884] = 8035
mem[3515] = 1195530
mask = 0001XX000010000XX0100101X0X0X0X01010
mem[21647] = 759
mem[28088] = 9889674
mem[64138] = 20143340
mask = 110X111000110101X11101001X00100010X0
mem[27804] = 18658
mem[8972] = 4279393
mem[17029] = 139910
mask = X01101000010X111X10X0111010X0011111X
mem[25266] = 537078836
mem[28845] = 25137
mem[51543] = 341944402
mem[2901] = 1319
mem[65349] = 6742
mask = X10101000XX0011101X101X00011X11X1110
mem[11535] = 965
mem[55453] = 3425244
mem[64739] = 43855
mem[19823] = 76844
mem[9063] = 26582792
mask = XXX10110X11101110111010010101100XXX0
mem[57255] = 4745
mem[26392] = 9886132
mem[11710] = 8127
mem[27551] = 12006
mem[59552] = 747
mem[44649] = 14163019
mask = 0101X11000110101111100X010101X101X00
mem[1937] = 1208
mem[5600] = 80957
mem[49042] = 7721225
mem[11363] = 172265265
mem[7012] = 1034871490
mask = 0XX101010X10011111010X10111111011010
mem[20626] = 12618
mem[37616] = 4950
mem[62602] = 29344259
mem[3244] = 966536375
mask = X1010110101001X1X10100010X0111X11000
mem[61936] = 42236
mem[20940] = 8323
mem[42570] = 127294805
mem[5498] = 1291
mem[20571] = 216808
mem[5540] = 150462686
mask = 010X1110XX10000101X0X11011111X100X01
mem[33347] = 23707
mem[24911] = 3176
mem[516] = 179
mem[4357] = 25149741
mem[13155] = 2062177
mem[27683] = 13845149
mem[22099] = 92648
mask = 110101X0X010010111X1000XX1X01000X10X
mem[7540] = 956
mem[25117] = 687282165
mask = XX000X0100X10X01110100011000111111X1
mem[35042] = 207010
mem[6214] = 230217
mem[65460] = 3002
mask = X111010000100111X110111XX01001X1X11X
mem[8618] = 409447383
mem[37322] = 9395
mem[58474] = 34280
mem[51176] = 121628193
mask = X10111100010111101X1X100X100X0010000
mem[50232] = 1227
mem[16115] = 853301
mem[27648] = 14015878
mask = 0X0X11100X1000010X1XX11011110X0X0010
mem[805] = 29195
mem[51298] = 442952581
mem[7348] = 1057
mem[59031] = 2086182
mem[11535] = 114747
mem[995] = 26044151
mask = 010101X0X0100XX111110101X000101010X1
mem[11384] = 52829
mem[49574] = 2181900
mem[24911] = 2487
mem[5436] = 36138
mem[23723] = 1317
mem[38886] = 49858
mask = X0X1X10XX0100111X111010000100X0X1011
mem[56459] = 6922678
mem[230] = 903809746
mem[5620] = 14477
mem[50090] = 1917155
mask = 010X01X011100XX0111100010110X0010111
mem[60707] = 12378
mem[5139] = 185
mem[33055] = 19612
mem[48694] = 143199644
mem[62012] = 11298
mem[46961] = 217987895
mask = X1001110011X00010XXX01001X1001100010
mem[13666] = 52961
mem[7377] = 134144120
mem[58224] = 211536
mem[36878] = 173058887
"""

}
