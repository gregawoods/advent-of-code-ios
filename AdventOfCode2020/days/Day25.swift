//
//  Day25.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/27/20.
//

import Foundation

struct Day25: DayProtocol {

    private let divisor = 20201227
    private let publicKeySubject = 7

    func transform(subject: Int, loopSize: Int) -> Int {
        var value = 1

        for _ in 1...loopSize {
            value *= subject
            value = value % divisor
        }

        return value
    }

    func findLoopsSize(forKey key: Int) -> Int {
        var value = 1
        var index = 0

        repeat {
            index += 1
            value *= publicKeySubject
            value = value % divisor
        } while value != key

        return index
    }

    func calculatePart1(_ input: [Int]) -> Int {
        let cardSubject = input.first!
        let doorSubject = input.last!

        let loopSize = findLoopsSize(forKey: cardSubject)
        let encryptionKey = transform(subject: doorSubject, loopSize: loopSize)

        return encryptionKey
    }

    func calculatePart2(_ input: [Int]) -> Int {
        return 0
    }
}
