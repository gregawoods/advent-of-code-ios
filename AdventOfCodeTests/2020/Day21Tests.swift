//
//  Day21Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/21/20.
//

import XCTest

@testable import AdventOfCode

class Day21Tests: XCTestCase {

    let day = Day21()
    let sample = [
        "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)",
        "trh fvjkl sbzzf mxmxvkd (contains dairy)",
        "sqjhc fvjkl (contains soy)",
        "sqjhc mxmxvkd sbzzf (contains fish)"
    ]
    let input = FileReader(file: "day21").lines

    func testPart1Sample() {
        let result = day.part1(sample)
        XCTAssertEqual(result, 5)
    }

    func testPart1() throws {
        let result = day.part1(input)
        print("Day 21 Part 1: \(result)")
        XCTAssertEqual(result, 1685)
    }

    func testPart2Sample() {
        let result = day.part2(sample)
        XCTAssertEqual(result, "mxmxvkd,sqjhc,fvjkl")
    }

    func testPart2() throws {
        let result = day.part2(input)
        print("Day 21 Part 2: \(result)")
        XCTAssertEqual(result, "ntft,nhx,kfxr,xmhsbd,rrjb,xzhxj,chbtp,cqvc")
    }
}
