//
//  Puzzle_2024_13.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/15/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_13: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    struct ClawMachine {
        var buttonA: Point2D
        var buttonB: Point2D
        var prize: Point2D
    }

    private func solvePart1(str: String) -> Int {
        var buttonA = Point2D()
        var buttonB = Point2D()
        var prize = Point2D()

        var clawMachines = [ClawMachine]()
        let lines = str.parseIntoStringArray()
        for line in lines {
            if line.hasPrefix("Button A:") {
                let components = line.capturedGroups(withRegex: "Button A: X+(.*), Y+(.*)", trimResults: true).map { $0.int }
                buttonA = Point2D(x: components[0], y: components[1])
            } else if line.hasPrefix("Button B:") {
                let components = line.capturedGroups(withRegex: "Button B: X+(.*), Y+(.*)", trimResults: true).map { $0.int }
                buttonB = Point2D(x: components[0], y: components[1])
            } else {
                let components = line.capturedGroups(withRegex: "Prize: X=(.*), Y=(.*)", trimResults: true).map { $0.int }
                prize = Point2D(x: components[0], y: components[1])
                clawMachines.append(ClawMachine(buttonA: buttonA, buttonB: buttonB, prize: prize))
            }
        }

        var totalTokens = 0
        for clawMachine in clawMachines {
            //print("processing machine \(clawMachine)")
            var tokens = Int.max
            for aPress in 0...100 {
                let aLocation = Point2D(x: aPress * clawMachine.buttonA.x, y: aPress * clawMachine.buttonA.y)
                let remaining = clawMachine.prize - aLocation
                if remaining.x < 0 || remaining.y < 0 {
                    break
                }

                if remaining.x % clawMachine.buttonB.x == 0 && remaining.y % clawMachine.buttonB.y == 0 {
                    let bPressesX = (remaining.x / clawMachine.buttonB.x)
                    let bPressesY = (remaining.y / clawMachine.buttonB.y)
                    if bPressesX == bPressesY {
                        //print("found solution with \(aPress) A and \(bPressesX) B")
                        let tokenSpend = aPress * 3 + (remaining.x / clawMachine.buttonB.x)
                        if tokenSpend < tokens {
                            tokens = tokenSpend
                        }
                    }
                }
            }

            for bPress in 0...100 {
                let bLocation = Point2D(x: bPress * clawMachine.buttonB.x, y: bPress * clawMachine.buttonB.y)
                let remaining = clawMachine.prize - bLocation
                if remaining.x < 0 || remaining.y < 0 {
                    break
                }

                if remaining.x % clawMachine.buttonA.x == 0 && remaining.y % clawMachine.buttonA.y == 0 {
                    let aPressesX = (remaining.x / clawMachine.buttonA.x)
                    let aPressesY = (remaining.y / clawMachine.buttonA.y)
                    if aPressesX == aPressesY {
                        //print("found solution with \(bPress) A and \(aPressesX) B")
                        let tokenSpend = bPress + (remaining.x / clawMachine.buttonA.x) * 3
                        if tokenSpend < tokens {
                            tokens = tokenSpend
                        }
                    }
                }
            }

            if tokens < Int.max {
                totalTokens += tokens
            }
        }

        return totalTokens
    }

    private func solvePart2(str: String) -> Int {
        var buttonA = Point2D()
        var buttonB = Point2D()
        var prize = Point2D()

        var clawMachines = [ClawMachine]()
        let lines = str.parseIntoStringArray()
        for line in lines {
            if line.hasPrefix("Button A:") {
                let components = line.capturedGroups(withRegex: "Button A: X+(.*), Y+(.*)", trimResults: true).map { $0.int }
                buttonA = Point2D(x: components[0], y: components[1])
            } else if line.hasPrefix("Button B:") {
                let components = line.capturedGroups(withRegex: "Button B: X+(.*), Y+(.*)", trimResults: true).map { $0.int }
                buttonB = Point2D(x: components[0], y: components[1])
            } else {
                let components = line.capturedGroups(withRegex: "Prize: X=(.*), Y=(.*)", trimResults: true).map { $0.int }
                prize = Point2D(x: components[0], y: components[1])
                clawMachines.append(ClawMachine(buttonA: buttonA, buttonB: buttonB, prize: prize))
            }
        }

        var totalTokens = 0
        for clawMachine in clawMachines {
            let prize = clawMachine.prize + Point2D(x: 10_000_000_000_000, y: 10_000_000_000_000)
            let b =
            (clawMachine.buttonA.y * prize.x - clawMachine.buttonA.x * prize.y) /
            (clawMachine.buttonA.y * clawMachine.buttonB.x - clawMachine.buttonA.x * clawMachine.buttonB.y)
            let a = (prize.x - clawMachine.buttonB.x * b) / clawMachine.buttonA.x
            let x = clawMachine.buttonA.x * a + clawMachine.buttonB.x * b
            let y = clawMachine.buttonA.y * a + clawMachine.buttonB.y * b
            if prize == Point2D(x: x, y: y) {
                totalTokens += (a * 3) + b
            }
        }

        return totalTokens
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
"""

    static let final = """
Button A: X+12, Y+57
Button B: X+56, Y+15
Prize: X=14212, Y=3815

Button A: X+17, Y+46
Button B: X+98, Y+19
Prize: X=3507, Y=4566

Button A: X+60, Y+12
Button B: X+23, Y+41
Prize: X=3236, Y=2540

Button A: X+13, Y+99
Button B: X+84, Y+41
Prize: X=3193, Y=10546

Button A: X+30, Y+82
Button B: X+35, Y+18
Prize: X=2250, Y=3354

Button A: X+24, Y+50
Button B: X+60, Y+18
Prize: X=8624, Y=9514

Button A: X+26, Y+17
Button B: X+17, Y+83
Prize: X=1284, Y=4290

Button A: X+18, Y+49
Button B: X+52, Y+18
Prize: X=16916, Y=4242

Button A: X+36, Y+12
Button B: X+18, Y+77
Prize: X=3834, Y=6035

Button A: X+53, Y+34
Button B: X+26, Y+51
Prize: X=3434, Y=2958

Button A: X+71, Y+65
Button B: X+21, Y+88
Prize: X=2999, Y=5359

Button A: X+14, Y+31
Button B: X+91, Y+42
Prize: X=2639, Y=1537

Button A: X+43, Y+11
Button B: X+41, Y+81
Prize: X=6381, Y=3069

Button A: X+46, Y+17
Button B: X+24, Y+29
Prize: X=3434, Y=3262

Button A: X+22, Y+74
Button B: X+50, Y+11
Prize: X=19706, Y=6810

Button A: X+46, Y+42
Button B: X+18, Y+57
Prize: X=4704, Y=6810

Button A: X+43, Y+25
Button B: X+19, Y+69
Prize: X=3212, Y=6156

Button A: X+29, Y+28
Button B: X+22, Y+86
Prize: X=2112, Y=2622

Button A: X+25, Y+50
Button B: X+57, Y+29
Prize: X=3544, Y=5518

Button A: X+15, Y+38
Button B: X+31, Y+14
Prize: X=11000, Y=9160

Button A: X+70, Y+41
Button B: X+14, Y+32
Prize: X=7070, Y=6283

Button A: X+22, Y+51
Button B: X+31, Y+14
Prize: X=16913, Y=1950

Button A: X+64, Y+30
Button B: X+19, Y+41
Prize: X=17339, Y=16511

Button A: X+13, Y+23
Button B: X+44, Y+25
Prize: X=14067, Y=1960

Button A: X+56, Y+99
Button B: X+42, Y+20
Prize: X=5068, Y=7983

Button A: X+94, Y+16
Button B: X+50, Y+97
Prize: X=9306, Y=9902

Button A: X+92, Y+14
Button B: X+56, Y+63
Prize: X=9880, Y=5208

Button A: X+44, Y+13
Button B: X+29, Y+94
Prize: X=4877, Y=6994

Button A: X+13, Y+71
Button B: X+70, Y+19
Prize: X=3783, Y=1769

Button A: X+93, Y+16
Button B: X+70, Y+59
Prize: X=8034, Y=3777

Button A: X+27, Y+80
Button B: X+63, Y+23
Prize: X=6012, Y=7175

Button A: X+11, Y+55
Button B: X+70, Y+58
Prize: X=4151, Y=4403

Button A: X+72, Y+11
Button B: X+12, Y+49
Prize: X=7808, Y=4329

Button A: X+13, Y+57
Button B: X+78, Y+13
Prize: X=2811, Y=6304

Button A: X+88, Y+58
Button B: X+11, Y+63
Prize: X=1738, Y=4602

Button A: X+18, Y+68
Button B: X+74, Y+11
Prize: X=11520, Y=10808

Button A: X+11, Y+36
Button B: X+77, Y+29
Prize: X=7326, Y=3906

Button A: X+65, Y+85
Button B: X+87, Y+36
Prize: X=9077, Y=7126

Button A: X+57, Y+11
Button B: X+11, Y+70
Prize: X=15132, Y=13220

Button A: X+60, Y+32
Button B: X+16, Y+99
Prize: X=2176, Y=5322

Button A: X+37, Y+56
Button B: X+30, Y+12
Prize: X=17178, Y=13168

Button A: X+72, Y+55
Button B: X+21, Y+97
Prize: X=5094, Y=8263

Button A: X+89, Y+13
Button B: X+70, Y+60
Prize: X=14755, Y=6635

Button A: X+46, Y+58
Button B: X+56, Y+18
Prize: X=3862, Y=4396

Button A: X+27, Y+59
Button B: X+50, Y+11
Prize: X=6611, Y=1827

Button A: X+29, Y+77
Button B: X+61, Y+15
Prize: X=9899, Y=17595

Button A: X+46, Y+16
Button B: X+24, Y+72
Prize: X=3932, Y=512

Button A: X+88, Y+13
Button B: X+43, Y+63
Prize: X=2104, Y=764

Button A: X+81, Y+11
Button B: X+57, Y+87
Prize: X=6786, Y=2586

Button A: X+18, Y+72
Button B: X+56, Y+34
Prize: X=1506, Y=4884

Button A: X+95, Y+64
Button B: X+29, Y+67
Prize: X=5613, Y=8148

Button A: X+66, Y+25
Button B: X+19, Y+79
Prize: X=5923, Y=3177

Button A: X+11, Y+39
Button B: X+52, Y+30
Prize: X=1742, Y=8240

Button A: X+82, Y+12
Button B: X+85, Y+75
Prize: X=9034, Y=3324

Button A: X+24, Y+45
Button B: X+31, Y+18
Prize: X=9352, Y=16955

Button A: X+11, Y+43
Button B: X+57, Y+34
Prize: X=7415, Y=12413

Button A: X+59, Y+13
Button B: X+16, Y+81
Prize: X=2291, Y=13580

Button A: X+15, Y+76
Button B: X+79, Y+16
Prize: X=19462, Y=10456

Button A: X+66, Y+21
Button B: X+24, Y+58
Prize: X=5130, Y=4503

Button A: X+24, Y+16
Button B: X+27, Y+79
Prize: X=3753, Y=8053

Button A: X+97, Y+98
Button B: X+20, Y+90
Prize: X=5539, Y=9016

Button A: X+43, Y+22
Button B: X+28, Y+50
Prize: X=18848, Y=3622

Button A: X+92, Y+92
Button B: X+14, Y+96
Prize: X=9944, Y=16996

Button A: X+92, Y+30
Button B: X+37, Y+59
Prize: X=10392, Y=6768

Button A: X+70, Y+12
Button B: X+14, Y+54
Prize: X=7102, Y=9098

Button A: X+16, Y+50
Button B: X+80, Y+65
Prize: X=2512, Y=4150

Button A: X+48, Y+81
Button B: X+67, Y+22
Prize: X=6742, Y=8281

Button A: X+22, Y+58
Button B: X+93, Y+55
Prize: X=3170, Y=4934

Button A: X+84, Y+19
Button B: X+86, Y+93
Prize: X=6536, Y=3979

Button A: X+53, Y+25
Button B: X+17, Y+29
Prize: X=10118, Y=1414

Button A: X+30, Y+56
Button B: X+43, Y+22
Prize: X=2954, Y=1220

Button A: X+38, Y+90
Button B: X+95, Y+40
Prize: X=5358, Y=7880

Button A: X+99, Y+12
Button B: X+18, Y+40
Prize: X=9630, Y=4760

Button A: X+41, Y+26
Button B: X+20, Y+50
Prize: X=3028, Y=3898

Button A: X+52, Y+67
Button B: X+11, Y+98
Prize: X=3265, Y=8482

Button A: X+14, Y+41
Button B: X+57, Y+27
Prize: X=5839, Y=7897

Button A: X+22, Y+67
Button B: X+61, Y+20
Prize: X=6417, Y=9556

Button A: X+37, Y+24
Button B: X+21, Y+68
Prize: X=4691, Y=8100

Button A: X+88, Y+96
Button B: X+13, Y+92
Prize: X=6182, Y=8456

Button A: X+67, Y+39
Button B: X+22, Y+44
Prize: X=14708, Y=13146

Button A: X+69, Y+31
Button B: X+20, Y+64
Prize: X=4046, Y=16838

Button A: X+52, Y+49
Button B: X+15, Y+96
Prize: X=2010, Y=4350

Button A: X+17, Y+62
Button B: X+79, Y+33
Prize: X=17079, Y=17948

Button A: X+97, Y+39
Button B: X+65, Y+85
Prize: X=8510, Y=4540

Button A: X+21, Y+89
Button B: X+98, Y+51
Prize: X=3836, Y=7149

Button A: X+22, Y+69
Button B: X+65, Y+15
Prize: X=3700, Y=4265

Button A: X+49, Y+13
Button B: X+27, Y+68
Prize: X=15734, Y=15972

Button A: X+17, Y+41
Button B: X+46, Y+32
Prize: X=8438, Y=3752

Button A: X+79, Y+54
Button B: X+13, Y+40
Prize: X=17365, Y=4550

Button A: X+16, Y+74
Button B: X+79, Y+13
Prize: X=5714, Y=11376

Button A: X+78, Y+25
Button B: X+31, Y+83
Prize: X=10011, Y=10442

Button A: X+21, Y+75
Button B: X+75, Y+22
Prize: X=6959, Y=5453

Button A: X+62, Y+35
Button B: X+15, Y+27
Prize: X=5517, Y=4695

Button A: X+28, Y+72
Button B: X+54, Y+13
Prize: X=2408, Y=4622

Button A: X+23, Y+70
Button B: X+55, Y+15
Prize: X=10833, Y=18120

Button A: X+22, Y+59
Button B: X+61, Y+20
Prize: X=2132, Y=12212

Button A: X+79, Y+20
Button B: X+19, Y+73
Prize: X=3217, Y=6233

Button A: X+87, Y+80
Button B: X+13, Y+42
Prize: X=2575, Y=5102

Button A: X+82, Y+97
Button B: X+69, Y+18
Prize: X=3228, Y=3564

Button A: X+42, Y+17
Button B: X+31, Y+62
Prize: X=17600, Y=6945

Button A: X+25, Y+37
Button B: X+27, Y+13
Prize: X=17558, Y=13118

Button A: X+29, Y+72
Button B: X+52, Y+18
Prize: X=19463, Y=458

Button A: X+18, Y+44
Button B: X+73, Y+41
Prize: X=6553, Y=5985

Button A: X+86, Y+54
Button B: X+39, Y+78
Prize: X=8187, Y=8940

Button A: X+47, Y+16
Button B: X+19, Y+60
Prize: X=742, Y=1652

Button A: X+30, Y+64
Button B: X+55, Y+15
Prize: X=15750, Y=9424

Button A: X+14, Y+44
Button B: X+56, Y+25
Prize: X=17336, Y=8337

Button A: X+22, Y+99
Button B: X+90, Y+51
Prize: X=2242, Y=6549

Button A: X+53, Y+15
Button B: X+20, Y+42
Prize: X=14769, Y=3629

Button A: X+32, Y+78
Button B: X+42, Y+13
Prize: X=4234, Y=4511

Button A: X+27, Y+73
Button B: X+83, Y+13
Prize: X=9202, Y=5430

Button A: X+53, Y+32
Button B: X+29, Y+93
Prize: X=2375, Y=5133

Button A: X+28, Y+58
Button B: X+51, Y+28
Prize: X=6187, Y=5346

Button A: X+15, Y+31
Button B: X+64, Y+26
Prize: X=10129, Y=3111

Button A: X+11, Y+39
Button B: X+36, Y+23
Prize: X=19551, Y=5522

Button A: X+20, Y+75
Button B: X+61, Y+19
Prize: X=6457, Y=15468

Button A: X+13, Y+74
Button B: X+72, Y+18
Prize: X=1941, Y=2820

Button A: X+18, Y+35
Button B: X+76, Y+29
Prize: X=7878, Y=5341

Button A: X+72, Y+19
Button B: X+60, Y+69
Prize: X=4668, Y=4156

Button A: X+27, Y+38
Button B: X+40, Y+11
Prize: X=4463, Y=2114

Button A: X+17, Y+68
Button B: X+87, Y+21
Prize: X=1562, Y=1016

Button A: X+64, Y+26
Button B: X+12, Y+70
Prize: X=5376, Y=3226

Button A: X+78, Y+63
Button B: X+21, Y+85
Prize: X=7281, Y=7990

Button A: X+72, Y+24
Button B: X+59, Y+85
Prize: X=5018, Y=4678

Button A: X+13, Y+55
Button B: X+70, Y+15
Prize: X=1665, Y=3770

Button A: X+31, Y+96
Button B: X+87, Y+39
Prize: X=11086, Y=12441

Button A: X+30, Y+60
Button B: X+42, Y+15
Prize: X=19412, Y=6455

Button A: X+76, Y+12
Button B: X+12, Y+85
Prize: X=17016, Y=16304

Button A: X+58, Y+14
Button B: X+27, Y+56
Prize: X=9151, Y=8908

Button A: X+24, Y+90
Button B: X+47, Y+29
Prize: X=3654, Y=7518

Button A: X+26, Y+53
Button B: X+54, Y+22
Prize: X=4656, Y=15833

Button A: X+78, Y+57
Button B: X+22, Y+70
Prize: X=2200, Y=4897

Button A: X+15, Y+29
Button B: X+58, Y+24
Prize: X=5471, Y=6517

Button A: X+98, Y+27
Button B: X+43, Y+76
Prize: X=7983, Y=3290

Button A: X+61, Y+20
Button B: X+20, Y+90
Prize: X=7573, Y=10410

Button A: X+42, Y+68
Button B: X+54, Y+29
Prize: X=386, Y=955

Button A: X+71, Y+98
Button B: X+78, Y+21
Prize: X=13197, Y=10416

Button A: X+96, Y+38
Button B: X+21, Y+84
Prize: X=10857, Y=9520

Button A: X+62, Y+66
Button B: X+94, Y+12
Prize: X=14506, Y=7428

Button A: X+60, Y+31
Button B: X+11, Y+35
Prize: X=10331, Y=18137

Button A: X+57, Y+93
Button B: X+70, Y+32
Prize: X=8231, Y=9319

Button A: X+91, Y+72
Button B: X+17, Y+60
Prize: X=2633, Y=2316

Button A: X+18, Y+38
Button B: X+61, Y+32
Prize: X=14969, Y=512

Button A: X+44, Y+17
Button B: X+36, Y+68
Prize: X=5380, Y=5310

Button A: X+98, Y+17
Button B: X+53, Y+98
Prize: X=10686, Y=6294

Button A: X+55, Y+31
Button B: X+50, Y+92
Prize: X=6400, Y=6862

Button A: X+96, Y+74
Button B: X+17, Y+85
Prize: X=5568, Y=11194

Button A: X+34, Y+12
Button B: X+38, Y+78
Prize: X=9900, Y=19352

Button A: X+91, Y+13
Button B: X+79, Y+69
Prize: X=9464, Y=6604

Button A: X+12, Y+70
Button B: X+80, Y+47
Prize: X=3404, Y=3070

Button A: X+46, Y+13
Button B: X+30, Y+61
Prize: X=10174, Y=6525

Button A: X+71, Y+33
Button B: X+21, Y+97
Prize: X=998, Y=3430

Button A: X+22, Y+47
Button B: X+76, Y+50
Prize: X=9974, Y=18515

Button A: X+15, Y+20
Button B: X+71, Y+29
Prize: X=3480, Y=2670

Button A: X+80, Y+77
Button B: X+15, Y+87
Prize: X=1855, Y=8824

Button A: X+41, Y+70
Button B: X+47, Y+15
Prize: X=8343, Y=7085

Button A: X+91, Y+53
Button B: X+30, Y+83
Prize: X=3673, Y=7578

Button A: X+86, Y+94
Button B: X+52, Y+12
Prize: X=9842, Y=8426

Button A: X+57, Y+12
Button B: X+37, Y+84
Prize: X=5657, Y=1572

Button A: X+96, Y+48
Button B: X+11, Y+18
Prize: X=9294, Y=5172

Button A: X+73, Y+56
Button B: X+11, Y+73
Prize: X=1407, Y=3339

Button A: X+11, Y+22
Button B: X+47, Y+23
Prize: X=8054, Y=16714

Button A: X+38, Y+23
Button B: X+14, Y+39
Prize: X=12668, Y=5818

Button A: X+83, Y+28
Button B: X+22, Y+31
Prize: X=5683, Y=3827

Button A: X+88, Y+11
Button B: X+18, Y+58
Prize: X=3154, Y=896

Button A: X+75, Y+51
Button B: X+11, Y+35
Prize: X=707, Y=9275

Button A: X+45, Y+70
Button B: X+69, Y+14
Prize: X=8886, Y=6916

Button A: X+49, Y+17
Button B: X+47, Y+77
Prize: X=13273, Y=11885

Button A: X+79, Y+29
Button B: X+22, Y+77
Prize: X=8077, Y=4757

Button A: X+48, Y+15
Button B: X+33, Y+51
Prize: X=6807, Y=5016

Button A: X+92, Y+16
Button B: X+52, Y+75
Prize: X=8208, Y=2153

Button A: X+84, Y+30
Button B: X+37, Y+98
Prize: X=1788, Y=1656

Button A: X+60, Y+91
Button B: X+89, Y+32
Prize: X=10221, Y=8396

Button A: X+26, Y+50
Button B: X+58, Y+31
Prize: X=4466, Y=16784

Button A: X+54, Y+25
Button B: X+25, Y+62
Prize: X=17082, Y=5538

Button A: X+12, Y+37
Button B: X+60, Y+53
Prize: X=1308, Y=2581

Button A: X+29, Y+19
Button B: X+11, Y+35
Prize: X=1061, Y=7527

Button A: X+41, Y+37
Button B: X+97, Y+14
Prize: X=7816, Y=4112

Button A: X+26, Y+80
Button B: X+99, Y+41
Prize: X=5754, Y=7160

Button A: X+42, Y+29
Button B: X+27, Y+86
Prize: X=5139, Y=10082

Button A: X+42, Y+46
Button B: X+57, Y+13
Prize: X=3465, Y=3449

Button A: X+52, Y+96
Button B: X+67, Y+35
Prize: X=6802, Y=4930

Button A: X+22, Y+47
Button B: X+61, Y+27
Prize: X=15433, Y=9291

Button A: X+57, Y+81
Button B: X+81, Y+31
Prize: X=4758, Y=2472

Button A: X+64, Y+13
Button B: X+24, Y+69
Prize: X=1680, Y=2778

Button A: X+68, Y+15
Button B: X+12, Y+40
Prize: X=7244, Y=5825

Button A: X+11, Y+80
Button B: X+80, Y+18
Prize: X=8042, Y=6616

Button A: X+15, Y+98
Button B: X+99, Y+18
Prize: X=7272, Y=7896

Button A: X+22, Y+43
Button B: X+46, Y+24
Prize: X=3806, Y=4664

Button A: X+44, Y+90
Button B: X+65, Y+37
Prize: X=5461, Y=5317

Button A: X+21, Y+62
Button B: X+59, Y+11
Prize: X=14054, Y=8436

Button A: X+15, Y+88
Button B: X+68, Y+64
Prize: X=6337, Y=7368

Button A: X+44, Y+24
Button B: X+18, Y+48
Prize: X=7068, Y=19448

Button A: X+20, Y+45
Button B: X+64, Y+43
Prize: X=1724, Y=1758

Button A: X+31, Y+74
Button B: X+64, Y+21
Prize: X=9475, Y=8615

Button A: X+59, Y+14
Button B: X+66, Y+68
Prize: X=6576, Y=3968

Button A: X+28, Y+14
Button B: X+15, Y+39
Prize: X=4301, Y=15029

Button A: X+33, Y+34
Button B: X+24, Y+96
Prize: X=2280, Y=5984

Button A: X+35, Y+14
Button B: X+32, Y+43
Prize: X=17749, Y=10973

Button A: X+61, Y+53
Button B: X+17, Y+87
Prize: X=4325, Y=9175

Button A: X+59, Y+15
Button B: X+14, Y+36
Prize: X=17016, Y=2144

Button A: X+17, Y+58
Button B: X+39, Y+14
Prize: X=17790, Y=508

Button A: X+18, Y+58
Button B: X+97, Y+74
Prize: X=3921, Y=4762

Button A: X+48, Y+16
Button B: X+30, Y+35
Prize: X=5766, Y=3647

Button A: X+26, Y+11
Button B: X+40, Y+63
Prize: X=1616, Y=8276

Button A: X+87, Y+41
Button B: X+47, Y+79
Prize: X=11997, Y=9747

Button A: X+18, Y+37
Button B: X+68, Y+38
Prize: X=14592, Y=2516

Button A: X+22, Y+98
Button B: X+45, Y+42
Prize: X=6235, Y=12404

Button A: X+81, Y+52
Button B: X+20, Y+58
Prize: X=8570, Y=8392

Button A: X+19, Y+47
Button B: X+42, Y+25
Prize: X=2978, Y=13948

Button A: X+16, Y+41
Button B: X+45, Y+31
Prize: X=7050, Y=3925

Button A: X+60, Y+23
Button B: X+15, Y+30
Prize: X=10520, Y=4953

Button A: X+25, Y+58
Button B: X+55, Y+36
Prize: X=6520, Y=6516

Button A: X+45, Y+12
Button B: X+46, Y+74
Prize: X=11032, Y=18174

Button A: X+62, Y+53
Button B: X+13, Y+48
Prize: X=2328, Y=3318

Button A: X+18, Y+55
Button B: X+43, Y+23
Prize: X=14000, Y=4702

Button A: X+29, Y+45
Button B: X+32, Y+14
Prize: X=361, Y=2419

Button A: X+46, Y+21
Button B: X+27, Y+54
Prize: X=9472, Y=18698

Button A: X+17, Y+42
Button B: X+75, Y+23
Prize: X=2577, Y=1011

Button A: X+70, Y+63
Button B: X+69, Y+14
Prize: X=9105, Y=5068

Button A: X+90, Y+33
Button B: X+13, Y+97
Prize: X=3502, Y=4420

Button A: X+25, Y+40
Button B: X+38, Y+17
Prize: X=6711, Y=9549

Button A: X+78, Y+44
Button B: X+28, Y+58
Prize: X=7876, Y=7144

Button A: X+54, Y+56
Button B: X+58, Y+11
Prize: X=2396, Y=2239

Button A: X+26, Y+57
Button B: X+42, Y+24
Prize: X=3734, Y=2808

Button A: X+29, Y+11
Button B: X+47, Y+68
Prize: X=18519, Y=8721

Button A: X+49, Y+71
Button B: X+72, Y+28
Prize: X=5571, Y=3569

Button A: X+42, Y+14
Button B: X+34, Y+51
Prize: X=18090, Y=7904

Button A: X+42, Y+42
Button B: X+72, Y+14
Prize: X=6960, Y=4466

Button A: X+70, Y+29
Button B: X+22, Y+62
Prize: X=10018, Y=17853

Button A: X+17, Y+16
Button B: X+22, Y+75
Prize: X=2685, Y=7685

Button A: X+85, Y+23
Button B: X+72, Y+91
Prize: X=7363, Y=2636

Button A: X+69, Y+22
Button B: X+28, Y+71
Prize: X=6942, Y=12417

Button A: X+37, Y+64
Button B: X+44, Y+12
Prize: X=4914, Y=3820

Button A: X+68, Y+52
Button B: X+32, Y+82
Prize: X=4392, Y=9054

Button A: X+23, Y+55
Button B: X+60, Y+14
Prize: X=7368, Y=14398

Button A: X+15, Y+48
Button B: X+56, Y+48
Prize: X=3381, Y=6096

Button A: X+96, Y+21
Button B: X+17, Y+18
Prize: X=2357, Y=1044

Button A: X+58, Y+25
Button B: X+40, Y+73
Prize: X=4576, Y=4675

Button A: X+81, Y+83
Button B: X+16, Y+64
Prize: X=9072, Y=13152

Button A: X+66, Y+20
Button B: X+19, Y+60
Prize: X=17847, Y=12420

Button A: X+14, Y+76
Button B: X+79, Y+15
Prize: X=10499, Y=15257

Button A: X+16, Y+70
Button B: X+97, Y+51
Prize: X=2993, Y=6747

Button A: X+73, Y+34
Button B: X+22, Y+61
Prize: X=5227, Y=6241

Button A: X+68, Y+16
Button B: X+13, Y+43
Prize: X=19722, Y=17918

Button A: X+40, Y+17
Button B: X+27, Y+67
Prize: X=18624, Y=9360

Button A: X+43, Y+40
Button B: X+15, Y+59
Prize: X=4377, Y=4432

Button A: X+47, Y+68
Button B: X+94, Y+43
Prize: X=3196, Y=3880

Button A: X+81, Y+52
Button B: X+13, Y+40
Prize: X=18712, Y=2644

Button A: X+71, Y+20
Button B: X+54, Y+71
Prize: X=6311, Y=2503

Button A: X+50, Y+16
Button B: X+15, Y+31
Prize: X=13350, Y=8128

Button A: X+61, Y+16
Button B: X+78, Y+83
Prize: X=11083, Y=8223

Button A: X+23, Y+37
Button B: X+46, Y+20
Prize: X=18937, Y=4341

Button A: X+45, Y+17
Button B: X+54, Y+93
Prize: X=5247, Y=5467

Button A: X+91, Y+52
Button B: X+21, Y+88
Prize: X=3353, Y=9440

Button A: X+11, Y+35
Button B: X+70, Y+38
Prize: X=12575, Y=2599

Button A: X+40, Y+23
Button B: X+22, Y+38
Prize: X=4572, Y=7330

Button A: X+34, Y+59
Button B: X+51, Y+29
Prize: X=14558, Y=4320

Button A: X+63, Y+19
Button B: X+20, Y+72
Prize: X=13945, Y=7281

Button A: X+17, Y+46
Button B: X+45, Y+20
Prize: X=3806, Y=12178

Button A: X+14, Y+35
Button B: X+45, Y+29
Prize: X=12968, Y=4771

Button A: X+38, Y+16
Button B: X+12, Y+33
Prize: X=11866, Y=1245

Button A: X+13, Y+61
Button B: X+34, Y+37
Prize: X=2072, Y=6659

Button A: X+57, Y+41
Button B: X+29, Y+83
Prize: X=3206, Y=4046

Button A: X+22, Y+66
Button B: X+66, Y+28
Prize: X=8746, Y=2528

Button A: X+72, Y+21
Button B: X+15, Y+94
Prize: X=5076, Y=4707

Button A: X+15, Y+64
Button B: X+68, Y+25
Prize: X=11124, Y=1417

Button A: X+27, Y+80
Button B: X+82, Y+34
Prize: X=3377, Y=3946

Button A: X+46, Y+70
Button B: X+94, Y+38
Prize: X=10856, Y=9272

Button A: X+73, Y+14
Button B: X+12, Y+61
Prize: X=7045, Y=18795

Button A: X+18, Y+51
Button B: X+65, Y+28
Prize: X=15231, Y=15784

Button A: X+15, Y+46
Button B: X+75, Y+39
Prize: X=2895, Y=5249

Button A: X+64, Y+53
Button B: X+95, Y+15
Prize: X=14909, Y=6043

Button A: X+91, Y+31
Button B: X+27, Y+34
Prize: X=3457, Y=2765

Button A: X+73, Y+27
Button B: X+16, Y+55
Prize: X=18944, Y=3264

Button A: X+59, Y+86
Button B: X+80, Y+32
Prize: X=4048, Y=3616

Button A: X+51, Y+16
Button B: X+39, Y+68
Prize: X=1004, Y=1332

Button A: X+36, Y+11
Button B: X+39, Y+63
Prize: X=16187, Y=17368

Button A: X+17, Y+30
Button B: X+63, Y+31
Prize: X=5166, Y=3905

Button A: X+83, Y+37
Button B: X+18, Y+88
Prize: X=6398, Y=3252

Button A: X+17, Y+60
Button B: X+48, Y+29
Prize: X=1107, Y=818

Button A: X+36, Y+17
Button B: X+26, Y+51
Prize: X=14926, Y=17397

Button A: X+53, Y+11
Button B: X+32, Y+59
Prize: X=5039, Y=4868

Button A: X+53, Y+94
Button B: X+80, Y+37
Prize: X=12182, Y=12166

Button A: X+14, Y+55
Button B: X+76, Y+23
Prize: X=3132, Y=2977

Button A: X+64, Y+84
Button B: X+30, Y+12
Prize: X=8956, Y=10976

Button A: X+82, Y+66
Button B: X+16, Y+45
Prize: X=6990, Y=6654

Button A: X+22, Y+22
Button B: X+68, Y+13
Prize: X=4858, Y=1943

Button A: X+31, Y+72
Button B: X+61, Y+17
Prize: X=6507, Y=7009

Button A: X+62, Y+55
Button B: X+19, Y+62
Prize: X=1727, Y=4015

Button A: X+34, Y+51
Button B: X+97, Y+47
Prize: X=1160, Y=1149

Button A: X+23, Y+89
Button B: X+78, Y+42
Prize: X=5451, Y=3165

Button A: X+25, Y+75
Button B: X+71, Y+14
Prize: X=3992, Y=6603

Button A: X+80, Y+11
Button B: X+17, Y+84
Prize: X=1730, Y=14714

Button A: X+88, Y+12
Button B: X+61, Y+66
Prize: X=3142, Y=1236

Button A: X+16, Y+81
Button B: X+69, Y+48
Prize: X=5643, Y=9585

Button A: X+16, Y+58
Button B: X+49, Y+13
Prize: X=5657, Y=8699

Button A: X+24, Y+75
Button B: X+47, Y+21
Prize: X=5888, Y=7323

Button A: X+91, Y+29
Button B: X+39, Y+58
Prize: X=1482, Y=1885

Button A: X+12, Y+68
Button B: X+24, Y+27
Prize: X=660, Y=3304

Button A: X+18, Y+15
Button B: X+22, Y+77
Prize: X=1278, Y=1593

Button A: X+62, Y+18
Button B: X+25, Y+61
Prize: X=7461, Y=6065

Button A: X+77, Y+24
Button B: X+83, Y+99
Prize: X=8910, Y=4386

Button A: X+19, Y+64
Button B: X+56, Y+23
Prize: X=565, Y=1075

Button A: X+95, Y+53
Button B: X+26, Y+74
Prize: X=6101, Y=5843

Button A: X+92, Y+22
Button B: X+38, Y+70
Prize: X=8148, Y=6456

Button A: X+75, Y+31
Button B: X+11, Y+33
Prize: X=17592, Y=16140

Button A: X+21, Y+94
Button B: X+63, Y+63
Prize: X=2037, Y=4738

Button A: X+46, Y+19
Button B: X+16, Y+38
Prize: X=3836, Y=2432

Button A: X+93, Y+28
Button B: X+13, Y+21
Prize: X=5256, Y=1890

Button A: X+36, Y+75
Button B: X+80, Y+43
Prize: X=7996, Y=4910

Button A: X+49, Y+60
Button B: X+46, Y+12
Prize: X=2817, Y=1632

Button A: X+21, Y+32
Button B: X+73, Y+34
Prize: X=5481, Y=3486

Button A: X+60, Y+40
Button B: X+11, Y+67
Prize: X=2172, Y=5744

Button A: X+17, Y+60
Button B: X+51, Y+22
Prize: X=13810, Y=1748

Button A: X+69, Y+15
Button B: X+13, Y+40
Prize: X=10017, Y=12420

Button A: X+30, Y+59
Button B: X+63, Y+29
Prize: X=16784, Y=14306

Button A: X+56, Y+17
Button B: X+33, Y+61
Prize: X=5469, Y=5178

Button A: X+73, Y+25
Button B: X+11, Y+66
Prize: X=7120, Y=10367

Button A: X+36, Y+76
Button B: X+56, Y+12
Prize: X=19412, Y=2980
"""
}
