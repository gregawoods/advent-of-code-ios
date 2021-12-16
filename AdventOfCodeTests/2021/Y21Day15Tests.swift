//
//  Y21Day15Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/14/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day15Tests: XCTestCase {

    let sample = """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day15_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day15().part1(sample), 40)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day15().part1(input), 790)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day15().part2(sample), 315)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day15().part2(input), 2998)
    }
}
