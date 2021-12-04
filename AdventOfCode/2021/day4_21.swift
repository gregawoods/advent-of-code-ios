//
//  day4_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/3/21.
//

import Foundation

struct Y21_Day4 : DayProtocol {

    class Spot {
        let value: Int
        var on: Bool = false

        init(_ val: Int) {
            self.value = val
        }
    }

    struct Board: Equatable {
        let rows: [[Spot]]
        let id: Int
        
        init(id: Int, input: String) {
            self.id = id

            let lines = input.components(separatedBy: "\n").filter { $0 != "" }

            self.rows = lines.map { rowStr in
                let ints = rowStr.components(separatedBy: " ").filter{ $0 != "" }.map{
                    Int($0)!
                }
                return ints.map { Spot($0) }
            }
        }

        static func == (lhs: Y21_Day4.Board, rhs: Y21_Day4.Board) -> Bool {
            lhs.id == rhs.id
        }

        func play(_ val: Int) {
            for row in rows {
                for step in row {
                    if step.value == val {
                        step.on = true
                        return
                    }
                }
            }
        }

        var width: Int {
            if let first = rows.first {
                return first.count
            }
            return 0
        }

        var winner: Bool {
            if rows.count == 0 { return false }

            for row in rows {
                if row.allSatisfy({ $0.on }) {
                    return true
                }
            }

            for n in (0...(width-1)) {
                let spots = rows.map({ $0[n] })
                if spots.allSatisfy({ $0.on  }) {
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
    
    func part1(_ input: String) -> Int {
        let split = input.components(separatedBy: "\n\n")
        let steps = split[0].components(separatedBy: ",").map({
            return Int($0)!
        })

        let boards = (1...(split.count-1)).filter { split[$0] != "" }.map { n in
            Board(id: n, input: split[n])
        }

        for step in steps {
            for board in boards {
                board.play(step)
                if board.winner {
                    return board.unmarkedTotal * step
                }
            }
        }
        
        return 0
    }

    func part2(_ input: String) -> Int {
        let split = input.components(separatedBy: "\n\n")
        let steps = split[0].components(separatedBy: ",").map({
            return Int($0)!
        })

        var boards = (1...(split.count-1)).filter { split[$0] != "" }.map { n in
            Board(id: n, input: split[n])
        }

        for step in steps {
            for board in boards {
                board.play(step)
                if board.winner {
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
