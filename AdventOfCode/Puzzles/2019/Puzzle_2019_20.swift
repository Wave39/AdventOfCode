//
//  Puzzle_2019_20.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/21/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_20: PuzzleBaseClass {

    enum Tile: Hashable, CustomStringConvertible, LosslessStringConvertible {
        init(_ value: String) {
            switch value {
            case ".": self = .path
            case "#": self = .wall
            default:
                self = .unknown
            }
        }

        case unknown
        case path
        case wall
        case portal(String)
        case startingPortal
        case endingPortal
        case visited

        var description: String {
            switch self {
            case .unknown: return String(Character.orangeSquare)
            case .wall: return String(Character.blackSquare)
            case .path: return String(Character.whiteSquare)
            case .portal: return String(Character.purpleSquare)
            case .startingPortal: return String(Character.greenSquare)
            case .endingPortal: return String(Character.redSquare)
            case .visited: return String(Character.yellowSquare)
            }
        }

    }

    struct Portal {
        var location: Point2D
        var identifier: String
        var outer: Bool
        var inner: Bool
    }

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_20_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        // return solvePart2(str: Puzzle_2019_20_Input.puzzleInput_test3)
        return solvePart2(str: Puzzle_2019_20_Input.puzzleInput)
    }

    func printBoard(_ board: [[Tile]]) {
        for line in board {
            var str = ""
            for tile in line {
                str += tile.description
            }

            print(str)
        }
    }

    func parseBoard(_ arr: [[String]]) -> [[Tile]] {
        var board: [[Tile]] = []
        let maxX = arr[2].count
        for y in 2..<arr.count {
            if arr[y].contains("#") {
                if arr[y][2] == "#" || arr[y][2] == "." || arr[y][2] == " " {
                    var lineArray: [Tile] = []
                    for x in 2..<min(arr[y].count, maxX) {
                        if arr[y][x] == "#" {
                            lineArray.append(.wall)
                        } else if arr[y][x] == "." {
                            lineArray.append(.path)
                        } else {
                            lineArray.append(.unknown)
                        }
                    }

                    board.append(lineArray)
                }
            }
        }

        // look for portals
        let boardHeight = board.count
        let boardWidth = board[0].count
        for y in 0..<boardHeight {
            for x in 0..<boardWidth {
                var portalString = ""
                var portalPoint = Point2D.origin

                if board[y][x] == .path && (x == 0 || x == (boardWidth - 1) || y == 0 || y == boardHeight - 1) {
                    portalPoint = Point2D(x: x, y: y)
                    if y == 0 {
                        // portal is above
                        portalString = String(arr[0][x + 2]) + String(arr[1][x + 2])
                    } else if y == boardHeight - 1 {
                        // portal is below
                        portalString = String(arr[y + 3][x + 2]) + String(arr[y + 4][x + 2])
                    } else if x == 0 {
                        // portal is left
                        portalString = String(arr[y + 2][0]) + String(arr[y + 2][1])
                    } else if x == boardWidth - 1 {
                        // portal is right
                        portalString = String(arr[y + 2][x + 3]) + String(arr[y + 2][x + 4])
                    }
                }

                if board[y][x] == .unknown {
                    if board[y - 1][x] == .path {
                        // portal is below
                        portalString = String(arr[y + 2][x + 2]) + String(arr[y + 3][x + 2])
                        portalPoint = Point2D(x: x, y: y - 1)
                    } else if board[y + 1][x] == .path {
                        // portal is above
                        portalString = String(arr[y + 1][x + 2]) + String(arr[y + 2][x + 2])
                        portalPoint = Point2D(x: x, y: y + 1)
                    } else if board[y][x - 1] == .path {
                        // portal is right
                        portalString = String(arr[y + 2][x + 2]) + String(arr[y + 2][x + 3])
                        portalPoint = Point2D(x: x - 1, y: y)
                    } else if board[y][x + 1] == .path {
                        // portal is left
                        portalString = String(arr[y + 2][x + 1]) + String(arr[y + 2][x + 2])
                        portalPoint = Point2D(x: x + 1, y: y)
                    }
                }

                if portalString != "" {
                    if portalString == "AA" {
                        board[portalPoint.y][portalPoint.x] = .startingPortal
                    } else if portalString == "ZZ" {
                        board[portalPoint.y][portalPoint.x] = .endingPortal
                    } else {
                        board[portalPoint.y][portalPoint.x] = .portal(portalString)
                    }
                }
            }
        }
        return board
    }

    func optimizeBoard(board: inout [[Tile]]) {
        let boardHeight = board.count
        let boardWidth = board[0].count
        var replacements = 0
        repeat {
            replacements = 0
            for y in 1..<(boardHeight - 1) {
                for x in 1..<(boardWidth - 1) {
                    if board[y][x] == .path {
                        var walls = 0
                        if board[y - 1][x] == .wall {
                            walls += 1
                        }

                        if board[y + 1][x] == .wall {
                            walls += 1
                        }

                        if board[y][x - 1] == .wall {
                            walls += 1
                        }

                        if board[y][x + 1] == .wall {
                            walls += 1
                        }

                        if walls >= 3 {
                            board[y][x] = .wall
                            replacements += 1
                        }
                    }
                }
            }
        } while replacements > 0
    }

    func findPortals(board: [[Tile]]) -> [Portal] {
        var retval: [Portal] = []
        let boardHeight = board.count
        let boardWidth = board[0].count
        for y in 0..<boardHeight {
            for x in 0..<boardWidth {
                if board[y][x] == .startingPortal {
                    retval.append(Portal(location: Point2D(x: x, y: y), identifier: "AA", outer: false, inner: false))
                } else if board[y][x] == .endingPortal {
                    retval.append(Portal(location: Point2D(x: x, y: y), identifier: "ZZ", outer: false, inner: false))
                } else if case Tile.portal(let v) = board[y][x] {
                    let outer = (x == 0 || x == (boardWidth - 1) || y == 0 || y == (boardHeight - 1))
                    retval.append(Portal(location: Point2D(x: x, y: y), identifier: v, outer: outer, inner: !outer))
                }
            }
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray().map { $0.map { String($0) } }
        let board = parseBoard(arr)
        // printBoard(board)

//        print("optimize:")
//        optimizeBoard(board: &board)
//        printBoard(board)

        let portals = findPortals(board: board)

        let boardHeight = board.count
        let boardWidth = board[0].count

        func findValidMoves(from: Point2D) -> [Point2D] {
            var retval: [Point2D] = []

            let port = portals.filter({ $0.location == from })
            if port.count == 1 {
                let otherPort = portals.filter { $0.identifier == port.first!.identifier && $0.location != port.first!.location }
                if otherPort.count == 1 {
                    retval.append(otherPort.first!.location)
                }
            }

            let adjacent = from.adjacentLocations()
            for a in adjacent {
                if a.x >= 0 && a.x < boardWidth && a.y >= 0 && a.y < boardHeight {
                    if board[a.y][a.x] == .path || board[a.y][a.x] == .endingPortal {
                        retval.append(a)
                    } else if case .portal = board[a.y][a.x] {
                        retval.append(a)
                    }
                }
            }

            return retval
        }

        let startingPosition = portals.filter { $0.identifier == "AA" }.first!
        let endingPosition = portals.filter { $0.identifier == "ZZ" }.first!
        var visitedLocations: Set<Point2D> = Set()
        var locations = [ startingPosition.location ]
        var stepCount = 0
        while locations.count > 0 {
            var nextLocations: [Point2D] = []
            for loc in locations {
                let moves = findValidMoves(from: loc)
                for move in moves {
                    if !visitedLocations.contains(move) {
                        nextLocations.append(move)
                        visitedLocations.insert(move)
                    }
                }
            }
            stepCount += 1
            if nextLocations.contains(endingPosition.location) {
                break
            }

            locations = nextLocations

//            print("\(stepCount) steps puts you at next: \(nextLocations)")
//            var newBoard = board
//            for loc in locations {
//                newBoard[loc.y][loc.x] = .visited
//            }
//
//            printBoard(newBoard)
        }

        return stepCount
    }

    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray().map { $0.map { String($0) } }
        var board = parseBoard(arr)
        // printBoard(board)

//        print("optimize:")
        optimizeBoard(board: &board)
//        printBoard(board)

        let portals = findPortals(board: board)

        let boardHeight = board.count
        let boardWidth = board[0].count

        func findValid3DMoves(from: Point3D) -> [Point3D] {
            var retval: [Point3D] = []

            let port = portals.filter({ $0.location == Point2D(x: from.x, y: from.y) })
            if port.count == 1 {
                if from.z > 0 || port.first!.inner {
                    let otherPort = portals.filter { $0.identifier == port.first!.identifier && $0.location != port.first!.location }
                    if otherPort.count == 1 {
                        let otherPortLocation = otherPort.first!.location
                        retval.append(Point3D(x: otherPortLocation.x, y: otherPortLocation.y, z: from.z + (port.first!.inner ? +1 : -1)))
                    }
                }
            }

            let adjacent = from.adjacentLocations().filter { $0.z == from.z }
            for a in adjacent {
                if a.x >= 0 && a.x < boardWidth && a.y >= 0 && a.y < boardHeight {
                    if board[a.y][a.x] == .path || (board[a.y][a.x] == .endingPortal && from.z == 0) {
                        retval.append(a)
                    } else if case .portal = board[a.y][a.x] {
                        retval.append(a)
                    }
                }
            }

            return retval
        }

        let startingPosition = portals.filter { $0.identifier == "AA" }.first!
        let endingPosition = portals.filter { $0.identifier == "ZZ" }.first!
        let endingPosition3D = Point3D(x: endingPosition.location.x, y: endingPosition.location.y, z: 0)
        var visitedLocations: Set<Point3D> = Set()
        var locations = [ Point3D(x: startingPosition.location.x, y: startingPosition.location.y, z: 0) ]
        var stepCount = 0
        while locations.count > 0 {
            var nextLocations: [Point3D] = []
            for loc in locations {
                let moves = findValid3DMoves(from: loc)
                for move in moves {
                    if !visitedLocations.contains(move) {
                        nextLocations.append(move)
                        visitedLocations.insert(move)
                    }
                }
            }
            stepCount += 1
            if nextLocations.contains(endingPosition3D) {
                break
            }

            locations = nextLocations

//            print("\(stepCount) steps puts you at next: \(nextLocations)")
//            var newBoard = board
//            for loc in locations {
//                newBoard[loc.y][loc.x] = .visited
//            }
//
//            printBoard(newBoard)
        }

        return stepCount
    }

}

