//
//  Day19.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/18/20.
//

import Foundation

struct Day19: DayProtocol {

    struct Rule {
        let id: Int
        let subRules: [[Int]]
        let char: String?

        init(_ input: String) {
            let parts = input.components(separatedBy: ": ")
            self.id = Int(parts[0])!

            if parts[1].firstIndex(of: "\"") != nil {
                self.subRules = []
                self.char = parts[1].replacingOccurrences(of: "\"", with: "")
            } else {
                self.subRules = parts[1].components(separatedBy: " | ").map({ ruleString in
                    return ruleString.components(separatedBy: " ").map({ Int(String($0))! })
                })
                self.char = nil
            }
        }
    }

    struct RuleStore {
        let rules: [Rule]
        var cache: Cache<Int, Set<String>> = Cache()

        func findRule(_ id: Int) -> Rule? {
            return rules.first(where: { rule in
                return rule.id == id
            })
        }

        func stringsForRule(ruleId: Int) -> Set<String> {
            return cache.fetch(key: ruleId) {
                guard let rule = findRule(ruleId) else {
                    return []
                }

                if let char = rule.char {
                    return [char]
                }

                var results: [String] = []
                for subRule in rule.subRules {
                    let set = subRule.map { Array(stringsForRule(ruleId: $0)) }
                    var matches: [String] = set.first!
                    for position in set.dropFirst() {
                        var newArr: [String] = []
                        for n in 0...matches.count-1 {
                            for m in 0...position.count-1 {
                                let str = matches[n] + position[m]
                                newArr.append(str)
                            }
                        }
                        matches = newArr
                    }
                    results += matches
                }

                return Set<String>(results)
            }
        }

        func match(input: String, ruleId: Int) -> Bool {
            let strings = stringsForRule(ruleId: ruleId)

            return strings.contains(input)
        }
    }

    func calculatePart1(_ input: [String]) -> Int {
        let rules = input[0].components(separatedBy: "\n").map { Rule($0) }
        let store = RuleStore(rules: rules)

        var count = 0

        for line in input[1].components(separatedBy: "\n") {
            if store.match(input: line, ruleId: 0) {
                count += 1
            }
        }

        return count
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
