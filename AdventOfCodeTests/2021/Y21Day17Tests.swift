//
//  Y21Day17Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/20/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day17Tests: XCTestCase {

//    let sample = "target area: x=20..30, y=-10..-5"
//    target area: x=128..160, y=-142..-88
//    let input = FileReader(file: "day17_21").lines.first!

    // dont feel like parsing these damn strings right now
    let sample = (20, 30, -10, -5)
    let input = (128, 160, -142, -88)

    func testPart1Sample() {
        XCTAssertEqual(Y21Day17().part1(sample), 45)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day17().part1(input), 10011)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day17().part2(sample), 112)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day17().part2(input), 2994)
    }
}
