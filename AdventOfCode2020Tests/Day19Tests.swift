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

    // swiftlint:disable function_body_length

    func testPart2Sample() {
        var rules = """
        42: 9 14 | 10 1
        9: 14 27 | 1 26
        10: 23 14 | 28 1
        1: "a"
        11: 42 31
        5: 1 14 | 15 1
        19: 14 1 | 14 14
        12: 24 14 | 19 1
        16: 15 1 | 14 14
        31: 14 17 | 1 13
        6: 14 14 | 1 14
        2: 1 24 | 14 4
        0: 8 11
        13: 14 3 | 1 12
        15: 1 | 14
        17: 14 2 | 1 7
        23: 25 1 | 22 14
        28: 16 1
        4: 1 1
        20: 14 14 | 1 15
        3: 5 14 | 16 1
        27: 1 6 | 14 18
        14: "b"
        21: 14 1 | 1 14
        25: 1 1 | 1 14
        22: 14 14
        8: 42
        26: 14 22 | 1 20
        18: 15 15
        7: 14 5 | 1 21
        24: 14 1
        """

        let messages = """
        abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
        bbabbbbaabaabba
        babbbbaabbbbbabbbbbbaabaaabaaa
        aaabbbbbbaaaabaababaabababbabaaabbababababaaa
        bbbbbbbaaaabbbbaaabbabaaa
        bbbababbbbaaaaaaaabbababaaababaabab
        ababaaaaaabaaab
        ababaaaaabbbaba
        baabbaaaabbaaaababbaababb
        abbbbabbbbaaaababbbbbbaaaababb
        aaaaabbaabaaaaababaa
        aaaabbaaaabbaaa
        aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
        babaaabbbaaabaababbaabababaaab
        aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
        """

        var result = day.calculatePart2([rules, messages])
        XCTAssertEqual(result, 3)

        rules = rules.replacingOccurrences(of: "8: 42", with: "8: 42 | 42 8")
        rules = rules.replacingOccurrences(of: "11: 42 31", with: "11: 42 31 | 42 11 31")

        result = day.calculatePart2([rules, messages])
        XCTAssertEqual(result, 12)
    }

    func testPart2() throws {
        // Replace rules 8 and 11 with new rules
        var copy = input
        copy[0] = copy[0].replacingOccurrences(of: "8: 42", with: "8: 42 | 42 8")
        copy[0] = copy[0].replacingOccurrences(of: "11: 42 31", with: "11: 42 31 | 42 11 31")

        let result = day.calculatePart2(copy)
        print("Day 19 Part 2: \(result)")
        XCTAssertEqual(result, 386)
    }
}
