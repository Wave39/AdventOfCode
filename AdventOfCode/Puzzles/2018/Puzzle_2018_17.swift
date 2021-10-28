//
//  Puzzle_2018_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/4/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

extension Sequence {
    var tuple3: (Element, Element, Element)? {
        var iter = makeIterator()
        guard let first  = iter.next(),
            let second = iter.next(),
            let third  = iter.next()
            else { return nil }
        return (first, second, third)
    }
}

class Puzzle_2018_17: NSObject {

    enum Area {
        case sand, clay, water, flowingWater
        var char: Character {
            switch self {
            case .sand: return "."
            case .clay: return "#"
            case .water: return "~"
            case .flowingWater: return "|"
            }
        }
        
        var isWater: Bool {
            return self == .water || self == .flowingWater
        }
    }
    
    struct Grid<Element> {
        var xRange: ClosedRange<Int>
        var yRange: ClosedRange<Int>
        var storage: [Element]
        
        init(repeating element: Element, x: ClosedRange<Int>, y: ClosedRange<Int>) {
            xRange = x
            yRange = y
            storage = [Element](repeating: element, count: xRange.count * yRange.count)
        }
        
        subscript(x x: Int, y y: Int) -> Element {
            get {
                precondition(xRange.contains(x) && yRange.contains(y))
                let xIndex = x - xRange.lowerBound
                let yIndex = y - yRange.lowerBound
                return storage[xRange.count * yIndex + xIndex]
            }
            set {
                precondition(xRange.contains(x) && yRange.contains(y))
                let xIndex = x - xRange.lowerBound
                let yIndex = y - yRange.lowerBound
                storage[xRange.count * yIndex + xIndex] = newValue
            }
        }
        
        func row(at y: Int) -> ArraySlice<Element> {
            precondition(yRange.contains(y))
            let yIndex = y - yRange.lowerBound
            return storage[(yIndex * xRange.count)..<((yIndex + 1) * xRange.count)]
        }
        
        var rows: LazyMapCollection<ClosedRange<Int>, ArraySlice<Element>> {
            return yRange.lazy.map { self.row(at: $0) }
        }
    }
    
    func aocD17(_ input: [(x: ClosedRange<Int>, y: ClosedRange<Int>)]) {
        let minX = input.lazy.map { $0.x.lowerBound }.min()! - 1
        let maxX = input.lazy.map { $0.x.upperBound }.max()! + 1
        let minY = input.lazy.map { $0.y.lowerBound }.min()!
        let maxY = input.lazy.map { $0.y.upperBound }.max()!
        let xbounds = minX...maxX
        let ybounds = minY...maxY
        var map = Grid(repeating: Area.sand, x: xbounds, y: ybounds)
        for (xrange, yrange) in input {
            for x in xrange {
                for y in yrange {
                    map[x: x, y: y] = .clay
                }
            }
        }
        func pourDown(x: Int, y: Int) -> Bool {
            var newY = y
            while map[x: x, y: newY] != .clay {
                map[x: x, y: newY] = .flowingWater
                newY += 1
                if !ybounds.contains(newY) {
                    return true
                }
            }
            repeat {
                // print(map.lazy.map({ String($0.lazy.map { $0.char }) }).joined(separator: "\n"))
                newY -= 1
            } while !pourSideways(x: x, y: newY) && newY > y
            return newY != y
        }
        func pourSideways(x: Int, y: Int) -> Bool {
            var lX = x
            var rX = x
            var spilled = false
            while map[x: lX, y: y] != .clay {
                let below = map[x: lX, y: y + 1]
                if below == .sand {
                    // print(map.lazy.map({ String($0.lazy.map { $0.char }) }).joined(separator: "\n"))
                    spilled = pourDown(x: lX, y: y) || spilled
                    break
                }
                else if below == .flowingWater {
                    spilled = true
                    break
                }
                map[x: lX, y: y] = .water
                lX -= 1
            }
            while map[x: rX, y: y] != .clay {
                let below = map[x: rX, y: y + 1]
                if below == .sand {
                    // print(map.lazy.map({ String($0.lazy.map { $0.char }) }).joined(separator: "\n"))
                    spilled = pourDown(x: rX, y: y) || spilled
                    break
                }
                else if below == .flowingWater {
                    spilled = true
                    break
                }
                map[x: rX, y: y] = .water
                rX += 1
            }
            if spilled {
                for x in lX...rX {
                    if map[x: x, y: y] == .water {
                        map[x: x, y: y] = .flowingWater
                    }
                }
            }
            return spilled
        }
        let start = DispatchTime.now()
        _ = pourDown(x: 500, y: minY)
        let end = DispatchTime.now()
        let allWater = map.storage.lazy.filter({ $0.isWater }).count
        let containedWater = map.storage.lazy.filter({ $0 == .water }).count
        let endCounting = DispatchTime.now()
        print(map.rows.lazy.map({ String($0.lazy.map { $0.char }) }).joined(separator: "\n"))
        print("""
            All water: \(allWater)
            Contained water: \(containedWater)
            Pour time: \(Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000)µs
            Counting time: \(Double(endCounting.uptimeNanoseconds - end.uptimeNanoseconds) / 1_000)µs
            """)
    }
    
    func solve() {
        let str = Puzzle_2018_17_Input.puzzleInput
        
        let input = str.split(separator: "\n").map { line -> (x: ClosedRange<Int>, y: ClosedRange<Int>) in
            let (a, bstart, bend) = line.split(whereSeparator: { !"0123456789-".contains($0) }).map({ Int($0)! }).tuple3!
            if line.first == "x" {
                return (x: a...a, y: bstart...bend)
            }
            else {
                return (x: bstart...bend, y: a...a)
            }
        }
        
        aocD17(input)
    }
    
