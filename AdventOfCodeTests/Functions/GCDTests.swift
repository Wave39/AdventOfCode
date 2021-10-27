//
//  GCDTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 1/6/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class GCDTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_gcd() {
        XCTAssertEqual(gcd(13, 13), 13)
        XCTAssertEqual(gcd(37, 600), 1)
        XCTAssertEqual(gcd(20, 100), 20)
        XCTAssertEqual(gcd(624129, 2061517), 18913)
    }

    func test_gcdIterativeEuklid() {
        XCTAssertEqual(gcdIterativeEuklid(13, 13), 13)
        XCTAssertEqual(gcdIterativeEuklid(37, 600), 1)
        XCTAssertEqual(gcdIterativeEuklid(20, 100), 20)
        XCTAssertEqual(gcdIterativeEuklid(624129, 2061517), 18913)
    }

    func test_gcdRecursiveEuklid() {
        XCTAssertEqual(gcdRecursiveEuklid(13, 13), 13)
        XCTAssertEqual(gcdRecursiveEuklid(37, 600), 1)
        XCTAssertEqual(gcdRecursiveEuklid(20, 100), 20)
        XCTAssertEqual(gcdRecursiveEuklid(624129, 2061517), 18913)
        XCTAssertEqual(gcdRecursiveEuklid(10, 5), 5)
    }

    func test_gcdBinaryRecursiveStein() {
        XCTAssertEqual(gcdBinaryRecursiveStein(13, 13), 13)
        XCTAssertEqual(gcdBinaryRecursiveStein(37, 600), 1)
        XCTAssertEqual(gcdBinaryRecursiveStein(20, 100), 20)
        XCTAssertEqual(gcdBinaryRecursiveStein(624129, 2061517), 18913)
    }

    func test_findEasySolution() {
        XCTAssertEqual(findEasySolution(13, 13), 13)
        XCTAssertEqual(findEasySolution(5, 0), 5)
        XCTAssertEqual(findEasySolution(0, 6), 6)
        XCTAssertEqual(findEasySolution(12, 13), nil)
    }

    func test_lcm() {
        var retval = 0
        do {
            retval = try lcm(286_332, 161_428)
            XCTAssertEqual(retval, 11_555_500_524)
            retval = try lcm(11_555_500_524, 108_344)
            XCTAssertEqual(retval, 312_992_287_193_064)
            retval = try lcm(2, 3)
            XCTAssertEqual(retval, 6)
            retval = try lcm(4, 10)
            XCTAssertEqual(retval, 20)
        } catch {
            print("Error: \(error)")
        }
    }

}
