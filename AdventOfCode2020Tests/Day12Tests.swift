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

    func testMoveShip() {
        let ship = day.moveShip(lines: sample)
        XCTAssertEqual(ship.x, 17)
        XCTAssertEqual(ship.y, -8)
        XCTAssertEqual(ship.manhatten, 25)
    }

    func testDay12Part1() throws {
        let result = day.calculatePart1()
        print("Day 12 Part 1: \(result)")
        XCTAssertEqual(result, 904)
    }

    func testMoveShip2() {
        let ship = day.moveShip2(lines: sample)
        XCTAssertEqual(ship.manhatten, 286)
    }

    func testRotations() {
        let ship = Day12.Ship(3, 3)

        ship.rotate(originX: 1, originY: 1, direction: "R", degrees: 90)
        XCTAssertEqual(ship.x, 3)
        XCTAssertEqual(ship.y, -1)

        ship.rotate(originX: 1, originY: -3, direction: "L", degrees: 90)
        XCTAssertEqual(ship.x, -1)
        XCTAssertEqual(ship.y, -1)

        ship.rotate(originX: -2, originY: 3, direction: "L", degrees: 180)
        XCTAssertEqual(ship.x, -3)
        XCTAssertEqual(ship.y, 7)
    }

    func testDay12Part2() throws {
        let result = day.calculatePart2()
        print("Day 12 Part 2: \(result)")
        XCTAssertEqual(result, 18747)
    }
}
