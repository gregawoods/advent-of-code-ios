//
//  Day23.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/23/20.
//

import Foundation

class Cup {
    let value: Int
    var next: Cup? {
        didSet {
            if let newNext = next {
                newNext.prev = self
            }
        }
    }
    var prev: Cup?

    init(value: Int) {
        self.value = value
    }
}

struct Day23: DayProtocol {

    func calculatePart1LinkedList(_ input: [Int]) -> Int {
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

        var startingCup = input.first!
        var iteration = 0
        repeat {
            startingCup = moveCupsLL(cups: allCups, startingCup: startingCup)
            iteration += 1
        } while iteration < 100

        return printAnswer(allCups: allCups)
    }

    func moveCupsLL(cups: [Int: Cup], startingCup: Int) -> Int {
        guard let currentCup = cups[startingCup] else {
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
                target = cups.keys.max()!
//                target = 1000000
            } else {
                target -= 1
            }
        }

        currentCup.next = toMove.last!.next!
        toMove.last!.next = cups[target]!.next
        cups[target]!.next = toMove.first!

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
            startingCup = moveCupsLL(cups: allCups, startingCup: startingCup)
            iteration += 1
        } while iteration < 10000000

        let cup1 = allCups[1]!.next!
        let cup2 = cup1.next!

        return cup1.value * cup2.value
    }
}
