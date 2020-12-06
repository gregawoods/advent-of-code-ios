//
//  Day4Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day4Tests: XCTestCase {

    func testDay4Part1() throws {
        let result = Day4().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 4 Part 1: \(result)")
    }

    func testDay4Part2() throws {
        let result = Day4().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 4 Part 2: \(result)")
    }

}
