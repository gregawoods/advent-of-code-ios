//
//  Day16.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/16/20.
//

import Foundation

struct Day16: DayProtocol {

    struct Rule: Equatable {
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
        let rules = input[0].components(separatedBy: "\n").map { Rule($0) }
        let myTicket = input[1].components(separatedBy: "\n").last!.toCsv()
        var tickets = input[2].components(separatedBy: "\n").dropFirst().map { $0.toCsv() }
        tickets = filterValidTickets(tickets: tickets, rules: rules)

        let positions = determinePositions(rules: rules, tickets: tickets)

        var departures: [Int] = []

        for index in 0...positions.count-1 {
            if positions[index].starts(with: "departure") {
                departures.append(myTicket[index])
            }
        }

        return departures.reduce(1, *)
    }

    // Return tickets that are valid
    func filterValidTickets(tickets: [[Int]], rules: [Rule]) -> [[Int]] {
        return tickets.filter { ticket in
            ticket.allSatisfy { number in
                rules.contains { $0.valid(value: number) }
            }
        }
    }

    // Determine the positions of each rule through process of elimination
    func determinePositions(rules: [Rule], tickets: [[Int]]) -> [String] {
        // Results array is a list of all possible rules in each position
        // When a position is reduced to 1 element, that must be what the position means
        var results = Array(repeating: rules, count: tickets.first!.count)

        repeat {
            results = validationPass(current: results, tickets: tickets)
        } while results.contains { $0.count > 1 }

        return results.compactMap { $0.first!.label }
    }

    // Run a single pass on the tickets, throwing out possible rules in each position
    func validationPass(current: [[Rule]], tickets: [[Int]]) -> [[Rule]] {
        var new = current
        var rulesToSanitize: [Int: Rule] = [:]

        for ticket in tickets {
            for (index, number) in ticket.enumerated() {
                new[index] = new[index].filter { rule in
                    return rule.valid(value: number)
                }
                if new[index].count == 1 {
                    rulesToSanitize[index] = new[index].first!
                }
            }
        }

        // A rule that appears only once in a slot is locked in and must
        // be cleansed from any other slots
        rulesToSanitize.forEach { (belongsToIndex, rule) in
            for index in 0...new.count-1 {
                if index == belongsToIndex { continue }
                new[index] = new[index].filter { $0 != rule }
            }
        }

        return new
    }
}
