//
//  Day3Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/3/20.
//

import XCTest
@testable import AdventOfCode2020

class Day3Tests: XCTestCase {

    var day = Day3()

    override func setUpWithError() throws {

    }

    func testCalculate() throws {
        let result = day.calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 3 Part 1: \(result)")
    }

    func testCalculatePart2() throws {
        let result = day.calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 3 Part 2: \(result)")
    }
}
