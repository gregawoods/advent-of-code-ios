//
//  Day5.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/4/20.
//

import Foundation

struct Day5: DayProtocol {

    let passes: [BoardingPass]

    init() {
        self.passes = FileReader(file: "day5").lines.map { line in
            BoardingPass(input: line)
        }
    }

    func calculatePart1() -> Int {
        return passes.map { $0.seatId }.max()!
    }

    func calculatePart2() -> Int {
        let seatIds = passes.map { $0.seatId }.sorted()

        var lastId = 0

        for id in seatIds {
            if lastId != 0 && (id - lastId > 1) {
                return id - 1
            }
            lastId = id
        }

        return 0
    }

    struct BoardingPass {
        let seatId: Int

        init(input: String) {
            let binary = input.replacingOccurrences(of: "F", with: "0")
                .replacingOccurrences(of: "B", with: "1")
                .replacingOccurrences(of: "L", with: "0")
                .replacingOccurrences(of: "R", with: "1")

            self.seatId = Int(binary, radix: 2)!
        }
    }
}
