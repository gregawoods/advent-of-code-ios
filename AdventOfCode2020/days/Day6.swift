//
//  Day6.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/5/20.
//

import Foundation

struct Day6: DayProtocol {

    func groups(_ input: [String]) -> [GroupAnswers] {
        return input.map { GroupAnswers($0) }
    }

    func calculatePart1(_ input: [String]) -> Int {
        return groups(input).map { $0.count }.sum()
    }

    func calculatePart2(_ input: [String]) -> Int {
        return groups(input).map { $0.countAll }.sum()
    }

    struct GroupAnswers {
        let count: Int
        let countAll: Int

        init(_ input: String) {
            var people = input.components(separatedBy: "\n").map { Set($0) }
            self.count = Set(people.flatMap { $0 }).count

            let initial = people.popLast()!
            self.countAll = people.reduce(initial) { $0.intersection($1) }.count
        }
    }
}
