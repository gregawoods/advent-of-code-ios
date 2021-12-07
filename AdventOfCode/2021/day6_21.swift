//
//  day6_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/5/21.
//

import Foundation

struct Y21Day6: DayProtocol {

    func calculateFish(currentFish: [Int]) -> [Int] {
        var newFish: [Int] = []

        for n in currentFish {
            if n == 0 {
                newFish.append(6)
                newFish.append(8)
            } else {
                newFish.append(n - 1)
            }
        }

        return newFish
    }

    func part1(_ input: [Int]) -> Int {
        var fish = input

        for _ in 0...79 {
            fish = calculateFish(currentFish: fish)
        }

        return fish.count
    }

    func part2(_ input: [Int]) -> Int {
        var allNumbers = Array(repeating: 0, count: 9)
        for n in input { allNumbers[n] += 1 }

        for _ in 0...255 {
            var newNumbers = Array(repeating: 0, count: 9)

            allNumbers.enumerated().forEach { (n, count) in
                if n == 0 {
                    newNumbers[8] = count
                    newNumbers[6] += count
                } else {
                    newNumbers[n-1] += count
                }
            }

            allNumbers = newNumbers
        }

        return allNumbers.sum()
    }
}
