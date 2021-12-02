//
//  Day9.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/8/20.
//

import Foundation

struct Day9: DayProtocol {

    func part1(_ input: [Int]) -> Int {
        return calculateFirstInvalid(data: input, length: 25)
    }

    func calculateFirstInvalid(data: [Int], length: Int) -> Int {
        for position in length...data.count {
            let current = data[position]
            let preamble = Array(data[(position-length)...position])
            if !findSum(current, preamble) {
                return current
            }
        }

        return 0
    }

    func findSum(_ needle: Int, _ haystack: [Int]) -> Bool {
        for n in haystack {
            if (needle / n) != 2 && haystack.contains(needle - n) {
                return true
            }
        }
        return false
    }

    func part2(_ input: [Int]) -> Int {
        let value = calculateFirstInvalid(data: input, length: 25)

        for length in 2...input.count {
            for index in 0...(input.count - 1) {
                let rangeEnd = index + length - 1

                if rangeEnd >= input.count {
                    continue
                }

                let range = Array(input[index...rangeEnd])
                if range.sum() == value {
                    return range.max()! + range.min()!
                }
            }
        }

        return 0
    }
}
