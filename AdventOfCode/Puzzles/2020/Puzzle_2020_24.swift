//
//  Puzzle_2020_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_24: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_Input.puzzleInput)
    }

    let offsetDict: Dictionary<String, (Int, Int)> = [ "w": (-2, 0), "e": (2, 0), "nw": (-1, 1), "sw": (-1, -1), "ne": (1, 1), "se": (1, -1) ]

    func getBlackTileCount(_ tileDict: Dictionary<Point2D, Int>) -> Int {
        var retval = 0
        for (_, v) in tileDict {
            if v == 1 {
                retval += 1
            }
        }

        return retval
   }

    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var tileDict = Dictionary<Point2D, Int>()

        for var line in lines {
            var location = Point2D()
            while !line.isEmpty {
                var c = String(line.removeFirst())
                if c == "s" || c == "n" {
                    c += String(line.removeFirst())
                }

                let offset = offsetDict[c] ?? (0, 0)
                location = Point2D(x: location.x + offset.0, y: location.y + offset.1)
            }

            if tileDict[location] == nil {
                tileDict[location] = 0
            }

            if let tileDictLocation = tileDict[location] {
                tileDict[location] = 1 - tileDictLocation
            }
        }

        return getBlackTileCount(tileDict)
    }

    func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        var tileDict = Dictionary<Point2D, Int>()
        for y in -200...200 {
            for x in -200...200 {
                if abs(y % 2) == abs(x % 2) {
                    let pt = Point2D(x: x, y: y)
                    tileDict[pt] = 0
                }
            }
        }

        for day in 1...100 {
            if day == 1 {
                for var line in lines {
                    var location = Point2D()
                    while !line.isEmpty {
                        var c = String(line.removeFirst())
                        if c == "s" || c == "n" {
                            c += String(line.removeFirst())
                        }

                        let offset = offsetDict[c] ?? (0, 0)
                        location = Point2D(x: location.x + offset.0, y: location.y + offset.1)
                    }

                    if let tileDictLocation = tileDict[location] {
                        tileDict[location] = 1 - tileDictLocation
                    }
                }
            }

            var newTileDict = tileDict
            for (k, _) in newTileDict {
                var adjacentBlackTiles = 0
                for (_, v) in offsetDict {
                    let pt = Point2D(x: k.x + v.0, y: k.y + v.1)
                    if tileDict[pt] == 1 {
                        adjacentBlackTiles += 1
                    }
                }
                if newTileDict[k] == 1 {
                    if adjacentBlackTiles == 0 || adjacentBlackTiles > 2 {
                        newTileDict[k] = 0
                    }
                } else {
                    if adjacentBlackTiles == 2 {
                        newTileDict[k] = 1
                    }
                }
            }

            tileDict = newTileDict
        }

        return getBlackTileCount(tileDict)
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
"""

    static let puzzleInput = """