    // Once again, I am stumped while being so close to the solution
    // Maybe I will swing back around and revisit this later
    
//    var ground: [[Character]] = []
//    var springLocation: Point2D = Point2D()
//
//    class Vein {
//        var isVertical: Bool = false
//        var fixedCoordinate: Int = 0
//        var rangeLow: Int = 0
//        var rangeHigh: Int = 0
//        var isHorizontal: Bool {
//            return !isVertical
//        }
//    }
//
//    func solve() {
//        //let puzzleInput = Day17PuzzleInput.puzzleInput_test
//        let puzzleInput = Day17PuzzleInput.puzzleInput
//
//        let lines = puzzleInput.parseIntoStringArray()
//        var clayVeins: [Vein] = []
//        for line in lines {
//            let arr = line.capturedGroups(withRegex: "(.*)=(.*), (.*)=(.*)\\.\\.(.*)", trimResults: true)
//            let v = Vein()
//            v.isVertical = (arr[0] == "x")
//            v.fixedCoordinate = Int(arr[1])!
//            v.rangeLow = Int(arr[3])!
//            v.rangeHigh = Int(arr[4])!
//            clayVeins.append(v)
//            if v.rangeLow >= v.rangeHigh {
//                print("Bad dates")
//            }
//        }
//
//        // find the minimum and maximum values
//        var minX = Int.max, minY = Int.max
//        var maxX = Int.min, maxY = Int.min
//        for vein in clayVeins {
//            if vein.isVertical {
//                minX = min(minX, vein.fixedCoordinate)
//                maxX = max(maxX, vein.fixedCoordinate)
//            } else {
//                minY = min(minY, vein.fixedCoordinate)
//                maxY = max(maxY, vein.fixedCoordinate)
//            }
//
//            if vein.isHorizontal {
//                minX = min(minX, vein.rangeLow, vein.rangeHigh)
//                maxX = max(maxX, vein.rangeLow, vein.rangeHigh)
//            } else {
//                minY = min(minY, vein.rangeLow, vein.rangeHigh)
//                maxY = max(maxY, vein.rangeLow, vein.rangeHigh)
//            }
//        }
//
//        // build the ground diagram
//        springLocation = Point2D(x: 500 - minX + 1, y: 0)
//        ground = Array(repeating: Array(repeating: ".", count: (maxX - minX + 3)), count: (maxY + 1))
//        ground[springLocation.y][springLocation.x] = "+"
//        for vein in clayVeins {
//            if vein.isVertical {
//                for y in vein.rangeLow...vein.rangeHigh {
//                    ground[y][vein.fixedCoordinate - minX + 1] = "#"
//                }
//            } else {
//                for x in vein.rangeLow...vein.rangeHigh {
//                    ground[vein.fixedCoordinate][x - minX + 1] = "#"
//                }
//            }
//        }
//
//        //print(groundToString(ground))
//
//        let part1 = solvePart1()
//        print("Part 1 solution: \(part1)")
//        //let part2 = solvePart2(originalSamples: samples, testProgram: testProgram)
//        //print("Part 2 solution: \(part2)")
//    }
//
//    func groundToString(_ ground: [[Character]]) -> String {
//        var retval = ""
//        for line in ground {
//            retval += (String(line) + "\n")
//        }
//
//        return retval
//    }
//
//    func locationConstraints(_ pt: Point2D) -> (Bool, Int, Bool, Int) {
//        var pt = pt
//        var leftPoint = 0, rightPoint = 0
//        var leftBounded = false, rightBounded = false
//
//        var keepLoopingLeft = true
//        while keepLoopingLeft {
//            pt = Point2D(x: pt.x - 1, y: pt.y)
//            if pt.x < 0 {
//                // the left boundary was reached
//                leftPoint = 0
//                leftBounded = false
//                keepLoopingLeft = false
//            } else if ground[pt.y][pt.x] == "#" {
//                // a wall was found, continue
//                leftPoint = pt.x + 1
//                leftBounded = true
//                keepLoopingLeft = false
//            } else if ground[pt.y][pt.x] == "." && ground[pt.y + 1][pt.x] == "." && ground[pt.y + 1][pt.x + 1] == "#" {
//                // a drop point was found
//                leftPoint = pt.x
//                leftBounded = false
//                keepLoopingLeft = false
//            }
//        }
//
//        var keepLoopingRight = true
//        while keepLoopingRight {
//            pt = Point2D(x: pt.x + 1, y: pt.y)
//            if pt.x >= ground[0].count {
//                // the right boundary was reached
//                rightPoint = pt.x - 1
//                rightBounded = false
//                keepLoopingRight = false
//            } else if ground[pt.y][pt.x] == "#" {
//                // a wall was found, continue
//                rightPoint = pt.x - 1
//                rightBounded = true
//                keepLoopingRight = false
//            } else if ground[pt.y][pt.x] == "." && ground[pt.y + 1][pt.x] == "." && pt.x > 0 && ground[pt.y + 1][pt.x - 1] == "#" {
//                // a drop point was found
//                rightPoint = pt.x
//                rightBounded = false
//                keepLoopingRight = false
//            }
//        }
//
//        return (leftBounded, leftPoint, rightBounded, rightPoint)
//    }
//
//    func processWaterFlow(_ originalPoint: Point2D) {
//        var pt = originalPoint
//        if pt.y >= ground.count {
//            // the water flow has reached the bottom of the area
//            return
//        }
//
//        var keepFlowing = true
//        var flowThroughPoints: [Point2D] = []
//        while keepFlowing {
//            if pt.y >= (ground.count - 1) {
//                // the water flow has reached the bottom of the area
//                flowThroughPoints = []
//                keepFlowing = false
//            } else {
//                let nextTile = ground[pt.y + 1][pt.x]
//                if nextTile == "#" {
//                    //print("Stop")
//                    //print("flowThroughPoints: \(flowThroughPoints)")
//                    keepFlowing = false
//                } else if nextTile == "." {
//                    pt = Point2D(x: pt.x, y: pt.y + 1)
//                    flowThroughPoints.append(pt)
//                    ground[pt.y][pt.x] = "|"
//                } else if nextTile == "~" {
//                    keepFlowing = false
////                    if ground[pt.y][pt.x - 1] == "." {
////                        ground[pt.y][pt.x - 1] = "="
////                        flowThroughPoints.append(Point2D(x: pt.x - 1, y: pt.y))
////                        //processWaterFlow(Point2D(x: pt.x - 1, y: pt.y))
////                    }
////
////                    if ground[pt.y][pt.x + 1] == "." {
////                        ground[pt.y][pt.x + 1] = "="
////                        flowThroughPoints.append(Point2D(x: pt.x + 1, y: pt.y))
////                        //processWaterFlow(Point2D(x: pt.x + 1, y: pt.y))
////                    }
//                } else if nextTile == "|" {
//                    keepFlowing = false
//                } else {
//                    print(groundToString(ground))
//                    print("Unknown situation for next tile: \(nextTile) below \(pt)")
//                }
//            }
//        }
//
//        for flowThroughPoint in flowThroughPoints.reversed() {
//            let constraint = locationConstraints(flowThroughPoint)
//            if constraint.0 && constraint.2 {
//                print("\(flowThroughPoint) is constrained to \(constraint)")
//                for x in constraint.1...constraint.3 {
//                    ground[flowThroughPoint.y][x] = "~"
//                }
//            } else if constraint.0 {
//                print("\(flowThroughPoint) is left constrained: \(constraint)")
//                for x in constraint.1...constraint.3 {
//                    ground[flowThroughPoint.y][x] = "|"
//                }
//
//                processWaterFlow(Point2D(x: constraint.3, y: flowThroughPoint.y))
//                //break
//            } else if constraint.2 {
//                print("\(flowThroughPoint) is right constrained: \(constraint)")
//                for x in constraint.1...constraint.3 {
//                    ground[flowThroughPoint.y][x] = "|"
//                }
//
//                processWaterFlow(Point2D(x: constraint.1, y: flowThroughPoint.y))
//                //break
//            } else {
//                print("\(flowThroughPoint) is not constrained: \(constraint)")
//                for x in constraint.1...constraint.3 {
//                    ground[flowThroughPoint.y][x] = "|"
//                }
//
//                processWaterFlow(Point2D(x: constraint.1, y: flowThroughPoint.y))
//                processWaterFlow(Point2D(x: constraint.3, y: flowThroughPoint.y))
//                //break
//            }
//        }
//
//        //print(groundToString(ground))
//    }
//
//    func solvePart1() -> Int {
//        processWaterFlow(springLocation)
//        print("Final ground configuration:")
//        print(groundToString(ground))
//
//        let retval = ground.flatMap { $0 }.filter { $0 == "|" || $0 == "~" }.count
//
//        return retval
//
//    }

}

private class Puzzle_2018_17_Input: NSObject {

    static let puzzleInput_test =
    """
x=495, y=2..7
y=7, x=495..501
x=501, y=3..7
x=498, y=2..4
x=506, y=1..2
x=498, y=10..13
x=504, y=10..13
y=13, x=498..504
"""
    
