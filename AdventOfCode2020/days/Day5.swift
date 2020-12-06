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
//        let seatId: Int
//        init(input: String) {
//            let binary = input.replacingOccurrences(of: "", with: "")
//
//            self.seatId = 1
//        }

        let source: String
        private var row = 0
        private var col = 0

        init(input: String) {
            self.source = input

            var rowMin = 1
            var rowMax = 128

            for char in input.prefix(7) {
                if char == "F" {
                    rowMax -= (rowMax - rowMin + 1) / 2
                } else {
                    rowMin += (rowMax - rowMin + 1) / 2
                }
                if rowMin == rowMax {
                    self.row = rowMin - 1
                }
            }

            var colMin = 1
            var colMax = 8

            for char in input.suffix(3) {
                if char == "L" {
                    colMax -= (colMax - colMin + 1) / 2
                } else {
                    colMin += (colMax - colMin + 1) / 2
                }
                if colMin == colMax {
                    self.col = colMin - 1
                }
            }
        }

        var seatId: Int {
            return (row * 8) + col
        }
    }
}
