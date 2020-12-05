//
//  DayTests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/4/20.
//

import XCTest
@testable import AdventOfCode2020

class DayTests: XCTestCase {

    func testDay1Part1() throws {
        let result = Day1().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 1 Part 1: \(result)")
    }

    func testDay1Part2() throws {
        let result = Day1().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 1 Part 2: \(result)")
    }

    func testDay2Part1() throws {
        let result = Day2().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 1: \(result)")
    }

    func testDay2Part2() throws {
        let result = Day2().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 2 Part 2: \(result)")
    }

    func testDay3Part1() throws {
        let result = Day3().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 3 Part 1: \(result)")
    }

    func testDay3Part2() throws {
        let result = Day3().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 3 Part 2: \(result)")
    }

    func testDay4Part1() throws {
        let result = Day4().calculatePart1()
        XCTAssertTrue(result > 0)
        print("Day 4 Part 1: \(result)")
    }

    func testDay4Part2() throws {
        let result = Day4().calculatePart2()
        XCTAssertTrue(result > 0)
        print("Day 4 Part 2: \(result)")
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
