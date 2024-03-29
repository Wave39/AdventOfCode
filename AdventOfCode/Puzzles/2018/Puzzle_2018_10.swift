//
//  Puzzle_2018_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2018_10: NSObject {
    public func solve() {
        _ = solveBothParts()
    }

    public func solveBothParts() -> (String, Int) {
        let puzzleInput = Puzzle_2018_10_Input.puzzleInput
        return runSimulation(pointsOfLight: puzzleInput)
    }

    private func parsePointsOfLight(pointsOfLight: String) -> [Particle2D] {
        var retval: [Particle2D] = []

        let arr = pointsOfLight.parseIntoStringArray()
        for line in arr {
            let components = line.capturedGroups(withRegex: "position=<(.*),(.*)> velocity=<(.*),(.*)>", trimResults: true)
            var particle = Particle2D()
            particle.x = components[0].int
            particle.y = components[1].int
            particle.deltaX = components[2].int
            particle.deltaY = components[3].int
            retval.append(particle)
        }

        return retval
    }

    private func runSimulation(pointsOfLight: String) -> (String, Int) {
        var secondsElapsed = 0
        var particles = parsePointsOfLight(pointsOfLight: pointsOfLight)
        var particleString: String
        repeat {
            let bounds = Particle2D.boundingRectangle(arr: particles)
            if bounds.y2 - bounds.y1 < 15 {
                particleString = Particle2D.gridString(arr: particles)
                if particleString.contains("#####") {
                    print("At seconds elapsed \(secondsElapsed), the particles look like this:")
                    print(particleString)
                    return (particleString, secondsElapsed)
                }
            }

            secondsElapsed += 1
            for idx in 0..<particles.count {
                particles[idx].x += particles[idx].deltaX
                particles[idx].y += particles[idx].deltaY
            }
        } while secondsElapsed < 20_000

        return ("", 0)
    }
}

private class Puzzle_2018_10_Input: NSObject {
    static let puzzleInput_test = """
position=< 9,  1> velocity=< 0,  2>
position=< 7,  0> velocity=<-1,  0>
position=< 3, -2> velocity=<-1,  1>
position=< 6, 10> velocity=<-2, -1>
position=< 2, -4> velocity=< 2,  2>
position=<-6, 10> velocity=< 2, -2>
position=< 1,  8> velocity=< 1, -1>
position=< 1,  7> velocity=< 1,  0>
position=<-3, 11> velocity=< 1, -2>
position=< 7,  6> velocity=<-1, -1>
position=<-2,  3> velocity=< 1,  0>
position=<-4,  3> velocity=< 2,  0>
position=<10, -3> velocity=<-1,  1>
position=< 5, 11> velocity=< 1, -2>
position=< 4,  7> velocity=< 0, -1>
position=< 8, -2> velocity=< 0,  1>
position=<15,  0> velocity=<-2,  0>
position=< 1,  6> velocity=< 1,  0>
position=< 8,  9> velocity=< 0, -1>
position=< 3,  3> velocity=<-1,  1>
position=< 0,  5> velocity=< 0, -1>
position=<-2,  2> velocity=< 2,  0>
position=< 5, -2> velocity=< 1,  2>
position=< 1,  4> velocity=< 2,  1>
position=<-2,  7> velocity=< 2, -2>
position=< 3,  6> velocity=<-1, -1>
position=< 5,  0> velocity=< 1,  0>
position=<-6,  0> velocity=< 2,  0>
position=< 5,  9> velocity=< 1, -2>
position=<14,  7> velocity=<-2,  0>
position=<-3,  6> velocity=< 2, -1>
"""

