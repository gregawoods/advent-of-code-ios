//
//  Y21Day3Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/2/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day3Tests: XCTestCase {

    let sample = [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
    ]

    let input = FileReader(file: "day3_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21_Day3().part1(sample), 198)
    }
    
    func testPart1() throws {
        XCTAssertEqual(Y21_Day3().part1(input), 2583164)
    }
    
    func testPart2Sample() {
        XCTAssertEqual(Y21_Day3().part2(sample), 230)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21_Day3().part2(input), 2784375)
    }

}
