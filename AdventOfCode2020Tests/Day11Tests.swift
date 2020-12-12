//
//  Day11Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/11/20.
//

import XCTest
@testable import AdventOfCode2020

class Day11Tests: XCTestCase {

    let day = Day11()

    func testParseSeats() {
        let seats = day.parseSeats(lines: [
            "L.#",
            ".#L"
        ])
        XCTAssertEqual(seats, [
            [.vacant, .floor, .occ],
            [.floor, .occ, .vacant]
        ])
    }

    func testAdjacentSpotsTaken() {
        let chart: [[Day11.Pos]] = [
            [.occ, .floor, .occ],
            [.occ, .vacant, .floor],
            [.occ, .occ, .vacant]
        ]
        XCTAssertEqual(
            day.adjacentSpotsTaken(rowIndex: 0, colIndex: 0, chart: chart), 1
        )
        XCTAssertEqual(
            day.adjacentSpotsTaken(rowIndex: 0, colIndex: 2, chart: chart), 0
        )
        XCTAssertEqual(
            day.adjacentSpotsTaken(rowIndex: 1, colIndex: 1, chart: chart), 5
        )
        XCTAssertEqual(
            day.adjacentSpotsTaken(rowIndex: 2, colIndex: 2, chart: chart), 1
        )
    }

    func testApplyRules() {
        let sample = """
        #.##.L#.##
        #L###LL.L#
        L.#.#..#..
        #L##.##.L#
        #.##.LL.LL
        #.###L#.##
        ..#.#.....
        #L######L#
        #.LL###L.L
        #.#L###.##
        """

        let expected = """
        #.#L.L#.##
        #LLL#LL.L#
        L.L.L..#..
        #LLL.##.L#
        #.LL.LL.LL
        #.LL#L#.##
        ..L.L.....
        #L#LLLL#L#
        #.LLLLLL.L
        #.#L#L#.##
        """

        let chart = day.parseSeats(lines: sample.components(separatedBy: "\n"))
        let newChart = day.applyRules(chart: chart)
        let result = newChart.map({ $0.map({ $0.rawValue }).joined() }).joined(separator: "\n")
        XCTAssertEqual(expected, result)
    }

    let input = FileReader(file: "day11").lines

    func testDay11Part1() throws {
        let result = day.calculatePart1(input)
        print("Day 11 Part 1: \(result)")
        XCTAssertEqual(result, 2321)
    }

    func testAdjacentSpotsTaken2() {
        let sample = """
        #....
        ...#.
        .#L.#
        .....
        ..#..
        """
        let chart = day.parseSeats(lines: sample.components(separatedBy: "\n"))
        let adjacent = day.adjacentSpotsTaken2(rowIndex: 2, colIndex: 2, chart: chart)
        XCTAssertEqual(adjacent, 5)
    }

    func testApplyRules2() {
        let sample = """
        #.L#.##.L#
        #L#####.LL
        L.#.#..#..
        ##L#.##.##
        #.##.#L.##
        #.#####.#L
        ..#.#.....
        LLL####LL#
        #.L#####.L
        #.L####.L#
        """

        // #.L#.##.L#
        let expected = """
        #.L#.L#.L#
        #LLLLLL.LL
        L.L.L..#..
        ##LL.LL.L#
        L.LL.LL.L#
        #.LLLLL.LL
        ..L.L.....
        LLLLLLLLL#
        #.LLLLL#.L
        #.L#LL#.L#
        """

        let chart = day.parseSeats(lines: sample.components(separatedBy: "\n"))
        let newChart = day.applyRules2(chart: chart)
        let result = newChart.map({ $0.map({ $0.rawValue }).joined() }).joined(separator: "\n")
        XCTAssertEqual(expected, result)
    }

    func testDay11Part2() throws {
        let result = day.calculatePart2(input)
        print("Day 11 Part 2: \(result)")
        XCTAssertEqual(result, 2102)
    }
}
