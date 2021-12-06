//
//  Y21Day2Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/1/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day2Tests: XCTestCase {

    let sample = [
        "forward 5",
        "down 5",
        "forward 8",
        "up 3",
        "down 8",
        "forward 2"
    ]

    let input = FileReader(file: "day2_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day2().part1(sample), 150)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day2().part1(input), 2322630)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day2().part2(sample), 900)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day2().part2(input), 2105273490)
    }
}
