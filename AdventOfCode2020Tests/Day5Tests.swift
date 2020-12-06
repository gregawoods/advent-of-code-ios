//
//  Day5Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode2020

class Day5Tests: XCTestCase {

    func testSeatId() throws {
        let pass = Day5.BoardingPass(input: "BFFFBBFRRR")
        XCTAssertEqual(pass.seatId, 567)
    }

    func testDay5Part1() throws {
        let result = Day5().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 5 Part 1: \(result)")
    }

    func testDay5Part2() throws {
        let result = Day5().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 5 Part 2: \(result)")
    }
}
