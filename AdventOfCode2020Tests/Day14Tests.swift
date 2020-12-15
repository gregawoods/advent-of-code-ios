//
//  Day14Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/14/20.
//

import XCTest
@testable import AdventOfCode2020

class Day14Tests: XCTestCase {

    let day = Day14()
    let input = FileReader(file: "day14").lines

    func testPart1Sample() {
        let sample = [
            "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
            "mem[8] = 11",
            "mem[7] = 101",
            "mem[8] = 0"
        ]
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 165)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 14 Part 1: \(result)")
        XCTAssertEqual(result, 10885823581193)
    }

    func testPart2Sample() {
        let sample = [
            "mask = 000000000000000000000000000000X1001X",
            "mem[42] = 100",
            "mask = 00000000000000000000000000000000X0XX",
            "mem[26] = 1"
        ]
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 208)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 14 Part 2: \(result)")
        XCTAssertEqual(result, 3816594901962)
    }
}
