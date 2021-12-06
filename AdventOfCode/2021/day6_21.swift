//
//  day6_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/5/21.
//

import Foundation

struct Y21_Day6 : DayProtocol {
    
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
        var allNumbers: [Int: Int] = [:]

        for n in input {
            allNumbers[n, default: 0] += 1
        }

        for _ in 0...255 {
            var newNumbers: [Int: Int] = [:]
            
            allNumbers.forEach { num, count in
                if num == 0 {
                    newNumbers[8] = count
                    newNumbers[6, default: 0] += count
                } else {
                    newNumbers[num - 1, default: 0] += count
                }
            }

            allNumbers = newNumbers
        }
  
        return allNumbers.map { $1 }.sum()
    }
}
