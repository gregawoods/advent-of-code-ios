//
//  Day18Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/18/20.
//

import XCTest

@testable import AdventOfCode2020

class Day18Tests: XCTestCase {

    let day = Day18()
    let sample = ["1"]
    let input = FileReader(file: "day18").lines

    func testPart1Sample() {
        var result = day.parseEquation("1 + 2 + 3")
        XCTAssertEqual(result.sum, 6)

        result = day.parseEquation("1 + 2 + (2 * 4)")
        XCTAssertEqual(result.sum, 11)

        result = day.parseEquation("1 + 2 + (2 * (1 + 3))")
        XCTAssertEqual(result.sum, 11)

        result = day.parseEquation("1 + (2 * 3) + (4 * (5 + 6))")
        XCTAssertEqual(result.sum, 51)

        result = day.parseEquation("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")
        XCTAssertEqual(result.sum, 13632)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 18 Part 1: \(result)")
        XCTAssertEqual(result, 3159145843816)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 0)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 18 Part 2: \(result)")
        XCTAssertEqual(result, 0)
    }
}
