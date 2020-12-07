//
//  Day7Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/6/20.
//

import XCTest
@testable import AdventOfCode2020

class Day7Tests: XCTestCase {

    func testBagParsing() throws {
        let bag = Day7.BagDef(input: "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.")
        XCTAssertEqual(bag.color, "shiny gold")
        XCTAssertEqual(bag.holds, [
            "dark olive": 1,
            "vibrant plum": 2
        ])

        let emptyBag = Day7.BagDef(input: "dotted black bags contain no other bags.")
        XCTAssertEqual(emptyBag.color, "dotted black")
        XCTAssertEqual(emptyBag.holds.count, 0)
    }

    func testDay7Part1() throws {
        let result = Day7().calculatePart1()
        XCTAssertEqual(result, 326)
        print("Day 7 Part 1: \(result)")
    }

    func testDay7Part2() throws {
        let result = Day7().calculatePart2()
        XCTAssertEqual(result, 5635)
        print("Day 7 Part 2: \(result)")
    }
}