private class Puzzle_2019_20_Input: NSObject {

    static let puzzleInput_test1 = """
         A
         A
  #######.#########
  #######.........#
  #######.#######.#
  #######.#######.#
  #######.#######.#
  #####  B    ###.#
BC...##  C    ###.#
  ##.##       ###.#
  ##...DE  F  ###.#
  #####    G  ###.#
  #########.#####.#
DE..#######...###.#
  #.#########.###.#
FG..#########.....#
  ###########.#####
             Z
             Z
"""

    static let puzzleInput_test2 = """
                   A
                   A
  #################.#############
  #.#...#...................#.#.#
  #.#.#.###.###.###.#########.#.#
  #.#.#.......#...#.....#.#.#...#
  #.#########.###.#####.#.#.###.#
  #.............#.#.....#.......#
  ###.###########.###.#####.#.#.#
  #.....#        A   C    #.#.#.#
  #######        S   P    #####.#
  #.#...#                 #......VT
  #.#.#.#                 #.#####
  #...#.#               YN....#.#
  #.###.#                 #####.#
DI....#.#                 #.....#
  #####.#                 #.###.#
ZZ......#               QG....#..AS
  ###.###                 #######
JO..#.#.#                 #.....#
  #.#.#.#                 ###.#.#
  #...#..DI             BU....#..LF
  #####.#                 #.#####
YN......#               VT..#....QG
  #.###.#                 #.###.#
  #.#...#                 #.....#
  ###.###    J L     J    #.#.###
  #.....#    O F     P    #.#...#
  #.###.#####.#.#####.#####.###.#
  #...#.#.#...#.....#.....#.#...#
  #.#####.###.###.#.#.#########.#
  #...#.#.....#...#.#.#.#.....#.#
  #.###.#####.###.###.#.#.#######
  #.#.........#...#.............#
  #########.###.###.#############
           B   J   C
           U   P   P
"""

