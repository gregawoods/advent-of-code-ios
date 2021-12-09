//
//  Y21Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/8/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day9Tests: XCTestCase {

    let sample = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day9_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day9().part1(sample), 15)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day9().part1(input), 0)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day9().part2(sample), 0)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day9().part2(input), 0)
    }
}
