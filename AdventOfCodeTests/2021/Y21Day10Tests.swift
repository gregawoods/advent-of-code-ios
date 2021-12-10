//
//  Y21Day10Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/9/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day10Tests: XCTestCase {

    let sample = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day10_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day10().part1(sample), 26397)
    }

    // not 320379
    func testPart1() {
        XCTAssertEqual(Y21Day10().part1(input), 318099)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day10().part2(sample), 288957)
    }

    func testPart2() {
        XCTAssertEqual(Y21Day10().part2(input), 2389738699)
    }
}
