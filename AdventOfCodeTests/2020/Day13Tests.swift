//
//  Day13Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 13/13/20.
//

import XCTest

@testable import AdventOfCode

class Day13Tests: XCTestCase {

    let day = Day13()
    let input = FileReader(file: "day13").lines
    let sample = [
        "939",
        "7,13,x,x,59,x,31,19"
    ]

    func testPart1Sample() {
        let result = day.part1(sample)
        XCTAssertEqual(result, 295)
    }

    func testPart1() throws {
        let result = day.part1(input)
        print("Day 13 Part 1: \(result)")
        XCTAssertEqual(result, 2092)
    }

    func testPart2Sample() {
        let result = day.part2(sample)
        XCTAssertEqual(result, 1068781)
    }

    func testPart2() throws {
        let result = day.part2(input)
        print("Day 13 Part 2: \(result)")
        XCTAssertEqual(result, 702970661767766)
    }
}
