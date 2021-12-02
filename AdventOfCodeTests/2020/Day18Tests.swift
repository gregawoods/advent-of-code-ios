//
//  Day18Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/18/20.
//

import XCTest

@testable import AdventOfCode

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
        let result = day.part1(input)
        print("Day 18 Part 1: \(result)")
        XCTAssertEqual(result, 3159145843816)
    }

    func testPart2Sample() {
        var result = day.parseEquation("2 * 3 + 4")
        XCTAssertEqual(result.sumV2, 14)

        result = day.parseEquation("1 + (2 * 2 + (1 + 2))")
        XCTAssertEqual(result.sumV2, 11)

        result = day.parseEquation("1 + (2 * 3) + (4 * (5 + 6))")
        XCTAssertEqual(result.sumV2, 51)

        result = day.parseEquation("2 * 3 + (4 * 5)")
        XCTAssertEqual(result.sumV2, 46)

        result = day.parseEquation("5 + (8 * 3 + 9 + 3 * 4 * 3)")
        XCTAssertEqual(result.sumV2, 1445)

        result = day.parseEquation("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
        XCTAssertEqual(result.sumV2, 669060)

        result = day.parseEquation("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")
        XCTAssertEqual(result.sumV2, 23340)
    }

    func testPart2() throws {
        let result = day.part2(input)
        print("Day 18 Part 2: \(result)")
        XCTAssertEqual(result, 55699621957369)
    }
}
