//
//  Puzzle_2018_20.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_20: NSObject {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2018_20_Input.puzzleInput
        return walkRoute(str: puzzleInput)
    }

    func walkRoute(str: String) -> (Int, Int) {
        var roomDictionary: Dictionary<Point2D, Int> = [:]
        var pt = Point2D(x: 0, y: 0)
        var stepCount = 0
        var ptStack: Stack<Point2D> = Stack()
        var stepCountStack: Stack<Int> = Stack()

        roomDictionary[pt] = stepCount
        for c in str {
            if c == "^" || c == "$" {
                // ignore starting and ending characters
            } else if c == "N" {
                stepCount += 1
                pt = Point2D(x: pt.x, y: pt.y - 1)
                if stepCount < roomDictionary[pt] ?? Int.max { roomDictionary[pt] = stepCount }
            } else if c == "S" {
                stepCount += 1
                pt = Point2D(x: pt.x, y: pt.y + 1)
                if stepCount < roomDictionary[pt] ?? Int.max { roomDictionary[pt] = stepCount }
            } else if c == "W" {
                stepCount += 1
                pt = Point2D(x: pt.x - 1, y: pt.y)
                if stepCount < roomDictionary[pt] ?? Int.max { roomDictionary[pt] = stepCount }
            } else if c == "E" {
                stepCount += 1
                pt = Point2D(x: pt.x + 1, y: pt.y)
                if stepCount < roomDictionary[pt] ?? Int.max { roomDictionary[pt] = stepCount }
            } else if c == "(" {
                ptStack.push(pt)
                stepCountStack.push(stepCount)
            } else if c == "|" {
                pt = ptStack.peek()!
                stepCount = stepCountStack.peek()!
            } else if c == ")" {
                _ = ptStack.pop()
                _ = stepCountStack.pop()
            } else {
                print("Unknown character: \(c)")
            }
        }

        let furthestRoom = roomDictionary.values.max() ?? 0
        let farAwayRooms = roomDictionary.values.filter { $0 >= 1000 }.count

        return (furthestRoom, farAwayRooms)
    }

}

private class Puzzle_2018_20_Input: NSObject {

    static let puzzleInput_test1 = "^WNE$"
    static let puzzleInput_test2 = "^ENWWW(NEEE|SSE(EE|N))$"
    static let puzzleInput_test3 = "^ENNWSWW(NEWS|)SSSEEN(WNSE|)EE(SWEN|)NNN$"
    static let puzzleInput_test4 = "^ESSWWN(E|NNENN(EESS(WNSE|)SSS|WWWSSSSE(SW|NNNE)))$"
    static let puzzleInput_test5 = "^WSSEESWWWNW(S|NENNEEEENN(ESSSSW(NWSW|SSEN)|WSWWN(E|WWS(E|SS))))$"

