//
//  Day1Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day1Tests: XCTestCase {

    let input = FileReader(file: "day1").arrayOfInts

    func testDay1Part1() throws {
        let result = Day1().calculatePart1(input)
        XCTAssertEqual(result, 646779)
        print("Day 1 Part 1: \(result)")
    }

    func testDay1Part2() throws {
        let result = Day1().calculatePart2(input)
        XCTAssertEqual(result, 246191688)
        print("Day 1 Part 2: \(result)")
    }
}
