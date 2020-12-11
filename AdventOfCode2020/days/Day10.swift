//
//  Day10.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/9/20.
//

import Foundation

struct Day10: DayProtocol {

    let numbers: [Int]

    init() {
        var input = FileReader(file: "day10").arrayOfInts.sorted()
        input.insert(0, at: 0)
        input.append(input.last! + 3)
        self.numbers = input
    }

    func calculatePart1() -> Int {
        let diffs = countDiffs(numbers: numbers)

        return diffs[0] * diffs[2]
    }

    func countDiffs(numbers: [Int]) -> [Int] {
        var diff1 = 0
        var diff2 = 0
        var diff3 = 0

        for n in 0...(numbers.count - 2) {
            let x = numbers[n]
            let y = numbers[n + 1]
            let diff = y - x
            if diff == 3 {
                diff3 += 1
            } else if diff == 2 {
                diff2 += 1
            } else if diff == 1 {
                diff1 += 1
            } else {
                print("Hmm, something went wrong here")
            }
        }

        return [diff1, diff2, diff3]
    }

    typealias Graph = [Int: [Int]]
    var maxValue: Int { return numbers.last! }

    func calculatePart2() -> Int {
        var graph = Graph()

        for n in numbers {
            graph[n] = (1...3).map({ $0 + n }).filter({ numbers.contains($0) })
        }

        var cache = Cache<Int, Int>()
        let result = count(graph, &cache, 0)

        return result
    }

    func count(_ graph: Graph, _ cache: inout Cache<Int, Int>, _ index: Int) -> Int {
        return cache.fetch(key: index) {
            guard let sequence = graph[index] else { return 0 }

            if sequence[0] == maxValue {
                return 1
            } else {
                return sequence.map { return count(graph, &cache, $0) }.sum()
            }
        }
    }
}
