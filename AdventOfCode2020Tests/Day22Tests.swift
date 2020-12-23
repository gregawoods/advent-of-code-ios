//
//  Day22Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/22/20.
//

import XCTest

@testable import AdventOfCode2020

class Day22Tests: XCTestCase {

    let day = Day22()

    let sample = """
    Player 1:
    9
    2
    6
    3
    1
    Player 2:
    5
    8
    4
    7
    10
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day22").lines

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 306)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 22 Part 1: \(result)")
        XCTAssertEqual(result, 32598)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 291)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 22 Part 2: \(result)")
        XCTAssertEqual(result, 35836)
    }
}
