//
//  Point2DTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/23/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import XCTest

final class Point2DTests: XCTestCase {
    func test_defaultInitializer() {
        let defaultInit = Point2D()
        XCTAssertEqual(defaultInit, Point2D.origin)
    }

    func test_description() {
        let p = Point2D(x: 3, y: -2)
        XCTAssertEqual(p.description, "(3,-2)")
    }

    func test_directionTo() throws {
        let point1_1 = Point2D(x: 1, y: 1)
        let point1_2 = Point2D(x: 1, y: 2)
        let point2_1 = Point2D(x: 2, y: 1)
        XCTAssertEqual(point1_1.directionTo(point1_2, topLeftOrigin: true), .South)
        XCTAssertEqual(point1_1.directionTo(point1_2, topLeftOrigin: false), .North)
        XCTAssertEqual(point1_1.directionTo(point1_2), .North)

        XCTAssertEqual(point1_1.directionTo(point2_1, topLeftOrigin: true), .East)
        XCTAssertEqual(point1_1.directionTo(point2_1), .East)

        XCTAssertEqual(point2_1.directionTo(point1_1, topLeftOrigin: true), .West)
        XCTAssertEqual(point2_1.directionTo(point1_1), .West)
    }

    func test_equatable() {
        let p1 = Point2D(x: 5, y: 7)
        let p2 = Point2D(x: 5, y: 7)
        let p3 = Point2D(x: 5, y: 8)

        XCTAssertEqual(p1, p2)
        XCTAssertNotEqual(p1, p3)
    }

    func test_hashable() {
        let p1 = Point2D(x: 5, y: 7)
        let p2 = Point2D(x: 5, y: 7)
        let p3 = Point2D(x: 5, y: 8)

        var set = Set<Point2D>()
        set.insert(p1)
        set.insert(p2) // should not create a new entry
        set.insert(p3)

        XCTAssertEqual(set.count, 2)
        XCTAssertTrue(set.contains(p1))
        XCTAssertTrue(set.contains(p3))
    }

    func test_originAndDefaultInitializer() {
        let origin = Point2D.origin
        XCTAssertEqual(origin.x, 0)
        XCTAssertEqual(origin.y, 0)
    }

    func testComparableOrdering() {
        let p1 = Point2D(x: 0, y: 0)
        let p2 = Point2D(x: 0, y: 1)
        let p3 = Point2D(x: 1, y: 0)
        let p4 = Point2D(x: 1, y: 1)

        let sorted = [p4, p3, p2, p1].sorted()
        XCTAssertEqual(sorted, [p1, p2, p3, p4])

        // Same x, smaller y should come first
        XCTAssertTrue(p1 < p2)
        // Larger x should come later regardless of y
        XCTAssertTrue(p2 < p3)
    }

    // MARK: - Arithmetic operators (example-based)

    func testAdditionAndSubtraction() {
        let a = Point2D(x: 2, y: 3)
        let b = Point2D(x: -1, y: 4)

        let sum = a + b
        XCTAssertEqual(sum, Point2D(x: 1, y: 7))

        let diff = a - b
        XCTAssertEqual(diff, Point2D(x: 3, y: -1))
    }

    func testAdditionAssignmentAndSubtractionAssignment() {
        var p = Point2D(x: 2, y: 3)
        let delta = Point2D(x: 5, y: -1)

        p += delta
        XCTAssertEqual(p, Point2D(x: 7, y: 2))

        p -= delta
        XCTAssertEqual(p, Point2D(x: 2, y: 3))
    }

    // MARK: - Arithmetic operators (property-style)

    func testAdditionIsCommutativeAndSubtractionIsInverse() {
        for x1 in -3...3 {
            for y1 in -3...3 {
                let a = Point2D(x: x1, y: y1)
                for x2 in -3...3 {
                    for y2 in -3...3 {
                        let b = Point2D(x: x2, y: y2)

                        // Commutativity: a + b == b + a
                        XCTAssertEqual(a + b, b + a)

                        // Inverse: (a + b) - b == a and (a - b) + b == a
                        XCTAssertEqual((a + b) - b, a)
                        XCTAssertEqual((a - b) + b, a)
                    }
                }
            }
        }
    }

    func testCompoundAssignmentMatchesBinaryOperators() {
        for x1 in -2...2 {
            for y1 in -2...2 {
                for dx in -2...2 {
                    for dy in -2...2 {
                        let base = Point2D(x: x1, y: y1)
                        let delta = Point2D(x: dx, y: dy)

                        var plus = base
                        plus += delta
                        XCTAssertEqual(plus, base + delta)

                        var minus = base
                        minus -= delta
                        XCTAssertEqual(minus, base - delta)
                    }
                }
            }
        }
    }