    static let puzzleInput =
"""
x=732, y=919..935
y=161, x=655..663
x=568, y=1564..1578
x=592, y=708..720
x=598, y=848..851
y=1682, x=699..718
y=1297, x=709..713
y=1138, x=511..514
y=1389, x=517..534
x=688, y=1287..1299
y=134, x=505..509
y=375, x=703..719
x=640, y=1796..1799
x=535, y=747..751
y=1473, x=655..679
x=630, y=848..856
x=646, y=1818..1840
x=625, y=352..380
x=532, y=1791..1816
x=642, y=976..987
x=521, y=70..78
x=590, y=589..593
x=625, y=166..170
y=1507, x=636..643
x=540, y=994..1004
y=1867, x=492..495
x=584, y=1108..1111
y=239, x=725..728
y=901, x=615..622
x=610, y=1493..1496
y=697, x=627..631
y=1439, x=511..536
x=730, y=616..643
y=828, x=720..746
y=1271, x=669..674
y=1670, x=489..491
y=727, x=563..571
x=579, y=400..405
x=719, y=539..542
y=1866, x=672..677
y=1821, x=624..633
y=1737, x=573..580
y=1712, x=590..593
x=689, y=696..706
y=213, x=621..641
x=715, y=644..650
y=469, x=622..632
x=726, y=278..300
y=884, x=634..636
y=284, x=712..715
x=726, y=556..562
x=736, y=1106..1111
y=846, x=654..674
x=674, y=733..760
y=1237, x=648..676
x=526, y=686..704
x=700, y=300..305
y=597, x=517..570
y=526, x=501..509
y=288, x=712..715
x=554, y=479..481
x=488, y=51..65
x=510, y=1626..1642
x=751, y=39..48
x=501, y=355..366
y=1708, x=666..670
x=710, y=1756..1769
y=1207, x=561..568
y=623, x=491..507
x=520, y=888..893
x=594, y=74..75
y=761, x=629..633
y=756, x=729..741
x=748, y=1254..1266
y=1373, x=650..668
x=572, y=891..911
y=1336, x=718..737
x=492, y=1151..1179
y=481, x=554..559
x=638, y=262..267
y=1591, x=564..571
y=162, x=735..737
x=667, y=1163..1175
x=550, y=1474..1487
x=589, y=1346..1358
x=588, y=1515..1519
x=484, y=1658..1673
x=635, y=1796..1799
x=657, y=1633..1635
y=1015, x=635..637
y=1737, x=671..673
y=1476, x=495..501
x=635, y=937..950
y=566, x=639..643
x=580, y=129..131
x=624, y=1501..1513
x=713, y=1009..1023
x=495, y=1840..1867
x=505, y=994..1012
x=718, y=30..36
x=742, y=678..681
x=593, y=234..259
y=170, x=620..625
y=1060, x=515..530
y=754, x=526..541
x=706, y=743..754
x=522, y=427..442
x=506, y=1310..1321
x=604, y=464..467
y=1814, x=714..728
x=604, y=438..441
x=541, y=745..754
y=1280, x=532..545
y=607, x=725..742
x=734, y=941..956
y=621, x=691..694
x=573, y=1679..1685
x=661, y=315..332
x=592, y=1029..1041
y=562, x=726..728
x=641, y=435..454
x=679, y=28..49
y=1301, x=613..627
x=707, y=214..219
x=527, y=73..82
x=486, y=435..436
x=666, y=398..408
y=308, x=505..520
x=651, y=1726..1735
x=559, y=479..481
y=530, x=520..539
y=1788, x=489..495
x=697, y=306..333
x=550, y=271..283
x=594, y=1004..1018
x=662, y=536..539
y=582, x=647..650
x=503, y=1100..1121
x=621, y=1382..1389
y=363, x=514..516
x=576, y=689..691
x=495, y=434..436
y=1333, x=724..730
x=718, y=1693..1704
x=575, y=271..283
x=580, y=1418..1435
x=683, y=257..282
x=655, y=1142..1154
y=616, x=554..572
x=659, y=572..596
x=706, y=615..625
x=747, y=880..893
x=571, y=1473..1487
y=970, x=494..504
x=720, y=969..976
y=500, x=674..699
x=634, y=490..497
x=689, y=1633..1642
y=1407, x=576..580
x=719, y=15..25
x=492, y=1221..1243
x=598, y=1529..1536
x=681, y=135..139
x=543, y=1079..1081
x=624, y=663..666
x=614, y=736..753
x=496, y=1348..1354
x=650, y=576..582
y=1286, x=642..645
x=709, y=1289..1297
x=549, y=1370..1382
y=1122, x=581..583
x=569, y=401..405
x=593, y=1516..1519
x=666, y=1701..1708
x=695, y=816..818
y=941, x=535..563
x=634, y=355..362
y=730, x=645..649
x=654, y=1182..1191
x=690, y=1513..1535
x=583, y=689..691
x=621, y=985..992
x=652, y=1182..1191
y=1528, x=652..655
x=598, y=1461..1472
x=532, y=522..524
y=589, x=586..590
x=646, y=1629..1642
x=482, y=327..352
y=908, x=720..748
x=640, y=1310..1321
x=673, y=180..182
y=1578, x=568..689
x=703, y=373..375
x=582, y=1611..1628
y=1058, x=609..611
x=742, y=1472..1486
x=634, y=1722..1741
x=650, y=1347..1373
y=182, x=696..701
y=1695, x=552..556
x=547, y=448..459
x=701, y=742..766
y=1582, x=728..732
x=552, y=1685..1695
y=684, x=602..611
y=332, x=618..631
x=594, y=1753..1755
x=742, y=598..607
y=448, x=654..656
x=732, y=1091..1095
x=513, y=915..931
x=689, y=1564..1578
x=628, y=520..523
y=1603, x=593..608
y=1248, x=517..541
y=811, x=533..548
x=625, y=481..503
x=729, y=750..756
x=593, y=1597..1603
x=606, y=1010..1013
y=1242, x=597..602
y=91, x=661..684
x=606, y=1439..1452
y=509, x=705..720
y=1805, x=567..570
x=571, y=1424..1429
x=535, y=412..422
x=664, y=1629..1642
x=511, y=1506..1510
y=1807, x=719..721
x=553, y=1588..1600
y=490, x=634..636
x=482, y=532..541
y=1642, x=689..706
x=689, y=1397..1418
x=612, y=393..400
x=634, y=874..884
x=575, y=955..958
y=1109, x=600..622
x=750, y=841..863
x=588, y=431..433
x=504, y=968..970
x=498, y=734..736
x=618, y=320..332
x=554, y=606..616
x=540, y=1017..1043
x=676, y=1226..1237
x=489, y=1012..1036
x=494, y=969..970
y=1379, x=556..560
x=732, y=1641..1654
y=182, x=648..673
x=496, y=56..60
x=685, y=1438..1447
x=543, y=760..784
y=1794, x=662..686
x=583, y=1118..1122
x=662, y=1780..1794
x=520, y=292..308
x=674, y=1043..1046
y=139, x=541..543
x=596, y=163..181
y=919, x=684..712
x=701, y=143..148
y=560, x=482..502
x=557, y=294..306
x=599, y=460..470
x=657, y=920..927
y=1125, x=528..549
y=467, x=604..607
x=522, y=1160..1179
y=1378, x=526..528
x=714, y=100..119
y=1183, x=573..577
x=600, y=1096..1109
y=1216, x=632..654
x=618, y=1329..1357
x=617, y=1238..1262
y=1054, x=735..748
y=1003, x=734..740
y=39, x=486..492
y=1266, x=748..750
x=714, y=315..341
x=631, y=319..332
y=1216, x=576..596
x=521, y=234..246
x=699, y=1719..1728
x=683, y=1367..1385
x=752, y=1161..1173
y=972, x=731..747
x=611, y=1054..1058
x=741, y=1787..1811
y=60, x=496..500
x=618, y=1753..1755
x=685, y=436..446
x=597, y=1774..1776
x=541, y=1838..1859
y=1027, x=702..707
x=705, y=934..961
y=1765, x=718..720
y=1041, x=592..612
x=676, y=82..88
y=523, x=628..633
x=708, y=1742..1745
x=647, y=15..20
x=685, y=664..690
y=799, x=599..604
x=734, y=211..234
x=558, y=832..857
x=653, y=1328..1338
y=747, x=533..535
x=612, y=422..431
x=498, y=1348..1354
x=730, y=1328..1333
y=317, x=488..492
x=512, y=653..668
x=677, y=937..958
y=120, x=741..743
x=677, y=276..294
x=655, y=1526..1528
y=1533, x=639..664
y=539, x=642..662
y=1059, x=488..492
y=1246, x=551..567
y=1240, x=523..526
x=730, y=1010..1023
x=519, y=70..78
y=64, x=567..590
y=222, x=652..658
x=635, y=922..925
x=658, y=1048..1076
x=728, y=1802..1814
x=583, y=431..433
y=1456, x=666..691
x=673, y=1716..1737
y=1239, x=636..645
x=493, y=1255..1259
y=1321, x=506..531
x=527, y=215..227
y=851, x=588..598
x=505, y=292..308
y=470, x=599..614
x=506, y=1506..1522
y=503, x=625..642
x=557, y=761..784
x=488, y=303..317
x=676, y=98..109
y=1013, x=606..608
x=695, y=896..904
x=656, y=1787..1806
y=232, x=631..633
y=113, x=557..585
y=609, x=606..613
x=501, y=427..442
x=724, y=170..172
y=1535, x=687..690
x=689, y=1167..1174
y=558, x=653..658
x=548, y=417..419
y=202, x=524..526
x=562, y=305..310
y=928, x=617..641
x=633, y=392..400
y=1715, x=563..582
x=621, y=439..441
x=637, y=1550..1552
y=133, x=541..543
y=1474, x=495..501
y=1732, x=499..527
y=1006, x=682..684
x=696, y=1038..1052
x=587, y=1078..1103
x=677, y=1840..1853
x=661, y=1184..1194
x=518, y=174..184
x=541, y=133..139
y=97, x=567..579
x=732, y=1577..1582
x=515, y=915..931
x=690, y=1257..1266
x=746, y=806..828
x=582, y=1709..1715
x=663, y=1049..1076
x=647, y=576..582
y=1122, x=677..686
y=207, x=552..576
x=501, y=1186..1211
x=536, y=994..1004
x=691, y=645..650
x=487, y=876..901
x=675, y=1515..1533
x=654, y=791..802
y=732, x=645..649
y=1870, x=667..683
x=511, y=151..165
y=124, x=609..621
x=561, y=236..245
x=612, y=353..380
x=595, y=1782..1796
x=576, y=586..597
x=551, y=219..221
x=531, y=1487..1510
y=1102, x=647..659
x=492, y=1841..1867
y=139, x=666..681
y=478, x=707..729
y=1536, x=598..608
x=553, y=219..221
x=575, y=1678..1685
x=524, y=259..262
y=283, x=550..575
x=705, y=1330..1348
x=615, y=897..901
y=408, x=650..666
y=142, x=529..552
y=651, x=611..614
x=632, y=444..469
y=1064, x=482..498
y=893, x=520..538
y=1741, x=626..634
x=616, y=1117..1131
x=648, y=179..182
y=1170, x=658..661
y=446, x=685..711
y=1799, x=635..640
y=925, x=632..635
y=944, x=644..647
x=744, y=880..893
x=713, y=229..233
y=1493, x=638..654
x=549, y=1330..1337
y=1606, x=617..629
y=754, x=706..709
y=84, x=731..752
y=1428, x=515..533
x=594, y=1437..1449
x=623, y=758..779
x=522, y=1837..1859
x=566, y=651..658
y=759, x=647..671
x=576, y=19..45
x=565, y=474..484
x=631, y=421..431
x=693, y=1719..1728
y=341, x=714..729
y=987, x=642..666
x=742, y=774..793
x=530, y=837..842
x=509, y=1198..1213
x=611, y=1550..1552
x=620, y=536..549
y=958, x=677..680
y=650, x=691..715
x=501, y=1657..1673
y=1776, x=588..597
x=527, y=1712..1732
y=700, x=615..640
x=495, y=1194..1207
x=629, y=790..800
x=488, y=1059..1061
y=1791, x=701..720
y=668, x=489..512
x=590, y=1696..1712
y=638, x=611..627
x=639, y=711..715
x=562, y=174..184
x=673, y=1204..1212
x=552, y=194..207
y=1360, x=488..511
x=638, y=1401..1411
x=619, y=985..992
y=1685, x=573..575
x=661, y=1170..1172
x=643, y=1504..1507
x=722, y=472..474
x=678, y=816..818
y=1402, x=702..720
x=604, y=787..799
x=563, y=1709..1715
y=1687, x=522..542
x=543, y=1524..1538
x=719, y=1092..1095
x=539, y=110..120
x=686, y=1781..1794
y=211, x=608..615
y=120, x=517..539
x=669, y=1010..1017
x=489, y=1668..1670
x=753, y=1802..1829
x=734, y=171..172
y=25, x=719..722
y=621, x=536..542
y=690, x=685..712
y=1510, x=531..545
x=530, y=273..297
x=615, y=831..833
x=603, y=742..745
x=598, y=1437..1449
y=785, x=711..729
x=658, y=1170..1172
y=825, x=497..515
x=633, y=761..770
x=609, y=62..75
y=554, x=532..573
y=565, x=685..693
x=483, y=597..611
x=654, y=1483..1493
x=578, y=1450..1456
x=697, y=1309..1321
x=685, y=538..565
y=1816, x=532..540
x=704, y=1088..1091
x=659, y=1788..1806
x=559, y=1280..1299
y=669, x=655..662
y=1542, x=499..508
x=578, y=1864..1868
x=481, y=908..916
y=754, x=653..659
y=1570, x=708..729
x=701, y=270..295
x=641, y=1348..1359
x=592, y=832..833
x=537, y=1519..1526
x=611, y=666..684
y=664, x=499..506
x=653, y=542..558
x=642, y=858..867
x=622, y=896..901
y=522, x=527..532
x=720, y=1042..1062
y=1856, x=625..647
y=1111, x=736..751
x=677, y=505..513
y=1431, x=606..625
x=621, y=1510..1519
y=1377, x=556..560
x=728, y=1104..1113
x=613, y=1283..1301
y=985, x=632..638
x=706, y=1228..1242
y=1146, x=721..745
x=535, y=295..306
x=660, y=794..797
y=1243, x=484..492
x=699, y=505..513
x=723, y=845..850
x=572, y=605..616
y=524, x=527..532
x=712, y=893..919
y=643, x=730..751
x=542, y=1684..1687
x=654, y=1633..1635
x=516, y=461..486
x=738, y=1449..1451
x=661, y=77..91
y=513, x=677..699
x=576, y=193..207
x=567, y=1785..1805
y=576, x=647..650
x=516, y=1316..1318
x=519, y=398..421
y=992, x=717..736
x=735, y=1030..1054
x=718, y=1753..1765
y=1113, x=725..728
y=459, x=538..547
x=640, y=689..700
x=662, y=661..669
x=481, y=32..43
x=647, y=1694..1698
y=103, x=668..670
x=632, y=790..800
y=1621, x=688..704
x=511, y=374..385
x=599, y=787..799
x=719, y=677..681
x=627, y=1384..1394
y=380, x=612..625
x=509, y=532..541
x=684, y=624..643
y=857, x=558..562
x=703, y=1367..1385
y=1642, x=646..664
y=433, x=583..588
y=1348, x=705..710
y=1840, x=646..650
x=619, y=65..70
x=671, y=29..49
x=528, y=638..658
x=578, y=1587..1600
y=1403, x=739..748
x=597, y=218..223
x=676, y=143..148
x=545, y=716..722
x=514, y=431..437
x=679, y=1469..1473
x=586, y=589..593
x=516, y=359..363
x=710, y=1331..1348
y=1443, x=498..505
x=694, y=1061..1081
y=208, x=645..660
x=728, y=557..562
y=745, x=598..603
y=1811, x=737..741
y=88, x=676..678
x=742, y=841..863
x=655, y=781..784
y=97, x=485..488
x=577, y=1542..1556
x=567, y=515..526
x=612, y=1694..1713
x=654, y=97..109
x=614, y=460..470
y=1842, x=558..573
x=617, y=496..500
y=1394, x=611..627
x=613, y=535..549
x=679, y=1499..1507
x=665, y=834..843
x=556, y=1231..1240
y=1076, x=658..663
x=670, y=1395..1403
x=602, y=666..684
x=694, y=1124..1137
x=562, y=562..575
x=737, y=1788..1811
x=620, y=507..520
x=662, y=1262..1275
x=733, y=543..568
x=703, y=572..591
x=517, y=110..120
x=571, y=651..658
x=500, y=56..60
x=734, y=995..1003
x=743, y=210..234
x=691, y=1433..1456
y=1318, x=516..520
x=648, y=782..784
y=681, x=719..742
x=660, y=356..362
y=1662, x=540..716
x=599, y=496..500
x=645, y=1163..1175
x=576, y=1210..1216
x=517, y=9..22
x=580, y=1384..1407
x=632, y=1204..1216
x=712, y=284..288
x=666, y=595..610
y=1804, x=625..649
x=702, y=1587..1600
x=638, y=1484..1493
x=499, y=662..664
y=611, x=561..564
x=498, y=1293..1308
x=694, y=599..621
x=547, y=891..911
x=573, y=1157..1183
x=598, y=248..256
y=759, x=497..505
x=641, y=201..213
x=620, y=34..39
x=636, y=490..497
x=696, y=1630..1638
y=403, x=655..657
y=1007, x=560..580
y=1136, x=511..514
x=745, y=1165..1169
y=1095, x=719..732
x=594, y=1144..1150
x=741, y=749..756
x=725, y=598..607
y=472, x=713..722
y=442, x=501..522
y=977, x=565..574
x=737, y=775..793
x=729, y=315..341
x=509, y=126..134
x=514, y=783..804
x=561, y=603..611
x=650, y=1710..1722
y=437, x=514..516
x=515, y=1400..1428
y=475, x=696..698
y=1338, x=627..653
y=1722, x=647..650
x=539, y=518..530
x=583, y=921..929
y=820, x=644..647
y=454, x=641..665
x=494, y=551..553
y=175, x=491..499
y=1004, x=536..540
y=1429, x=571..573
x=492, y=303..317
y=1231, x=556..558
y=1038, x=551..556
x=668, y=101..103
y=735, x=619..621
x=642, y=537..539
x=721, y=301..305
y=1486, x=742..749
x=565, y=961..977
y=863, x=684..688
x=536, y=1436..1439
y=22, x=499..517
x=637, y=1004..1015
x=663, y=1410..1417
x=636, y=1071..1085
y=1061, x=584..622
y=352, x=482..494
x=505, y=166..177
y=1452, x=586..606
x=529, y=152..165
y=1179, x=481..492
x=712, y=1668..1679
y=441, x=604..621
x=517, y=129..141
y=1091, x=691..704
x=636, y=1504..1507
y=1526, x=516..537
x=577, y=1158..1183
x=670, y=1700..1708
x=485, y=1625..1642
x=710, y=1710..1719
y=506, x=531..578
x=615, y=688..700
x=596, y=19..45
y=715, x=609..639
x=686, y=1253..1260
x=701, y=191..211
x=748, y=1385..1403
x=695, y=66..72
x=511, y=1136..1138
x=624, y=1818..1821
x=699, y=1630..1638
y=245, x=545..561
y=592, x=553..563
y=45, x=576..596
x=658, y=543..558
y=1084, x=530..549
x=641, y=918..928
x=654, y=836..846
x=663, y=149..161
x=688, y=1819..1831
x=492, y=1059..1061
x=589, y=73..75
y=1081, x=694..697
y=541, x=482..509
x=531, y=990..1013
x=611, y=651..655
x=563, y=586..592
x=655, y=660..669
y=877, x=611..620
y=180, x=712..728
y=385, x=580..598
y=766, x=693..701
y=1600, x=677..702
x=557, y=8..28
x=684, y=998..1006
x=626, y=1673..1678
y=629, x=641..649
x=494, y=909..916
x=608, y=248..256
x=551, y=1021..1038
x=540, y=1649..1662
x=556, y=1684..1695
y=1382, x=549..569
x=625, y=1791..1804
x=607, y=873..883
x=541, y=1237..1248
x=524, y=90..103
x=567, y=1227..1246
x=625, y=120..134
x=751, y=1105..1111
x=649, y=611..629
x=635, y=727..737
x=647, y=1082..1102
x=614, y=1330..1357
x=588, y=1236..1239
x=491, y=1668..1670
y=500, x=599..617
x=743, y=1819..1831
x=517, y=1237..1248
x=615, y=193..211
x=744, y=140..165
x=629, y=761..770
x=737, y=39..48
y=1745, x=691..708
y=1728, x=693..699
y=1239, x=586..588
x=668, y=1242..1251
x=651, y=248..258
y=958, x=575..598
y=574, x=674..682
x=514, y=296..303
x=720, y=1753..1765
x=605, y=1389..1413
x=501, y=1474..1476
y=523, x=579..582
y=1864, x=672..677
x=707, y=463..478
x=627, y=695..697
x=601, y=331..345
x=523, y=1240..1244
x=552, y=452..464
y=56, x=496..500
x=500, y=128..141
x=664, y=857..867
x=591, y=781..807
y=667, x=701..703
x=744, y=452..477
x=712, y=175..180
x=599, y=1693..1713
x=620, y=673..675
x=545, y=1488..1510
y=1262, x=612..617
x=552, y=130..142
x=564, y=66..72
x=560, y=1377..1379
x=682, y=1150..1178
y=300, x=726..752
x=714, y=1258..1266
x=752, y=76..84
y=706, x=689..703
x=719, y=225..237
x=708, y=1555..1570
x=533, y=747..751
y=658, x=528..539
x=703, y=667..675
x=696, y=1458..1467
y=1207, x=492..495
y=75, x=589..594
y=1169, x=738..745
y=227, x=501..527
x=653, y=751..754
x=526, y=744..754
x=645, y=1268..1286
x=702, y=1713..1724
x=642, y=1444..1455
x=574, y=422..439
x=708, y=969..976
y=1713, x=599..612
x=684, y=845..863
y=139, x=646..661
x=562, y=431..441
x=627, y=1006..1018
x=580, y=994..1007
x=585, y=562..575
x=662, y=1245..1254
x=504, y=876..901
x=508, y=993..1012
x=568, y=1723..1745
x=738, y=1694..1704
y=1018, x=594..614
x=749, y=1473..1486
x=709, y=744..754
x=568, y=1524..1538
x=711, y=435..446
x=728, y=175..180
x=527, y=1617..1631
x=710, y=420..424
x=576, y=1384..1407
x=482, y=843..863
x=499, y=1534..1542
y=1178, x=682..700
x=738, y=1165..1169
x=568, y=1017..1043
y=1081, x=540..543
y=1519, x=588..593
x=720, y=846..850
x=561, y=1482..1484
x=719, y=1363..1386
y=1194, x=643..661
x=651, y=1395..1403
x=619, y=1402..1411
y=1829, x=751..753
x=712, y=855..868
y=1489, x=585..607
x=560, y=993..1007
y=742, x=598..603
y=850, x=720..723
y=1615, x=695..698
y=946, x=644..647
x=739, y=1386..1403
y=1010, x=606..608
x=604, y=1144..1150
x=512, y=1756..1764
x=647, y=810..820
x=621, y=103..124
y=804, x=612..638
x=680, y=938..958
x=505, y=742..759
x=682, y=560..574
x=609, y=1293..1296
y=1337, x=537..549
y=1447, x=673..685
y=963, x=511..514
x=657, y=1725..1735
y=1526, x=652..655
x=556, y=1377..1379
x=548, y=255..266
x=712, y=1710..1719
x=525, y=1160..1179
y=267, x=629..638
x=606, y=981..995
y=1504, x=636..643
y=109, x=654..676
x=652, y=212..222
x=543, y=474..484
x=625, y=1852..1856
y=1467, x=696..704
x=719, y=373..375
x=609, y=711..715
x=705, y=494..509
x=533, y=789..811
y=1147, x=647..649
x=515, y=1052..1060
y=1510, x=511..517
x=552, y=233..242
y=1354, x=496..498
x=717, y=988..992
x=661, y=119..139
x=627, y=62..75
y=1725, x=517..519
x=712, y=663..690
y=1326, x=563..566
x=539, y=717..722
x=538, y=887..893
x=584, y=129..131
x=539, y=638..658
y=793, x=737..742
y=181, x=596..600
y=553, x=487..494
x=523, y=273..297
x=488, y=1336..1360
y=1435, x=565..580
y=1417, x=663..673
x=681, y=305..333
x=569, y=1370..1382
x=506, y=662..664
x=573, y=1733..1737
x=673, y=1409..1417
y=136, x=653..655
x=512, y=332..345
x=593, y=123..136
x=755, y=1840..1853
x=593, y=1695..1712
x=726, y=540..542
y=1141, x=501..521
x=563, y=939..941
x=491, y=614..623
x=600, y=647..658
y=464, x=604..607
x=588, y=1774..1776
x=688, y=845..863
x=603, y=1803..1808
x=737, y=1641..1654
x=596, y=587..597
x=594, y=423..439
x=697, y=1061..1081
y=1673, x=484..501
y=720, x=592..648
y=28, x=557..564
x=521, y=1130..1141
x=579, y=922..929
y=225, x=542..559
y=784, x=543..557
x=509, y=254..266
y=405, x=569..579
y=863, x=742..750
x=511, y=72..82
x=698, y=419..424
x=692, y=100..119
x=488, y=78..97
y=1174, x=687..689
x=650, y=1819..1840
x=535, y=938..941
y=1043, x=540..568
y=985, x=619..621
y=385, x=511..537
y=1038, x=597..603
y=916, x=481..494
x=526, y=1240..1244
x=608, y=193..211
y=259, x=593..620
x=703, y=696..706
x=648, y=1407..1424
x=715, y=284..288
x=622, y=24..26
x=564, y=305..310
x=627, y=1284..1301
x=517, y=1506..1510
x=679, y=475..491
x=633, y=572..596
x=634, y=1345..1356
y=931, x=513..515
x=683, y=1861..1870
x=537, y=1331..1337
y=1513, x=624..651
x=489, y=1777..1788
x=491, y=1099..1121
x=533, y=259..262
y=1357, x=614..618
y=961, x=705..717
y=1131, x=616..645
y=976, x=708..720
x=568, y=382..388
y=802, x=654..671
y=26, x=622..629
x=634, y=903..905
x=611, y=871..877
y=1600, x=553..578
x=677, y=1864..1866
x=658, y=211..222
y=119, x=692..714
x=666, y=975..987
x=662, y=1357..1368
x=674, y=560..574
x=589, y=514..526
y=1638, x=696..699
x=720, y=493..509
x=588, y=849..851
x=519, y=1254..1259
x=548, y=395..404
x=617, y=918..928
y=1386, x=719..735
y=1259, x=493..519
x=748, y=1031..1054
y=1211, x=485..501
x=719, y=1807..1810
x=526, y=1370..1378
x=610, y=410..413
x=500, y=1506..1522
x=526, y=394..404
y=234, x=734..743
x=524, y=193..202
x=667, y=1860..1870
x=532, y=1261..1280
x=706, y=1632..1642
x=623, y=518..531
x=705, y=1511..1531
y=248, x=598..608
x=678, y=82..88
x=549, y=66..72
x=590, y=1781..1796
y=303, x=512..514
x=526, y=193..202
x=609, y=102..124
x=529, y=862..872
x=612, y=1071..1085
y=177, x=539..541
y=1724, x=702..718
x=664, y=1524..1533
y=223, x=570..597
y=1358, x=578..589
x=704, y=1457..1467
y=1413, x=602..605
x=597, y=1027..1038
y=1842, x=602..609
y=658, x=566..571
y=1700, x=726..728
x=675, y=595..610
x=631, y=1444..1455
y=1755, x=594..618
x=584, y=1050..1061
y=735, x=741..745
x=621, y=728..735
x=609, y=1054..1058
x=606, y=591..609
x=566, y=781..807
x=553, y=586..592
x=492, y=29..39
x=556, y=1021..1038
x=721, y=1807..1810
x=537, y=375..385
x=498, y=1040..1064
x=654, y=812..825
x=710, y=1668..1679
y=1012, x=505..508
x=516, y=431..437
x=646, y=1481..1488
y=1046, x=674..682
x=545, y=235..245
x=696, y=453..475
y=1538, x=543..568
x=625, y=1421..1431
x=695, y=856..868
y=1679, x=710..712
x=542, y=610..621
x=655, y=1470..1473
y=421, x=515..519
y=1519, x=618..621
x=499, y=1454..1458
x=721, y=1133..1146
x=549, y=1120..1125
y=205, x=516..534
y=742, x=581..585
x=724, y=1328..1333
x=687, y=258..282
x=540, y=1079..1081
x=638, y=1461..1472
x=564, y=8..28
x=519, y=1618..1631
x=629, y=262..267
y=131, x=580..584
y=275, x=732..743
x=663, y=771..783
x=629, y=25..26
y=413, x=610..637
y=172, x=724..734
x=531, y=1310..1321
y=848, x=571..578
y=345, x=512..601
x=725, y=1104..1113
x=711, y=777..785
x=701, y=1777..1791
y=927, x=657..677
x=495, y=1778..1788
x=589, y=1116..1125
y=1212, x=673..685
y=72, x=549..564
x=609, y=1816..1842
x=600, y=164..181
x=528, y=1370..1378
x=623, y=876..889
x=647, y=1853..1856
x=736, y=1284..1292
y=783, x=663..683
y=556, x=696..707
x=570, y=584..597
x=639, y=1141..1154
x=515, y=398..421
x=517, y=583..597
y=1418, x=684..689
x=702, y=1014..1027
x=714, y=1801..1814
x=622, y=445..469
x=560, y=1553..1559
x=718, y=1325..1336
y=1079, x=540..543
x=551, y=429..438
x=620, y=167..170
x=495, y=1474..1476
x=706, y=1039..1052
y=295, x=701..723
x=643, y=1007..1018
x=618, y=1510..1519
y=950, x=635..653
y=177, x=505..508
y=1552, x=611..637
x=682, y=733..760
x=633, y=520..523
y=575, x=562..585
x=514, y=359..363
x=737, y=1325..1336
x=614, y=669..679
x=676, y=1542..1556
y=136, x=571..593
y=78, x=519..521
x=656, y=728..737
y=1678, x=618..626
x=560, y=413..422
x=606, y=627..638
x=598, y=371..385
x=625, y=1367..1377
x=686, y=573..591
x=699, y=498..500
x=542, y=1342..1362
x=597, y=1229..1242
y=903, x=634..645
x=563, y=1325..1326
x=745, y=717..735
y=1013, x=531..546
x=485, y=79..97
x=713, y=472..474
x=543, y=133..139
y=1631, x=519..527
y=1748, x=712..731
x=565, y=1417..1435
x=620, y=871..877
y=1859, x=522..541
x=673, y=315..332
y=229, x=711..713
y=82, x=511..527
y=294, x=662..677
x=579, y=520..523
x=564, y=1591..1594
y=593, x=586..590
x=548, y=789..811
x=710, y=1511..1531
x=627, y=16..20
y=1449, x=594..598
x=677, y=920..927
y=1385, x=683..703
x=684, y=77..91
x=741, y=103..120
x=608, y=1530..1536
x=612, y=1030..1041
x=696, y=166..182
x=619, y=729..735
x=498, y=1442..1443
x=728, y=1162..1173
x=608, y=1598..1603
x=731, y=1735..1748
y=1172, x=658..661
y=148, x=676..701
y=610, x=666..675
x=735, y=1363..1386
x=599, y=874..883
x=639, y=757..779
x=671, y=1286..1299
y=1191, x=652..654
y=404, x=526..548
x=586, y=1236..1239
y=1507, x=668..679
x=752, y=278..300
y=424, x=698..710
y=1628, x=582..592
y=1328, x=724..730
x=669, y=1067..1072
x=712, y=1123..1137
x=712, y=615..625
x=499, y=173..175
y=1151, x=647..649
x=503, y=462..486
y=19, x=506..509
y=833, x=592..615
y=1403, x=651..670
x=562, y=833..857
x=641, y=247..258
y=542, x=719..726
y=428, x=733..753
x=723, y=271..295
x=520, y=517..530
x=646, y=120..139
x=683, y=770..783
x=645, y=1694..1698
x=516, y=195..205
x=670, y=474..491
x=578, y=1345..1358
x=628, y=670..679
x=533, y=1401..1428
x=725, y=227..239
x=531, y=494..506
y=526, x=567..589
y=1831, x=688..743
y=751, x=533..535
x=485, y=1463..1479
x=722, y=14..25
x=617, y=1605..1606
x=645, y=195..208
y=1207, x=731..739
x=621, y=200..213
x=526, y=1755..1764
x=596, y=1209..1216
x=731, y=964..972
x=698, y=1608..1615
x=571, y=845..848
x=538, y=448..459
x=684, y=1398..1418
x=499, y=8..22
x=580, y=1733..1737
x=645, y=1232..1239
x=573, y=1115..1125
y=591, x=686..703
x=622, y=1494..1496
y=134, x=625..640
y=43, x=481..499
y=655, x=611..614
x=601, y=299..314
y=1654, x=732..737
y=1487, x=550..571
y=1806, x=656..659
x=751, y=615..643
y=1522, x=500..506
y=233, x=711..713
x=731, y=1189..1207
y=753, x=592..614
y=333, x=681..697
y=842, x=530..550
x=552, y=686..704
y=994, x=536..540
x=672, y=1864..1866
x=612, y=1238..1262
y=1198, x=532..554
x=643, y=1481..1488
x=572, y=451..464
x=546, y=862..872
x=671, y=1717..1737
x=643, y=548..566
y=1240, x=556..558
y=72, x=687..695
x=678, y=1244..1254
x=499, y=31..43
x=681, y=215..219
y=1085, x=612..636
x=581, y=1118..1122
x=654, y=1205..1216
y=596, x=633..659
x=559, y=626..638
y=520, x=607..620
x=591, y=1079..1103
x=545, y=1261..1280
x=509, y=499..526
x=677, y=1586..1600
x=629, y=899..908
x=636, y=813..825
y=804, x=514..521
x=515, y=813..825
x=636, y=1231..1239
x=662, y=276..294
y=474, x=713..722
x=728, y=140..165
y=1374, x=617..619
x=617, y=1365..1374
x=484, y=1220..1243
y=497, x=634..636
x=506, y=6..19
y=1356, x=632..634
y=324, x=526..590
x=665, y=436..454
x=511, y=52..65
y=1299, x=671..688
x=508, y=1534..1542
y=549, x=613..620
x=733, y=423..428
y=1084, x=671..687
x=751, y=399..401
x=509, y=843..863
x=481, y=1152..1179
y=1175, x=645..667
y=1260, x=684..686
x=753, y=543..568
x=701, y=667..675
x=684, y=1254..1260
y=1735, x=651..657
y=259, x=524..533
y=1179, x=522..525
y=1154, x=639..655
x=729, y=462..478
x=618, y=1673..1678
x=514, y=943..963
x=718, y=1670..1682
y=1451, x=715..738
y=1244, x=523..526
y=441, x=542..562
y=1017, x=649..669
y=1796, x=635..640
x=622, y=1051..1061
y=1810, x=719..721
x=614, y=651..655
y=896, x=695..703
y=436, x=486..495
y=1299, x=556..559
x=519, y=1717..1725
x=567, y=97..101
y=1296, x=585..609
y=904, x=695..703
x=677, y=1110..1122
y=770, x=629..633
x=559, y=216..225
x=653, y=937..950
x=647, y=1711..1722
x=526, y=1343..1362
x=618, y=1382..1389
x=671, y=748..759
y=760, x=674..682
y=1254, x=662..678
y=807, x=566..591
x=494, y=327..352
x=486, y=29..39
x=582, y=520..523
y=48, x=737..751
x=645, y=730..732
y=305, x=700..721
x=571, y=124..136
x=571, y=707..727
x=487, y=551..553
x=680, y=1261..1275
x=640, y=121..134
x=735, y=154..162
y=905, x=634..645
x=657, y=401..403
y=1292, x=723..736
x=574, y=1863..1868
x=631, y=695..697
x=633, y=216..232
x=512, y=296..303
y=1496, x=610..622
x=613, y=592..609
x=698, y=453..475
x=541, y=177..179
x=644, y=958..970
x=649, y=1791..1804
x=728, y=1691..1700
y=1853, x=677..755
x=564, y=603..611
x=527, y=522..524
x=599, y=1272..1289
y=893, x=744..747
x=709, y=1043..1062
x=608, y=1010..1013
x=585, y=1292..1296
x=729, y=1555..1570
x=501, y=1129..1141
x=674, y=1259..1271
x=674, y=497..500
y=1137, x=694..712
x=581, y=730..742
x=666, y=1433..1456
x=693, y=743..766
x=534, y=196..205
x=656, y=898..908
x=622, y=673..675
x=686, y=1110..1122
y=1023, x=713..730
y=1213, x=509..519
y=101, x=567..579
y=400, x=612..633
x=717, y=1229..1242
x=656, y=439..448
x=602, y=1228..1242
x=516, y=1519..1526
x=701, y=167..182
y=597, x=576..596
x=750, y=452..477
x=558, y=1132..1137
x=505, y=126..134
x=509, y=1463..1479
x=614, y=1004..1018
x=633, y=1818..1821
x=668, y=834..843
x=499, y=89..103
x=558, y=1231..1240
y=258, x=641..651
x=704, y=31..36
x=726, y=1691..1700
y=419, x=548..550
x=518, y=735..736
y=1488, x=643..646
x=619, y=849..856
x=654, y=439..448
x=702, y=1396..1402
y=929, x=579..583
y=266, x=509..548
x=567, y=50..64
x=720, y=940..956
x=497, y=598..611
x=629, y=1604..1606
y=1745, x=568..592
x=695, y=1608..1615
y=658, x=600..620
y=1769, x=710..730
x=598, y=954..958
y=422, x=535..560
x=638, y=984..985
x=653, y=133..136
y=1150, x=594..604
x=691, y=1089..1091
y=141, x=500..517
y=675, x=620..622
x=568, y=1197..1207
x=556, y=1279..1299
x=649, y=1147..1151
y=366, x=501..522
y=282, x=683..687
y=70, x=714..727
x=632, y=1345..1356
y=1635, x=654..657
y=1173, x=728..752
x=613, y=298..314
x=507, y=614..623
x=717, y=933..961
x=578, y=844..848
x=645, y=903..905
x=655, y=149..161
y=427, x=623..625
x=542, y=432..441
x=611, y=620..638
y=889, x=623..642
x=644, y=944..946
x=570, y=1784..1805
y=704, x=526..552
y=306, x=535..557
x=620, y=958..970
x=532, y=1194..1198
x=625, y=1347..1359
x=688, y=1611..1621
x=530, y=1052..1060
y=262, x=524..533
x=633, y=298..310
x=590, y=50..64
x=638, y=783..804
x=626, y=1722..1741
y=1559, x=560..572
x=554, y=429..438
y=1594, x=564..571
y=1368, x=655..662
x=632, y=922..925
y=568, x=733..753
x=492, y=1194..1207
y=49, x=671..679
x=564, y=1482..1484
x=602, y=1389..1413
y=184, x=518..562
x=497, y=741..759
x=509, y=6..19
y=1389, x=618..621
x=668, y=1499..1507
x=573, y=1833..1842
x=501, y=498..526
x=732, y=271..275
x=522, y=356..366
y=1121, x=491..503
y=1316, x=516..520
y=800, x=629..632
x=639, y=1523..1533
x=682, y=1044..1046
x=659, y=751..754
y=797, x=660..663
y=970, x=620..644
y=211, x=676..701
x=592, y=737..753
y=1242, x=706..717
y=1036, x=489..495
y=1362, x=526..542
x=620, y=233..259
x=675, y=341..349
x=647, y=1147..1151
x=574, y=961..977
x=649, y=1011..1017
y=1061, x=488..492
x=612, y=782..804
x=563, y=707..727
x=693, y=538..565
x=602, y=1815..1842
x=675, y=985..1013
y=1868, x=574..578
x=666, y=136..139
x=491, y=174..175
y=20, x=627..647
x=514, y=1136..1138
x=641, y=610..629
x=607, y=508..520
x=575, y=1273..1289
x=614, y=65..70
x=565, y=1450..1456
x=555, y=233..242
x=740, y=995..1003
x=672, y=1242..1251
x=676, y=191..211
y=1719, x=710..712
x=655, y=133..136
x=497, y=814..825
x=670, y=101..103
y=625, x=706..712
x=647, y=747..759
y=911, x=547..572
y=1321, x=640..697
y=1808, x=603..605
y=491, x=670..679
x=603, y=1027..1038
x=728, y=226..239
x=720, y=1396..1402
x=690, y=986..1013
y=666, x=624..627
y=908, x=629..656
x=729, y=777..785
x=643, y=1185..1194
y=477, x=744..750
x=489, y=654..668
x=578, y=494..506
y=1472, x=598..638
y=484, x=543..565
x=723, y=1285..1292
x=639, y=547..566
x=647, y=944..946
y=1456, x=565..578
y=872, x=529..546
y=611, x=483..497
y=520, x=579..582
y=401, x=743..751
x=743, y=400..401
x=526, y=313..324
y=901, x=487..504
y=935, x=732..750
y=1052, x=696..706
y=643, x=657..684
x=703, y=225..237
x=687, y=1083..1084
x=561, y=382..388
x=646, y=271..276
x=522, y=1684..1687
x=751, y=1801..1829
y=221, x=551..553
y=586, x=553..563
x=660, y=195..208
x=671, y=791..802
y=956, x=720..734
x=536, y=609..621
y=1021, x=551..556
y=1698, x=645..647
x=649, y=730..732
x=611, y=1385..1394
x=570, y=219..223
x=712, y=1735..1748
x=592, y=1612..1628
x=711, y=229..233
x=488, y=1292..1308
x=580, y=370..385
x=602, y=34..39
x=535, y=234..246
x=748, y=901..908
y=36, x=704..718
y=438, x=551..554
x=659, y=1083..1102
x=542, y=215..225
x=497, y=1453..1458
x=511, y=1437..1439
y=1479, x=485..509
x=561, y=1196..1207
x=592, y=1724..1745
x=750, y=1253..1266
x=743, y=104..120
y=1424, x=648..651
y=297, x=523..530
y=1018, x=627..643
y=868, x=695..712
y=1359, x=625..641
x=534, y=1365..1389
y=256, x=598..608
x=620, y=647..658
x=691, y=599..621
x=730, y=1755..1769
y=464, x=552..572
y=310, x=562..564
x=622, y=1097..1109
x=521, y=784..804
x=517, y=1717..1725
x=501, y=214..227
x=684, y=1514..1533
x=579, y=97..101
x=590, y=313..324
y=246, x=521..535
x=636, y=874..884
y=1455, x=631..642
y=1062, x=709..720
x=519, y=1199..1213
x=715, y=1448..1451
y=1377, x=606..625
x=642, y=877..889
x=520, y=1316..1318
x=669, y=1259..1271
y=992, x=619..621
y=1796, x=590..595
x=529, y=129..142
x=537, y=1133..1137
x=687, y=67..72
x=741, y=718..735
y=722, x=539..545
y=1125, x=573..589
y=219, x=681..707
y=70, x=614..619
y=237, x=703..719
x=739, y=1188..1207
y=1137, x=537..558
x=598, y=742..745
x=716, y=1650..1662
x=550, y=836..842
x=687, y=1512..1535
x=517, y=1365..1389
x=674, y=837..846
y=388, x=561..568
y=1704, x=718..738
x=655, y=401..403
y=417, x=548..550
y=1251, x=668..672
y=349, x=654..675
y=439, x=574..594
x=700, y=1150..1178
x=482, y=1039..1064
y=1072, x=669..686
y=856, x=619..630
x=728, y=1576..1582
x=627, y=620..638
x=482, y=547..560
y=314, x=601..613
y=675, x=701..703
x=627, y=1329..1338
x=606, y=1421..1431
y=825, x=636..654
y=1411, x=619..638
x=655, y=1357..1368
x=745, y=1134..1146
y=1764, x=512..526
x=508, y=166..177
x=727, y=64..70
x=639, y=272..276
x=640, y=517..531
x=668, y=1348..1373
x=654, y=340..349
y=310, x=633..639
x=684, y=894..919
y=1642, x=485..510
x=652, y=1526..1528
x=605, y=1802..1808
x=671, y=1082..1084
y=1103, x=587..591
y=242, x=552..555
y=679, x=614..628
x=750, y=918..935
y=65, x=488..511
x=650, y=397..408
y=863, x=482..509
x=549, y=1065..1084
x=627, y=664..666
x=573, y=541..554
y=1013, x=675..690
x=731, y=76..84
x=714, y=65..70
y=843, x=665..668
y=736, x=498..518
x=572, y=1554..1559
x=557, y=90..113
x=558, y=1832..1842
x=639, y=297..310
y=784, x=648..655
y=103, x=499..524
y=1484, x=561..564
x=511, y=943..963
x=625, y=424..427
x=707, y=543..556
y=1308, x=488..498
x=651, y=1502..1513
y=1550, x=611..637
x=720, y=1777..1791
x=753, y=424..428
x=673, y=1438..1447
x=585, y=1480..1489
x=687, y=1167..1174
x=651, y=1407..1424
x=591, y=1108..1111
x=495, y=1012..1036
x=499, y=1712..1732
y=276, x=639..646
x=607, y=464..467
x=586, y=1440..1452
y=1289, x=575..599
x=637, y=411..413
y=737, x=635..656
x=530, y=1066..1084
y=1266, x=690..714
y=431, x=612..631
x=704, y=1610..1621
y=638, x=559..606
x=736, y=987..992
x=747, y=965..972
x=642, y=1268..1286
x=502, y=548..560
x=539, y=177..179
y=1111, x=584..591
x=627, y=981..995
x=585, y=731..742
y=1533, x=675..684
y=165, x=511..529
x=540, y=1791..1816
x=505, y=1441..1443
x=682, y=998..1006
x=623, y=424..427
x=485, y=1186..1211
y=39, x=602..620
y=1531, x=705..710
x=635, y=1004..1015
x=511, y=1336..1360
y=691, x=576..583
x=566, y=1324..1326
y=1275, x=662..680
x=528, y=1121..1125
y=531, x=623..640
x=737, y=154..162
y=1733, x=573..580
x=619, y=1365..1374
x=642, y=481..503
y=179, x=539..541
y=779, x=623..639
x=696, y=543..556
x=632, y=983..985
x=657, y=624..643
x=648, y=709..720
y=867, x=642..664
x=631, y=217..232
x=691, y=1741..1745
y=1458, x=497..499
x=720, y=807..828
x=573, y=1424..1429
y=1556, x=577..676
x=713, y=1289..1297
y=362, x=634..660
y=401, x=655..657
y=995, x=606..627
x=550, y=417..419
x=743, y=271..275
x=606, y=1368..1377
x=546, y=991..1013
y=883, x=599..607
x=585, y=90..113
x=645, y=1118..1131
x=699, y=1671..1682
x=686, y=1067..1072
x=644, y=810..820
x=532, y=541..554
x=720, y=901..908
y=818, x=678..695
x=554, y=1194..1198
x=607, y=1479..1489
x=551, y=1226..1246
x=718, y=1712..1724
y=332, x=661..673
x=707, y=1014..1027
y=75, x=609..627
x=571, y=1591..1594
x=685, y=1203..1212
y=486, x=503..516
x=703, y=896..904
x=663, y=794..797
y=165, x=728..744
x=648, y=1226..1237
"""
}
