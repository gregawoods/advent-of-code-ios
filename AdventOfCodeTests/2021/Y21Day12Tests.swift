//
//  Y21Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/11/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day12Tests: XCTestCase {

    let sample = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day12_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day12().part1(sample), 10)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day12().part1(input), 3576)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day12().part2(sample), 36)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day12().part2(input), 84271)
    }
}
