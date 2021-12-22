//
//  Rect3DTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/22/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

import XCTest

public class Rect3DTests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test_intersection() {
        // (-15, 35) (-32, 21) (-32, 21)
        let r1 = Rect3D(x1: -15, y1: -32, z1: -32, x2: 35, y2: 21, z2: 21)
        // (-19, 34) (-11, 39) (-31, 17)
        let r2 = Rect3D(x1: -19, y1: -11, z1: -31, x2: 34, y2: 39, z2: 17)
        // (-15, 34) (-11, 21) (-31, 17)
        let r3 = r2.intersection(with: r1)
        XCTAssertEqual(r3, Rect3D(x1: -15, y1: -11, z1: -31, x2: 34, y2: 21, z2: 17))
    }
}
