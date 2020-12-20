//
//  Day19Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/18/20.
//

import XCTest

@testable import AdventOfCode2020

class Day19Tests: XCTestCase {

    let day = Day19()

    let sample = """
    0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"
    """

    let sampleMessages = """
    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb
    """

    let input = FileReader(file: "day19").chunksByNewline

    func testRules() {
        var rule = Day19.Rule("0: 4 1 5")
        XCTAssertEqual(rule.id, 0)
        XCTAssertEqual(rule.subRules, [[4, 1, 5]])
        XCTAssertEqual(rule.char, nil)

        rule = Day19.Rule("1: 2 3 | 3 2")
        XCTAssertEqual(rule.id, 1)
        XCTAssertEqual(rule.subRules, [[2, 3], [3, 2]])
        XCTAssertEqual(rule.char, nil)

        rule = Day19.Rule("4: \"a\"")
        XCTAssertEqual(rule.id, 4)
        XCTAssertEqual(rule.subRules, [])
        XCTAssertEqual(rule.char, "a")
    }
    
    func testRuleStore() {
        let store = Day19.RuleStore(rules: [
            Day19.Rule("0: 4 1 5"),
            Day19.Rule("1: 2 3 | 3 2"),
            Day19.Rule("2: 4 4 | 5 5"),
            Day19.Rule("3: 4 5 | 5 4"),
            Day19.Rule("4: \"a\""),
            Day19.Rule("5: \"b\"")
        ])
    
        var strings = store.stringsForRule(ruleId: 2)
        XCTAssertEqual(strings, ["aa", "bb"])
        
        strings = store.stringsForRule(ruleId: 3)
        XCTAssertEqual(strings, ["ab", "ba"])
        
        strings = store.stringsForRule(ruleId: 1)
        XCTAssertEqual(strings, [
            "aaab", "aaba", "bbab", "bbba", "abaa", "abbb", "baaa", "babb"
        ])
        
        strings = store.stringsForRule(ruleId: 0)
        XCTAssertEqual(strings, [
            "aaaabb", "aaabab", "abbabb", "abbbab", "aabaab", "aabbbb", "abaaab", "ababbb"
        ])
    }

    func testPart1Sample() {
        let result = day.calculatePart1([sample, sampleMessages])
        XCTAssertEqual(result, 2)
    }

    func testPart1() throws {
        let result = day.calculatePart1(input)
        print("Day 19 Part 1: \(result)")
        XCTAssertEqual(result, 151)
    }

    func testPart2Sample() {
//        let result = day.calculatePart2(sample)
//        XCTAssertEqual(result, 0)
    }

    func testPart2() throws {
        let result = day.calculatePart2(input)
        print("Day 19 Part 2: \(result)")
        XCTAssertEqual(result, 0)
    }
}
