//
//  Y21Day6Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/5/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day6Tests: XCTestCase {

    let sample = [3, 4, 3, 1, 2]
    let input = FileReader(file: "day6_21").commaSeparatedInts

    func testPart1Sample() {
        XCTAssertEqual(Y21Day6().part1(sample), 5934)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day6().part1(input), 350917)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day6().part2(sample), 26984457539)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day6().part2(input), 1592918715629)
    }
}