    static let puzzleInput = """
position=<-52592,  31869> velocity=< 5, -3>
position=<-20934,  52988> velocity=< 2, -5>
position=<-20910,  31871> velocity=< 2, -3>
position=<-31503, -52596> velocity=< 3,  5>
position=<-42061, -10364> velocity=< 4,  1>
position=< 10776, -31475> velocity=<-1,  3>
position=<-10348,  31875> velocity=< 1, -3>
position=< 52969,  52985> velocity=<-5, -5>
position=< 31848, -10366> velocity=<-3,  1>
position=<-10376, -10366> velocity=< 1,  1>
position=<-10376, -31474> velocity=< 1,  3>
position=<-42058,  52990> velocity=< 4, -5>
position=<-52628, -10358> velocity=< 5,  1>
position=<-52630,  52985> velocity=< 5, -5>
position=< 31888, -31474> velocity=<-3,  3>
position=<-31492,  42429> velocity=< 3, -4>
position=< 31892,  52988> velocity=<-3, -5>
position=< 52961,  52989> velocity=<-5, -5>
position=<-20908, -42031> velocity=< 2,  4>
position=<-52627,  10759> velocity=< 5, -1>
position=< 21307, -42034> velocity=<-2,  4>
position=<-20937, -31475> velocity=< 2,  3>
position=< 21315, -52594> velocity=<-2,  5>
position=< 10744, -10366> velocity=<-1,  1>
position=< 21287, -10358> velocity=<-2,  1>
position=< 21298, -31478> velocity=<-2,  3>
position=<-10384,  31866> velocity=< 1, -3>
position=< 52953, -10364> velocity=<-5,  1>
position=<-42029, -52597> velocity=< 4,  5>
position=< 21319,  10757> velocity=<-2, -1>
position=<-10352,  21310> velocity=< 1, -2>
position=<-10395, -42034> velocity=< 1,  4>
position=< 10756,  31873> velocity=<-1, -3>
position=<-10384,  42425> velocity=< 1, -4>
position=<-42050,  42427> velocity=< 4, -4>
position=< 31866,  10759> velocity=<-3, -1>
position=<-52592, -10357> velocity=< 5,  1>
position=<-42066,  31874> velocity=< 4, -3>
position=<-52605, -20924> velocity=< 5,  2>
position=< 21274,  10753> velocity=<-2, -1>
position=<-20933,  42433> velocity=< 2, -4>
position=< 52961, -10365> velocity=<-5,  1>
position=<-20913, -20923> velocity=< 2,  2>
position=< 10716, -42039> velocity=<-1,  4>
position=<-42070,  21315> velocity=< 4, -2>
position=<-42040,  31875> velocity=< 4, -3>
position=<-42029,  52989> velocity=< 4, -5>
position=< 52953, -20917> velocity=<-5,  2>
position=<-42058, -10364> velocity=< 4,  1>
position=<-52574, -42031> velocity=< 5,  4>
position=<-52600, -42032> velocity=< 5,  4>
position=< 10740, -52598> velocity=<-1,  5>
position=< 42438, -20919> velocity=<-4,  2>
position=<-20937, -31477> velocity=< 2,  3>
position=<-42072,  42427> velocity=< 4, -4>
position=<-20921, -52598> velocity=< 2,  5>
position=<-52619, -20918> velocity=< 5,  2>
position=<-31467, -20915> velocity=< 3,  2>
position=<-42066, -10366> velocity=< 4,  1>
position=< 21334, -42035> velocity=<-2,  4>
position=< 21309,  21317> velocity=<-2, -2>
position=< 42414, -10364> velocity=<-4,  1>
position=< 21290,  21311> velocity=<-2, -2>
position=< 52972, -20917> velocity=<-5,  2>
position=< 10776,  10755> velocity=<-1, -1>
position=< 21298, -10363> velocity=<-2,  1>
position=< 42430,  52986> velocity=<-4, -5>
position=< 21294,  21312> velocity=<-2, -2>
position=< 10752, -10357> velocity=<-1,  1>
position=< 42438,  21315> velocity=<-4, -2>
position=<-42050, -20915> velocity=< 4,  2>
position=<-31504, -52598> velocity=< 3,  5>
position=< 52999,  21317> velocity=<-5, -2>
position=<-10390, -10362> velocity=< 1,  1>
position=< 21300,  10754> velocity=<-2, -1>
position=<-20933, -10366> velocity=< 2,  1>
position=< 10725, -10366> velocity=<-1,  1>
position=< 10737,  31874> velocity=<-1, -3>
position=<-20913,  10758> velocity=< 2, -1>
position=<-42063,  21312> velocity=< 4, -2>
position=<-10358,  10754> velocity=< 1, -1>
position=< 21334,  52986> velocity=<-2, -5>
position=< 42430,  31871> velocity=<-4, -3>
position=< 21319,  21310> velocity=<-2, -2>
position=< 21290, -52592> velocity=<-2,  5>
position=< 21295,  10753> velocity=<-2, -1>
position=< 42390, -42036> velocity=<-4,  4>
position=< 10721,  52990> velocity=<-1, -5>
position=< 21285, -52598> velocity=<-2,  5>
position=< 31837, -42037> velocity=<-3,  4>
position=<-42018,  52989> velocity=< 4, -5>
position=<-10355,  31871> velocity=< 1, -3>
position=< 42411, -31477> velocity=<-4,  3>
position=<-52632,  42428> velocity=< 5, -4>
position=< 42441,  10759> velocity=<-4, -1>
position=<-52624, -10365> velocity=< 5,  1>
position=<-10360, -42038> velocity=< 1,  4>
position=< 21314,  21311> velocity=<-2, -2>
position=< 52988,  42430> velocity=<-5, -4>
position=<-10350, -31482> velocity=< 1,  3>
position=<-52592,  10753> velocity=< 5, -1>
position=<-20954, -52590> velocity=< 2,  5>
position=<-52611, -42033> velocity=< 5,  4>
position=< 31841,  42424> velocity=<-3, -4>
position=< 10729,  52990> velocity=<-1, -5>
position=< 31837,  42426> velocity=<-3, -4>
position=<-20958,  42429> velocity=< 2, -4>
position=< 10737,  42432> velocity=<-1, -4>
position=<-52624, -31477> velocity=< 5,  3>
position=<-20949,  10754> velocity=< 2, -1>
position=< 10729, -20923> velocity=<-1,  2>
position=< 31892, -52597> velocity=<-3,  5>
position=<-10355,  21314> velocity=< 1, -2>
position=< 52960,  42428> velocity=<-5, -4>
position=<-52587,  42424> velocity=< 5, -4>
position=<-52592,  52983> velocity=< 5, -5>
position=< 31832,  21315> velocity=<-3, -2>
position=< 52956, -10362> velocity=<-5,  1>
position=< 52992,  42428> velocity=<-5, -4>
position=< 10749, -20924> velocity=<-1,  2>
position=<-31504,  21308> velocity=< 3, -2>
position=<-20950, -42032> velocity=< 2,  4>
position=<-20907,  31866> velocity=< 2, -3>
position=<-52624,  42432> velocity=< 5, -4>
position=< 31865, -10357> velocity=<-3,  1>
position=<-52611,  52988> velocity=< 5, -5>
position=< 42441,  31866> velocity=<-4, -3>
position=< 42438,  21309> velocity=<-4, -2>
position=< 42398,  21310> velocity=<-4, -2>
position=<-10352, -10360> velocity=< 1,  1>
position=<-42050, -42036> velocity=< 4,  4>
position=< 52948,  42429> velocity=<-5, -4>
position=< 52993,  21311> velocity=<-5, -2>
position=<-10384, -52598> velocity=< 1,  5>
position=<-42029, -31473> velocity=< 4,  3>
position=<-10375, -52589> velocity=< 1,  5>
position=<-31460, -31475> velocity=< 3,  3>
position=< 42418, -31473> velocity=<-4,  3>
position=<-10392,  52984> velocity=< 1, -5>
position=< 10767,  10750> velocity=<-1, -1>
position=<-52573,  52991> velocity=< 5, -5>
position=<-52611,  52984> velocity=< 5, -5>
position=<-52592,  42431> velocity=< 5, -4>
position=<-10380,  21312> velocity=< 1, -2>
position=<-42029, -42038> velocity=< 4,  4>
position=<-42056, -10362> velocity=< 4,  1>
position=<-42041, -20915> velocity=< 4,  2>
position=<-10395,  31868> velocity=< 1, -3>
position=<-42045,  52991> velocity=< 4, -5>
position=< 21319,  21313> velocity=<-2, -2>
position=< 31844, -20920> velocity=<-3,  2>
position=<-20918,  52990> velocity=< 2, -5>
position=<-31514, -52595> velocity=< 3,  5>
position=< 10752,  31869> velocity=<-1, -3>
position=<-42034, -52597> velocity=< 4,  5>
position=< 10733, -20920> velocity=<-1,  2>
position=<-31476,  21309> velocity=< 3, -2>
position=< 10716, -42037> velocity=<-1,  4>
position=< 10720,  42431> velocity=<-1, -4>
position=<-20909, -20915> velocity=< 2,  2>
position=<-52627,  10750> velocity=< 5, -1>
position=<-31489, -52589> velocity=< 3,  5>
position=< 10756, -20915> velocity=<-1,  2>
position=<-31483, -20918> velocity=< 3,  2>
position=< 31861,  10759> velocity=<-3, -1>
position=<-31471,  21308> velocity=< 3, -2>
position=< 52948, -42040> velocity=<-5,  4>
position=< 21302, -31478> velocity=<-2,  3>
position=<-52587, -31476> velocity=< 5,  3>
position=< 21308, -31477> velocity=<-2,  3>
position=<-31492,  42429> velocity=< 3, -4>
position=<-31513, -31476> velocity=< 3,  3>
position=<-10388, -52598> velocity=< 1,  5>
position=<-20953,  31867> velocity=< 2, -3>
position=<-42038, -20921> velocity=< 4,  2>
position=< 10732,  31870> velocity=<-1, -3>
position=< 52964, -52595> velocity=<-5,  5>
position=< 21284,  10750> velocity=<-2, -1>
position=< 21299,  21317> velocity=<-2, -2>
position=<-42041,  31872> velocity=< 4, -3>
position=<-10360,  10750> velocity=< 1, -1>
position=< 10774,  10759> velocity=<-1, -1>
position=< 42406,  42429> velocity=<-4, -4>
position=<-42022,  42433> velocity=< 4, -4>
position=<-52606,  42428> velocity=< 5, -4>
position=< 31832, -31476> velocity=<-3,  3>
position=< 21295, -20923> velocity=<-2,  2>
position=<-42050, -42039> velocity=< 4,  4>
position=< 21284, -52594> velocity=<-2,  5>
position=<-42034, -42035> velocity=< 4,  4>
position=< 21279,  21313> velocity=<-2, -2>
position=< 31880,  42427> velocity=<-3, -4>
position=<-31484,  21317> velocity=< 3, -2>
position=< 42391, -20922> velocity=<-4,  2>
position=<-42058, -10365> velocity=< 4,  1>
position=< 42409,  52986> velocity=<-4, -5>
position=<-20918,  42431> velocity=< 2, -4>
position=< 31851,  21312> velocity=<-3, -2>
position=<-10387, -31479> velocity=< 1,  3>
position=<-42033, -31478> velocity=< 4,  3>
position=<-42047, -42036> velocity=< 4,  4>
position=< 21301, -31482> velocity=<-2,  3>
position=<-10365, -31473> velocity=< 1,  3>
position=<-31471, -42031> velocity=< 3,  4>
position=<-42074, -10357> velocity=< 4,  1>
position=<-31500,  10758> velocity=< 3, -1>
position=< 21311,  10751> velocity=<-2, -1>
position=< 42398, -10362> velocity=<-4,  1>
position=<-20921,  42424> velocity=< 2, -4>
position=< 52985, -52597> velocity=<-5,  5>
position=<-42073,  52983> velocity=< 4, -5>
position=< 42390,  31874> velocity=<-4, -3>
position=<-42061, -10360> velocity=< 4,  1>
position=< 21301,  42428> velocity=<-2, -4>
position=<-20942, -20917> velocity=< 2,  2>
position=<-10350, -52589> velocity=< 1,  5>
position=<-52595,  31875> velocity=< 5, -3>
position=< 42432, -52594> velocity=<-4,  5>
position=<-20937, -20924> velocity=< 2,  2>
position=< 42395,  31873> velocity=<-4, -3>
position=<-31508,  42433> velocity=< 3, -4>
position=< 10751, -31473> velocity=<-1,  3>
position=<-42032,  52986> velocity=< 4, -5>
position=< 42447, -10357> velocity=<-4,  1>
position=<-42048,  42428> velocity=< 4, -4>
position=<-10344, -42032> velocity=< 1,  4>
position=< 21290, -42034> velocity=<-2,  4>
position=<-42014, -42037> velocity=< 4,  4>
position=<-20906, -42040> velocity=< 2,  4>
position=< 10721, -20920> velocity=<-1,  2>
position=<-10379,  42433> velocity=< 1, -4>
position=< 21319,  52986> velocity=<-2, -5>
position=<-10368,  42431> velocity=< 1, -4>
position=<-20950, -20924> velocity=< 2,  2>
position=< 31877, -52595> velocity=<-3,  5>
position=<-31482,  42429> velocity=< 3, -4>
position=< 21334,  42432> velocity=<-2, -4>
position=<-10364,  42427> velocity=< 1, -4>
position=<-42074,  10755> velocity=< 4, -1>
position=< 21300, -10366> velocity=<-2,  1>
position=< 42408,  10754> velocity=<-4, -1>
position=< 10732,  10753> velocity=<-1, -1>
position=<-52632,  21310> velocity=< 5, -2>
position=< 10740, -20920> velocity=<-1,  2>
position=< 52956,  42429> velocity=<-5, -4>
position=< 10756, -52598> velocity=<-1,  5>
position=<-31506,  52991> velocity=< 3, -5>
position=< 10724,  10751> velocity=<-1, -1>
position=<-20921,  21310> velocity=< 2, -2>
position=<-20946, -42031> velocity=< 2,  4>
position=< 42435,  52986> velocity=<-4, -5>
position=<-42037, -31473> velocity=< 4,  3>
position=< 21287, -52592> velocity=<-2,  5>
position=< 10717, -42039> velocity=<-1,  4>
position=<-52627,  31872> velocity=< 5, -3>
position=< 31875,  52986> velocity=<-3, -5>
position=< 42411, -42036> velocity=<-4,  4>
position=< 52964, -20915> velocity=<-5,  2>
position=<-31488,  42428> velocity=< 3, -4>
position=< 42426,  21308> velocity=<-4, -2>
position=<-52579,  10751> velocity=< 5, -1>
position=<-42014,  10753> velocity=< 4, -1>
position=<-42034,  10752> velocity=< 4, -1>
position=< 21275,  42425> velocity=<-2, -4>
position=<-10350, -10366> velocity=< 1,  1>
position=<-52628, -52591> velocity=< 5,  5>
position=< 31845, -52591> velocity=<-3,  5>
position=< 21285, -31473> velocity=<-2,  3>
position=< 21319,  21312> velocity=<-2, -2>
position=< 42427, -31480> velocity=<-4,  3>
position=< 52956, -52591> velocity=<-5,  5>
position=<-10389,  52986> velocity=< 1, -5>
position=< 42400,  10754> velocity=<-4, -1>
position=<-31508, -10362> velocity=< 3,  1>
position=< 10740,  10756> velocity=<-1, -1>
position=<-20898,  42424> velocity=< 2, -4>
position=< 21319, -42031> velocity=<-2,  4>
position=<-52574,  10759> velocity=< 5, -1>
position=< 21274, -31476> velocity=<-2,  3>
position=<-31463, -10358> velocity=< 3,  1>
position=<-20950,  21311> velocity=< 2, -2>
position=<-52600, -31474> velocity=< 5,  3>
position=< 31864,  42431> velocity=<-3, -4>
position=< 21279,  21316> velocity=<-2, -2>
position=< 21287,  42426> velocity=<-2, -4>
position=< 10716,  10754> velocity=<-1, -1>
position=<-42042,  52989> velocity=< 4, -5>
position=<-31492,  42427> velocity=< 3, -4>
position=< 21298, -10364> velocity=<-2,  1>
position=<-42040,  21308> velocity=< 4, -2>
position=<-42045,  10750> velocity=< 4, -1>
position=< 31835, -20919> velocity=<-3,  2>
position=< 10773,  42433> velocity=<-1, -4>
position=< 42443,  10758> velocity=<-4, -1>
position=< 52973, -52598> velocity=<-5,  5>
position=< 21295, -52592> velocity=<-2,  5>
position=<-10392,  31868> velocity=< 1, -3>
position=< 21282, -42031> velocity=<-2,  4>
position=< 10737, -20920> velocity=<-1,  2>
position=< 52985,  31875> velocity=<-5, -3>
position=<-42049, -20920> velocity=< 4,  2>
position=< 52992,  10754> velocity=<-5, -1>
position=< 10716,  31866> velocity=<-1, -3>
position=< 31884, -20924> velocity=<-3,  2>
position=< 42442, -20924> velocity=<-4,  2>
position=< 10732, -10361> velocity=<-1,  1>
position=<-31508,  10756> velocity=< 3, -1>
position=< 31872,  21314> velocity=<-3, -2>
position=<-42042,  10750> velocity=< 4, -1>
position=<-42069,  21315> velocity=< 4, -2>
position=<-20898, -10365> velocity=< 2,  1>
position=<-42071, -20918> velocity=< 4,  2>
position=< 10752, -10357> velocity=<-1,  1>
position=<-20946, -10362> velocity=< 2,  1>
position=<-52572, -10358> velocity=< 5,  1>
position=< 10716,  42424> velocity=<-1, -4>
position=<-52611,  42426> velocity=< 5, -4>
position=< 31856,  52991> velocity=<-3, -5>
position=< 10750,  52982> velocity=<-1, -5>
position=<-31495, -52598> velocity=< 3,  5>
position=< 52975,  21308> velocity=<-5, -2>
position=< 10729, -20919> velocity=<-1,  2>
position=<-52620,  10759> velocity=< 5, -1>
position=< 10751, -10366> velocity=<-1,  1>
position=<-20898, -52591> velocity=< 2,  5>
position=<-42023,  52991> velocity=< 4, -5>
position=<-31500,  31875> velocity=< 3, -3>
position=<-52584,  52990> velocity=< 5, -5>
position=< 21314,  52990> velocity=<-2, -5>
position=< 10776,  21309> velocity=<-1, -2>
position=<-10376,  31875> velocity=< 1, -3>
position=<-20946, -52589> velocity=< 2,  5>
position=<-52628, -52590> velocity=< 5,  5>
position=< 52988, -31474> velocity=<-5,  3>
position=<-31491, -42040> velocity=< 3,  4>
position=<-20918, -42036> velocity=< 2,  4>
position=<-20947,  10754> velocity=< 2, -1>
position=< 52953, -31474> velocity=<-5,  3>
position=<-42031,  31870> velocity=< 4, -3>
position=<-52583,  42424> velocity=< 5, -4>
position=< 42393, -20919> velocity=<-4,  2>
position=< 42411,  10750> velocity=<-4, -1>
position=< 10716, -42032> velocity=<-1,  4>
position=<-31503,  42429> velocity=< 3, -4>
position=<-42053,  10753> velocity=< 4, -1>
position=<-31481, -20920> velocity=< 3,  2>
position=<-31468, -31481> velocity=< 3,  3>
position=< 21284, -20924> velocity=<-2,  2>
position=< 42409, -42036> velocity=<-4,  4>
position=<-42063,  31875> velocity=< 4, -3>
position=< 42450, -10358> velocity=<-4,  1>
position=<-20897, -52598> velocity=< 2,  5>
position=< 42407, -10362> velocity=<-4,  1>
position=< 52983,  10754> velocity=<-5, -1>
position=< 52969, -31477> velocity=<-5,  3>
position=< 53000, -10357> velocity=<-5,  1>
position=<-52619, -31475> velocity=< 5,  3>
position=< 10756,  10756> velocity=<-1, -1>
position=< 31889, -42031> velocity=<-3,  4>
position=<-31511,  52985> velocity=< 3, -5>
position=<-31511,  42425> velocity=< 3, -4>
position=< 21322, -31476> velocity=<-2,  3>
position=< 10764,  21312> velocity=<-1, -2>
position=< 10724,  21314> velocity=<-1, -2>
position=< 53001,  10758> velocity=<-5, -1>
position=<-52607, -10362> velocity=< 5,  1>
position=<-31482, -20919> velocity=< 3,  2>
position=< 21276,  10754> velocity=<-2, -1>
position=< 42426,  21317> velocity=<-4, -2>
position=< 21299, -10362> velocity=<-2,  1>
position=< 42450, -20922> velocity=<-4,  2>
position=< 10719,  10755> velocity=<-1, -1>
position=<-52623,  10759> velocity=< 5, -1>
position=< 31840, -42040> velocity=<-3,  4>
position=< 10724, -20918> velocity=<-1,  2>
position=<-10341,  21308> velocity=< 1, -2>
position=< 42403, -10365> velocity=<-4,  1>
position=< 31877,  31866> velocity=<-3, -3>
position=<-42048,  31875> velocity=< 4, -3>
position=< 52953,  52986> velocity=<-5, -5>
position=<-10340, -10360> velocity=< 1,  1>
position=< 31869,  10752> velocity=<-3, -1>
position=<-52612,  21312> velocity=< 5, -2>
position=<-42053, -52592> velocity=< 4,  5>
position=<-31490,  10750> velocity=< 3, -1>
"""
}
