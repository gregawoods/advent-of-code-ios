//
//  Day1Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/2/20.
//

import XCTest
@testable import AdventOfCode2020

class Day1Tests: XCTestCase {

    var day: Day1!

    override func setUpWithError() throws {
        self.day = Day1()
    }

    func testCalculate() throws {
        let result = day.calculate()

        XCTAssertTrue(result > 0)
        print("Day 1 Part 1: \(result)")
    }

    func testCalculateV2() throws {
        let result = day.calculatePart2()

        XCTAssertTrue(result > 0)
        print("Day 1 Part 2: \(result)")
    }
}
