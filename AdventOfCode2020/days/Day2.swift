//
//  Day2.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/2/20.
//

import Foundation

struct Day2: DayProtocol {

    func calculatePart1(_ input: [String]) -> Int {
        return input.map({ Password($0) }).countWhere { $0.valid }
    }

    func calculatePart2(_ input: [String]) -> Int {
        return input.map({ Password($0) }).countWhere { $0.validPart2 }
    }

    struct Password {
        // 1-3 a: abcde
        let password: String
        let char: String
        let min: Int
        let max: Int

        init(_ input: String) {
            var parts = input.components(separatedBy: " ")
            self.char = parts[1].replacingOccurrences(of: ":", with: "")
            self.password = parts[2]

            parts = parts[0].components(separatedBy: "-")
            self.min = Int(parts[0])!
            self.max = Int(parts[1])!
        }

        var valid: Bool {
            let occurances = Array(password).filter({ String($0) == char }).count
            return occurances >= min && occurances <= max
        }

        var validPart2: Bool {
            let array = Array(password)

            let minVal = String(array[min-1])
            let maxVal = String(array[max-1])

            return (minVal == char && maxVal != char) || (minVal != char && maxVal == char)
        }
    }
}
