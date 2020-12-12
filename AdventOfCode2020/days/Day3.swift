//
//  Day3.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/3/20.
//

import Foundation

struct Day3: DayProtocol {

    func calculatePart1(_ input: [String]) -> Int {
        return Slope(input).countTreesForSlope(colMove: 3, rowMove: 1)
    }

    func calculatePart2(_ input: [String]) -> Int {
        let moves = [
            [1, 1],
            [3, 1],
            [5, 1],
            [7, 1],
            [1, 2]
        ]
        return moves.reduce(1) { current, moves in
            let next = Slope(input).countTreesForSlope(colMove: moves[0], rowMove: moves[1])
            return current * next
        }
    }

    struct Slope {
        var coords: [[Bool]] = []
        let height: Int

        init(_ lines: [String]) {
            self.height = lines.count

            var row = 0

            lines.forEach { line in
                coords.append([])

                Array(line).forEach { (char) in
                    coords[row].append(char == "#")
                }
                row += 1
            }
        }

        func countTreesForSlope(colMove: Int, rowMove: Int) -> Int {
            var row = 0
            var col = 0
            var trees = 0

            while row < height {
                if isTree(col, row) {
                    trees += 1
                }
                row += rowMove
                col += colMove
            }

            return trees
        }

        func isTree(_ col: Int, _ row: Int) -> Bool {
            let effectiveCol = col % coords[row].count

            return coords[row][effectiveCol]
        }
    }
}
