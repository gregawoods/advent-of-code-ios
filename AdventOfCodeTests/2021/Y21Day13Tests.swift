//
//  Y21Day13Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/12/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day13Tests: XCTestCase {

    let sample = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day13_21").fileContents!.components(separatedBy: "\n")

    func testPart1Sample() {
        XCTAssertEqual(Y21Day13().part1(sample), 17)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day13().part1(input), 678)
    }

    func testPart2Sample() {
        XCTAssertEqual(
            Y21Day13().part2(sample),
            """
            #####
            #...#
            #...#
            #...#
            #####
            """
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            Y21Day13().part2(input),
            """
            ####..##..####.#..#.#....#..#.####.####
            #....#..#.#....#..#.#....#..#....#.#...
            ###..#....###..####.#....####...#..###.
            #....#....#....#..#.#....#..#..#...#...
            #....#..#.#....#..#.#....#..#.#....#...
            ####..##..#....#..#.####.#..#.####.#...
            """
        )
    }
}
