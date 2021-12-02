//
//  Day23Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/23/20.
//

import XCTest

@testable import AdventOfCode

class Day23Tests: XCTestCase {

    let day = Day23()
    let sample = [3, 8, 9, 1, 2, 5, 4, 6, 7]
    let input = [9, 2, 5, 1, 7, 6, 8, 3, 4]

    func testPart1Sample() {
        let result = day.part1(sample)
        XCTAssertEqual(result, 67384529)
    }

    func testPart1() throws {
        let result = day.part1(input)
        print("Day 23 Part 1: \(result)")
        XCTAssertEqual(result, 69852437)
    }

    func testPart2Sample() {
        let result = day.part2(sample)
        XCTAssertEqual(result, 149245887792)
    }

    func testPart2() throws {
        let result = day.part2(input)
        print("Day 23 Part 2: \(result)")
        XCTAssertEqual(result, 91408386135)
    }
}
