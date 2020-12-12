//
//  Day12Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/11/20.
//

import XCTest

@testable import AdventOfCode2020

class Day12Tests: XCTestCase {

    let day = Day12()

    let sample = [
        "F10",
        "N3",
        "F7",
        "R90",
        "F11"
    ]

    let input = FileReader(file: "day12").lines

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 25)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 12 Part 1: \(result)")
        XCTAssertEqual(result, 904)
    }

    func testRotations() {
        let ship = Day12.Ship(3, 3)

        ship.rotate(degrees: 90, direction: "R", aroundX: 1, aroundY: 1)
        XCTAssertEqual(ship.x, 3)
        XCTAssertEqual(ship.y, -1)

        ship.rotate(degrees: 90, direction: "L", aroundX: 1, aroundY: -3)
        XCTAssertEqual(ship.x, -1)
        XCTAssertEqual(ship.y, -1)

        ship.rotate( degrees: 180, direction: "L", aroundX: -2, aroundY: 3)
        XCTAssertEqual(ship.x, -3)
        XCTAssertEqual(ship.y, 7)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 286)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 12 Part 2: \(result)")
        XCTAssertEqual(result, 18747)
    }
}
