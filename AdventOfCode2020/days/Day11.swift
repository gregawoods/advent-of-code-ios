//
//  Day11.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/11/20.
//

import Foundation

struct Day11: DayProtocol {

    enum Pos: String {
        case floor = "."
        case vacant = "L"
        case occ = "#"
    }

    init() {

    }

    var input: [String] {
        return FileReader(file: "day11").lines
    }

    func parseSeats(lines: [String]) -> [[Pos]] {
        let chart = lines.map { line in
            return line.map { Pos(rawValue: String($0))! }
        }
        return chart
    }

    func calculatePart1() -> Int {
        var chart = parseSeats(lines: input)

        repeat {
            let newChart = applyRules(chart: chart)
            if chart == newChart {
                let count = newChart.reduce([], +).filter({ $0 == .occ }).count
                return count
            } else {
                chart = newChart
            }
        } while true
    }

    func applyRules(chart: [[Pos]]) -> [[Pos]] {
        var newChart: [[Pos]] = []

        for row in chart.indices {
            newChart.append([])

            for col in chart[row].indices {
                let spot = chart[row][col]
                let adjacent = adjacentSpotsTaken(rowIndex: row, colIndex: col, chart: chart)
                if spot == .vacant && adjacent == 0 {
                    newChart[row].append(.occ)
                } else if spot == .occ && adjacent >= 4 {
                    newChart[row].append(.vacant)
                } else {
                    newChart[row].append(spot)
                }
            }
        }

        return newChart
    }

    func adjacentSpotsTaken(rowIndex: Int, colIndex: Int, chart: [[Pos]]) -> Int {
        var adjacent = 0

        for row in (rowIndex - 1)...(rowIndex + 1) {
            if row < 0 || row >= chart.count { continue }

            for col in (colIndex - 1)...(colIndex + 1) {
                if col < 0 || col >= chart[row].count { continue }
                if col == colIndex && row == rowIndex { continue }

                if chart[row][col] == .occ {
                    adjacent += 1
                }
            }
        }

        return adjacent
    }

    func applyRules2(chart: [[Pos]]) -> [[Pos]] {
        var newChart: [[Pos]] = []

        for row in chart.indices {
            newChart.append([])

            for col in chart[row].indices {
                let spot = chart[row][col]
                let adjacent = adjacentSpotsTaken2(rowIndex: row, colIndex: col, chart: chart)
                if spot == .vacant && adjacent == 0 {
                    newChart[row].append(.occ)
                } else if spot == .occ && adjacent >= 5 {
                    newChart[row].append(.vacant)
                } else {
                    newChart[row].append(spot)
                }
            }
        }

        return newChart
    }

    func adjacentSpotsTaken2(rowIndex: Int, colIndex: Int, chart: [[Pos]]) -> Int {
        var adjacent = 0

        let moves = [
            [-1, -1], [0, -1], [1, -1],
            [-1, 0], [1, 0],
            [-1, 1], [0, 1], [1, 1]
        ]

        for move in moves {
            let colMove = move[0]
            let rowMove = move[1]
            if let spot = nextSeatAt(
                row: rowIndex + rowMove,
                col: colIndex + colMove,
                rowMove: rowMove,
                colMove: colMove,
                chart: chart) {
                if spot == .occ {
                    adjacent += 1
                }
            }
        }

        return adjacent
    }

    func nextSeatAt(row: Int, col: Int, rowMove: Int, colMove: Int, chart: [[Pos]]) -> Pos? {
        if row < 0 || row >= chart.count || col < 0 || col >= chart[row].count {
            return nil
        }

        let spot = chart[row][col]

        if spot == .floor {
            return nextSeatAt(
                row: row + rowMove,
                col: col + colMove,
                rowMove: rowMove,
                colMove: colMove,
                chart: chart)
        } else {
            return spot
        }
    }

    func calculatePart2() -> Int {
        var chart = parseSeats(lines: input)

        repeat {
            let newChart = applyRules2(chart: chart)
            if chart == newChart {
                let count = newChart.reduce([], +).filter({ $0 == .occ }).count
                return count
            } else {
                chart = newChart
            }
        } while true
    }
}
