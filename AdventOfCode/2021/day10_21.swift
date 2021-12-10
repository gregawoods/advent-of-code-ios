//
//  day10_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/9/21.
//

import Foundation

struct Y21Day10: DayProtocol {

    let openers = ["(", "[", "<", "{"]
    let closers = [")", "]", ">", "}"]

    func part1(_ input: [String]) -> Int {
        var corrupted: [String] = []

        for line in input {
            if let c = findCorruptCharacter(line: line) {
                corrupted.append(c)
            }
        }

        let values = [")": 3, "]": 57, "}": 1197, ">": 25137]

        return corrupted.map { values[$0]! }.sum()
    }

    func findCorruptCharacter(line: String) -> String? {
        var openChunks: [String] = []

        for char in line {
            let str = String(char)

            if openers.contains(str) {
                openChunks.append(str)
            } else if closers.contains(str) {
                let expectedCloser = closers[openers.firstIndex(of: openChunks.last!)!]

                if str == expectedCloser {
                    _ = openChunks.popLast()
                } else {
                    return str
                }
            } else {
                print("wat")
            }
        }

        return nil
    }

    func part2(_ input: [String]) -> Int {
        var results: [[String]] = []

        for line in input {
            if let c = findLineCompletion(line: line) {
                results.append(c)
            }
        }

        let values = [")": 1, "]": 2, "}": 3, ">": 4]
        var scores: [Int] = []

        for result in results {
            var score = 0
            for char in result {
                score *= 5
                score += values[char]!
            }
            scores.append(score)
        }

        scores = scores.sorted()

        let index = (scores.count - 1) / 2
        return scores[index]
    }

    func findLineCompletion(line: String) -> [String]? {
        var openChunks: [String] = []

        for char in line {
            let str = String(char)

            if openers.contains(str) {
                openChunks.append(str)
            } else if closers.contains(str) {
                let expectedCloser = closers[openers.firstIndex(of: openChunks.last!)!]

                if str == expectedCloser {
                    _ = openChunks.popLast()
                } else {
                    return nil
                }
            } else {
                print("wat")
            }
        }

        var completion: [String] = []

        while openChunks.count > 0 {
            let opener = openChunks.popLast()!
            let expectedCloser = closers[openers.firstIndex(of: opener)!]

            completion.append(expectedCloser)
        }

        return completion
    }
}
