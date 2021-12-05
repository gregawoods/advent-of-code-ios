//
//  Y21Day5Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/4/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day5Tests: XCTestCase {

    let sample = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day5_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21_Day5().part1(sample), 5)
    }
    
    func testPart1() throws {
        XCTAssertEqual(Y21_Day5().part1(input), 4745)
    }
    
    func testPart2Sample() {
        XCTAssertEqual(Y21_Day5().part2(sample), 12)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21_Day5().part2(input), 18442)
    }
}