    static let puzzleInput = "^WWWWWWWNNEES(W|EEENNWSWNWNNEEES(EESSW(SEEEEEENWNNWWNENWNWSS(WNNWNNENNWNEEEEENENWNENWWWSESWS(E|WWNNE(NNWSWWWNNESENENNWWWNWNWSWNWWNNEEES(WW|ENENNWNWSS(WNWWNEENNWWWS(EE|SSWWNWWNWWWSWSWSWWNENNWWNEEEE(SWSNEN|)NWNWWWWWSWWSWSWSEEEN(NESSSWWWSEEEESSWSWSESSSESESWWSSENEEENNEESWSESENEEESWSESESSWNWWN(N(N|WSWSWSWNWWSESSEESWWWWWNNNWNNN(EEES(ENESEN(NWWWEEES|)E|WWSESSESW(ENWNNWESSESW|))|WNWNNWNWNWNENENWNWSWNWSSE(E|SSSSE(SWSEEE(NWNSES|)SSSSSWWNWSSESWWNNNWSSSWWWNNNNNENNEESSS(EEEE(NWWN(W(S|NNWNWSWNWSWNWNNWNEESSENENNNWWWWNNWWWNNNEESWSEEENNNNENEENWWNEENWWWWNWWWNENNNWSSWNNNENEEEESSWNW(W|SSESS(WNSE|)ENEN(W|ESESWWS(W|EEESEESSSENEES(SSWN(WSWSWWNEN(E|W(WWSSW(N|SSSS(WNSE|)ENNNE(SSEE(NN(WSNE|)EEEESE(NNWWWEEESS|)EEE(E|SWSW(NW(S|WWWN(WSNE|)E)|SSE(N|SWWSESESSE(S|NN(E|N(W|NN))))))|SW(W|SESSSW(NN|S(EE(NN|S)|W))))|NN))|NNE(NWES|)S))|N)|ENNWNNESES(ENNNW(S|NEESSENEESS(ENNENNNNESEENNEENWWWNENENENWNENENNNNWWNNEES(ESENN(ESSEENWNEESSENEEN(WW|EEEESWSWSESESWWWSSEESSWNWWWWNNNNEN(WWWSESSWSESWSEEEESWSWSSWWSESSSWWSSESENEEESEESSSWWNN(ESNW|)WS(SSEEEESSESENNENWW(NNW(S|NEENNWSWNNNWNNEENENNWSWSWWNENNW(N(EES(S|EENWNNNN(ESSES(W|EEEESWSSSWNNWSSSEESENEEESSSWNNWSSSWNNWSWNNWSWSWS(WNN(W|ENENNNNNEE(WWSSSSNNNNEE|))|EE(SSEEN(NWSNES|)EEENESEEEESWSWNWSWWN(WWSWWWW(NN|SES(WWNSEE|)SSSWSSSEEESWWWSW(WWWNEENN(ESSNNW|)WSW(WSNE|)NN(NNWESS|)E|SESENESENEEENNESESWSESWWSEESSENENESESSWNWSSSENESSSSSWSESSSEESSWNWSSEEEENESSSSESSSWWSWSESWWWWWNEENNWNWSS(E|WNWNNE(S|NESENEEESE(NNNWWWWS(EEE|WNWNNWSSS(E|SWSWNWNEENWWNEENNWSWWSW(NNEENENWWSWW(NWNNESE(EENENEENE(ENNWWWNWWNEEE(NWWNWSWW(NNE(S|EE|NWN(NE(S|E)|WWWS(WNWNSESE|)EE))|SSE(SSENESE(EE|SWWSWSWNWNWSW(S|WNNE(EEN(ESSEWNNW|)(N|WWWWSSSW(ENNNEEWWSSSW|))|S)))|N))|S)|SSWSSEE(NWES|)SS(SS|WWN(WNN(W|N)|E)))|S)|S)|SWWSESWSWSSESWSEEESWWSESENENNENNN(NWW(NNE(S|N)|WS(EESWS(WNSE|)E|W))|ESSSSWSEEESWWSWW(NEWS|)SESENEEESWSESWWWN(ENSW|)WWNWSWNNENWWNWNNWNNNNWWWSWSSENENESSSW(WWWSSSSENNNEEESSE(ESSWSWSEENE(SESENEESSW(SWWN(E|WSSWNWNEN(WWSWWWWSWNWNEENESENE(S|NWWWWN(WWNEENWNWSWWSSWWNNNNWWNWWWSESWSEESENN(WNSE|)ESSSWSWWWNN(ESEWNW|)WWNNE(NNNNEEES(WW|EENNNNNNNNNWWSESSSWWWSSES(WWNNNNEEENWNWSWNNNEE(SWEN|)NEENESEESE(EENNWSWNNWSWNNENNESENNNWNEESSEENWNEENNN(WWSESWWWWWSSS(WW(NNE(NWNENWW(SS|NWWWWNENNNWWWWSS(ENESEN|W(SS|NNNWW(SSE(S|N)|NEENWN(NNN(W(NNNEEE|S)|E)|EESESS(WNSE|)EENNNW(W|SS|NENENESESSWSSEESSEESEENWN(NWSWNNENN(E(SS|EE)|WSW(SWEN|)NN)|EESSSENNESE(SWSWWSWNWS(WWNN(NWWNNW(WNNNNE|SSSSENES(NWSWNNSSENES|))|E(EE|S))|SSENEE(NEEN|SW))|EEE|N))))))))|S)|SESWWSWWNWNN(ESE(E|S)|W(N|WS(ESSSSS(WNWWWWSSSSWSSENEEEE(SWWSW(N|WSSESSWSSEESWWSWWSSSSWNWNWNEE(S|NNENNNNNWWSSE(N|SSWWN(WSSS(EENWESWW|)SWNWSSSSSSWSSESWWNWSSESSWSWWSESSWWSSSEESSEENENWNEEENWNNWSSWW(NNNE(NEEES(WW|SES(W|EENWNWNNNWN(NNENENESSWSWSESSEENWNEN(W|ENWNNN(WNWWN(NWSSSE(SWSWENEN|)E|E)|ESEESW(SSSSEENNN(WSSNNE|)NENWNWWNNNEN(ESSS(WNSE|)ESESEEEEN(WWWNWN(EESNWW|)NW(S|NN(E(S|NNE(NNNWW(SESWWEENWN|)NEN(E(NWES|)S|WW)|S))|W))|EESEENWNEESENE(NN|SE(NESEWNWS|)SWSESSE(N|SESWWNWSSEEEEENWNN(W|EEN(W|ESE(SSEESWSWNWNW(N(E|W)|SSESESWWWN(E|WWN(EE|WWSESWSSWWWWNNNENE(NWWWS(SWWNENNWWS(WWNWSSEESSWWSSSEEESEESSWSWWSWSEESSSSWNNWSWWNEN(EE|NNWSWNWNNESEEENWNW(N(EEES(E(SWEN|)E|W)|NWNNNNWWWSSEE(NWES|)SSWNWSSSWSEE(SWWSEESESWWNWWWWSWNNNWSSSSWNNNNN(NNEESS(WNSE|)EESS(WNSE|)ENNNWWNEEENWN(WWWSEE|NE(S|NWNWN(EE(S|EN(WNNSSE|)ESEEN(NE(NNN(WSSNNE|)NESSEEES(W(S|WW)|ENNEESWSEES(W|ENE(S|NWWNN(WWW(N|WWS(WNSE|)E)|ESE(ES|NNW)))))|SSS(EE|SSS))|W))|W)))|WSWSSSE(SSEEEEEN(NEESSENEEE(NEWS|)SSEESWWWNNWSWSWNW(SSESWWNNNWWWWWSSESWSEESEESWWSEESEES(WWWNWSWWNNNE(SS|NWWSSSSWWWNWSWNNNNENWWNEENNESENNWNENE(SSSE(SWSESWSSSSWNNNW(NENW|SSWN)|NNN)|NNWSWWWNEENWNWSWWWNEENNWNWWNNNWWWNEEENNWSWWNENWNENNENWWSSWSSWSWNNNNNENNES(SSWSSNNENN|)ENENNENWNEESENENNWWNEEEESWSSESWWSWWSESENEEEN(WW|NNN(ESESESENNE(SSSWWWNW(SSES(ENESNWSW|)WSWWWN(EENWWEESWW|)WSWSESESEENWN(W|EESE(NN|S(E|WS(E|WSWSS(E(N|E)|WSWNW(NEENN(WSWNN(E|WSWNNE(E|NNN(W(N(N|E)|W)|E)))|E)|SSES(EE(S(SSENESSESEN(SWNWNNSSESEN|)|W)|N(W|N))|W)))))))|N)|NNNNENWNENENWWSWNNWSSSSWSSS(WNW(S|NNWNENWWSSWS(WWNWWWWNWSSEESSES(WWWNENWWNNWSW(NNNNNENNW(NENWNENEESSSESEEEENNWWNEENEESSW(N|SEEESWSESENESS(E(SSW(SS|N)|NNNENNENEESSSWN(N|WSS(EES(W|ENESSSE(NNENWNWNENWW(SS|NEEESENE(ENWNENN(WWWWSSWNNNN(EES(W|ENNWNNNW(SSS|N))|WSSSSS(EEENE(S|N(W|E))|WNNNWSSSWWWNEENWWWSWSSS(SE(SWEN|)NE(N(WNSE|)E|S)|WWNENNNN(WSS(WNWWNNWNNNNEEESWSS(WNNSSE|)EES(WWSEWNEE|)ENNNNNW(SSSWENNN|)WWNENN(ESES(ENSW|)W|WNWSS(E|SSWNWWNNWSWWWSEEESESE(SSWNWNWWSESSSWNNWW(NNE(N(EE|WNNNENNNNNENEESSESESE(NNNESSSE(ESNW|)NNN(EEEESNWWWW|)NWWWN(EEE|NNWNENWNNNWNNWSWSWNW(SSEESEN(ESSWWSSEE(NWES|)SS(WNWWNNW(NNESNWSS|)SSSS(ENEWSW|)SSSSS|E(SSESNWNN|)N)|N)|NNNNEESENNWNNWW(SESWENWN|)NENNW(S|NEESSENEEE(SWSW(SW(NWES|)SESE(NN|SESWS(SSENEN(EESSSSE(NENWNE|S(WWNWW(SEWN|)NEEN(N|W)|SS))|W)|W(NN|WWW(SEWN|)N)))|N)|ENNENWNNWSWWNNE(S|EENWWWWNWWSESESSWSEEESE(SWWWN(WWNNN(W(SSS|N(NNNEEEEENWWNWWN(WSSEEWWNNE|)EEESENEESSSW(S(EESEENWNENWNEEESWSEEEESSWSWWW(WSWS(WNNEWSSE|)EEEESWWSEEEENWNEEEESWSSW(NN|SEESEENWNEEEEEEENESSSWNWSSSS(WNWWNW(SS(EE|WSWNNWWSESSE(EENSWW|)SSW(SEWN|)NWWNN(ESNW|)NNNWSW(SESSNNWN|)WWNENWNEN(WWWW(WSEEE|NENW)|EESS(EESEEES(NWWWNWESEEES|)|W(N|S))))|NEESENNWWW(EEESSWENNWWW|))|SENENE(SSWENN|)N(WWSNEE|)NEE(ESNW|)NNNNE(NE(S|NNENNWSWNNE(EESSNNWW|)NNNWWSWWWSEESWSWNWSWSSEEN(W|ESSEE(ENWWNEN(NNENSWSS|)W|SWWWWS(EESSSENNN(SSSWNNSSENNN|)|WWNN(WWWSESS(WNWSW(WSNE|)NNNE(S|NWWSWWW(WWWW|NENNES(ENENWWWNNWWN(EEEEEEEEEESWWSSWSESEE(NWNNESENNE(N(EEE|W)|S)|SWWWNW(NNNENWWWWSEE(WWNEEEWWWSEE|)|W))|W(SSEEWWNN|)WWWWWSSS(NNNEEEWWWSSS|))|S)))|E(EE|NN))|E(S|EE))))))|S)))|NEEN(WW|E))|WW)|NN)|E))|E)|E)|N))))))|SW(SESWENWN|)WWWNN(ESEWNW|)W(NEN|SSSE)))|S)|SESSESEES(WWWNW(SS|NN)|SSE(S(SEEWWN|)W|NENWNNW(W|NEN(WNSE|)ESSES(W|S(S|EE))))))|N)))|S)|E(S|EEEE)))))|EEEEENN(SSWWWWEEEENN|))|SSSW(WNEWSE|)SSEE(NWES|)SS(SSSS|E)))|SWWSSSW(ENNNEEWWSSSW|)))|W)))|WWWWSSW(NNWSSWWNNE(NEN(WWSWWWSW(NNE(NWNNNSSSES|)EE|WSSENEENESS(NNWSWWEENESS|))|ENESS(W|E))|S)|S)))|S)|SESWSSENE(SSWSSSW(SE(ENNNESENE(S|NWWNEE)|SWSESSW(N|SESWSSSENESSENNN(E(SSSEESE(SWWNWWWSSWW(SESWSESWSEENEENNNEN(WW(NEWS|)SWSESW|EESE(NESEWNWS|)SWSWW(NENSWS|)SSWWSEESEENWNEN(W|E(N|ESSSW(SWWSSSEEEE(NNW(WS(WNSE|)E|NENNNNESSSSSE(SWEN|)NENWNEE(WWSESWENWNEE|))|SWSWWWSESEESWWWWN(E|NNN(EEE|WWWNNEENN(WWN(EE|WSS(SW(SSE(N|SEEESWSWNWW(SSSEEEN(WWNSEE|)E(N|SEEEEEENE(S|NNNWS(WW|S)))|N))|NNNNEE)|EE))|ESSSWW))))|NN))))|NNE(NWES|)S)|N)|N)|WW)))|NNN)|N))|E(NNWNEWSESS|)EE)|EE))|SE(ENWNNE(S|NN)|S)))|W))))|ENEENENESSES(ENNWNENNNEESSSESWW(NNN|SES(ENENNNENESENENNNEENENNWWNNWWSSE(SE(E|SWWNWSWW(NENNE(NNN(ESEENNNWWS(ESNW|)WNNN(ESEEN(W|EESESWW(N|SEESEESWSESESENNWNENENNWSW(S|WNNE(S|ENENWN(EEEENWNEEN(W|NENESSENNNWN(EEEESWWSEEEESSENESSWWWSEEEESEENESSSWSEEESWWSEEEESWWSWSWSEENESSENNN(ENEENENWWNNWNNENWWNWNWNWNNWNENESENNWNNWWWWWSEESWSSSE(SESWWSW(NN(E|WNNNWNN(NE(SSESSS|NWNENESEES(WW|EEEEEESSENESENEESSSWN(N|WWWSSSENNESESESWW(SSSSW(NNWSWNNW(S|NW(WNEEE(SESENSWNWN|)NWNENWNNWS(NESSESNWNNWS|)|S))|SS(ESENN(W|NENWNNEENEENWNEESSEESESESSWNWWN(WSSWSEEE(NWES|)EESENENNEESWSSSSWWN(ENSW|)WSWSWNNWWWWWSW(SSEEN(NESESSSSESWWWSSEEN(EEENESEENESSEENNESENNNNENNENESESENNWNWWNWWSWWSSW(SWWWW(NEEEWWWS|)WWW(NNWESS|)SSENESES(WWSNEE|)E(EENEEE(SWWSSNNEEN|)NW(NEENWNEEN(SWWSESNWNEEN|)|WWWSWNW(ESENEEWWSWNW|))|S)|NNNEENENWNNW(SSSWENNN|)NNWWNWWSS(WNNW(S|WNW(NNNWWWW(NNESENNNEESESS(SSENEESENNESSENEENWNENNEESWSSSESENNN(WSNE|)EENNWNW(SSEWNN|)NNENENWNENNWWS(E|WNWNENWNNENNWSWWNNNNEENESESS(WNWWS(E|S)|SEEEENNWSWWNNE(EEENWNNNWWSSS(ENNSSW|)WNNNNEENNNNESSSSENE(SSWSSE(N|SSSWSSE(N|SSSSWNWNN(ESNW|)WSWSWSS(ENE(ESSSENE(NWES|)SSSWSWSW(SESESSSE(NNNNWNEN(SWSESSNNWNEN|)|SSSWNNWNW(SSESWWSSWN(NNNESNWSSS|)WWSESSWSEENNEENESEE(NWN(WW|E)|SSSSSSWNNNWSWSWNWWSS(E(N|SENESE(NN|ESE(SSWW(SESWWSWWSEESENESE(NN(WW|NN)|SSWNWSWSSSSWSSWWWWWNWSSEESWSEENEN(W|EEESWWSS(W(WWWWWNWWWS(EE|WNWNWWSES(E|WWNWNENENWWSWNWWSSE(N|ESS(E|WWN(WWWNWNEESENNNNEENEESS(ENESESSEESEENESE(ESNW|)NNNNWNNN(ESEESS(WNWESE|)ENENESE(SWWS(W|EE)|ENNW(S|WNW(SW(W(NEWS|)W|S)|NEEE(SWEN|)(NWWNW(S|NENE(NWES|)E)|E))))|WNWWWSWW(NEWS|)SS(EEEEE(SSESWW(NWW(SEWN|)N(EE|W)|S)|NWW(NEWS|)WW)|WNWWWN(WWWNNWNENWW(WSESWSSWWSSWSESWSESSSWWWS(WWWWNWSWNWNWSWS(WNWWS(WNNNEES(ENNWNNWNENWWSWWWNWSWWSESENEESWSWWSWWWSSWS(EENESEENESEENNNN(WSWS(ESNW|)W(N|W(WW|S))|EENWWNE(WSEESWENWWNE|))|WNNENWNEENE(ESWENW|)NWWNWN(WSSWSW(NNEWSS|)SWSWSEENEE(N(W|NE(E|N))|SWSWS(EENSWW|)WNWWS(E|W(NNENWESWSS|)W))|NNEE(SS(WNSE|)E(SWEN|)NEE(SWEN|)EEENWWNENENENWWNW(SWSE(E|SWSSWW)|NENESES(ESEENNNEENWWWNNWNW(NEEEN(WWNSEE|)EESE(NNWN(WS|EES)|SWW(SS(WNNWESSE|)ENESENNEEESESWSWNNWSSSWNWSSSSEENN(WSNE|)ESSENNEEE(NWN(NNE|WSWW)|SWSW(N|SESSWWWSESWSSWSSWNWWW(SEESWS(EENESES(W|EEES(W|ENNNEE(SS(EN|WN)|NWNNE(NNNWN(W(NNNENE|SSESWSWSESWWWN(WSSEES(ENSW|)W|ENN(WSNE|)NE(NWES|)S))|EES(EE|SS))|S))))|S)|NENESENNE(S|NNNN(EES(E|W)|WWWW(NNNESS|SEEESSWWN(E|WSWWS(WNW(SSWENN|)N(W|NEEE(SWW|NWW))|EE(S|EE)))))))))|N))|SWWWSEEES(E(S(SE(S|N)|W)|N)|WWW(S|W)))|W))|NWNW(S|WWNNE(NW|SEN)))))|W)|E)|EE)|EEEENE(NNNENNEE(SWSEWNEN|)NEN(ESNW|)WWSWWN(ENENWESWSW|)WSSESWSSS(NNNENWESWSSS|)|ES(EEE|W)))|NEEEEES(ENN(WWW(NNNWWN|W)|E(SS|N))|SSSWNW(NENWESWS|)S))|EEE)))|W(WW|N))|E)))))|N)|EEN(EEE(SWWEEN|)NNWSWNNEENNNWNENWWSSSS(EN|WS)|W))))|N(NWES|)E)|N)))|WNNN(EEENNEES(WS|EN)|W(NNW(NNE(SEWN|)NWW(NEEWWS|)WWS(EESWENWW|)WNWSWN(W(S|W)|N)|S)|S))))|NN(ESNW|)NWN(N|W)))|NNN(NNN|E(E|S)))|N)|WNN(NNE(S|E)|W))))|NWNNNE(NNWNNE(S|NNNNWNENWNENWWWWSSWWNWNWSSWSESSSSWWSESWSSSSSWSSSSSSEE(EEE(S|NNWSWWNENNNW(SSW(SS|NN)|NEENWNNEES(W|SENNNNENWNENEEE(SWWSSSSS(EN(E|NNN)|W(NN|SSWSS(ENSW|)WW(SE|NEN)))|NWNWWWWN(EEENE(NWES|)S|W(SSSSSSS(ENNNNNE(EE|S)|W(WSSSNNNE|)NN)|N))))))|SWWSSWNNNNNWSWNNNNNEE(SWSSEN|NNNWWNNENWNENEE(SWSESWS(ESSSNNNW|)W|NEE(SWEN|)NWWWSWNNWSWNNEENNWSWWNENWWSWWSSWWNENNENE(S|NEENWNWSWNWNEENENENWWWS(E|SWNWSWSWWNWSWSSWNNNNWSWWSSWSESSSSENNNE(NNNWSS|SSESSW(WSEEENNENNW(S|N(WSNE|)EENEESWSEE(SSWSSSESWWNNWSW(SWWWSESWWSWSEESEENWN(ENNESSSENNESEEEENWWN(W(WWNSEE|)S|ENNEESS(WNSE|)EE(NWNENWWNE(WSEESWENWWNE|)|EESWWWWSSWWWWSSWWSSWSSSSSWSSSSWSSEESSEENWNNENWNNW(SSSWENNN|)NENESEESENESEESENNWWNWNWSWWNNNNNN(EEESWSW(N|SS(S|EEN(W|EEENWW(W|NNENN(NEE(NWWEES|)SWSSE(N|S(WW|ES(ENSW|)WSSSS(SSSSSWNWWSSWWWW(W|SESEEN(EEESESSENNEESE(NNWWNW(SWNWWN|NNE(NWES|)S)|SSWSWWWSEEEEEE(NW(NENWESWS|)W|SSESESE(N|SWWWN(E|WWWNEE(E|NNWSWWWWWWSEESEE(NWES|)SEESE(EESWWS(EEENNSSWWW|)SSWWS(ESNW|)WWSWWNNE(S|ENNWWNWNWWWNWNNWWWSESSE(ESS(WWSWNN(EE|WWNWNEE(SENSWN|)NNWWS(WWNENNWW(NEEEENENNWWS(WWW(SEEEWWWN|)NENE(S|NWNE(NNNWWNWSSWNNNENESENNNWNWNWSWSEES(E|WSWSSWSS(SS(EN(NN|ESESS(ENNN(NESNWS|)W|SS))|S)|WWNNE(S|NENWNNE(SEWN|)NWNW(NEEE(SWEN|)EENESENENWWNE(EEES(ENNEEN|SW(SESSWNW(N|W(SESSSE(NNEWSS|)SSW(N|W)|W))|N))|NWWNNWSSWSWNNWSSW(SSEEN(W|ESENENW(ESWSWNSENENW|))|WNWWNW(NNESESEE(NNW(S|WNWWNNWWNWNNNEESWSEES(EESWSEENNNENWNNNW(NENESSSES(W|SSSESSESS(WNW(SSEESNWWNN|)NW(SWEN|)N(E|N)|ENENNW(S|NEN(WW(SS|WNNNNEE(SWSSEEN(W|NN)|NNWWNW(SS(S|EE)|NENWNWWWWNEEENWWWWSSSES(WWNNNNNENESEEEEESWSESENENNENENENEESSEEEESEEESEES(WWSWNNWSSWNNWWN(E|WSSWNNWW(NENSWS|)WSSSW(NN|WSSS(WNNSSE|)ENNEENE(NNWSNESS|)EEEE(NWES|)S(WWSNEE|)E(S|E)))|ENNWNW(S|NNNESENEESEENNNEESWSEEENENWNW(SS|WNENENWWNENWWSSS(E|WNWWSWWNNNEN(WWWSWNWSWSWWNWN(WSWWN(E|WWWSESE(SWSWSSWSEESEENNESESEEENESSWWSEES(SEENWNNE(S|NWNEESENESENNWN(EESE(SWSESNWNEN|)N(EESWENWW|)N|WWS(WNWSWWWSWNNW(NNN(WSSSWW(NENNSSWS|)S(WNSE|)S|ESSENESE(SWWEEN|)EEEENN(WSWNWSW(ENESENSWNWSW|)|N))|S)|E)))|WWWWNENWW(N|WWWSWSWSW(WNWSWNNWSSWNWNENENNWWS(WWWWNENESENEENENENWNNWSWNWWN(WSWSWSWSSWNNNENN(WSWNWWSW(SEE(N|SWSESSS(WNNWNNWN(SESSESNWNNWN|)|ES(EEE(SSSSS(WNNSSE|)EENNE(S|NE(S|N(WWWS(E|SS)|E)))|NWWN(WNNNNSSSSE|)EENE(S|N(ESENNN(WSWENE|)ESSSENENW(ESWSWNSENENW|)|W)))|W)))|N)|E(S|E))|EEEEEEEEESWWSEES(ENSW|)WSWW(SWS(SSSENEE(NWN(WSNE|)EN(ENSW|)W|SWS(E(ENENWESWSW|)S|W))|W)|N(NWNEWSES|)E))|E)|SS)))|N))|EE(E|S))|ESES(WWSNEE|)ENN(EEEESES(ENN(ESEEEESSWNWSSWSEESSSESSWNWWWSEESESWWSESSSWNNWWNENN(WSWSSSSWWWWNWNNENN(EN(EEE(SWSW(N|WSS(W|ES(ENNWESSW|)W))|EN(W|NENESENNWWW(NNW(NEE(ENWESW|)SS|S(W|S))|S)))|W)|WSWWSW(NWN(E(EE|N)|W)|SEE(SSW(NWES|)SSSS(WN(N|W)|EESWWSEESEENWNNNEENWN(EESSSSSEESENEENNEENESSE(NNNNWWNW(SS(WS(E|WSWNWW(NEEN(E(S|E)|W(NENWESWS|)W)|SES(W|EE)))|EE)|NEEE(SWEN|)NNNWW(SS(EN|WN)|NENNNE(NNNWSW(SEWN|)NN(W|EENNNNW(SSS|WWWW))|SSS)))|SWSS(ENSW|)WNW(NENWESWS|)SWNWSS(S|WNWWNWW(NNNWSNESSS|)SSS(ENNSSW|)WSW(SEENSWWN|)NNN(ESNW|)WWNWWW))|WSWW(NEN|SE)))|N)))|E)|W)|W)|W))))))|ENEESSWN(SENNWWEESSWN|)))))|ESSSS(SWEN|)ENNEEE))))|SWSW(SESENN|NN(WWS(WWSSWNNWSSSSW(NNNNNEEE(E|N)|S(WNSE|)EESSE(SWWWWEEEEN|)NE(EESNWW|)NWNWNE)|E)|E)))|W))|S)|SS)))|SSSSS))))|ESSE(EEEE(N|SSWNWSSEESENNNEEN(WW|EE(NWES|)ESWWSESWWNWSSESE(SSWW(SEEES(E(N|SESEN(NWES|)ESSS(S|ENE(NWNSES|)S))|WW)|N(WWN(EE|WSWNN(WSWWSEE(WWNEENSWWSEE|)|E))|E))|NESE(NNNEEEN(N|E)|EEEE))))|NN)))|E)|S(SWSESWW(SEESEE(NNWSNESS|)SSS(ESENNE(SEE(SWW|ENES)|NWW(N|S))|WWNN(ESNW|)WWN(WNWWWSES(WWNWW(S(ESNW|)WW|N(EE|NWN(E|W(N(NN|E)|S))))|E(ES(EESWWEENWW|)WW|N))|E))|NN)|E))|E))|EEE(NWW|ESEE))|NN))|N))))))|W)|NEENN(E(E|SS)|WSWNWNE(WSESENSWNWNE|)))|WNW(WNEEWWSE|)S)))|WSWWN(WSNE|)E)))))|WSSSSSWNNN(SSSENNSSWNNN|))))|W)|NNEENWN(EE|N))|NN(ES(E|S)|N(WWWWSNEEEE|)N)))|N))))))))|SS))|S)))|WWN(E|N))|SES(EENWESWW|)WS(S|W))|S))|S(SS|EEN(WN|ES))))|W)|W)|NNEE(NW(NNN(W|ENE(SSWSNENN|)EE)|W)|EEEEES))|E))|W))|N))))|WSSSS(E(S|N)|WNNWW(NNEESW|W))))|SE(EEE(NWWEES|)ESSE(ESSW(SES(W|E(SEWN|)N)|NWW(SEWN|)NN)|N)|S))|NNENENW(ESWSWSNENENW|))|W)|WSW(WWNSEE|)S))|WSSWW(WNNENESSW(ENNWSWENESSW|)|SSS))))))|WWNENN(ESSNNW|)WSW(SWNWSNESEN|)NNN)|WSW(W|S(SS|E)))|S)|SEEESWWS(EE|WW(S(S|E)|N(NWW(N|S(E|WWSWNWSWW(NENSWS|)SSWNWSSW(NNWNW(WNN(ESENSWNW|)W|S)|SEENE(ENEN(EESWENWW|)W|S))))|E)))))|N)|W))|WW(N|WW)))|NN)|WW)|NN))|NNESEN))|S))|E)|E)|SSE(SWWNSEEN|)NN))))|N))))))|W)|W)))|WSW(SEEWWN|)N)))|SS)|WWSEESS(NNWWNEWSEESS|))|E))))|NWWWNNEE(ESWW|NWW))|ENEN(WNSE|)E(EENSWW|)S)|WW))))|E)|EESSW(N|SSS(W(SESSS(ESNW|)WWWWWN(W|EENWNEESSEN(SWNNWWEESSEN|))|N)|E)))|SSWSW(NN(NWWWEEES|)E|SSSEENWNE(N|ESESWSSESSENNENNNEES(WS(SSWS(SWWWS(EEESNWWW|)WNW(NNW(SSWENN|)NEE(NWW|SSEN)|SS(EE|SS))|E)|E)|ENEN(EEN(ESSWSW(W|N)|W)|WWWWW(SSSWENNN|)W)))))|ENE(NWWEES|)SS))|S)|EEENE(NNWSNESS|)E(SWEN|)E))|E))|N)|NN)|NN)|N)))))|S(ENSW|)WSW(NWNEWSES|)SS)))))|E)|N)))|WW))|N)|SW(N|SSW(WSSEEE(NWWEES|)SWWS(EEESWENWWW|)W(N|WW)|NN))))|S)|WN(NEWS|)WWS(E|WWSWW(SEESNWWN|)WWNEEENNWSWNNEENNNWNNENNENWWSSW(SSWSESESWWNWWSSE(N|SS(ENNSSW|)SW(SEWN|)NNW(NNNW(SSWSEWNENN|)NEEENNE(WSSWWWEEENNE|)|S))|NNN(WSWENE|)ENWNEN(NNENEN(WWSNEE|)ESS(WSWSSENE(SSWWSEEESWS(EENNEWSSWW|)SSW(S(W|S(EENWESWW|)SSSSESW(ENWNNNSSSESW|))|N)|N)|E)|W))))|NESE(NNEWSS|)S(E|WSSW(SEWN|)N)))|W)|W)|W(WWSNEE|)N))|S))))))|EE)|S)|W(SSW(SEWN|)NN|NN))|N))))|E)|W))|E))|S))|SSES(ENSW|)W)|N)|WW))$"

}
