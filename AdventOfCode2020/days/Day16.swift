//
//  Day16.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/16/20.
//

import Foundation

struct Day16: DayProtocol {

    struct Rule {
        let label: String
        let ranges: [ClosedRange<Int>]

        init(_ input: String) {
            let parts = input.components(separatedBy: ": ")
            self.label = parts[0]
            self.ranges = parts[1].components(separatedBy: " or ").map { str in
                let parts = str.components(separatedBy: "-")
                return Int(parts[0])!...Int(parts[1])!
            }
        }

        func valid(value: Int) -> Bool {
            return ranges.contains { $0.contains(value) }
        }
    }

    func calculatePart1(_ input: [String]) -> Int {
        let rules = input[0].components(separatedBy: "\n").map { Rule($0) }
        let tickets = input[2].components(separatedBy: "\n").dropFirst().map { $0.toCsv() }

        var errorRate = 0

        for ticket in tickets {
            for number in ticket {
                let valid = rules.contains { $0.valid(value: number) }
                if !valid {
                    errorRate += number
                }
            }
        }

        return errorRate
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
