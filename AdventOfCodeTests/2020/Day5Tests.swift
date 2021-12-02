//
//  Day5Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/5/20.
//

import XCTest
@testable import AdventOfCode

class Day5Tests: XCTestCase {

    func testSeatId() throws {
        XCTAssertEqual(Day5.BoardingPass("BFFFBBFRRR").seatId, 567)
        XCTAssertEqual(Day5.BoardingPass("FFFBBBFRRR").seatId, 119)
        XCTAssertEqual(Day5.BoardingPass("BBFFBBFRLL").seatId, 820)
    }

    let input = FileReader(file: "day5").lines

    func testDay5Part1() throws {
        let result = Day5().part1(input)
        XCTAssertEqual(result, 980)
        print("Day 5 Part 1: \(result)")
    }

    func testDay5Part2() throws {
        let result = Day5().part2(input)
        XCTAssertEqual(result, 607)
        print("Day 5 Part 2: \(result)")
    }
}
