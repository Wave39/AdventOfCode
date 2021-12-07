//
//  Puzzle_2021_07.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/7

import Foundation

public class Puzzle_2021_07: PuzzleBaseClass {
    private var fuelCache: [Int: Int] = [:]

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

    private func fuelBurned(position1: Int, position2: Int, linearFuelConsumption: Bool) -> Int {
        if linearFuelConsumption {
            return abs(position1 - position2)
        }

        let distance = abs(position1 - position2)
        if let fuel = fuelCache[distance] {
            return fuel
        }

        var fuel = 0
        var p1 = min(position1, position2)
        let p2 = max(position1, position2)
        var step = 0
        while p1 < p2 {
            step += 1
            fuel += step
            p1 += 1
        }

        fuelCache[distance] = fuel
        return fuel
    }

    private func processCrabs(str: String, linearFuelConsumption: Bool) -> Int {
        var dict: [Int: Int] = [:]
        let arr = str.parseIntoIntArray(separator: ",")
        for entry in arr {
            if dict[entry] == nil {
                dict[entry] = 0
            }

            dict[entry]? += 1
        }

        var lowestFuel = Int.max
        if let maxPosition = dict.keys.max() {
            for value in 0...maxPosition {
                var fuel = 0
                for (k, v) in dict {
                    fuel += (fuelBurned(position1: k, position2: value, linearFuelConsumption: linearFuelConsumption) * v)
                }

                if fuel < lowestFuel {
                    lowestFuel = fuel
                }
            }
        }

        return lowestFuel
    }

    private func solvePart1(str: String) -> Int {
        processCrabs(str: str, linearFuelConsumption: true)
    }

    private func solvePart2(str: String) -> Int {
        processCrabs(str: str, linearFuelConsumption: false)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
16,1,2,0,4,2,7,1,2,14
"""

    static let final = """
1101,1,29,67,1102,0,1,65,1008,65,35,66,1005,66,28,1,67,65,20,4,0,1001,65,1,65,1106,0,8,99,35,67,101,99,105,32,110,39,101,115,116,32,112,97,115,32,117,110,101,32,105,110,116,99,111,100,101,32,112,114,111,103,114,97,109,10,591,116,168,1277,832,147,32,237,1060,589,149,100,137,603,662,290,361,139,1145,163,241,524,700,85,94,91,267,615,934,378,134,63,503,1022,87,44,711,26,567,49,141,80,53,1434,153,904,243,119,1064,9,202,18,1410,362,61,220,37,699,557,109,396,1065,1,928,614,351,169,498,282,156,614,879,199,259,1323,283,1128,307,374,60,218,1658,103,369,967,816,1037,694,160,1335,943,222,151,451,289,289,1079,604,165,111,130,228,45,368,153,122,356,923,691,183,386,1296,1868,367,1071,10,11,554,134,354,350,221,598,220,1082,361,35,982,18,4,11,13,262,281,57,325,204,1054,583,1166,474,141,9,788,157,85,345,903,2,365,863,661,140,131,1285,381,348,1443,926,172,374,1284,1285,915,380,433,854,11,352,152,1049,209,982,108,893,46,650,100,1653,834,1716,693,24,138,555,112,184,8,448,239,1226,45,788,109,178,517,173,152,364,190,344,951,97,644,716,746,882,58,74,149,716,1316,312,53,323,606,648,906,62,4,275,563,1092,192,527,6,58,376,350,594,50,179,483,693,321,1428,946,41,581,1794,1801,270,1344,902,1347,1064,19,168,687,1631,394,27,1327,98,212,285,436,602,936,760,175,984,1062,842,1133,572,153,792,677,1223,1949,296,221,1421,159,441,316,808,797,278,613,216,147,353,379,23,566,1149,76,232,431,1818,43,81,538,129,80,40,27,1178,348,60,512,343,378,321,1162,932,14,1293,72,846,351,632,1561,247,161,519,97,1361,350,683,118,142,16,34,1577,436,327,118,1102,195,154,579,1147,164,272,773,1017,556,549,589,32,52,118,417,394,133,29,512,1582,126,1106,156,175,484,875,467,544,300,462,22,437,255,507,355,405,1096,36,375,261,284,282,13,457,434,509,12,684,80,614,2,222,657,554,520,710,825,242,29,144,570,1116,182,861,209,159,247,191,423,733,386,385,774,810,22,131,76,105,235,1522,91,2,422,1133,81,11,151,341,317,1332,873,1218,374,0,49,19,73,268,332,60,558,244,595,210,535,7,409,985,970,223,286,84,486,246,675,1112,494,219,605,298,642,139,81,152,899,1181,157,1055,290,199,28,604,9,52,125,723,218,211,519,591,121,264,157,225,1431,172,26,424,212,1173,377,228,597,63,380,0,596,489,38,28,876,108,1669,169,295,318,251,847,1023,181,668,721,205,1376,1890,85,488,636,1022,21,1482,703,599,1136,427,513,186,1320,491,1502,528,4,247,393,152,363,243,1292,508,619,818,151,30,298,89,466,25,393,641,841,200,815,947,260,332,422,958,1186,382,814,1045,830,230,221,673,499,1402,867,635,57,814,1149,1027,830,331,1346,299,0,92,543,160,339,809,59,1128,259,271,1593,475,71,574,95,220,158,288,443,1052,156,450,1218,177,1351,204,1229,765,596,565,62,313,7,313,53,575,10,448,5,705,360,1371,1372,315,256,1323,136,62,807,238,343,173,904,67,680,162,509,231,524,196,218,681,715,552,658,183,1670,379,203,37,8,409,1403,371,69,361,511,272,498,46,489,1346,857,69,233,117,318,1199,977,871,308,435,42,797,550,406,91,171,133,1148,104,324,1489,942,530,468,196,293,534,613,73,29,497,814,1199,466,312,138,70,33,178,29,1549,98,442,23,1142,1074,551,12,741,1277,1278,217,1839,294,200,212,1014,383,1067,30,1257,279,93,786,96,219,639,932,983,45,633,687,67,726,11,162,297,1157,44,273,450,1689,1070,1407,198,1288,790,118,1221,310,655,285,167,115,870,156,217,444,518,1422,52,48,721,34,381,41,299,386,506,327,1201,262,5,42,448,246,145,1268,1047,944,428,29,1,265,381,767,481,409,1747,110,1238,1821,35,594,1,784,301,1228,72,1247,161,582,380,48,51,904,751,179,409,1219,238,453,42,248,99,94,10,387,257,70,1339,130,943,569,986,46,100,77,270,906,506,851,1,1550,983,192,351,233,798,1408,1029,215,95,240,1615,522,1285,392,133,794,431,195,959,504,679,50,837,58,964,342,1548,218,388,596,448,1377,617,442,210,412,355,1249,1094,1060,1718,131,248,4,301,809,980,166,80,282,1846,482,89,221,22,80,356,279,330,13,471,457,28,254,174,110,1742,26,633,1708,818,441,1578,1013,1312,897,458,11,696,1084,453,507,315,149,413,7,36,1000,458,181,286,300,132,1453,76,293,415,288,141,52,1190,1250,107,63,708,356,599,870,769,264,274
"""
}