    static let puzzleInput_test3 = """
             Z L X W       C
             Z P Q B       K
  ###########.#.#.#.#######.###############
  #...#.......#.#.......#.#.......#.#.#...#
  ###.#.#.#.#.#.#.#.###.#.#.#######.#.#.###
  #.#...#.#.#...#.#.#...#...#...#.#.......#
  #.###.#######.###.###.#.###.###.#.#######
  #...#.......#.#...#...#.............#...#
  #.#########.#######.#.#######.#######.###
  #...#.#    F       R I       Z    #.#.#.#
  #.###.#    D       E C       H    #.#.#.#
  #.#...#                           #...#.#
  #.###.#                           #.###.#
  #.#....OA                       WB..#.#..ZH
  #.###.#                           #.#.#.#
CJ......#                           #.....#
  #######                           #######
  #.#....CK                         #......IC
  #.###.#                           #.###.#
  #.....#                           #...#.#
  ###.###                           #.#.#.#
XF....#.#                         RF..#.#.#
  #####.#                           #######
  #......CJ                       NM..#...#
  ###.#.#                           #.###.#
RE....#.#                           #......RF
  ###.###        X   X       L      #.#.#.#
  #.....#        F   Q       P      #.#.#.#
  ###.###########.###.#######.#########.###
  #.....#...#.....#.......#...#.....#.#...#
  #####.#.###.#######.#######.###.###.#.#.#
  #.......#.......#.#.#.#.#...#...#...#.#.#
  #####.###.#####.#.#.#.#.###.###.#.###.###
  #.......#.....#.#...#...............#...#
  #############.#.#.###.###################
               A O F   N
               A A D   M
"""

