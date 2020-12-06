//
//  Day6.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/5/20.
//

import Foundation

struct Day6: DayProtocol {
    let groups: [GroupAnswers]

    init() {
        self.groups = FileReader(file: "day6").chunksByNewline.map { GroupAnswers(input: $0) }
    }

    func calculatePart1() -> Int {
        return groups.map { $0.count }.sum()
    }

    func calculatePart2() -> Int {
        return groups.map { $0.countAll }.sum()
    }

    struct GroupAnswers {
        let count: Int
        let countAll: Int

        init(input: String) {
            var people = input.components(separatedBy: "\n").map { Array($0) }

            self.count = Set(people.flatMap { $0 }).count

            let initial = Set(people.popLast()!)
            self.countAll = people.reduce(initial) { (result, current) in
                return result.intersection(Set(current))
            }.count
        }
    }
}
