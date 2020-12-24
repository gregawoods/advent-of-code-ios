//
//  Day23.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/23/20.
//

import Foundation

struct Day23: DayProtocol {

    class Cup {
        let value: Int
        var next: Cup? {
            didSet { next?.prev = self }
        }
        var prev: Cup?

        init(value: Int) {
            self.value = value
        }
    }

    func calculatePart1(_ input: [Int]) -> Int {
        var allCups: [Int: Cup] = [:]

        var firstCup: Cup?
        var lastCup: Cup?

        for n in 0...input.count-1 {
            let newCup = Cup(value: input[n])
            allCups[newCup.value] = newCup

            if firstCup == nil {
                firstCup = newCup
            } else if lastCup != nil {
                lastCup!.next = newCup
            }
            lastCup = newCup
        }

        lastCup?.next = firstCup

        let maxVal = input.max()!
        var startingCup = input.first!
        var iteration = 0

        repeat {
            startingCup = moveCups(allCups: allCups, startingCup: startingCup, maxVal: maxVal)
            iteration += 1
        } while iteration < 100

        return printAnswer(allCups: allCups)
    }

    func moveCups(allCups: [Int: Cup], startingCup: Int, maxVal: Int) -> Int {
        guard let currentCup = allCups[startingCup] else {
            return 0
        }

        var toMove: [Cup] = []
        toMove.append(currentCup.next!)
        toMove.append(currentCup.next!.next!)
        toMove.append(currentCup.next!.next!.next!)

        let nextStartingCup = toMove.last!.next!

        var target = currentCup.value - 1

        while target == 0 || toMove.map({ $0.value }).contains(target) {
            if target == 0 {
                target = maxVal
            } else {
                target -= 1
            }
        }

        currentCup.next = toMove.last!.next!
        toMove.last!.next = allCups[target]!.next
        allCups[target]!.next = toMove.first!

        return nextStartingCup.value
    }

    func printAnswer(allCups: [Int: Cup]) -> Int {
        var cup = allCups[1]!
        var answer: [Int] = []

        repeat {
            cup = cup.next!
            if cup.value == 1 { break }
            answer.append(cup.value)
        } while true

        return Int(answer.map({ String($0) }).joined())!
    }

    func calculatePart2(_ input: [Int]) -> Int {
        var allCups: [Int: Cup] = [:]

        var firstCup: Cup?
        var lastCup: Cup?

        for n in 0...input.count-1 {
            let newCup = Cup(value: input[n])
            allCups[newCup.value] = newCup

            if firstCup == nil {
                firstCup = newCup
            } else if lastCup != nil {
                lastCup!.next = newCup
            }
            lastCup = newCup
        }

        let max = input.max()!

        for n in 0...(1000000-input.count-1) {
            let newCup = Cup(value: n + max + 1)
            allCups[newCup.value] = newCup
            lastCup!.next = newCup
            lastCup = newCup
        }

        lastCup?.next = firstCup

        var startingCup = input.first!
        var iteration = 0
        repeat {
            startingCup = moveCups(allCups: allCups, startingCup: startingCup, maxVal: 1000000)
            iteration += 1
        } while iteration < 10000000

        let cup1 = allCups[1]!.next!
        let cup2 = cup1.next!

        return cup1.value * cup2.value
    }
}
