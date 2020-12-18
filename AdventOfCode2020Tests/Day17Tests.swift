//
//  Day17Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/17/20.
//

import XCTest

@testable import AdventOfCode2020

class Day17Tests: XCTestCase {

    let day = Day17()

    let sample = """
    .#.
    ..#
    ###
    """.components(separatedBy: "\n")

    let input = """
    ....###.
    #...####
    ##.#.###
    ..#.#...
    ##.#.#.#
    #.######
    ..#..#.#
    ######.#
    """.components(separatedBy: "\n")

    func testGrid() {
        let grid = Day17.Grid(input: sample)
        XCTAssertEqual(grid.points, [
            Day17.Point(0, 0, 0, false),
            Day17.Point(1, 0, 0, true),
            Day17.Point(2, 0, 0, false),
            Day17.Point(0, 1, 0, false),
            Day17.Point(1, 1, 0, false),
            Day17.Point(2, 1, 0, true),
            Day17.Point(0, 2, 0, true),
            Day17.Point(1, 2, 0, true),
            Day17.Point(2, 2, 0, true)
        ])
        let activeNeighbors = grid.activeNeighbors(0, 1, 0)
        XCTAssertEqual(activeNeighbors, 3)
    }

    func testActiveAt() {
        var grid = Day17.Grid(input: sample)
        XCTAssertTrue(grid.activeAt(1, 0, 0))

        // accessing and setting arbitrary point
        XCTAssertFalse(grid.activeAt(200, 300, -999))
        grid.setActiveAt(200, 300, -999, active: true)
        XCTAssertTrue(grid.activeAt(200, 300, -999))
        grid.setActiveAt(200, 300, -999, active: false)
        XCTAssertFalse(grid.activeAt(200, 300, -999))
    }

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 112)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 17 Part 1: \(result)")
        XCTAssertEqual(result, 333)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 0)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 17 Part 2: \(result)")
        XCTAssertEqual(result, 0)
    }
}
