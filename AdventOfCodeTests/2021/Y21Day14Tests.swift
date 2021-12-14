//
//  Y21Day14Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/13/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day14Tests: XCTestCase {

    let sample = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day14_21").fileContents!.components(separatedBy: "\n")

    func testPart1Sample() {
        XCTAssertEqual(Y21Day14().part1(sample), 1588)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day14().part1(input), 3342)
    }

    func testPart2Sample() {
        XCTAssertEqual(
            Y21Day14().part2(sample), 2188189693529)
    }

    func testPart2() throws {
        XCTAssertEqual(
            Y21Day14().part2(input), 3776553567525)
    }
}
