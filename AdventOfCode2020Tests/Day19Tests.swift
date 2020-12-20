//
//  Day19Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/18/20.
//

import XCTest

@testable import AdventOfCode2020

class Day19Tests: XCTestCase {

    let day = Day19()
    let sample = ["1"]
    let input = FileReader(file: "day19").lines

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 0)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 19 Part 1: \(result)")
        XCTAssertEqual(result, 0)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 0)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 19 Part 2: \(result)")
        XCTAssertEqual(result, 0)
    }
}
