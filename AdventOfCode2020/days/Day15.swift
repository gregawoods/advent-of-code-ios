//
//  Day15.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/15/20.
//

import Foundation

struct Day15: DayProtocol {

    func findLastNumber(_ input: [Int], limit: Int) -> Int {
        var previousNumberDelta: Int?

        // key: The number
        // val: The last time this number was used
        var numbers: [Int: Int] = [:]

        // seed the initial values
        for (index, item) in input.enumerated() {
            numbers[item] = index
        }

        var value = -1

        for index in input.count...(limit - 1) {
            value = previousNumberDelta ?? 0
            if let turn = numbers[value] {
                previousNumberDelta = index - turn
            } else {
                previousNumberDelta = nil
            }
            numbers[value] = index
        }

        return value
    }

    func calculatePart1(_ input: [Int]) -> Int {
        return findLastNumber(input, limit: 2020)
    }

    func calculatePart2(_ input: [Int]) -> Int {
        return findLastNumber(input, limit: 30000000)
    }
}
