//
//  Day2Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day2Tests: XCTestCase {

    func testDay2Part1() throws {
        let result = Day2().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 1: \(result)")
    }

    func testDay2Part2() throws {
        let result = Day2().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 2: \(result)")
    }

}
