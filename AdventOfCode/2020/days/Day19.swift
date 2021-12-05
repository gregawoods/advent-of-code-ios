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
        let char: Character?

        init(_ input: String) {
            let parts = input.components(separatedBy: ": ")
            self.id = Int(parts[0])!

            if parts[1].firstIndex(of: "\"") != nil {
                self.subRules = []
                self.char = parts[1].replacingOccurrences(of: "\"", with: "").first
            } else {
                self.subRules = parts[1].components(separatedBy: " | ").map({ ruleString in
                    return ruleString.components(separatedBy: " ").map({ Int(String($0))! })
                })
                self.char = nil
            }
        }

        var condition1: [Int]? { subRules.first }
        var condition2: [Int]? {
            if subRules.count > 1 {
                return subRules[1]
            }
            return nil
        }
    }

    struct RuleStore {
        let rules: [Int: Rule]
        var cache: Cache<Int, Set<String>> = Cache()

        init(rules: [Rule]) {
            var dict: [Int: Rule] = [:]
            rules.forEach { dict[$0.id] = $0 }
            self.rules = dict
        }

        func findRule(_ id: Int) -> Rule? {
            return rules[id]
        }

        func stringsForRule(ruleId: Int) -> Set<String> {
            return cache.fetch(key: ruleId) {
                guard let rule = findRule(ruleId) else {
                    return []
                }

                if let char = rule.char {
                    return [String(char)]
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

        var maxDepth = 10

        func searchProgressively(ruleId: Int, message: String, depth: Int = 0) -> Set<String> {
            if depth >= maxDepth {
                return ["💣"]
            }

            guard let rule = findRule(ruleId) else {
                return []
            }

            if let char = rule.char {
                if message.contains(char) {
                    return [String(char)]
                } else {
                    return []
                }
            }

            var results: Set<String> = []
            for subRule in rule.subRules {
                var set = subRule.map { searchProgressively(ruleId: $0, message: message, depth: depth + 1) }
                set = set.filter { $0.count > 0 }
                if set.count == 0 { continue }

                var matches = set.first!
                for position in set.dropFirst() {
                    var newSet: Set<String> = []
                    for match in matches {
                        for pos in position {
                            let str = match + pos
                            newSet.insert(str)
                        }
                    }
                    matches = newSet
                }
                results = results.union(matches)
            }

            return results.filter { message.contains($0) }
        }

        func checkMessage(message: String) -> Bool {
            let results = searchProgressively(ruleId: 0, message: message)

            return results.contains(message)
        }
    }

    func part1(_ input: [String]) -> Int {
        let lines = input[1].components(separatedBy: "\n")
        let rules = input[0].components(separatedBy: "\n").map { Rule($0) }
        let store = RuleStore(rules: rules)
        let strings = store.stringsForRule(ruleId: 0)

        return lines.countWhere { strings.contains($0) }
    }

    func part2(_ input: [String]) -> Int {
        let lines = input[1].components(separatedBy: "\n")
        let rules = input[0].components(separatedBy: "\n").map { Rule($0) }
        var store = RuleStore(rules: rules)
        var index = 0

        let matching = lines.filter {
            index += 1
            store.maxDepth = $0.count
            return store.checkMessage(message: $0)
        }

        return matching.count
    }
}
