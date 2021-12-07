//
//  day7_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/6/21.
//

import Foundation

struct Y21Day7: DayProtocol {

    func part1(_ input: [Int]) -> Int {
        var costs: [Int] = []

        for target in input.min()!...input.max()! {
            costs.append(input.map { abs(target - $0) }.sum())
        }

        return costs.sorted()[0]
    }

    func part2(_ input: [Int]) -> Int {
        var costs: [Int] = []
        let cache = Cache<Int, Int>()

        for target in input.min()!...input.max()! {
            costs.append(
                input.map { n in
                    let moves = abs(target - n)
                    return cache.fetch(key: moves) {
                        var newValue = 0
                        for n in 0...moves { newValue += n }
                        return newValue
                    }
                }.sum()
            )
        }

        return costs.sorted()[0]
    }
}
