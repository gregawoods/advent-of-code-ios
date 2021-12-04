//
//  day4_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/3/21.
//

import Foundation

struct Y21_Day4 : DayProtocol {

    class Spot: Equatable {
        let value: Int
        var on: Bool = false

        init(_ val: Int) {
            self.value = val
        }
        
        static func == (lhs: Spot, rhs: Spot) -> Bool {
            lhs.value == rhs.value
        }
    }

    struct Board: Equatable {
        let rows: [[Spot]]
        
        init(input: String) {
            let lines = input.components(separatedBy: "\n")

            self.rows = lines.map { rowStr in
                return rowStr.toIntegerArray(" ").map { Spot($0) }
            }
        }

        static func == (lhs: Board, rhs: Board) -> Bool {
            return lhs.rows == rhs.rows
        }

        func play(_ val: Int) {
            for row in rows {
                for spot in row {
                    if spot.value == val {
                        spot.on = true
                        return
                    }
                }
            }
        }

        var width: Int {
            return rows.first?.count ?? 0
        }

        var isWinner: Bool {
            for row in rows {
                if row.allSatisfy({ $0.on }) {
                    return true
                }
            }

            for n in (0...(width-1)) {
                let column = rows.map({ $0[n] })
                if column.allSatisfy({ $0.on  }) {
                    return true
                }
            }

            return false
        }

        var unmarkedTotal: Int {
            return rows.map { row in
                return row.filter{ !$0.on }.map { $0.value }.sum()
            }.sum()
        }
    }
    
    func part1(_ input: [String]) -> Int {
        let steps = input[0].toIntegerArray()
        let boards = (1...(input.count-1)).map { Board(input: input[$0]) }

        for step in steps {
            for board in boards {
                board.play(step)
                if board.isWinner {
                    return board.unmarkedTotal * step
                }
            }
        }
        
        return 0
    }

    func part2(_ input: [String]) -> Int {
        let steps = input[0].toIntegerArray()
        var boards = (1...(input.count-1)).map { Board(input: input[$0]) }

        for step in steps {
            for board in boards {
                board.play(step)
                if board.isWinner {
                    if boards.count == 1 {
                        return board.unmarkedTotal * step
                    } else {
                        boards = boards.filter { $0 != board }
                    }
                }
            }
        }

        return 0
    }
}
