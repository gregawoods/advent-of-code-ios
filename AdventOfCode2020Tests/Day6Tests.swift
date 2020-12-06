//
//  Day6Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/6/20.
//

import XCTest
@testable import AdventOfCode2020

class Day6Tests: XCTestCase {

    func testGroupAnswerCount() throws {
        XCTAssertEqual(Day6.GroupAnswers(input: "abc").count, 3)

        let input = """
        a
        b
        c
        """
        XCTAssertEqual(Day6.GroupAnswers(input: input).count, 3)

        let input2 = """
        ab
        ac
        """
        XCTAssertEqual(Day6.GroupAnswers(input: input2).count, 3)

        let input3 = """
        a
        a
        a
        a
        """
        XCTAssertEqual(Day6.GroupAnswers(input: input3).count, 1)
    }

    func testGroupAnswerCountAll() {
        let input = """
        ab
        ac
        """
        XCTAssertEqual(Day6.GroupAnswers(input: input).countAll, 1)
    }

    func testDay6Part1() throws {
        let result = Day6().calculatePart1()
        XCTAssertEqual(result, 6782)
        print("Day 6 Part 1: \(result)")
    }

    func testDay6Part2() throws {
        let result = Day6().calculatePart2()
        XCTAssertEqual(result, 3596)
        print("Day 6 Part 2: \(result)")
    }
}
