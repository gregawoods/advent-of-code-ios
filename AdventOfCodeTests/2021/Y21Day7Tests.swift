//
//  Y21Day7Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/6/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day7Tests: XCTestCase {

    let sample = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
    let input = FileReader(file: "day7_21").commaSeparatedInts

    func testPart1Sample() {
        XCTAssertEqual(Y21Day7().part1(sample), 37)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day7().part1(input), 342534)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day7().part2(sample), 168)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day7().part2(input), 94004208)
    }
}
