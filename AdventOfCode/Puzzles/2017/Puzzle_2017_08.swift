//
//  Puzzle_2017_08.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2017_08: PuzzleBaseClass {
    private var puzzleInput: [[String]] = []

    public func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    public func solveBothParts() -> (Int, Int) {
        let puzzleInputString = Puzzle_2017_08_Input.puzzleInput
        puzzleInput = puzzleInputString.parseIntoMatrix()
        return solvePuzzle()
    }

    private func highValue(dict: [String: Int]) -> Int {
        var retval = 0
        for (_, v) in dict {
            if v > retval {
                retval = v
            }
        }

        return retval
    }

    private func solvePuzzle() -> (Int, Int) {
        var highestValue = 0
        var dict: [String: Int] = [:]
        for line in puzzleInput {
            let register = line[0]
            let opcode = line[1]
            let incValue = (opcode == "inc" ? line[2].int : -(line[2].int))
            let testRegister = line[4]
            let condition = line[5]
            let conditionValue = line[6].int
            if dict[register] == nil {
                dict[register] = 0
            }

            if dict[testRegister] == nil {
                dict[testRegister] = 0
            }

            if let testRegisterValue = dict[testRegister] {
                var doIncDec: Bool
                switch condition {
                case "==":
                    doIncDec = (testRegisterValue == conditionValue)
                case "!=":
                    doIncDec = (testRegisterValue != conditionValue)
                case "<":
                    doIncDec = (testRegisterValue < conditionValue)
                case "<=":
                    doIncDec = (testRegisterValue <= conditionValue)
                case ">":
                    doIncDec = (testRegisterValue > conditionValue)
                case ">=":
                    doIncDec = (testRegisterValue >= conditionValue)
                default:
                    doIncDec = false
                }

                if doIncDec {
                    if let reg = dict[register] {
                        dict[register] = reg + incValue
                    }
                }
            }

            let highestValueNow = highValue(dict: dict)
            if highestValueNow > highestValue {
                highestValue = highestValueNow
            }
        }

        return (highValue(dict: dict), highestValue)
    }
}

private class Puzzle_2017_08_Input: NSObject {
    static let puzzleInput_test1 =
"""
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10
"""

