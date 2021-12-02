//
//  Y21Day2Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/1/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day2Tests: XCTestCase {

    let input = FileReader(file: "day2_21").arrayOfInts

    func testPart1() throws {
        XCTAssertEqual(Y21_Day2().part1(input), 1)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21_Day2().part2(input), 1)
    }
}
