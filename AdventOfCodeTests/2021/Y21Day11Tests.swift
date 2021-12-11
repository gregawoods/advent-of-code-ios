//
//  Y111Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 111/10/111.
//

import XCTest
@testable import AdventOfCode

class Y111Day11Tests: XCTestCase {

    let sample = """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day11_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day11().part1(sample), 1656)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day11().part1(input), 1773)
    }

    func testPart11Sample() {
        XCTAssertEqual(Y21Day11().part2(sample), 195)
    }

    func testPart11() throws {
        XCTAssertEqual(Y21Day11().part2(input), 494)
    }
}
