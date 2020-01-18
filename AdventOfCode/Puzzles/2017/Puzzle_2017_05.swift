//
//  Puzzle_2017_05.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_05 : PuzzleBaseClass {

    func solve() {
        let (part1Solution, part2Solution) = solveBothParts()
        print ("Part 1 solution: \(part1Solution)")
        print ("Part 2 solution: \(part2Solution)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2017_05_Input.puzzleInput
        
        let part1Solution = solveInput(str: puzzleInput, testForStrangeJump: false)
        let part2Solution = solveInput(str: puzzleInput, testForStrangeJump: true)
        return (part1Solution, part2Solution)
    }

    func parseInput(str: String) -> [Int] {
        var retval: [Int] = []
        let lineArray = str.split(separator: "\n")
        for line in lineArray {
            retval.append(Int(line)!)
        }
        
        return retval
    }
    
    func solveInput(str: String, testForStrangeJump: Bool) -> Int {
        var total = 0
        var programCounter = 0
        
        var instructionArray = parseInput(str: str)

        while programCounter >= 0 && programCounter < instructionArray.count {
            let jumpValue = instructionArray[programCounter]
            let previousProgramCounter = programCounter
            programCounter += jumpValue
            instructionArray[previousProgramCounter] += ((testForStrangeJump && jumpValue >= 3) ? -1 : 1)
            total += 1
        }
        
        return total
    }

}

