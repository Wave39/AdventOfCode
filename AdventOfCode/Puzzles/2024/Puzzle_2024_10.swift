//
//  Puzzle_2024_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_10: PuzzleBaseClass {
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

    private func solvePart1(str: String) -> Int {
        var retval = 0
        let grid = str.parseIntoCharacterMatrix()
        let trailheads = grid.findInstancesOf("0")
        for trailhead in trailheads {
            var locations = [ trailhead ]
            var searchElevation = 1
            while !locations.isEmpty && searchElevation <= 9 {
                let searchElevationCharacter = Character(String(searchElevation))
                var newLocations = Set<Point2D>()
                for location in locations {
                    let neighbors = location.adjacentLocations()
                    for neighbor in neighbors {
                        if grid.pointIsValid(neighbor) {
                            if grid.characterAtPoint(neighbor) == searchElevationCharacter {
                                newLocations.insert(neighbor)
                            }
                        }
                    }
                }

                locations = Array(newLocations)
                searchElevation += 1
            }

            retval += locations.count
        }

        return retval
    }

    private func solvePart2(str: String) -> Int {
        var retval = 0
        let grid = str.parseIntoCharacterMatrix()
        let trailheads = grid.findInstancesOf("0")
        for trailhead in trailheads {
            var paths = Set<[Point2D]>()
            paths.insert([ trailhead ])
            var searchElevation = 1
            while !paths.isEmpty && searchElevation <= 9 {
                let searchElevationCharacter = Character(String(searchElevation))
                var newPaths = Set<[Point2D]>()
                for path in paths {
                    let neighbors = path.last!.adjacentLocations()
                    for neighbor in neighbors {
                        if grid.pointIsValid(neighbor) {
                            if grid.characterAtPoint(neighbor) == searchElevationCharacter {
                                newPaths.insert(path + [ neighbor ])
                            }
                        }
                    }
                }

                paths = newPaths
                searchElevation += 1
            }

            retval += paths.count
        }

        return retval
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""

    static let final = """
4321102312343410145698012374325601278921
5670231101652101234567321289012567365430
4789340108768945434443450108723478472378
3493451299897636723982569237632199581069
2102169387896521810671678344541087698754
4589078456985430920540989854569143215653
3674567325087651501234988763678654004102
2103258014194545690347832102345710123201
3010189543223036789656543211056891934987
0989787612310121058760659800287602875676
1874698901876501765951265760196012560169
2965013450983432834894376054298123481058
3454322168992101926765289123367210592347
2989010076898032015010101230456987685456
1874321081761087654329890121378976976347
0765345690650196012018721430165805801238
1894298721043298763487610541234014761229
0123193438923410054598541690121023450310
9032087567012522101010032783432189210487
8541056156987633454323121122569274306596
7603441067896549965014010031678565217895
4012532158923458876965123440734564376014
3219687143018767657879854659821078789123
4108796032109658743589765565764109698034
5689345123001549872678126876853234567965
6798239834432332101549054967943456430876
7867108765521001012632163258932347121210
8950165689698012106701278140121298034322
0141234018789823612890109032100654345421
1234389823456738743653278932108761256930
0345698765696549656765368943449870107845
3210789054787656543834457656654891012396
4109870123892187012921765434783987683487
1235432110763096876540891023292100596576
0346789001654301985432082314109001487215
1650109892783218654301101405678212324303
0743210710890129565210278569210901015012
1890345623011018978898369878367810926743
2761219554322567089765450965456921834874
3454308765543432167896321034345436765965
"""
}
