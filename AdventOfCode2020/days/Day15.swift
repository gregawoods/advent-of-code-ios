//
//  Day15.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/15/20.
//

import Foundation

struct Day15: DayProtocol {
    func calculatePart1(_ input: [Int]) -> Int {

        var numbers = input

        repeat {
            let lastNum = numbers.last!

            if numbers.countWhere({ $0 == lastNum }) > 1 {
                let indices = numbers.allIndicesOf(element: lastNum)
                numbers.append(indices.last! - indices[indices.count - 2])
            } else {
                numbers.append(0)
            }
        } while numbers.count < 2020

        return numbers.last!
    }

    func calculatePart2(_ input: [Int]) -> Int {
        return 0
    }
}
