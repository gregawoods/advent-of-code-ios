//
//  Day6Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/6/20.
//

import XCTest
@testable import AdventOfCode

class Day6Tests: XCTestCase {

    func testGroupAnswerCount() throws {
        XCTAssertEqual(Day6.GroupAnswers("abc").count, 3)

        let input = """
        a
        b
        c
        """
        XCTAssertEqual(Day6.GroupAnswers(input).count, 3)

        let input2 = """
        ab
        ac
        """
        XCTAssertEqual(Day6.GroupAnswers(input2).count, 3)

        let input3 = """
        a
        a
        a
        a
        """
        XCTAssertEqual(Day6.GroupAnswers(input3).count, 1)
    }

    func testGroupAnswerCountAll() {
        let input = """
        ab
        ac
        """
        XCTAssertEqual(Day6.GroupAnswers(input).countAll, 1)
    }

    let input = FileReader(file: "day6").chunksByNewline

    func testDay6Part1() throws {
        let result = Day6().part1(input)
        XCTAssertEqual(result, 6782)
        print("Day 6 Part 1: \(result)")
    }

    func testDay6Part2() throws {
        let result = Day6().part2(input)
        XCTAssertEqual(result, 3596)
        print("Day 6 Part 2: \(result)")
    }
}
