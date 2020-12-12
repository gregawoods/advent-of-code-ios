//
//  Day3Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day3Tests: XCTestCase {

    let input = FileReader(file: "day3").lines

    func testDay3Part1() throws {
        let result = Day3().calculatePart1(input)
        XCTAssertEqual(result, 232)
        print("Day 3 Part 1: \(result)")
    }

    func testDay3Part2() throws {
        let result = Day3().calculatePart2(input)
        XCTAssertEqual(result, 3952291680)
        print("Day 3 Part 2: \(result)")
    }

}
