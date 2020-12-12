//
//  Day9Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/9/20.
//

import XCTest
@testable import AdventOfCode2020

class Day9Tests: XCTestCase {

    let day = Day9()
    let input = FileReader(file: "day9").arrayOfInts

    let sample = [
        35,
        20,
        15,
        25,
        47,
        40,
        62,
        55,
        65,
        95,
        102,
        117,
        150,
        182,
        127,
        219,
        299,
        277,
        309,
        576
    ]

    func testCalculateFirstInvalid() {
        let result = day.calculateFirstInvalid(data: sample, length: 5)
        XCTAssertEqual(result, 127)
    }

    func testDay9Part1() throws {
        let result = day.calculatePart1(input)
        print("Day 9 Part 1: \(result)")
        XCTAssertEqual(result, 177777905)
    }

    func testDay9Part2() throws {
        let result = day.calculatePart2(input)
        print("Day 9 Part 2: \(result)")
        XCTAssertEqual(result, 23463012)
    }
}
