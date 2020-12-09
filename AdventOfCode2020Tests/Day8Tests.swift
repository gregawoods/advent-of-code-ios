//
//  Day8Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/8/20.
//

import XCTest
@testable import AdventOfCode2020

class Day8Tests: XCTestCase {

    let sample = """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """.components(separatedBy: "\n")

    func testInputParsing() throws {
        let game = Day8.Game(input: sample)
        XCTAssertEqual(game.instructions, [
            Day8.Instruction(action: .nop, value: 0),
            Day8.Instruction(action: .acc, value: 1),
            Day8.Instruction(action: .jmp, value: 4),
            Day8.Instruction(action: .acc, value: 3),
            Day8.Instruction(action: .jmp, value: -3),
            Day8.Instruction(action: .acc, value: -99),
            Day8.Instruction(action: .acc, value: 1),
            Day8.Instruction(action: .jmp, value: -4),
            Day8.Instruction(action: .acc, value: 6)
        ])
    }

    func testPlay() {
        var game = Day8.Game(input: sample)
        game.play()
        XCTAssertEqual(game.accumulator, 5)
    }

    func testDay8Part1() throws {
        let result = Day8().calculatePart1()
        print("Day 8 Part 1: \(result)")
        XCTAssertEqual(result, 1501)

    }

    func testCalculateFixedGame() {
        let result = Day8().calculateFixedGame(lines: sample)
        XCTAssertEqual(result, 8)
    }

    func testDay8Part2() throws {
        let result = Day8().calculatePart2()
        XCTAssertEqual(result, 509)
        print("Day 8 Part 2: \(result)")
    }
}