    // MARK: - maximumBounds

    func testMaximumBounds() {
        let points = [
            Point2D(x: 1, y: 2),
            Point2D(x: 5, y: 3),
            Point2D(x: 4, y: 10),
            Point2D(x: -2, y: 0)
        ]

        let maxPoint = Point2D.maximumBounds(arr: points)
        XCTAssertEqual(maxPoint, Point2D(x: 5, y: 10))
    }

    // MARK: - Distances

    func testManhattanDistanceExamples() {
        let a = Point2D(x: 0, y: 0)
        let b = Point2D(x: 3, y: 4)
        let c = Point2D(x: -1, y: -2)

        XCTAssertEqual(a.manhattanDistanceTo(pt: b), 7)
        XCTAssertEqual(a.manhattanDistanceTo(pt: c), 3)
        XCTAssertEqual(b.manhattanDistanceTo(pt: c), 10)
    }

    func testManhattanDistanceProperties() {
        for x1 in -3...3 {
            for y1 in -3...3 {
                let a = Point2D(x: x1, y: y1)

                // Distance to self is zero
                XCTAssertEqual(a.manhattanDistanceTo(pt: a), 0)

                for x2 in -3...3 {
                    for y2 in -3...3 {
                        let b = Point2D(x: x2, y: y2)

                        // Symmetry: d(a,b) == d(b,a)
                        XCTAssertEqual(a.manhattanDistanceTo(pt: b),
                                       b.manhattanDistanceTo(pt: a))
                    }
                }
            }
        }
    }

    func testLocationsAtManhattanDistanceZero() {
        let center = Point2D(x: 5, y: 5)
        let ring = center.locationsAtManhattanDistance(0)
        XCTAssertEqual(ring.count, 1)
        XCTAssertEqual(ring.first, center)
    }

    /// A mild sanity check: all returned points should be at *some* fixed distance
    /// from the center (based on their current implementation this corresponds to
    /// a specific ring shape).
    func testLocationsAtManhattanDistanceAreConsistent() {
        let center = Point2D(x: 0, y: 0)
        for d in 1...3 {
            let ring = center.locationsAtManhattanDistance(d)
            XCTAssertFalse(ring.isEmpty, "Ring for distance \(d) should not be empty")

            // All points should have the same Manhattan distance from the center.
            let distances = Set(ring.map { center.manhattanDistanceTo(pt: $0) })
            XCTAssertEqual(distances.count, 1, "All points for distance \(d) should share one Manhattan distance")
        }
    }

    // MARK: - Adjacency

    func testAdjacentLocationsWithoutDiagonals() {
        let center = Point2D(x: 10, y: 10)
        let adj = center.adjacentLocations()

        XCTAssertEqual(adj.count, 4)

        // Order documented:
        // 0: (x, y-1)  up
        // 1: (x-1, y)  left
        // 2: (x+1, y)  right
        // 3: (x, y+1)  down
        XCTAssertEqual(adj[0], Point2D(x: 10, y: 9))
        XCTAssertEqual(adj[1], Point2D(x: 9, y: 10))
        XCTAssertEqual(adj[2], Point2D(x: 11, y: 10))
        XCTAssertEqual(adj[3], Point2D(x: 10, y: 11))
    }

    func testAdjacentLocationsWithDiagonals() {
        let center = Point2D(x: 0, y: 0)
        let adj = center.adjacentLocations(includeDiagonals: true)

        XCTAssertEqual(adj.count, 8)

        // First 4 are the same as non-diagonals
        XCTAssertEqual(adj[0], Point2D(x: 0, y: -1))
        XCTAssertEqual(adj[1], Point2D(x: -1, y: 0))
        XCTAssertEqual(adj[2], Point2D(x: 1, y: 0))
        XCTAssertEqual(adj[3], Point2D(x: 0, y: 1))

        // Extra 4 diagonals
        XCTAssertEqual(adj[4], Point2D(x: -1, y: -1))
        XCTAssertEqual(adj[5], Point2D(x: 1, y: -1))
        XCTAssertEqual(adj[6], Point2D(x: -1, y: 1))
        XCTAssertEqual(adj[7], Point2D(x: 1, y: 1))
    }