    static let puzzleInput = """
                                     K     Z   V           U     I F
                                     Q     T   Y           Y     E E
  ###################################.#####.###.###########.#####.#.#####################################
  #.......#.#.............#.........#.#.......#.#.#.........#.....#...#...#...........#...#.....#.#.....#
  ###.#####.###.###.###.###########.#.###.#####.#.###.#.#.#.###.###.###.#####.#######.###.#####.#.###.###
  #.#...#.#.#.#.#.#.#.#.....#...........#.....#.#...#.#.#.#...#.#.#.#.....#.#.#...#.#.#...#.#.#.....#...#
  #.#.###.#.#.###.###.#.#########.###.#######.#.#.#.#######.#.#.#.#.#.###.#.#.#.###.#####.#.#.#.#####.###
  #.....#...#...............#.#.#.#.#.#.....#.#.#.#...#.....#.#.#.#.#...#.....#.#.#.........#...#.#...#.#
  #.#######.###########.###.#.#.###.#.###.#.#.#.#.###.###.###.#.#.#.#.###.#.###.#.#.#.#######.###.###.#.#
  #...#.......#...#.#...#...#...#.#.#.#...#...#.....#.#.#.#...#...#...#...#.........#.#.#.#...#.......#.#
  #.#######.#.###.#.#######.###.#.#.#.#.#.###.###.#####.#####.###.#.#####.#####.#.#.###.#.###.#.#######.#
  #.#.#...#.#...#.......#.......#.#...#.#...#.#.#...#.#.......#...#.#.........#.#.#...............#.....#
  #.#.#.#######.#####.#####.###.#.###.#.#####.#.#.###.#####.###.#####.###.###########.###############.###
  #.#...#...#.......#...#...#.#.......#.....#.#.....#.#.......#.#...#.#.#.#.......#.......#...#...#.#...#
  #.###.###.#####.#.###.#####.#####.#.###.#######.#.#.#######.#.#.#####.#.#.###########.#####.###.#.#.###
  #.#.#.#...#...#.#.#...#.#.#.#.#.#.#.#...#.......#.#.#.#.....#.....#...............#...#.#...#.........#
  #.#.#.#.#####.#.#####.#.#.#.#.#.###.#.#####.###.###.#.#####.#.#######.#.#######.#######.#.#.###.#####.#
  #.......#.#.#...#.#...............#.#...#.#.#.......#...#...#.......#.#.#.#.#...#.#.....#.#.#...#.#...#
  #.#######.#.###.#.#.###.#.#.#.###.#.###.#.###.#.###.#.###.#.#.#.#######.#.#.#####.#.#######.#.###.###.#
  #.#.#.#.#.#.......#.#.#.#.#.#.#.#.#.#...#...#.#.#.#.#.....#.#.#.#.#.#...#.......#.#.#.#...#.#.#...#.#.#
  #.#.#.#.#.#####.#####.#.#####.#.#.#.#.###.#.#.###.#####.#####.#.#.#.#.#####.#.###.#.#.#.###.#.###.#.###
  #.#.#.#.#.#.....#.#.....#.......#.#.#.#...#.#...#...#.......#.#.#.#.........#.#...#.......#.#.#.#.#.#.#
  #.#.#.#.#.#.###.#.#.#####.###.#.#.#.#.#.###.#.###.#.###.#######.#.#.###.###.#####.#.#.#.###.#.#.#.#.#.#
  #.......#.#.#.#.#.#.#...#.#.#.#.#...#...#...#...#.#.#.....#.#...#...#...#.......#...#.#...#.#.#.#...#.#
  #####.###.#.#.###.#####.###.###.###.#####.#####.#.#.#.#####.#.#.#####.#######.#####.#######.#.#.#.###.#
  #.#...#.........#...#.#.......#...#...#.....#...#.#.#.....#...#.#...........#.#.#.#...#.#.........#...#
  #.###.#.#.#######.#.#.#.#########.#########.#.###.#.#.#.###.#.#########.###.###.#.#.###.###.#######.###
  #.#.....#...#...#.#...#.....#.......#.......#.....#.#.#...#.#.....#.....#.....#...#.#...#.........#...#
  #.###.#.#.#####.###.###.#######.#####.#############.#.#########.###.###########.###.#.#.#.###.#.###.#.#
  #...#.#.#.#.#...#.#.#.....#    U     N             Q W         Z   N        #.......#.#...#...#...#.#.#
  ###.###.###.###.#.#.###.###    Y     D             P L         W   J        #####.#########.#######.###
  #.#.#.#.#...#...#.#...#.#.#                                                 #.....#...#...........#.#.#
  #.#.#.#.###.###.#.#.###.#.#                                                 ###.#.###.###.###.#####.#.#
  #...................#.#...#                                                 #.#.#.........#...#........CB
  #.###.#######.#.###.#.#.#.#                                                 #.#.#.###.#####.###.#.#.#.#
  #.#.........#.#...#.....#.#                                                 #...#.#.....#...#...#.#.#..AA
  #######.#######.###.#####.#                                                 #.#######.#.###.#.#.###.###
  #.....#.......#...#...#...#                                               QJ..#.#...#.#.#.#...#...#.#.#
  ###.#.#.###.###########.###                                                 ###.#.#######.###########.#
YG....#.....#.#.......#......TY                                               #.........#...........#...#
  #.#.#.###########.#.#.#####                                                 #.#####.###.#########.#.#.#
  #.#.#.#...#...#...#.#.#...#                                               CB..#.#.......#.#.#.#.....#..DN
  #######.#####.#.#.#####.###                                                 ###.#########.#.#.#########
  #.....#...#...#.#.#...#.#.#                                                 #...#.........#...#.......#
  #.###.#.#.#.#.#.#.#.#.#.#.#                                                 ###.###.#####.#.#.#.#####.#
SP..#.....#...#...#...#......YG                                               #.......#...#...#.#.#.....#
  ###########################                                                 #.#.###.###.#.###.#.#.#####
NJ....#.................#.#.#                                               KQ..#.#.......#.#...#.#.....#
  #.#.#.#####.#.#.#####.#.#.#                                                 ###.###.###.###.#.#.###.#.#
  #.#.#.....#.#.#.#.....#...#                                                 #.#...#.#.#.#.#.#.....#.#..IT
  ###.#####.###.#####.#####.#                                                 #.#.#####.###.#############
  #.#.....#...#.....#........WE                                             IE..#.#.#.#...............#.#
  #.#.#.#.#.#########.#.###.#                                                 #.#.#.#.#.###.###.###.###.#
  #...#.#...#.#.#.#...#.#...#                                                 #.#.#...#.#.#...#.#...#.#.#
  #.#######.#.#.#.#####.#####                                                 #.#####.#.#.#.#.#####.#.#.#
  #.#.....#.#.........#.#...#                                                 #...........#.#.#.#...#....QJ
  #######.###.#.#.###.#####.#                                                 #######.#.#######.#.#.###.#
  #.#.....#...#.#.#.........#                                                 #.....#.#.#...#.#...#.....#
  #.###.#.#.#######.#.#####.#                                                 ###.#########.#.###########
YV..#...#.#...#.#.#.#.#.....#                                                 #.......#.........#.#.....#
  #.#.###.#.#.#.#.#.###.#.###                                                 #.#####.###.#####.#.#.#.#.#
  #.....#...#.#...#.#.#.#....QX                                               #.#...#.........#.#...#.#..QP
  ###.###.#######.###.###.#.#                                                 #.###.#.###.#####.#.#####.#
  #.#.#.....#.....#.....#.#.#                                                 #.#.#.#.#...#.....#...#...#
  #.#####.#######.###.#.#####                                                 #.#.#.#####.#.###.###.#.#.#
  #.#...#.#.....#.#.#.#...#..DM                                             FE..#.#...#.#.#.#.......#.#.#
  #.#.#####.#.###.#.#.###.#.#                                                 #.#.#.#.#.###############.#
  #.#.......#...#.#.....#...#                                                 #.#...#.#.#.....#.......#.#
  #.#.#.#.#.###.#.#####.###.#                                                 #######.#.#.#######.#.#####
QX....#.#.#.#.............#.#                                                 #.......#.#.......#.#.....#
  #####.#.#.#.#.#.###########                                                 ###.###.#.#.#.###.#.#####.#
  #.#.#.#.#.#.#.#.#.........#                                               GX..#.#.......#.#.#.......#..DM
  #.#.###############.###.#.#                                                 #.#.#####.#.###.###.###.#.#
  #.#.#.........#...#...#.#..CS                                               #.....#.#.#.#.#...#.#.#.#.#
  #.#.#######.#####.###.#.###                                                 #######.#.###.#.#####.#####
WE........#.#.#.#.#.#...#...#                                               MX........#.#.........#......CS
  #####.###.#.#.#.#.#.#.#####                                                 #####.###.###.#####.###.###
  #...#...............#.#.#.#                                                 #.#.....#.#.......#...#...#
  ###.###################.#.#                                                 #.#.###########.#.###.#.#.#
  #...............#.#........ME                                               #.#.#.#...#...#.#.#...#.#.#
  #.#.#####.#####.#.#.###.#.#                                                 #.#.#####.#######.#.#####.#
GX..#...#.#.#...........#.#.#                                                 #.................#.......#
  #.#.###.#######.###.#####.#      J         D   Z V S             I   Y      #.###.###.#.###.###.#.#.#.#
  #.#.......#.......#.....#.#      I         N   T Y P             T   V      #...#...#.#.#.#.#.#.#.#.#.#
  #.#.#.#########.#.#.#############.#########.###.#.#.#############.###.###########.###.#.#.#.#.#.#####.#
  #.#.#.....#.....#.#...#.......#.....#.......#.....#.#.#.#.#...#...#.........#.....#...#.#.....#...#...#
  #.#############.###.#######.#.#####.#.###.###.#####.#.#.#.###.#.#####.#.#.#####.#.#.#.#.#####.###.#####
  #...........#.....#.....#...#.......#...#.#.#.....#.#.....#.#.......#.#.#...#...#.#.#.#.#.....#.#.....#
  ###.#######.#######.#####.###.#######.#.###.###.#.#.#.###.#.#.#######.#############.#.#######.#.#.###.#
  #.#.....#.#.#.#.......#.#.#.#...#...#.#...#...#.#.#.....#...#.......#.....#.#...#...#...#.......#.#...#
  #.#.#.###.#.#.#.#.###.#.###.###.#.#.###.#.###.#.#########.#####.#.###.#.###.#.#########.#####.#####.#.#
  #...#...#.....#.#.#...#...#.#...#.#...#.#.#.....#.#.#.....#...#.#.#...#.............#.....#.....#...#.#
  #####.###########.#####.###.#.###.#.###.#####.#.#.#.###.#.#.#.###.#.#######.###.#########.#.#.#########
  #.........#.....#.#...........#...#.#...#.#...#.#...#...#.#.#.....#.......#...#.#.....#.#.#.#.....#.#.#
  ###.###.#.###.#####.#.#.#.#.#.#.###.###.#.###.#####.#.#####.#.###.###.#####.#####.#####.#####.#####.#.#
  #...#.#.#.#.........#.#.#.#.#...#...#.....#.....#.......#...#.#.#.#.......#.#.#...#.....#.#.#.........#
  #.#.#.#.###.###.###########.###.#.###.#.#####.#.#.#.#.#.#.#.###.###.#.###.###.###.#.#.#.#.#.#.###.#.#.#
  #.#.#...#...#.....#.........#.#.#...#.#.#.#...#.#.#.#.#.#.#.......#.#...#.#.....#...#.#.#.......#.#.#.#
  #.#.###.#.#.#.#.#.#####.#####.#.###.#.###.###.#####.#######.###.###.#########.###.#######.#.#.#####.#.#
  #.#.#...#.#.#.#.#.#.#.#.#.......#...#...#...#...#.....#.#.....#.#.#.......#...#.....#.#.#.#.#.#.#...#.#
  #.#####.#.#####.###.#.#######.#.#.#.###.###.#.#.###.###.###.#####.#.#.#####.#####.#.#.#.###.#.#.#####.#
  #...#...#.#.....#.#.....#.#...#.#.#.#...#.#...#.#.......#.#.#.#.#...#...........#.#.#...#.#.#.....#.#.#
  ###.###.#########.#####.#.###.#####.#.###.###.#####.#####.#.#.#.#.#######.#######.###.###.#####.#.#.###
  #.....#.#.....................#...#.#.......#.#.....#.....#.....#.#...........#.....#.#.#.#.#...#.#...#
  #.###.#####.#.#.#.###.#.#.#.###.###.###.#.###.#####.###.#.#.#########.###########.###.#.#.#.###.###.###
  #...#...#...#.#.#.#...#.#.#.#.......#.#.#...#.....#.#...#.#.......#.#.........#.............#.........#
  ###.#.#####.#############.#####.#.###.#.###.#####.#.#.###.###.#.#.#.#####.#.###.###.###.###.#.#####.###
  #...#.#.#.#...#.#...#.......#...#.....#.#...#.....#...#.#.#.#.#.#...#.....#.....#.....#...#.#...#.....#
  #.###.#.#.###.#.###.###.#####.#####.#####.###.#########.#.#.#####.#######.#####.###.#####.#.#.###.###.#
  #.#.........#.#.........#.....#.....#.....#.........#.....#.......#...........#...#...#...#.#...#.#...#
  ###################################.###.#######.#.###.###.###.#######.#################################
                                     N   J       W Z   Z   M   M       T
                                     D   I       L W   Z   X   E       Y
"""

}
