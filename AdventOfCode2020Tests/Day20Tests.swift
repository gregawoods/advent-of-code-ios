//
//  Day20Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/21/20.
//

import XCTest

@testable import AdventOfCode2020

class Day20Tests: XCTestCase {

    let day = Day20()
    let sample = """
    Tile 2311:
    ..##.#..#.
    ##..#.....
    #...##..#.
    ####.#...#
    ##.##.###.
    ##...#.###
    .#.#.#..##
    ..#....#..
    ###...#.#.
    ..###..###

    Tile 1951:
    #.##...##.
    #.####...#
    .....#..##
    #...######
    .##.#....#
    .###.#####
    ###.##.##.
    .###....#.
    ..#.#..#.#
    #...##.#..

    Tile 1171:
    ####...##.
    #..##.#..#
    ##.#..#.#.
    .###.####.
    ..###.####
    .##....##.
    .#...####.
    #.##.####.
    ####..#...
    .....##...

    Tile 1427:
    ###.##.#..
    .#..#.##..
    .#.##.#..#
    #.#.#.##.#
    ....#...##
    ...##..##.
    ...#.#####
    .#.####.#.
    ..#..###.#
    ..##.#..#.

    Tile 1489:
    ##.#.#....
    ..##...#..
    .##..##...
    ..#...#...
    #####...#.
    #..#.#.#.#
    ...#.#.#..
    ##.#...##.
    ..##.##.##
    ###.##.#..

    Tile 2473:
    #....####.
    #..#.##...
    #.##..#...
    ######.#.#
    .#...#.#.#
    .#########
    .###.#..#.
    ########.#
    ##...##.#.
    ..###.#.#.

    Tile 2971:
    ..#.#....#
    #...###...
    #.#.###...
    ##.##..#..
    .#####..##
    .#..####.#
    #..#.#..#.
    ..####.###
    ..#.#.###.
    ...#.#.#.#

    Tile 2729:
    ...#.#.#.#
    ####.#....
    ..#.#.....
    ....#..#.#
    .##..##.#.
    .#.####...
    ####.#.#..
    ##.####...
    ##..#.##..
    #.##...##.

    Tile 3079:
    #.#.#####.
    .#..######
    ..#.......
    ######....
    ####.#..#.
    .#...#.##.
    #.#####.##
    ..#.###...
    ..#.......
    ..#.###...
    """.components(separatedBy: "\n\n")

    let input = FileReader(file: "day20").chunksByNewline

    func testTileParse() {
        let sample = """
        Tile 2311:
        ..##.#..#.
        ##..#.....
        #...##..#.
        ####.#...#
        ##.##.###.
        ##...#.###
        .#.#.#..##
        ..#....#..
        ###...#.#.
        ..###..###
        """

        let tile = Day20.Tile(input: sample)
        XCTAssertEqual(tile.id, 2311)
        XCTAssertEqual(tile.topEdge, [
            false, false, true, true, false, true, false, false, true, false
        ])
        XCTAssertEqual(tile.rightEdge, [
            false, false, false, true, false, true, true, false, false, true
        ])
        XCTAssertEqual(tile.bottomEdge, [
            false, false, true, true, true, false, false, true, true, true
        ])
        XCTAssertEqual(tile.leftEdge, [
            false, true, true, true, true, true, false, false, true, false
        ])
    }

    func testRotate() {
        let sample = """
        Tile 2311:
        ..##.#..#.
        ##..#.....
        #...##..#.
        ####.#...#
        ##.##.###.
        ##...#.###
        .#.#.#..##
        ..#....#..
        ###...#.#.
        ..###..###
        """

        var tile = Day20.Tile(input: sample)

        tile.rotateRight()

        XCTAssertEqual(tile.topEdge, [
           false, true, false, false, true, true, true, true, true, false
        ])
        XCTAssertEqual(tile.rightEdge, [
           false, false, true, true, false, true, false, false, true, false
        ])
        XCTAssertEqual(tile.leftEdge, [
           false, false, true, true, true, false, false, true, true, true
        ])
        XCTAssertEqual(tile.bottomEdge, [
           true, false, false, true, true, false, true, false, false, false
        ])

        tile.rotateLeft()
        tile.rotateLeft()

        XCTAssertEqual(tile.topEdge, [
            false, false, false, true, false, true, true, false, false, true
        ])
        XCTAssertEqual(tile.rightEdge, [
           true, true, true, false, false, true, true, true, false, false
        ])
        XCTAssertEqual(tile.leftEdge, [
           false, true, false, false, true, false, true, true, false, false
        ])
        XCTAssertEqual(tile.bottomEdge, [
           false, true, true, true, true, true, false, false, true, false
        ])
    }

    func testFlips() {
        let sample = """
        Tile 2311:
        ..##.#..#.
        ##..#.....
        #...##..#.
        ####.#...#
        ##.##.###.
        ##...#.###
        .#.#.#..##
        ..#....#..
        ###...#.#.
        ..###..###
        """

        var tile = Day20.Tile(input: sample)

        tile.flipX()

        XCTAssertEqual(tile.topEdge, [
           false, true, false, false, true, false, true, true, false, false
        ])
        XCTAssertEqual(tile.rightEdge, [
            false, true, true, true, true, true, false, false, true, false
        ])
        XCTAssertEqual(tile.leftEdge, [
            false, false, false, true, false, true, true, false, false, true
        ])
        XCTAssertEqual(tile.bottomEdge, [
           true, true, true, false, false, true, true, true, false, false
        ])

        tile.flipY()

        XCTAssertEqual(tile.topEdge, [
            true, true, true, false, false, true, true, true, false, false
        ])
        XCTAssertEqual(tile.rightEdge, [
            false, true, false, false, true, true, true, true, true, false
        ])
        XCTAssertEqual(tile.leftEdge, [
            true, false, false, true, true, false, true, false, false, false
        ])
        XCTAssertEqual(tile.bottomEdge, [
            false, true, false, false, true, false, true, true, false, false
        ])
    }

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 20899048083289)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 20 Part 1: \(result)")
        XCTAssertEqual(result, 140656720229539)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 273)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 20 Part 2: \(result)")
        XCTAssertEqual(result, 1885)
    }
}