    func testAdjacentLocationsWithinGrid() {
        let center = Point2D(x: 0, y: 0)
        let rows = 3
        let columns = 3

        let adj = center.adjacentLocationsWithinGrid(rows: rows, columns: columns, includeDiagonals: true)

        // All must be within [0, columns) x [0, rows)
        for p in adj {
            XCTAssertTrue(p.x >= 0 && p.x < columns, "x out of range for point \(p)")
            XCTAssertTrue(p.y >= 0 && p.y < rows, "y out of range for point \(p)")
        }

        // From (0,0) in a 3x3 grid, valid neighbors are: (1,0), (0,1), (1,1)
        let expected = Set([
            Point2D(x: 1, y: 0),
            Point2D(x: 0, y: 1),
            Point2D(x: 1, y: 1)
        ])
        XCTAssertEqual(Set(adj), expected)
    }

    // MARK: - Movement (bottom-left origin)

    func testMoveForwardBottomLeftOrigin() {
        let start = Point2D(x: 5, y: 5)

        XCTAssertEqual(start.moveForward(direction: .North), Point2D(x: 5, y: 6))
        XCTAssertEqual(start.moveForward(direction: .South), Point2D(x: 5, y: 4))
        XCTAssertEqual(start.moveForward(direction: .East), Point2D(x: 6, y: 5))
        XCTAssertEqual(start.moveForward(direction: .West), Point2D(x: 4, y: 5))
    }

    func testMoveForwardBottomLeftOriginWithBounds() {
        let rows = 10
        let columns = 10

        let center = Point2D(x: 5, y: 5)
        XCTAssertEqual(center.moveForward(direction: .North, rows: rows, columns: columns),
                       Point2D(x: 5, y: 6))

        let edge = Point2D(x: 0, y: 0)
        // Moving West or South should go out of bounds and return nil
        XCTAssertNil(edge.moveForward(direction: .West, rows: rows, columns: columns))
        XCTAssertNil(edge.moveForward(direction: .South, rows: rows, columns: columns))
    }

    // MARK: - Movement (top-left origin)

    func testMoveForwardTopLeftOrigin() {
        let start = Point2D(x: 5, y: 5)

        // In top-left origin, y increases downward
        XCTAssertEqual(start.moveForwardFromTopLeftOrigin(direction: .North), Point2D(x: 5, y: 4))
        XCTAssertEqual(start.moveForwardFromTopLeftOrigin(direction: .South), Point2D(x: 5, y: 6))
        XCTAssertEqual(start.moveForwardFromTopLeftOrigin(direction: .East), Point2D(x: 6, y: 5))
        XCTAssertEqual(start.moveForwardFromTopLeftOrigin(direction: .West), Point2D(x: 4, y: 5))
    }

    func testMoveForwardTopLeftOriginWithBounds() {
        let rows = 10
        let columns = 10

        let center = Point2D(x: 5, y: 5)
        XCTAssertEqual(center.moveForwardFromTopLeftOrigin(direction: .North, rows: rows, columns: columns),
                       Point2D(x: 5, y: 4))

        let topLeft = Point2D(x: 0, y: 0)
        // Moving North or West from (0,0) should go out of bounds
        XCTAssertNil(topLeft.moveForwardFromTopLeftOrigin(direction: .North, rows: rows, columns: columns))
        XCTAssertNil(topLeft.moveForwardFromTopLeftOrigin(direction: .West, rows: rows, columns: columns))
    }

    // MARK: - Direction to another point

    func testDirectionToExamplesBottomLeftOrigin() {
        let origin = Point2D(x: 0, y: 0)

        // Careful: implementation uses self - point
        XCTAssertEqual(origin.directionTo(Point2D(x: 0, y: 1)), .North)
        XCTAssertEqual(origin.directionTo(Point2D(x: 0, y: -1)), .South)
        XCTAssertEqual(origin.directionTo(Point2D(x: 1, y: 0)), .East)
        XCTAssertEqual(origin.directionTo(Point2D(x: -1, y: 0)), .West)
    }

    func testDirectionToExamplesTopLeftOrigin() {
        let origin = Point2D(x: 0, y: 0)

        XCTAssertEqual(origin.directionTo(Point2D(x: 0, y: 1), topLeftOrigin: true), .South)
        XCTAssertEqual(origin.directionTo(Point2D(x: 0, y: -1), topLeftOrigin: true), .North)
        XCTAssertEqual(origin.directionTo(Point2D(x: 1, y: 0), topLeftOrigin: true), .East)
        XCTAssertEqual(origin.directionTo(Point2D(x: -1, y: 0), topLeftOrigin: true), .West)
    }

