//
//  Point2DTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/23/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import XCTest

final class Point2DTests: XCTestCase {
//    override func setUpWithError() throws {
//    }

//    override func tearDownWithError() throws {
//    }

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
}
