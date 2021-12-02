//
//  Day4Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode

class Day4Tests: XCTestCase {

    let input = FileReader(file: "day4").chunksByNewline

    func testDay4Part1() throws {
        let result = Day4().part1(input)
        XCTAssertEqual(result, 206)
        print("Day 4 Part 1: \(result)")
    }

    func testDay4Part2() throws {
        let result = Day4().part2(input)
        XCTAssertEqual(result, 123)
        print("Day 4 Part 2: \(result)")
    }

}
