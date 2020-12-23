//
//  Day23.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/23/20.
//

import Foundation

struct Day23: DayProtocol {
    
    func calculatePart1(_ input: [Int]) -> Int {
        var cups = input
        var iteration = 0

        repeat {
            cups = moveCups(cups: cups)
            iteration += 1
        } while iteration < 100

        return cupsToAnswer(cups: cups)
    }

    func moveCups(cups: [Int]) -> [Int] {
        let current = cups.first!
        let toMove = cups[1...3]

        var newArray = Array(cups[4...])

        var target = current - 1

        if target < 1 {
            target = newArray.max()!
        } else {
            while toMove.contains(target) {
                target -= 1
                if target < 1 {
                    target = newArray.max()!
                }
            }
        }

        let targetIndex = newArray.firstIndex(of: target)!
        newArray.insert(contentsOf: toMove, at: targetIndex + 1)
        newArray.append(current)

        return newArray
    }

    // Reorders array starting at the 1 cup and return a Int value representing the order
    func cupsToAnswer(cups: [Int]) -> Int {
        var shifted = cups

        while shifted.first != 1 {
            shifted.append(shifted.removeFirst())
        }

        let strVal = shifted[1...].map { String($0) }.joined()

        return Int(strVal)!
    }

    func cupsStartingFrom1(cups: [Int]) -> [Int] {
        let firstIndex = cups.firstIndex(of: 1)!
        var newArray: [Int] = []

        for n in 0...cups.count-1 {
            var index = n + firstIndex
            if index > cups.count - 1 {
                index -= cups.count
            }
            let val = cups[n]
            if val != 1 {
                newArray.append(cups[n])
            }
        }

        return newArray
    }

    func calculatePart2(_ input: [Int]) -> Int {
        var cups = input
        let max = cups.max()!

        for n in 0...(1000000-input.count-1) {
            cups.append(n + max)
        }

        var iteration = 0

        repeat {
            cups = moveCups(cups: cups)
            iteration += 1
        } while iteration < 10000000

        return 1
    }
}