sweswseeeseseneeeeeeenwnweswe
neswswsenwseeswsesesenwseseeseseseseswnw
swswswnwwneeseneswseseneeswswseswswsenw
eeswwnwnwwnwnwnwwnwswnwnwnwnweswnw
sewwwnwwewswewswnewnwwnenesw
swswswwnesesweeswewwnewnewswswsw
nwswswnweneswswwwswswswswseswswwswsesw
nweneweneswswsenwseswnwwsesewnwwe
senwewseneswwswwsesesesenwseseesenee
sesenwseseseneseeseswswswweesewwse
swswsewswwneswseswneseswswseswswneswswsw
swswnwwwswswnwswsweswswswswswnweswsese
swnenwneeeneneswswnenewneswnwnenwneene
swseswswswseneeseswswswwswwsesw
swnwneenewweeenwenenenesenesenene
seseeweeeweeseeeneeeweee
enweseseseswseswsesesesesenewsenwsesese
neseswsweswswseswswswwswswnwsw
neneeswneswnenwneneneeewneswneenee
nenwwnenwseneenenwnenwenwswneneswnenwenw
seseseseseswseneswsesesese
seeseewnwewwnwwswnwswnweeweww
sweseseseswswseswsewsesesenwsene
sesenwwesweseseeseseeneseneeesewse
nwneneseswnenenenwne
nweeeswenweeeswwenweswwneeese
nwseswnesenwswswsewseswsenweneseeswswe
swseswswneewwnwweswwsenwwwwsww
seeseeweeeesweseneeeeenwsesw
swswswsweswswnwswsw
wwswswnwwswswwnwswneseseneseswnweesw
nenenwnwnweswnenwwneswneseswnwswnwnee
swswswswswswsweswswswswsww
sesesesenwsewenwsesewsesesenesese
seeneeeweswnenenwnwseeneseenwesw
wnenwnwwsweneswsewsesenenenewswnwnw
enwseswwnwseswswnewnwseseeseneswesew
neneneneenenewneenenenenewne
sesewewnweeeeeswe
wwewswwwwwewwww
wnesesesenewsenewsee
seseseenwseweseswsesesesesesenewnwse
swnesesewseswseswswswseswnwswsweswwsw
wwneswswseseswwneswnewswswswewswsww
swsewewnwnwswwesw
neeeenweneseneneeene
seseswnwwsewswwesesenwseswneeneenwnw
eesweeeseneenwneneenewewnwsenw
seseenwnwswswswswswneswseseswwsesenwsw
eeneseeeseeseseseneseesewwswsese
eeseseeswewnwenw
wwwwswseswwwwswswnw
swswneseswswwswswneswsewseswwswseswswswne
eeneeneneeneeeswe
wsesesewseseeesenweneseeswsesenese
nenwenenenenewnenweenesesesenewnenee
eseneeewenweeseweeswneeseneenenw
wswwwwswwwwne
nenwseseswswwsesesesesenwseeseswswsese
nenwsenwnenwnwwnwnwnwnwsenenwnenesenwnw
wseweneeswnwnwsweewswsesesesesese
seseseseswsweswseswseswswswnwnwsese
nwwswenwenenwswnene
neweeweeeeeneeseeeeeswee
nenewneweneneneneneneeeneswnenesenesw
nesewnwwneswnwswneseneseenesweeswe
nwseseneswsewseneswswewnenwseew
swswnwwwwswswswwneseswwswewneww
neeneeneseneesweeneweneenee
seseswswswswswsesesesesenwsee
wnewwwswwnwseneswsenewwewseew
nenesewwnenewnenwsenwnenenwewsenwnenenw
sesewnwnwwneswnwnewnwnwsenewww
neeswsewnwnewwwsenwesew
eeeeseeseeneweeseeewwnesenw
swwswswwwswwnesene
nenenenewwswnweeweswneneneneswnese
neneewenenenenenenenenene
swnwewnwewnwwnenwwnwwswnww
swenwwswneseswswswswswswwneewswswse
seeseeeesewseeee
wswwswseswwswwswwswnenwnesenwenwsew
wwwwwwnwwwesenewwwwewwnwsw
eeeeenenweese
nweeweeeneseneesweneswseswnwneee
wsenenenwseenwnenewseswnwnesene
wwsewwwenwweswnwwwnwwwswwnwne
nwsewnenenenenenenwsenwneswneenenenenenw
ewneswneneswenwwewneneewneseene
swswwswswswnweswswswenwswseswswswwsw
senweseseeswnenwsweweseesewse
wswwnenwewwwwwnesewnwnwsewww
nenwnenewseneneneneneneneseneeneswwnenene
neswseswswswwnwswswwwneneswseswswsesw
eneenenwneneneneneeeswnenene
neseseswsesesesesesesewe
eewnwenwseenenesenenwse
swswswewwswswswswwnwsww
wnenwsenwewnwnwnenwnwweeseswnwnwnesw
wwwenwnwswseswswswseseenewnewswswww
nwseneneeenewnenenenenenenewnenenese
eeswseswswseswnwseseseswsww
eneneenwneneeswnewnwsenwnwneswnenwnwne
swweswswswswwswsweswswswnwnesewswswne
nenwneenwwneneswnwne
nenewwsewwwsesewewswnwnwwsewww
wnwsesesesewwwswweswnwnwwnwnwsww
eseeswseeeeneseeswseswnwseseenwnwse
senwsewseseswseswneneseseseseseswswsesw
nenwneswnenwnenenwnenenwsenenwsewnenewne
sweseeneewewnesesesweweseeenee
wwnesenwnwwwnwswnwnwsenenwsewwenw
swwsewswwnewwwswswswswnwneswnewswse
wnwenwswnenenwnwnwseneswnwenwswnwsenesw
swseswseseseesewsesesesesese
wnwseseeseseswesewsenesesesesesesesesw
swswnwwnwswsenwneseseseeswsenwswwswne
swenwwseeneneweweseswneeeseenenw
swseswswneswswneewseswwswnwwseeseswsw
nwnwsenwsenwsenewnwnwwwnwnewwnwswnw
wswswwwnwwwwwwwwsewnwnewwe
nesenenenenwnwnwnwnwnenesenwnewnwnewsw
wneewwenwnwenesewsweswsweswsenw
neswswwswseeswwnwswwnwseswnenweneesese
eweneeneweseeeeeese
seseseenweseseseseese
esewneeswseswsenwneenwenwswwnenenw
eneseswnewneneenwnweesweswneneesw
nwnwnwnwwewswswewwnwwewnwnwwsw
wwwwsewwwwwnewwwnw
nwneneneneseneenewsewwsweweeseene
eeewsewwwneswwnwneseweswswwwww
nenenenenesewseneeneeneswnwnenwnenene
senesenwnwsenwsenwnwenwwnwnwnewwnwnw
swwseesesesesesenwseseeeseseseenwse
wwneeswsesenenesenewwneseenenenew
nwnwnenwnenewswnwswswneneeenwnwnwenwne
neneeneeewewneneeeeewneneneswne
nenwnewwnwneseenwswnwnwnwswnenenwnwne
enwswsweenenenwwwseneeeneweesw
wwnwwweswwwwnwewwwwwsenwnew
nwneneswsenwswnwnenwnwnenwsenwsenwnwenenw
weswnesenweseesenwse
eweeeenenwweeswsweneeenwe
wewwnewwwwwwwwwswwwwese
nwwneenwnwnwnwesewnwnwwenwnesw
swwnewswwwwseenewwwwswwwww
eswnenesesenwesesewswwseseneeesee
weneneneseswnwswneneneswnenwneeneenenee
wnwnwnenwneenwnenenenene
swswswswnwswswswewseswswseswsweeewnw
nwnwesesenwseswseeseseneswseee
swswswsesesewseesesesese
seswneswneesenwnwneswesesww
nwwswswwwswwwsewwnwewsw
swnwswswwswewnwswwnweswneswswwwswse
newesesenesesesesesenwswsesewsesesesenw
wswnwswswenwswswwwswswswse
swswswneswswsesewsese
swsewswwnenewwwswneswnwswenwnwne
eseswnwnwenwswesesweewwnwenwsesese
wwnwnwweswsewwwnwnwnwwne
swswsenwswswenwswwnewwsew
seeenwwnwwnwwnwweswwnwnwnenwnwnw
eeneswseneneneeweeew
enenwsenenwnenwnenwswnwnwwnwnweswnwnwnw
enwneeeneeeswnwneeneneneseene
wnwewwswseswnwwnwswneseeweewsw
eneneeswswneeewnwnweeeseeneee
newnwnwenwnwnwnwnwnenwnesenenwne
wswwewswswswswwswsw
swnwnwnewwswwwsenewwnwewnwwsewnw
nweeeeenwnweeeewseenwswseesew
swesenwswswwnweeneeseeeeeeesee
nenenenwnwwnwnenesenwnenwnenenwwe
eeeneeneweseeeeeswnewnweeswe
nesewwwweswswwwswnenwwwwwesww
nesweesweenweneeeswnweneeeeesw
seswseeeweseesenweneweneeswnesw
sesweswswswwseneeswnwwwsenwswnwwswsw
neneneenwnewnwseesewseneneeeeseew
seeswsesenwnwseseeseseseesenweenewse
ewswwseseswswswsene
nwnwnwnwwwsenwnwnwsewwnwnwnwsenenwnw
nwenweseenwwnwnewsweswnwwseswwnwne
wswswseswneswnwwneswnewwwsewswsw
neseswsewswswswsenenwsesesweswsweseswsw
nenwsewnwwnenwnenesesenwneswwnesenwwne
swwweswswwwnewwwwnwswwwwesw
nesenewsenwnweneewswnwwswwsenwseseswne
swwnewwwwnwwneswwsewwswwsesew
neneneneeseneewswneneseewneswnewsw
nwnenenwnenwswnwnwnwswswnwnenwnwwsesee
swwseswswswswwswnesw
enenwneeeweseseeseeswsewsewneew
wwwnwnwwwwnwwseenenenwwswwwsew
swseswsenwswswswswnwswswswnwneeswsesese
nwnenwsenwswenwnenwnwswnwnwnwnwseswnewnw
swwwwnewswnesewwnesewswwwseew
ewnwnenwnwnwnwnwnwnw
seneneswwnewnwnwsewnwnwnwseenwwwsee
seeseseenwseseenwseesenwesesenwswsese
enewnwewseswnesewwwwnwswnwnwwne
swswwswneswsweswnw
nenenewswneswenenwswneeeseewneneee
nwwewnwwnenenwnwnwsewnenwswsenwnwsw
nwwnwnenenwwsewenwswswnweswswsewnwe
nwnwswnwnwnwnwnwnwenwwseswwwwnenwwnwe
nwnesenweesewenwweseeseeeswwsw
wnewwwnwnwwwwsewwewsewwnewse
newseneenweseswesweeesweeesew
enwswneeesweswsenwseneseeseswnewse
eeseswwseneseseeeswnweeneseesee
sewswswwsesweswnwesenwnwswswsweswsw
nesenenenesenwnenwneeweneneeswneee
nwnweewnwnwnwnwnwnwnwnwnesewnwnwswnw
nwenwswswnwnenwnwnwwsenwnwnwnwenwnwnwse
seswswswswwsweswnewsweseseswnw
swseswwsesesenesesweswseseswnwwswsesw
wnweeeseseeeeenwneeweeseeee
eenwswnwwnwweenwwneswnweswwnwsw
wnewswewwswsenwsenwwwsewswnwwenew
swswneeneneneenenwnenenenesenenenwnene
newnwneneesenewswsewnwneseneeswsew
wnwewseseswwenwnenwwnwwswswwwnwnwe
enwnenenewneneneneneneneneneswswwnese
nenwswseseseswswesenwseswsene
nwnenwnwnwwneseneenenenesweeseneeswnese
nwnwswnenenwnwnwnenwnwnwnwnwnw
swswnwswswswswseswswneesenwswsweswwswesw
nwswnesewseseneneseswsesesewswneswsesw
nwnenwesenenesenwnwnenewnwwnwnwnwnwwnw
seeneneneneneenwnee
newsweeseesesesewnesesenwsesenesesese
eenewnwswnwesewnwwswnwswnwwswnwnwe
wewsewwwwsewnwnwnewwsewwswnw
swnewnwwnwswwwswwwwswewwseswwne
nwswnenwsewnwseswwwneweweeswwww
wnwnwenwnwsenwnwsewnewnwwnwnwnwenwnenw
swnesenwenwneswswneswsesewseseeseesene
nwnwnwnwewsenwswnwenwnwwenwnenw
ewneewseenwswneswenwsenwewwe
senwesenenwsewseseseseseseseswesesenw
nesenewwnweneneneneneneesenewnwneswne
neneeeswwneeeswswenenwwnewwee
weseeseseeneeeneesw
nwnwnwnenwswsenwneswenwnwsewnwneneswnenenw
wneweenwenesweneeweenenenewse
sweenwswnweneneseneeseseweswseseese
swnwnesewwwseewnewwwwwwwww
eenenenweswwnwwnw
swswnwsweswneneeswswswswswswswsenwnewse
wnenwewwewseewswswnwnesenwnwnwene
seswseseswnwseseswseswswsw
nwnwnwnwswwenwwnwwwswewwewnwnw
nesewsewneswwwsenewsenewnwwsw
nweneeeewneseseweneswseseswnesewse
wswswwwwsenenenewwswsewwwnw
eenwwwswnwwwwnwenwwewnwswswwnw
swsenwnwsesenwseswseseseneswseneswwese
sewseseseswseeneseseswsesewsesenewse
swswswswswswswswswswwswseneneeswwswsw
nenenenwneneeseeseneenewnenewneewsw
nwsenwnwnenenewnwswnwnwswnwwnwnwswnwwe
wwwnenwsenwnwnenwsewwnwsenenw
neeswwweseseenwsenwseseesesenwwne
esesewseseneneeseseenwseswswseeeee
neneneneswseneneweneswnenenw
nweswswwseswwseeneseseseswewswswswnw
swswwwnwswnewwnewwwwwwswwswe
enwwnwwnwwwnwwnwenw
sewwnwnwwewswwwswswnwwseswswswsw
swswseswnwnwswseswnwsenwswwswwswswesww
weewwwsewwnewsewnewnwwwww
nweswsenwswneseewnenwswwewnwnwnwnwenw
eeewnweeneseswsweswseenenweeswe
swswswwwswnenwsweswseswswnewneswswsw
swneswswseswsenwseswnewsesenesenwswsesw
nesewnesweswnenew
nenwsesenenenwweenesweseswneneneew
eeswnweneswseesenwwese
esewwseswnwneeseswnwswnwesenwnwnwnww
nwnwwnwwwwwnwewnwnw
nwnwwesweenenenwnweswnwwnwenesweswne
nwwswesewnwwenwswewneseseeesesenw
swwseenwnwsewsewseneneww
neswneswenwwneneneenwnwnenesewne
neeneenweweeneneseseswnwsweeee
wswnwswwswswnenwswswwwswesewswnese
nwwnwwsewnweswsesesweenenwswnwnee
sweeneneneneneneswnweneneswnesenwwnee
eeswnwsweenenesenenwwnwneswseneese
swwnwnwswseeseswswseseseswneneswsewsesene
swnwwseneswnenenenewsenewneneneenenesw
sewwseseseseseneewseeseenwseenenesee
eeenwwweneneeeeswnesweeeenwne
seseseeeneseseseswe
nwnenwsewnwsenwnwnwnwwnw
nwswnenwswneseneswnwnwesenwnenewnenene
swseswnenwseeseswsewswswsewseneseswnwse
wswwswnwnewseweneswenwswswswswnese
wsenwnwnwnwnweewnwnwnwnwseswe
eenewneseeeneeeseenwnenewneneeswe
neswnwnwswnwswenenwnewnenenenenenwenene
sewsewsesenwesesweseswswsewseneew
swwswseswneeweswswseswnwwewnwswwne
eenesweeeeenenwnwseswsesewnwsesw
wwwnwsewnwwnwsenwnwwewwwnewenwe
nwwnwneneswnwnwnwnwnwwswnenwwnwsenesesenw
swseewseseseseseneseswsesesenese
newnwsenwnwswswenwnenwnwsewswnwnwnwwnw
eeneeweeneeeseeewenweswesw
wesewwswnweseneseneweswwwwneww
wnenesenwnwneseneenwese
nenenenwnewswnenwnwswneseswswneswnwseesw
swswseswswnwseswswswswnesese
seswswnwseseseswswseseswseswsw
neswsesewnwswwnweneseseswenwnwswe
nwsesweswnesewnwswsenenenwswneseswswswsw
swnwneneneswswnenenwwsenwnwnwse
swswseseseneswneswsesesenwseneneswwsese
nenwenenwnwsenwneewnwswenenwwnenew
eewnwseeneeeeweesewseneswee
seswseswsenwseseesenwsewseeseseseee
senwwnwnwnwnenwnwwwnww
wneeswnwswseswswnwwewsw
nwsweneswneeeneenesenwneneeswnw
esweenwnenenwweneneneseneeneneeesw
seeewseeseseeseenwwseesesweese
swswsewswseeswnwnweswwswnenwswswswwsw
swnwneneneeneenenenewenenene
nwsenwnwwsenwsenenenwenwwneneswseneew
enwneswswnesenewswwe
sesesenwnwswsesenewsesenwenwseseseseswe
nwseneswneswnwneneeneeswnenenwnenwese
seenesesenwnwwswnewswwwnwwwneswne
swseswnwnwswswswswswswseswswswswneswenwsw
senwnweenwesweseeeeeeeeewese
swwseneswwswwnewwneeseswenesewsene
eseneweenenenenenwneenenwneneswneneswne
nwnesenwseeeneeesewnwweswweesw
neseseseseseewwsesee
swnwseswswswneeswswswswswswwswnwneswsw
wnwwnwsenenesesewnenwswneesw
"""

}
