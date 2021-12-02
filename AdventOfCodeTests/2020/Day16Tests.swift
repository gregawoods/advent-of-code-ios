//
//  Day16Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/16/20.
//

import XCTest

@testable import AdventOfCode

class Day16Tests: XCTestCase {

    let day = Day16()

    let input = FileReader(file: "day16").chunksByNewline

    func testRule() {
        let rule = Day16.Rule("class: 1-3 or 5-7")
        XCTAssertEqual(rule.label, "class")
        XCTAssertEqual(rule.ranges, [
            1...3,
            5...7
        ])
        XCTAssertTrue(rule.valid(value: 2))
        XCTAssertTrue(rule.valid(value: 6))
        XCTAssertTrue(rule.valid(value: 7))
        XCTAssertFalse(rule.valid(value: 10))
    }

    func testPart1Sample() {
        let sampleText = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        let sample = FileReader(raw: sampleText).chunksByNewline
        let result = day.part1(sample)
        XCTAssertEqual(result, 71)
    }

    func testPart1() throws {
        let result = day.part1(input)
        print("Day 16 Part 1: \(result)")
        XCTAssertEqual(result, 20975)
    }

    func testPart2Sample() {
        let result = day.determinePositions(rules: [
            Day16.Rule("class: 0-1 or 4-19"),
            Day16.Rule("row: 0-5 or 8-19"),
            Day16.Rule("seat: 0-13 or 16-19")
        ], tickets: [
            [3, 9, 18],
            [15, 1, 5],
            [5, 14, 9]
        ])
        XCTAssertEqual(result, ["row", "class", "seat"])
    }

    func testPart2() throws {
        let result = day.part2(input)
        print("Day 16 Part 2: \(result)")
        XCTAssertEqual(result, 910339449193)
    }
}
