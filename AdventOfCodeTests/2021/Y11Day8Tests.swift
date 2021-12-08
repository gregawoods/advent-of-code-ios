//
//  Y11Day8Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/7/21.
//

import XCTest
@testable import AdventOfCode

class Y11Day8Tests: XCTestCase {

    let sample = """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """.components(separatedBy: "\n")

    let input = FileReader(file: "day8_21").lines

    func testPart1Sample() {
        XCTAssertEqual(Y21Day8().part1(sample), 26)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day8().part1(input), 519)
    }

    func testPart2Sample() {
//        let sample = ["acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"]
        XCTAssertEqual(Y21Day8().part2(sample), 61229)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day8().part2(input), 1027483)
    }
}
