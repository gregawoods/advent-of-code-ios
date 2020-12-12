//
//  Day10Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/10/20.
//

import XCTest
@testable import AdventOfCode2020

class Day10Tests: XCTestCase {

    let day = Day10()
    let input = FileReader(file: "day10").arrayOfInts

    let sample = [
        28,
        33,
        18,
        42,
        31,
        14,
        46,
        20,
        48,
        47,
        24,
        23,
        49,
        45,
        19,
        38,
        39,
        11,
        1,
        32,
        25,
        35,
        8,
        17,
        7,
        9,
        4,
        2,
        34,
        10,
        3
    ]

    func testSample() {
        var numbers = sample.sorted()
        numbers.append(numbers.last! + 3)
        numbers.insert(0, at: 0)
        let diffs = day.countDiffs(numbers: numbers)
        XCTAssertEqual(diffs, [22, 0, 10])
    }

    func testDay10Part1() throws {
        let result = day.calculatePart1(input)
        print("Day 10 Part 1: \(result)")
        XCTAssertEqual(result, 1980)
    }

    func testDay10Part2() throws {
        let result = day.calculatePart2(input)
        print("Day 10 Part 2: \(result)")
        XCTAssertEqual(result, 4628074479616)
    }
}