    static let puzzleInput =
"""
v inc 523 if t == 6
qen dec -450 if lht != 10
jyg dec -378 if lb != -6
k inc -994 if z < 6
gjr inc -698 if hbq < 9
gjr inc -422 if pv <= 9
lb dec -17 if t != -3
pv dec -627 if u > -3
pv inc -84 if jpc != 2
erl inc -531 if kfw > -10
kfw dec -751 if tu != 9
erl dec -536 if g != 0
tu inc -813 if ee >= 0
mpj dec -929 if u < -1
uz inc 565 if lb > 8
ml inc -357 if uz == 565
qen inc 800 if erl > -540
lht dec -238 if tu == -811
z dec 16 if hbq >= 10
v inc 308 if osr < 4
u dec -628 if u < 7
u dec -606 if pv >= 553
bmm dec -498 if hbq < 7
mpj inc -517 if iwd >= 4
jpc dec -284 if z < 10
v inc -9 if v <= 311
gjr dec -759 if ml <= -357
k inc -733 if hbq == 0
ml dec -709 if hbq < 4
iwd dec -148 if mpj > -6
k inc -84 if fg == 0
z inc -89 if lb <= 14
k dec 836 if v <= 300
hbq inc 89 if uz < 570
iwd inc -54 if t != -8
pv inc -663 if v == 299
k dec -888 if ee < 2
iwd dec 567 if g == 0
fg inc 156 if fg == 0
jyg dec -123 if lb > 16
iwd dec 859 if cj >= 9
hbq dec 521 if hbq < 83
hbq dec 756 if lb < 25
u dec -320 if mpj > -6
jpc inc 656 if k < -1758
lht dec 924 if jpc > 936
kfw inc -874 if t == 0
bmm inc 602 if mpj <= -5
lht dec 478 if qen < 1258
jpc inc -580 if lht > -1398
ee dec -707 if uz > 558
k dec 113 if lb <= 18
hbq inc 792 if g <= 2
jyg inc -516 if z >= -8
hbq dec -841 if iwd >= -473
z dec 457 if v > 295
iwd inc -389 if bmm != 492
uz inc 171 if v > 298
gjr inc 352 if ee < 709
uz dec 861 if mpj < 7
qen dec 571 if ml != 344
erl dec 584 if jyg < -11
erl dec 673 if bmm != 496
gjr dec 1 if ee > 709
pv inc -481 if g >= -6
u dec 846 if v != 301
g inc 178 if uz == -125
v inc -648 if jyg <= -9
osr dec 700 if lb <= 23
cj dec -627 if g < 185
erl dec 437 if qen <= 688
g inc -645 if cj <= 631
kfw dec 182 if fg < 158
k inc -562 if u > 94
lht inc 469 if hbq <= 974
gjr inc -547 if v >= -356
gjr dec 603 if pv != -611
kfw inc 201 if gjr >= -1157
iwd dec -455 if uz == -116
jyg dec 339 if qen != 682
pv inc -504 if qen != 685
t inc -558 if g != -469
lb dec 148 if osr <= -695
ee dec -442 if fg >= 155
lht dec -550 if t == -558
lb inc 67 if fg >= 157
iwd dec 634 if jyg <= -350
pv inc -989 if lb != -136
uz dec 795 if uz == -125
gjr inc -441 if z <= -453
erl inc -997 if gx >= -3
hbq inc 871 if cj < 631
qen inc 733 if ee != 1154
lb inc 305 if t == -558
lht inc -720 if uz < -916
g dec 909 if bmm <= 494
lb dec 197 if tu > -817
t inc -803 if t <= -552
iwd inc -989 if iwd == -1501
v dec 7 if t != -1367
gx inc 31 if ml < 362
kfw dec -538 if hbq == 1827
v inc 717 if iwd >= -1497
z dec 945 if tu != -811
iwd dec -600 if erl >= -3222
mpj dec -807 if gx != 39
cj dec 677 if t > -1371
bmm dec -89 if ml == 352
jpc inc -534 if t > -1367
u inc -405 if ee >= 1154
erl dec 457 if lb <= -14
uz inc -58 if gjr == -1606
iwd inc 415 if pv > -2104
bmm dec -788 if qen < 1417
erl dec -270 if iwd != -472
g dec -253 if g < -463
lht inc -849 if u != 102
uz inc -98 if bmm > 1376
jpc inc -524 if erl == -3409
ee dec -289 if lb > -14
gx dec 666 if fg <= 146
kfw inc 209 if mpj == 807
ml dec 487 if bmm <= 1381
pv dec 83 if fg >= 152
fg inc 688 if tu >= -803
iwd inc -867 if ee >= 1147
kfw dec -820 if ee >= 1148
erl inc 845 if gx < 40
g inc -401 if ee <= 1156
lb inc -927 if mpj >= 798
jpc dec -494 if gx != 33
kfw inc -728 if gjr >= -1595
ee dec -33 if g == -615
hbq dec -61 if iwd == -1348
tu inc 535 if u >= 105
jpc inc -961 if gjr <= -1591
kfw inc -256 if pv < -2170
uz inc -942 if mpj < 811
pv dec -711 if ee > 1175
uz dec 291 if z <= -1402
fg dec -339 if osr == -700
lb inc -61 if bmm < 1384
u dec 249 if erl > -2571
uz inc 968 if gx > 25
lht inc -696 if jpc > -586
jyg inc 304 if erl < -2565
mpj inc -365 if pv >= -1466
k inc 562 if qen > 1403
v inc -874 if jyg != -361
osr inc 700 if k > -1874
v inc -366 if fg <= 489
erl inc -626 if g == -615
g dec -962 if qen != 1403
lb dec 615 if u != -155
ml dec 681 if jpc < -585
g inc -316 if tu > -822
iwd inc 153 if u >= -143
osr inc 534 if z >= -1411
fg dec -350 if t > -1362
gjr dec -800 if cj != -57
pv inc -617 if ml >= -140
qen dec -133 if t != -1352
ee dec 630 if ml >= -129
jyg inc 861 if z > -1411
gjr inc -98 if t != -1354
u dec 598 if osr == 534
fg dec 21 if iwd >= -1354
tu dec -291 if g <= 36
bmm inc 664 if lb <= -1624
gx inc -178 if erl != -3190
gjr dec 660 if tu >= -529
tu dec 37 if osr < 536
jpc inc -115 if lht == -1799
tu dec -815 if hbq <= 1904
lht inc -160 if pv != -2083
t dec 588 if cj < -41
z dec 225 if jyg == 505
qen inc 207 if ml != -135
v dec 321 if z > -1405
jpc inc -551 if gx > 28
tu dec -373 if osr > 526
cj dec -519 if lb > -1622
tu inc 114 if k != -1869
osr dec 847 if lht < -1789
pv inc -640 if jpc < -1246
mpj inc 733 if t <= -1948
t dec -305 if k >= -1871
lb dec -551 if lb >= -1627
hbq inc -688 if gjr >= -1559
jyg inc -757 if bmm != 2031
g inc 297 if bmm != 2049
lb inc -86 if ee < 1187
iwd dec 893 if kfw >= 468
cj inc -46 if hbq == 1210
uz inc 785 if lht > -1804
lb inc -642 if gx == 31
cj dec -636 if hbq > 1209
tu dec 856 if uz >= -408
z dec 152 if jpc <= -1250
k dec -330 if lb < -1798
jyg dec 30 if gjr >= -1549
osr dec -758 if ml >= -137
hbq inc 451 if g <= 335
ee dec 404 if iwd < -2240
z dec -960 if mpj > 1182
tu dec 981 if erl <= -3188
kfw inc 706 if jpc == -1251
v inc -642 if gx != 31
pv dec -130 if k <= -1536
mpj inc -569 if bmm > 2043
osr dec 847 if qen <= 1549
qen inc 56 if z < -1546
hbq inc -10 if g != 322
v inc 867 if ee >= 788
ee inc -974 if t == -1949
fg dec 114 if lht < -1808
gx dec -389 if erl == -3190
mpj inc 673 if cj == 540
iwd inc 973 if jpc < -1250
bmm inc -975 if mpj < 1858
tu dec -751 if uz < -397
uz inc 11 if u >= -753
jyg dec -663 if v == -834
qen dec 551 if mpj != 1848
k dec 504 if lht < -1789
bmm dec 954 if jyg != 413
lht dec 659 if jpc == -1251
osr dec 391 if qen >= 1594
qen inc 548 if kfw < 1177
t dec -947 if bmm > 1057
hbq inc 254 if iwd < -1263
tu dec -696 if cj == 544
iwd inc 808 if k > -2052
uz inc 859 if lht <= -2450
qen dec 25 if v < -832
qen dec 708 if ml <= -126
k dec -640 if uz < 461
tu dec -609 if ml <= -130
iwd inc -620 if k <= -2044
v dec -558 if iwd > -1087
iwd inc -132 if cj >= 539
gjr dec -923 if ee >= -200
gx dec 180 if kfw != 1173
gjr dec 716 if cj > 532
pv dec -778 if pv == -2593
tu inc 427 if v >= -278
lht dec 421 if cj < 544
u inc -313 if g > 323
erl inc 300 if erl != -3184
t dec -623 if gjr < -1341
qen dec -618 if uz != 465
osr inc 832 if u > -1065
gjr dec 896 if gx > 237
lb inc 886 if erl != -2900
ee dec -693 if v >= -279
jpc dec 462 if kfw != 1171
ee dec 433 if lht > -2881
tu dec 817 if pv < -1808
lht inc 382 if gx == 240
erl inc 806 if pv >= -1810
u inc -85 if erl != -2890
z inc -208 if lht >= -2497
tu inc 252 if osr >= 45
lht dec 157 if gjr < -2237
z dec -977 if z == -1762
fg inc 235 if lht > -2662
lb dec -379 if t != -376
cj inc -710 if lb == -538
lb dec -116 if iwd < -1220
u dec -661 if bmm < 1073
gx inc -555 if gx < 233
jpc dec 904 if fg > 1051
u inc -574 if kfw > 1165
k dec -993 if cj != -169
gjr dec -694 if cj == -170
k dec 819 if erl < -2887
fg inc 387 if erl == -2890
lb inc 256 if g <= 319
kfw inc -871 if osr == 39
lb dec 765 if lb <= -531
fg inc -881 if erl > -2897
t inc -958 if qen != 2033
ee dec 481 if g < 327
iwd dec 15 if gjr == -1553
fg inc -860 if lht == -2654
erl dec -599 if lb == -1303
kfw dec 588 if fg >= -300
gjr dec 419 if gx >= 235
osr dec 386 if lb <= -1301
cj inc -567 if tu > -118
t inc 55 if pv <= -1814
z dec 667 if z == -785
kfw dec -804 if u == -971
tu dec -282 if g == 328
ml dec -126 if tu >= 160
pv dec 66 if cj >= -176
kfw dec 612 if ee != 55
ee dec 453 if hbq >= 1904
jpc dec -311 if erl > -2283
k inc -813 if ee <= -380
z inc -900 if bmm == 1055
jyg inc -801 if mpj == 1858
gjr dec 375 if iwd < -1224
u inc 5 if bmm == 1064
kfw dec -66 if ml == -135
uz dec -492 if ee > -399
iwd inc 723 if k >= -2685
v inc -639 if fg > -303
tu dec 751 if cj >= -177
bmm dec 680 if jyg > 408
iwd dec 910 if mpj > 1850
fg inc -972 if ee == -389
k dec 512 if bmm != 391
ee dec 48 if gjr != -2354
kfw dec -825 if k != -3207
ee inc -182 if osr < -346
u dec -581 if ml != -130
lht inc -178 if mpj <= 1857
uz inc 40 if hbq > 1900
uz inc 548 if mpj >= 1842
k dec -504 if z == -1452
qen dec 373 if hbq >= 1904
bmm inc -387 if bmm <= 382
kfw dec 112 if t < -1279
k inc 405 if bmm != 383
kfw dec 941 if cj < -164
ee inc 447 if pv <= -1872
lb inc 965 if uz < 1552
k inc 807 if u < -380
cj inc -711 if gx >= 248
kfw inc -29 if uz > 1550
osr dec 242 if lb <= -337
ee dec -584 if hbq > 1914
qen inc 717 if osr <= -587
v inc -837 if mpj <= 1850
cj inc 943 if gjr < -2346
lht dec -506 if ee < -168
k dec -831 if pv > -1889
g inc -643 if t == -1289
hbq inc 228 if bmm <= 386
mpj dec -830 if hbq <= 2133
jyg dec -237 if mpj > 2674
v inc 630 if hbq > 2128
gx inc -764 if iwd >= -507
jyg inc -792 if cj >= 774
k dec -255 if tu == -593
kfw inc -789 if lht == -2326
erl inc -773 if bmm != 388
uz inc 175 if osr != -598
qen inc -132 if cj <= 781
v dec -372 if fg < -1266
cj inc 690 if fg != -1262
lht dec -629 if jyg != 650
tu inc 814 if z >= -1460
jpc inc 712 if osr < -584
erl dec -193 if gx < -532
g inc -514 if k >= -398
jyg dec 235 if fg < -1265
u dec 925 if jpc != -1907
qen dec -351 if kfw > -1051
gx inc 728 if hbq != 2133
jyg dec 53 if kfw >= -1053
ml inc 528 if v > -743
tu dec 700 if erl >= -3068
ee inc 140 if pv < -1889
pv dec 988 if erl == -3064
jpc inc 166 if gx < -522
bmm inc -718 if pv != -2873
z dec 264 if jpc == -1739
pv inc -60 if uz >= 1718
iwd inc 629 if jpc != -1746
k dec -49 if uz < 1732
fg dec 37 if uz == 1731
g inc -825 if kfw != -1046
z inc -157 if bmm != -326
iwd inc 299 if uz < 1728
lht inc 737 if jpc < -1731
jyg inc 313 if k < -345
cj dec 748 if erl != -3064
ee inc 496 if osr >= -594
cj dec 278 if hbq < 2138
cj dec 779 if t < -1285
g dec -972 if z > -1883
tu inc 36 if jyg != 675
pv inc -706 if cj > 1186
t dec -711 if t != -1282
ml dec -451 if kfw < -1040
fg inc 517 if fg < -1259
ee dec -524 if cj < 1195
ee inc -628 if u <= -1302
v dec -515 if t != -1283
jyg inc -345 if v > -235
g inc -195 if t <= -1276
lb dec -506 if osr < -580
hbq inc 320 if qen > 2593
t dec 548 if jpc >= -1739
erl inc 272 if bmm == -334
hbq inc 742 if fg <= -742
ee inc -307 if uz >= 1716
u dec 487 if kfw > -1051
ee inc -359 if pv < -2928
uz dec -930 if u == -1797
kfw inc -764 if k >= -346
g dec -134 if hbq <= 3187
lht dec -790 if jyg == 675
jpc inc -58 if uz > 2653
k inc 658 if hbq >= 3193
g dec -411 if mpj > 2671
jpc inc -644 if hbq != 3200
k inc -422 if k != 309
osr inc -212 if bmm == -334
gjr inc -922 if t <= -1828
cj inc -282 if ee >= -439
gjr dec 554 if fg < -748
lb inc 826 if fg != -752
osr dec -344 if hbq < 3199
lht inc 6 if v != -234
kfw dec 592 if hbq >= 3188
u dec 364 if ml > 315
gjr dec 673 if pv != -2939
fg dec 77 if u != -2166
osr dec 592 if cj >= 1185
ml dec -229 if k == -110
v inc -370 if gjr < -4492
z dec -536 if ml < 545
lht dec 525 if lht > -797
fg inc 349 if uz != 2647
erl dec -670 if cj != 1184
qen dec -396 if ml > 541
cj inc 842 if erl < -2118
gjr inc 139 if hbq == 3195
mpj dec 841 if kfw > -2401
pv dec -47 if gjr <= -4361
ml dec 697 if pv != -2935
z inc -562 if uz != 2655
u inc 426 if kfw == -2400
fg inc 124 if mpj > 1828
cj inc 672 if qen == 2993
v inc 386 if gx == -524
u dec 373 if hbq >= 3192
ml inc -661 if cj < 2704
pv dec 422 if erl >= -2125
jpc dec -768 if qen >= 2988
tu dec -918 if qen <= 2997
g inc 21 if pv == -3351
v dec 677 if gjr < -4354
uz dec 533 if pv < -3347
ml inc -549 if mpj <= 1841
z dec 84 if lb <= 996
lb dec 209 if qen != 2999
v inc 367 if jpc >= -1678
k inc -169 if iwd >= 419
pv inc 951 if uz <= 2130
osr dec -54 if g >= 189
z dec -426 if z > -1964
fg dec -992 if cj >= 2690
lb inc -434 if gjr <= -4349
jyg inc -155 if u < -2109
iwd dec -738 if k <= -272
hbq dec 262 if mpj != 1830
t dec -43 if jyg < 680
fg dec -408 if pv > -2410
v inc -250 if erl == -2122
mpj inc 429 if u > -2114
jyg dec 855 if jyg >= 675
ml dec 690 if pv != -2404
hbq inc -69 if cj < 2700
bmm dec 359 if jyg > -184
jpc dec 190 if cj > 2696
qen inc -291 if osr < -999
iwd dec 803 if bmm == -693
mpj inc -180 if t >= -1790
qen inc 273 if jyg > -183
t dec 692 if erl <= -2125
k inc 91 if lht < -1314
pv dec 240 if z < -1526
z inc 800 if qen >= 3269
k inc -554 if gx != -518
cj inc -943 if lht >= -1325
t dec 784 if u >= -2114
kfw dec 108 if ml <= -2051
hbq inc 389 if pv == -2640
lht dec 89 if erl > -2129
fg inc 391 if hbq != 3253
kfw dec -84 if v == -775
qen dec -337 if u >= -2116
cj dec 255 if k > -744
t inc -506 if hbq > 3257
iwd dec 931 if mpj > 2079
mpj inc 79 if fg != 1052
kfw dec 208 if erl == -2122
uz dec 141 if hbq > 3249
erl inc 630 if k != -742
kfw inc 101 if erl >= -2130
u inc -107 if cj != 1501
gjr dec -559 if gx != -520
iwd dec -866 if u != -2098
iwd dec 334 if jpc == -1863
t inc -224 if ee == -446
hbq inc 71 if bmm <= -685
cj dec 380 if v > -782
bmm inc -832 if lb >= 350
g inc 503 if qen >= 3603
fg dec 519 if cj == 1121
mpj inc -621 if fg < 533
jpc inc -751 if kfw > -2625
jpc inc -934 if bmm != -1533
ee inc -98 if osr < -988
jyg dec -61 if jpc <= -3546
jyg inc -939 if lb < 354
mpj inc -598 if tu < 440
lb inc 969 if gjr > -3805
bmm inc 977 if k <= -739
jyg inc 859 if gjr >= -3802
kfw dec 958 if k <= -739
tu dec -336 if gx >= -518
lb inc 270 if osr != -994
gx dec -338 if bmm <= -551
u dec -341 if u < -2107
u dec -790 if t != -2805
uz dec -805 if gjr == -3798
mpj dec -479 if tu == 439
lb inc -223 if jpc < -3557
fg inc -188 if mpj != 1425
ml inc 293 if k == -742
erl inc 671 if gx != -517
z dec 191 if erl > -1459
kfw dec -354 if lht < -1413
ee dec 442 if g > 694
v dec -663 if k != -747
z dec 160 if kfw <= -3582
jpc dec 845 if kfw != -3569
qen dec 337 if ml == -1759
kfw inc 693 if hbq <= 3332
t dec -857 if kfw < -2886
t inc 632 if z < -1723
hbq inc 157 if gx < -514
qen inc -90 if mpj < 1419
z dec 821 if pv >= -2644
gjr inc 11 if g >= 697
cj inc -870 if erl > -1455
hbq dec 525 if k < -737
z inc -327 if ee != -996
hbq inc 616 if v <= -109
hbq inc -77 if z <= -2865
bmm dec 834 if uz != 2791
jyg dec -415 if u >= -972
k dec -974 if cj == 251
gjr dec 53 if jyg < -198
kfw dec 142 if g <= 699
kfw inc 534 if lht != -1402
ml dec 537 if ee < -981
erl inc 976 if v < -116
ee inc -501 if ml == -2298
gjr dec -721 if v != -109
qen dec 961 if gjr != -3124
jpc dec -875 if k > 223
kfw inc -678 if gx == -524
bmm dec 304 if qen != 2301
cj dec -574 if ml > -2299
jyg dec 967 if jyg != -207
t inc -957 if qen != 2300
iwd dec 602 if ml < -2295
osr dec -979 if osr < -993
hbq inc 94 if lht == -1407
lht dec -404 if cj > 823
fg dec 250 if iwd >= -632
jpc dec 116 if u <= -968
hbq inc -814 if u >= -973
g dec -130 if lht < -1000
pv inc 639 if jpc >= -3632
pv dec 706 if qen < 2310
jyg dec 996 if jyg < -1157
iwd inc 295 if tu != 439
pv dec -645 if z != -2869
cj inc 728 if z == -2870
mpj inc -833 if lht != -1006
z dec 802 if pv >= -2697
ml dec 660 if u <= -981
tu dec 311 if qen > 2313
u inc -664 if tu == 439
gx dec -96 if iwd >= -645
g inc 838 if ml == -2289
ee dec 55 if t <= -3747
erl inc -296 if g != 836
g dec -253 if z > -2872
tu dec -671 if gjr > -3128
qen inc -57 if cj != 1562
iwd inc -157 if erl <= -1744
uz dec -700 if ml != -2292
pv inc 650 if tu == 1120
ee inc -847 if hbq > 3586
mpj inc -242 if erl <= -1745
tu inc -410 if qen >= 2255
hbq dec 409 if g == 1084
lht dec 667 if erl != -1740
jyg inc -32 if gjr < -3113
jyg dec -972 if gx < -429
mpj inc 996 if gjr == -3122
osr inc 808 if erl == -1747
z dec 601 if fg != 535
gjr dec -166 if jyg > -2197
gx inc 718 if t == -3752
erl inc 94 if t != -3762
jyg dec 941 if hbq < 3176
hbq inc -710 if v != -114
t dec -986 if gx > 299
jyg dec -20 if tu != 1101
uz inc -653 if jpc == -3640
ee inc -283 if lb > 1588
g inc 601 if v > -118
g dec -674 if iwd == -799
gjr dec -959 if k < 241
mpj dec -665 if ml > -2291
pv inc 962 if qen < 2240
lb dec 292 if z != -3470
ml inc 422 if kfw > -3034
k inc -511 if v > -123
iwd inc -847 if iwd != -793
z dec 436 if gjr > -1999
cj dec -58 if pv > -2710
erl dec 631 if jpc >= -3638
jpc inc 206 if jpc < -3625
hbq inc 85 if qen > 2243
erl dec 966 if hbq > 2549
osr inc -556 if gx != 290
erl inc -602 if kfw >= -3028
gx dec 629 if g != 2359
fg inc 347 if tu == 1110
cj inc -722 if ml < -1864
uz dec -490 if ee >= -2164
pv dec 126 if uz < 3496
fg inc -987 if k <= -278
erl dec -91 if mpj < 354
gx dec -194 if kfw == -3024
ee dec 171 if t <= -3747
gx dec 442 if ml == -1874
t inc -17 if uz > 3480
ml inc -867 if qen == 2248
gx inc -711 if g != 2364
cj inc -299 if lht >= -1676
bmm inc 432 if erl > -3758
bmm dec 746 if ml <= -2733
ml inc 117 if lht != -1660
pv inc 684 if gx >= -662
t dec 656 if jpc > -3437
bmm inc -176 if lht > -1675
g dec 925 if cj <= 592
z dec -485 if jpc == -3428
uz inc -921 if gx <= -672
gx dec 568 if jyg < -2169
t dec 829 if qen >= 2246
ml inc 511 if v >= -118
qen dec -471 if tu != 1104
iwd dec -56 if v > -118
jyg inc 897 if g >= 1425
gjr inc -79 if iwd > -1595
bmm dec 623 if kfw >= -3022
u dec 596 if tu > 1111
iwd dec 705 if ee > -2341
osr inc -481 if jpc != -3428
gx dec 103 if uz >= 3480
tu inc 602 if hbq == 2555
kfw dec -39 if t < -5246
gjr dec -769 if mpj < 353
ml inc 358 if k < -269
kfw inc -237 if qen <= 2719
lht dec 895 if lb < 1305
mpj dec 368 if erl > -3767
ee inc 377 if g >= 1431
bmm inc 244 if ee == -1968
lb dec -410 if mpj <= -17
pv inc 814 if kfw > -3230
fg dec 127 if iwd == -1590
fg dec -36 if t > -5245
jpc dec -630 if mpj < -8
pv inc 744 if bmm == -2608
kfw dec 772 if fg == -240
tu dec -295 if jpc == -2798
tu inc -961 if fg < -246
cj inc 91 if ml > -1756
qen dec 872 if fg != -249
ee inc 56 if ee <= -1963
lb dec 143 if v == -116
pv inc -969 if pv > -1275
uz inc -299 if mpj < -16
lht dec -871 if gx < -1345
jyg inc -833 if ee >= -1909
mpj dec -70 if k == -279
mpj inc 117 if gjr == -1304
tu dec 131 if ml > -1765
cj inc -208 if ml != -1759
pv dec -45 if cj >= 477
t inc -581 if k >= -285
kfw dec 639 if kfw == -3994
gjr dec 135 if ee < -1899
lht inc -842 if lb > 1561
k inc -594 if lht != -3397
ml dec 217 if z < -3420
bmm dec -682 if ee < -1907
fg inc 806 if fg < -247
mpj dec 511 if mpj > 169
u dec 292 if u >= -1641
gjr inc 757 if ee > -1916
k inc -518 if g >= 1430
jyg dec -154 if osr != 797
k dec -776 if g < 1438
g inc 171 if ee >= -1913
pv inc -913 if jyg != -1950
iwd inc 891 if gjr != -683
t dec -980 if erl == -3761
pv dec 616 if jyg <= -1947
ee dec -798 if ml > -1982
qen dec 500 if hbq < 2551
osr dec 747 if erl <= -3759
tu dec -328 if lb == 1565
bmm inc 262 if v != -116
kfw dec 695 if jyg <= -1954
mpj inc -563 if gx >= -1340
z inc 30 if k >= -621
gx dec 913 if ml > -1975
bmm dec 77 if bmm == -1926
bmm inc 677 if erl != -3761
cj dec -894 if g < 1606
ee dec 538 if fg >= -242
osr dec -737 if ml != -1963
ee dec 114 if u < -1934
tu inc -658 if qen < 1847
pv dec -434 if jpc <= -2792
kfw dec -426 if lht == -3404
osr dec -726 if erl >= -3759
lb dec -45 if g >= 1604
lb inc 263 if jyg < -1951
ml dec 693 if ee <= -1642
z inc 547 if kfw > -5331
fg dec 867 if k <= -608
v dec -863 if lht != -3399
u dec 778 if qen > 1853
erl inc -219 if erl <= -3757
jyg dec 301 if hbq == 2555
iwd dec 299 if gjr > -689
g dec -133 if jyg <= -2253
v dec 89 if erl < -3986
t inc -598 if lht < -3404
mpj dec 219 if cj >= 1366
mpj inc 781 if osr < 788
cj inc 740 if erl != -3979
hbq dec 536 if qen == 1847
erl inc 548 if ee != -1650
t inc -151 if iwd != -989
t dec -597 if jyg <= -2266
tu dec -356 if lb > 1864
g inc -397 if uz >= 3178
ml dec 773 if kfw > -5335
qen inc -805 if ml > -3443
erl dec 460 if t > -5612
osr dec 735 if cj < 2112
z dec 493 if ml == -3439
gx inc -361 if fg == -1107
k dec 186 if osr < 56
z dec 982 if uz != 3177
iwd inc -984 if lht != -3402
pv dec 856 if gx > -2612
tu dec 71 if z <= -3824
t dec -385 if g >= 1340
ee inc -429 if cj <= 2108
mpj inc 68 if lb == 1868
k inc 483 if bmm < -1997
kfw inc 611 if jpc == -2798
g dec -18 if erl >= -3893
z dec 968 if lht != -3403
lb dec 717 if osr <= 51
v dec 577 if kfw <= -4712
z dec 604 if z > -4805
jpc inc -476 if fg < -1102
gjr dec 177 if gjr != -678
kfw inc -520 if osr < 55
bmm inc 439 if v != 175
qen dec -843 if g < 1361
k inc 321 if iwd >= -1977
jpc inc 670 if ee == -2086
bmm dec -978 if jyg > -2250
fg inc 998 if jpc != -3264
bmm inc -158 if bmm == -1564
gjr inc -304 if pv == -3333
osr dec 743 if fg >= -105
qen inc 449 if erl <= -3902
jyg dec 45 if ml < -3436
osr dec 773 if jyg <= -2296
osr dec 656 if cj >= 2104
ml inc -70 if fg > -106
kfw dec 695 if g >= 1354
uz dec -631 if mpj != 177
bmm inc 736 if ml > -3430
qen inc 315 if fg < -112
lht inc 856 if uz == 3820
uz inc -825 if u != -1935
hbq dec 622 if gjr <= -1161
k dec 16 if ee > -2083
tu dec 708 if z < -5394
ee inc -946 if osr == -1382
z dec 656 if hbq > 1392
ee dec -253 if bmm != -1729
gx dec -449 if jpc >= -3283
mpj inc 142 if uz < 2996
gx dec -615 if v >= 161
v dec -310 if pv > -3341
erl dec 174 if k >= -337
kfw inc -59 if erl == -4066
pv inc 765 if t <= -5213
gjr inc 862 if ml < -3430
gjr dec -337 if lb <= 1157
v inc -114 if bmm <= -1716
fg inc -278 if iwd == -1982
osr inc -350 if jpc <= -3271
pv dec -885 if pv < -2563
jpc dec -224 if g == 1359
g dec 793 if gx != -1557
k inc -874 if v == 366
k inc -540 if ee < -2770
tu dec 746 if tu >= 1773
bmm dec 152 if v > 367
lb dec -557 if hbq == 1397
u inc 659 if erl >= -4075
gx inc 807 if kfw != -5993
jpc dec -472 if lht < -3405
v inc -326 if osr > -1726
lht inc -80 if cj != 2117
gx inc -492 if t == -5219
u inc -32 if fg >= -391
tu inc 149 if k >= -1754
lb inc 828 if fg > -388
bmm inc 216 if osr < -1733
lb inc -99 if z <= -6048
kfw dec 186 if u > -1306
v inc -550 if jyg == -2302
ml dec -165 if qen != 1877
osr inc 66 if fg >= -388
uz inc 953 if gx >= -1227
pv dec 344 if k < -1755
gx dec -44 if iwd >= -1982
erl dec 885 if k >= -1754
gjr dec -737 if iwd < -1983
lht dec -333 if v >= -183
iwd inc -737 if qen >= 1894
qen dec -220 if gx <= -1186
jyg inc 85 if k < -1739
osr dec 544 if mpj != 307
qen dec -420 if z != -6062
fg dec 694 if jyg != -2220
fg inc 978 if cj == 2107
lht inc -651 if lht >= -3487
osr inc -813 if mpj < 317
g dec 297 if lht < -4142
jyg inc 443 if iwd >= -1982
cj inc 406 if cj != 2099
z dec 180 if tu <= 1182
lb dec 307 if uz == 2993
kfw dec 255 if uz >= 2986
v dec -656 if hbq >= 1396
fg inc 939 if u > -1308
pv inc -670 if gx < -1190
bmm inc -126 if ee <= -2769
iwd inc -386 if lb >= 2131
cj dec 406 if cj != 2508
k inc 41 if mpj <= 314
v inc 342 if v == 472
gx dec -126 if t == -5219
ml inc -536 if iwd == -2368
z dec -450 if lb <= 2138
erl dec 325 if qen <= 2526
bmm dec 27 if tu > 1193
t dec 434 if g > 556
v inc 728 if pv >= -2348
v dec 945 if t >= -5645
bmm inc -947 if osr == -3023
ml inc -978 if ml == -3809
u inc 654 if tu <= 1189
iwd dec -260 if z < -5598
erl dec -238 if ml < -4780
uz inc 361 if osr >= -3023
qen dec -486 if fg <= 839
k inc 735 if tu != 1184
v inc -18 if mpj > 302
kfw dec 842 if lb <= 2135
v dec 295 if u < -642
bmm dec 987 if z <= -5598
gjr dec -266 if osr != -3025
v dec -469 if iwd <= -2108
iwd dec -499 if qen >= 3006
ee inc -251 if erl != -5048
lht inc -778 if kfw < -7086
z dec 934 if kfw >= -7088
qen inc -891 if t >= -5659
cj dec -704 if lb <= 2133
v inc 363 if hbq == 1389
gjr dec 159 if tu <= 1190
lb inc 231 if gx != -1070
uz dec 505 if bmm < -3776
uz dec 468 if gjr >= 143
fg dec 455 if fg > 830
hbq inc 423 if tu >= 1180
qen inc 346 if osr == -3023
osr inc -445 if tu == 1184
gx inc 84 if kfw != -7091
pv inc 148 if ml > -4789
k dec -105 if ml == -4785
jyg dec 963 if cj > 2109
ee dec 969 if ee >= -3030
kfw inc 689 if pv < -2201
pv inc 946 if gx != -986
fg dec -660 if jyg < -1764
erl inc -781 if qen < 2467
jyg inc -461 if erl >= -5828
ml dec 77 if u > -656
u inc -990 if gjr == 143
ml inc -691 if fg < 1036
kfw inc 638 if gjr > 137
iwd inc -705 if u < -1641
uz inc -694 if gx != -974
iwd dec -218 if gjr == 144
mpj dec 948 if gjr > 136
lht inc 92 if osr <= -3474
z inc 174 if ee == -3991
erl inc 100 if z <= -6362
ee dec -598 if g >= 557
gjr inc -385 if k == -1700
qen inc 336 if osr < -3463
fg dec 681 if cj > 2102
v inc -899 if u == -1642
erl dec -837 if u < -1640
lht inc 731 if z > -6370
k dec -467 if pv == -1259
bmm dec -230 if lht == -4185
u inc 811 if lb > 2360
lht inc 251 if uz != 1685
mpj inc -818 if v <= 62
pv dec 974 if g > 574
iwd dec 762 if pv == -1259
erl dec -514 if osr == -3468
fg dec 225 if qen >= 2806
t dec 464 if tu != 1193
jyg inc 389 if v > 66
gx dec -186 if osr >= -3475
osr inc 281 if jpc != -2576
gx dec -630 if cj > 2104
kfw dec 589 if lb != 2369
lht inc -506 if t != -6119
bmm dec -751 if mpj >= -638
uz dec 711 if osr >= -3193
fg dec 50 if erl > -4377
t dec 632 if iwd != -3076
u dec 854 if fg > 309
uz dec 560 if fg == 310
gx inc -746 if lb == 2366
g dec 392 if jpc < -2577
gx dec -816 if hbq >= 1812
ml dec 445 if hbq >= 1816
t dec -19 if gx <= -95
fg inc -814 if gjr > 134
erl inc -865 if ml <= -5306
fg inc -730 if ee < -3389
jyg dec 134 if gx != -95
mpj inc 25 if ee > -3400
hbq dec 295 if cj <= 2111
uz dec -106 if uz <= 421
gjr inc 36 if lb >= 2358
kfw inc 194 if u < -1681
iwd inc 736 if bmm == -2801
gx inc -894 if gjr > 170
v inc 732 if mpj > -623
ml inc -46 if lht >= -4448
ee dec 487 if u == -1685
cj dec 638 if pv < -1254
gjr inc 158 if t == -6098
tu dec 110 if bmm < -2799
lb dec 69 if gjr > 327
gjr inc -9 if k != -1247
erl inc -982 if osr != -3187
uz inc -336 if tu != 1065
ee dec -220 if z >= -6366
tu inc -797 if jyg >= -1854
t dec 35 if t == -6098
uz inc -986 if fg < -1232
qen inc 810 if t <= -6127
lb inc -726 if jpc <= -2572
cj dec 332 if k < -1231
jpc dec -719 if u < -1682
pv dec -307 if k > -1242
gjr inc -973 if pv < -960
g inc -716 if osr == -3187
osr inc -646 if jyg == -1846
ee inc -200 if pv != -950
cj inc 191 if fg != -1230
mpj inc -126 if k <= -1231
mpj inc 738 if u <= -1681
ml dec 383 if bmm >= -2809
v inc -547 if g < -538
jyg dec -940 if ml == -5733
ml inc 52 if lb > 1564
"""
}
