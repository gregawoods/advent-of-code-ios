//
//  Day24Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/24/20.
//

import XCTest

@testable import AdventOfCode2020

class Day24Tests: XCTestCase {

    let day = Day24()
    let sample = """
    sesenwnenenewseeswwswswwnenewsewsw
    neeenesenwnwwswnenewnwwsewnenwseswesw
    seswneswswsenwwnwse
    nwnwneseeswswnenewneswwnewseswneseene
    swweswneswnenwsewnwneneseenw
    eesenwseswswnenwswnwnwsewwnwsene
    sewnenenenesenwsewnenwwwse
    wenwwweseeeweswwwnwwe
    wsweesenenewnwwnwsenewsenwwsesesenwne
    neeswseenwwswnwswswnw
    nenwswwsewswnenenewsenwsenwnesesenew
    enewnwewneswsewnwswenweswnenwsenwsw
    sweneswneswneneenwnewenewwneswswnese
    swwesenesewenwneswnwwneseswwne
    enesenwswwswneneswsenwnewswseenwsese
    wnwnesenesenenwwnenwsewesewsesesew
    nenewswnwewswnenesenwnesewesw
    eneswnwswnwsenenwnwnwwseeswneewsenese
    neswnwewnwnwseenwseesewsenwsweewe
    wseweeenwnesenwwwswnew
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day24").lines

    func testParseLine() {
        var moves = day.parseInstruction(input: "esenee")
        XCTAssertEqual(moves, [
            .e, .se, .ne, .e
        ])
        moves = day.parseInstruction(input: "sesenwnenenewseeswwswswwnenewsewsw")
        XCTAssertEqual(moves, [
            .se, .se, .nw, .ne, .ne, .ne, .w, .se, .e, .sw, .w, .sw, .sw, .w, .ne, .ne, .w, .se, .w, .sw
        ])
    }

    func testPart1Sample() {
        let result = day.calculatePart1(sample)
        XCTAssertEqual(result, 10)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 24 Part 1: \(result)")
        XCTAssertEqual(result, 450)
    }

    func testPart2Sample() {
        let result = day.calculatePart2(sample)
        XCTAssertEqual(result, 2208)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 24 Part 2: \(result)")
        XCTAssertEqual(result, 4059)
    }
}
