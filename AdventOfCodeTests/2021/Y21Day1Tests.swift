//
//  Y21Day1.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/1/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day1Tests: XCTestCase {

    let input = FileReader(file: "day1_21").arrayOfInts

    func testDay1Part1() throws {
        XCTAssertEqual(Y21Day1().part1(input), 1624)
    }

    func testDay1Part2() throws {
        XCTAssertEqual(Y21Day1().part2(input), 1653)
    }
}
