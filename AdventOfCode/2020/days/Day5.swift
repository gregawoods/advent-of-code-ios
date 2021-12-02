//
//  Day5.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/4/20.
//

import Foundation

struct Day5: DayProtocol {

    func passes(_ input: [String]) -> [BoardingPass] {
        input.map { BoardingPass($0) }
    }

    func part1(_ input: [String]) -> Int {
        return passes(input).map { $0.seatId }.max()!
    }

    func part2(_ input: [String]) -> Int {
        let seatIds = passes(input).map { $0.seatId }.sorted()

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

        init(_ input: String) {
            let binary = input.replacingOccurrences(of: "F", with: "0")
                .replacingOccurrences(of: "B", with: "1")
                .replacingOccurrences(of: "L", with: "0")
                .replacingOccurrences(of: "R", with: "1")

            self.seatId = Int(binary, radix: 2)!
        }
    }
}