    func testDirectionToIsAntisymmetricForUnitSteps() {
        let deltas = [
            Point2D(x: 0, y: 1),
            Point2D(x: 0, y: -1),
            Point2D(x: 1, y: 0),
            Point2D(x: -1, y: 0),
        ]

        for a in [-1, 0, 1] {
            for b in [-1, 0, 1] {
                let p = Point2D(x: a, y: b)
                for d in deltas {
                    let q = Point2D(x: p.x + d.x, y: p.y + d.y)

                    let dirPQ = p.directionTo(q)
                    let dirQP = q.directionTo(p)

                    // For unit steps, going from p->q and q->p
                    // should yield opposite directions.
                    switch dirPQ {
                    case .North: XCTAssertEqual(dirQP, .South)
                    case .South: XCTAssertEqual(dirQP, .North)
                    case .East:  XCTAssertEqual(dirQP, .West)
                    case .West:  XCTAssertEqual(dirQP, .East)
                    case .NorthEast, .NorthWest, .SouthEast, .SouthWest:
                        // implementation never returns diagonals currently
                        XCTFail("Unexpected diagonal direction from directionTo")
                    }
                }
            }
        }
    }

    // MARK: - Walking paths

    func testWalkingPathsStayWithinBoundsAndHaveCorrectLength() {
        let start = Point2D(x: 4, y: 4)
        let rows = 10
        let columns = 10
        let steps = 3

        let paths = start.walkingPaths(rows: rows, columns: columns, stepCount: steps)

        XCTAssertFalse(paths.isEmpty, "Expected at least one walking path")

        for path in paths {
            // Path length
            XCTAssertEqual(path.count, steps, "Each path should have \(steps) points")

            // First point is always the starting point
            XCTAssertEqual(path.first, start)

            // All points within grid
            for p in path {
                XCTAssertTrue((0..<columns).contains(p.x), "x out of bounds in path: \(p)")
                XCTAssertTrue((0..<rows).contains(p.y), "y out of bounds in path: \(p)")
            }

            // Each step should move by 1 in x and/or 1 in y (cardinal or diagonal)
            for (a, b) in zip(path, path.dropFirst()) {
                let dx = abs(a.x - b.x)
                let dy = abs(a.y - b.y)
                XCTAssertTrue(
                    (dx == 1 && dy == 0) ||  // horizontal
                    (dx == 0 && dy == 1) ||  // vertical
                    (dx == 1 && dy == 1),    // diagonal
                    "Invalid step from \(a) to \(b)"
                )
            }
        }
    }

    // MARK: - moved(to:steps:)

    func testMovedCardinalDirections() {
        let start = Point2D(x: 10, y: 10)

        XCTAssertEqual(start.moved(to: .North), Point2D(x: 10, y: 9))
        XCTAssertEqual(start.moved(to: .South), Point2D(x: 10, y: 11))
        XCTAssertEqual(start.moved(to: .East), Point2D(x: 11, y: 10))
        XCTAssertEqual(start.moved(to: .West), Point2D(x: 9, y: 10))
    }

    func testMovedDiagonalDirections() {
        let start = Point2D(x: 10, y: 10)

        XCTAssertEqual(start.moved(to: .NorthWest), Point2D(x: 9, y: 9))
        XCTAssertEqual(start.moved(to: .NorthEast), Point2D(x: 11, y: 9))
        XCTAssertEqual(start.moved(to: .SouthWest), Point2D(x: 9, y: 11))
        XCTAssertEqual(start.moved(to: .SouthEast), Point2D(x: 11, y: 11))
    }

    func testMovedWithMultipleSteps() {
        let start = Point2D(x: 0, y: 0)

        XCTAssertEqual(start.moved(to: .East, steps: 5), Point2D(x: 5, y: 0))
        XCTAssertEqual(start.moved(to: .South, steps: 3), Point2D(x: 0, y: 3))
        XCTAssertEqual(start.moved(to: .SouthEast, steps: 2), Point2D(x: 2, y: 2))
    }

    /// Property-ish check for moved(to:steps:) consistency:
    /// Applying 1-step move repeatedly should match a multi-step move.
    func testMovedRepeatedStepsMatchesMultiStepMove() {
        let start = Point2D(x: 1, y: 1)
        let directions: [CompassDirection] = [.North, .South, .East, .West,
                                              .NorthEast, .NorthWest, .SouthEast, .SouthWest]

        for dir in directions {
            for steps in 1...4 {
                var p = start
                for _ in 0..<steps {
                    p = p.moved(to: dir, steps: 1)
                }
                XCTAssertEqual(p, start.moved(to: dir, steps: steps),
                               "Repeated 1-step moves should equal multi-step move for \(dir), steps \(steps)")
            }
        }
    }
}
