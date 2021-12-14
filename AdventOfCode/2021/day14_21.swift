//
//  day14_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/13/21.
//

import Foundation

struct Y21Day14: DayProtocol {

    func parseInput(_ input: [String]) -> ([String: Int], [String: String]) {
        var pairs = [String: Int]()
        var rules: [String: String] = [:]

        for n in 1...(input[0].count-1) {
            let pair = "\(input[0][n-1])\(input[0][n])"
            pairs[pair] = pairs[pair] ?? 0
            pairs[pair]! += 1
        }

        input[2...].forEach { txt in
            if txt == "" { return }
            let parts = txt.components(separatedBy: " -> ")
            rules[parts[0]] = parts[1]
        }

        return (pairs, rules)
    }

    func solve(_ input: [String], iterations: Int) -> Int {
        var (pairs, rules) = parseInput(input)

        for _ in 1...iterations {
            var p2 = [String: Int]()

            pairs.forEach { key, val in
                let left = String(key[0])
                let right = String(key[1])
                let rule = rules[key]!

                p2["\(left)\(rule)", default: 0] += val
                p2["\(rule)\(right)", default: 0] += val
            }

            pairs = p2
        }

        var counts: [Character: Int] = [:]

        pairs.forEach { key, val in
            counts[key[0], default: 0] += val
            counts[key[1], default: 0] += val
        }

        let max = Int(round(Double(counts.values.max()!) / 2.0))
        let min = Int(round(Double(counts.values.min()!) / 2.0))

        return max - min
    }

    func part1(_ input: [String]) -> Int {
        return solve(input, iterations: 10)
    }

    func part2(_ input: [String]) -> Int {
        return solve(input, iterations: 40)
    }
}
