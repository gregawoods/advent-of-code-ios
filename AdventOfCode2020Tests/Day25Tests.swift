//
//  Day25Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/27/20.
//

import XCTest

@testable import AdventOfCode2020

class Day25Tests: XCTestCase {

    let day = Day25()

    let sample = [
        5764801,
        17807724
    ]

    let input = [
        8458505,
        16050997
    ]

    func testFindLoopsSize() {
        XCTAssertEqual(day.findLoopsSize(forKey: 5764801), 8)
        XCTAssertEqual(day.findLoopsSize(forKey: 17807724), 11)
    }

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 14897079)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 25 Part 1: \(result)")
        XCTAssertEqual(result, 448851)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 0)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 25 Part 2: \(result)")
        XCTAssertEqual(result, 0)
    }
}
