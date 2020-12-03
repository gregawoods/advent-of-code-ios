//
//  Day2Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/2/20.
//

import XCTest
@testable import AdventOfCode2020

class Day2Tests: XCTestCase {
    
    var day: Day2!

    override func setUpWithError() throws {
        day = Day2()
    }

    func testCalculate() throws {
        let result = day.calculate()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 1: \(result)")
    }

    func testCalculatePart2() throws {
        let result = day.calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 2: \(result)")
    }
}
