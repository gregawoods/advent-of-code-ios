//
//  Day2Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day2Tests: XCTestCase {

    let input = FileReader(file: "day2").lines

    func testDay2Part1() throws {
        let result = Day2().calculatePart1(input)
        print("Day 2 Part 1: \(result)")
        XCTAssertEqual(result, 524)
    }

    func testDay2Part2() throws {
        let result = Day2().calculatePart2(input)
        print("Day 2 Part 2: \(result)")
        XCTAssertEqual(result, 485)
    }
}