fileprivate class Puzzle_2017_05_Input: NSObject {

    static let puzzleInput_test1 =
        
"""
0
3
0
1
-3
"""
    
    static let puzzleInput =
    
"""
2
1
2
-1
2
-3
1
-2
-7
-3
-1
-5
-2
-6
-1
-7
-11
-10
0
-5
-13
0
-5
-13
-19
-19
-6
-16
1
-18
-28
-8
-15
-15
-32
-25
-33
-7
-13
-20
-33
-33
-3
-10
-32
-9
-12
-35
2
-31
2
1
-6
1
-15
-51
-20
-28
-38
-3
-36
-29
-19
-48
-39
-56
1
-32
-14
-57
-20
-8
-59
-56
-30
-68
-62
-28
1
-62
-14
-61
-19
-24
-17
-70
-39
-6
-12
-69
-39
-63
-75
-38
-40
-62
-71
-65
-84
-59
-92
-21
-3
-2
-53
-42
-2
-64
-64
-23
-33
-40
-17
-21
-38
-17
-70
-78
-62
-95
-97
-115
-101
-31
-13
-121
0
-21
-69
-94
-70
-9
-122
-30
-38
-28
-14
-91
-28
-110
-114
-96
-104
-78
-30
-125
-41
-26
-94
-142
-74
-86
-12
-103
-126
-16
-118
-133
-72
-147
-149
-119
-91
-44
-145
-42
-97
-66
-38
-33
-6
-79
-5
-151
-145
-23
-118
-103
-20
-66
-18
-140
-99
-176
-143
-60
-3
-51
-65
-37
-178
-27
-1
-181
-115
-122
-162
-12
-140
-34
-146
-133
-115
-144
-152
-85
-173
-44
-29
-98
-159
-88
-173
-117
-172
-210
-41
-125
-181
-149
-54
-71
-57
-188
-160
-85
-85
-215
-108
-130
-150
-36
-225
-1
-207
-233
-171
-2
-176
-16
-83
-148
-200
-59
-108
-62
-118
-94
-31
-211
-89
-243
-7
-106
-36
-239
-116
-135
-98
-136
-159
-242
-233
-212
-29
-128
-234
-208
-153
-200
-122
-38
-159
-211
-264
-41
-74
-219
-274
-114
-116
-24
-243
-74
-198
-250
-35
-95
-146
-110
-179
-213
-279
-160
-34
-90
-282
-174
-17
-287
-146
-196
-140
-139
-238
-148
-22
-43
-50
-300
-104
-67
-243
-129
-264
-192
-8
-171
-263
-38
-147
-315
-65
-141
-49
-164
-104
-43
-203
-217
-320
-167
-21
-42
-180
1
-89
-67
-27
-319
-131
-240
-211
-283
-148
-341
-207
-97
-242
-183
-339
-182
-97
-157
-53
-346
-112
-282
-127
-226
-341
-196
-230
-362
-191
-180
-347
-223
-5
-278
-217
-50
-268
-288
-258
-300
-353
-296
-221
-303
-167
-378
-259
-17
-199
-140
-323
-352
-226
-380
-299
-88
-265
-315
-285
-139
-331
-146
-282
-331
-279
-347
-13
-26
-156
-299
-364
-155
-309
-280
-34
-362
-16
-193
-240
-194
-55
-315
-292
-121
-110
-334
-95
-341
-118
0
-282
-194
-128
-137
-161
-111
-46
-31
-375
-339
-131
-224
-62
-183
-50
-156
-338
-440
-186
-86
-54
-401
-197
-135
-304
-369
-31
-20
-62
-272
-321
-289
-205
-448
-40
-114
-393
-403
-244
-285
-19
-334
-45
-19
-422
-308
-271
-224
-252
-433
-198
-451
-353
-333
-310
-130
-396
-182
-414
-221
-425
-121
-311
2
-236
-24
-81
-21
-340
-393
-173
-360
-339
-282
-245
-330
-273
-448
-425
-398
-137
-434
-400
-439
-110
-295
-287
-321
-338
-288
-217
-444
-87
-237
-405
-406
-6
-126
-94
-2
-257
-62
-365
-499
-527
-409
-230
-275
-376
-270
-191
-252
-476
-340
-458
-465
-511
-232
-488
-445
-402
-299
-515
-164
-113
-397
-323
-339
-388
-146
-435
-292
-433
-86
-158
-459
-172
-107
-334
-411
-517
-459
-62
-186
-102
-198
-189
-549
-176
-216
-393
-475
-528
-551
-196
-319
-457
-404
-22
-158
-414
-15
-509
-307
-531
-389
-171
-353
-306
-281
-374
-348
-125
-461
-121
-192
-75
-95
-555
-113
-603
-361
-195
-516
-509
-23
-211
-271
-119
-401
-544
-557
-584
-294
-155
-92
-306
-351
-292
-202
-291
-334
-485
-280
-98
-374
-411
-572
-577
-350
-590
-312
-297
-200
-489
-141
-99
-589
-326
-420
-152
-365
-560
-548
-562
-456
-206
-175
-617
-454
-141
-621
-560
-503
-156
-498
-469
-433
-629
-459
-234
-454
-490
-72
-188
-395
-185
-21
-645
-47
-549
-225
-587
-174
-334
-358
-244
-592
-15
-109
-258
-639
-676
-550
-29
-255
-633
-469
-367
-190
-601
-667
-120
-170
-236
-16
-464
-194
-263
-648
-613
-642
-263
-111
-8
-142
-543
-670
-178
-293
-660
-14
-502
-279
-391
-74
-298
-286
-640
-658
-144
-648
2
-328
-418
-294
-461
-646
-612
-563
-250
-420
-318
-464
-478
-172
-47
-284
-293
-121
-642
-41
-406
-538
-100
-44
-505
-663
-437
-680
-181
-57
-619
-17
-434
-27
-509
-182
-635
-710
-514
-693
-678
-351
-129
-63
-556
-312
-359
-627
-44
-391
-138
-79
-607
-226
-637
-340
-508
-632
-124
-637
-575
-263
-392
-521
-760
-526
-213
-209
-501
-381
-76
-555
-321
-172
-685
-14
-135
-360
-799
-70
-85
-534
-100
-414
-519
-596
-714
-493
-136
-442
-379
-778
-555
-429
-245
-360
-399
-117
-410
-383
-406
-316
-633
-163
-328
-224
-421
-196
-801
-549
-156
-541
-245
-424
-324
-242
-834
-444
-513
-300
-86
-4
-564
-617
-631
-454
-22
-201
-819
-241
-621
-332
-563
-855
-436
-144
-403
-101
-527
-157
-778
-256
-378
-6
-860
-805
-307
-581
-595
-380
-83
-641
-566
-71
-809
-866
-856
-234
-402
-511
-382
-716
-331
-701
-279
-142
-90
-828
-415
-768
-25
-409
-158
-423
-161
-670
-349
-188
-590
-504
-599
-57
-849
-521
-275
-257
-883
-476
-602
-683
-393
-374
-695
-573
-52
-263
-446
-690
-708
-881
-218
-334
-149
-674
-419
-793
-764
-413
-230
-541
-705
-777
-440
-651
-387
-532
-290
-824
-659
-772
-511
-817
-384
-703
-309
-880
-518
-579
-38
-114
-902
-693
-496
-682
-744
-543
-929
-774
-699
-364
-542
-198
-170
-822
-681
-811
-769
-219
-824
-904
-161
-334
-736
-246
-846
-615
-597
-565
-61
-813
-460
-194
-882
-272
-416
-270
-79
-719
-256
-405
-939
-200
-776
-375
-798
-829
-894
-96
-41
-405
-684
-851
-588
-132
-127
-839
-123
-8
-916
-370
-486
-178
-761
-481
-532
-1015
-64
-13
-551
-295
-964
-879
-16
-304
-1022
-191
-734
-486
-337
-819
-701
-769
-687
-854
-800
-999
-317
-435
-97
-966
-887
-589
-793
-962
-1032
-595
-19
-119
-857
-520
"""
    
}
