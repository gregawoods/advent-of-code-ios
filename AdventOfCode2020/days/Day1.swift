//
//  Day1.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/2/20.
//

import Foundation

struct Day1: DayProtocol {

    func calculatePart1(_ input: [Int]) -> Int {
        for x in input {
            let y = 2020 - x
            if input.contains(y) {
                return x * y
            }
        }
        return -1
    }

    func calculatePart2(_ input: [Int]) -> Int {
        for x in input {
            for y in input {
                let z = 2020 - x - y
                if input.contains(z) {
                    return x * y * z
                }
            }
        }
        return -1
    }
}
