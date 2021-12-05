//
//  day5_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/4/21.
//

import Foundation

struct Y21_Day5 : DayProtocol {

    struct Line {
        let x1: Int
        let y1: Int
        let x2: Int
        let y2: Int
        
        init(_ input: String) {
            let split = input.components(separatedBy: " -> ")
            
            let start = split[0].toIntegerArray()
            self.x1 = start[0]
            self.y1 = start[1]

            let end = split[1].toIntegerArray()
            self.x2 = end[0]
            self.y2 = end[1]
        }
        
        var horizontal: Bool {
            return y1 == y2
        }
        
        var vertical: Bool {
            return x1 == x2
        }
    }
    
    func buildGrid(lines: [Line]) -> [[Int]] {
        let width = lines.map { [$0.x1, $0.x2] }.flatMap { $0 }.max()!
        let height = lines.map { [$0.y1, $0.y2] }.flatMap { $0 }.max()!
        
        var grid:[[Int]] = []

        // popuplate grid with zeros
        for x in 0...height {
            grid.append([])
            for _ in 0...width {
                grid[x].append(0)
            }
        }

        return grid
    }

    func part1(_ input: [String]) -> Int {
        let lines = input.map { Line($0) }
        var grid = buildGrid(lines: lines)

        for line in lines {
            if line.horizontal {
                let range = line.x2 > line.x1 ? (line.x1...line.x2) : (line.x2...line.x1)
                for n in range {
                    grid[line.y1][n] += 1
                }
            } else if line.vertical {
                let range = line.y2 > line.y1 ? (line.y1...line.y2) : (line.y2...line.y1)
                for n in range {
                    grid[n][line.x1] += 1
                }
            } else {
                // Ignore
            }
        }

        return grid.map({ $0.countWhere { $0 > 1 } }).sum()
    }

    func part2(_ input: [String]) -> Int {
        let lines = input.map { Line($0) }
        var grid = buildGrid(lines: lines)

        for line in lines {
            if line.horizontal {
                let range = line.x2 > line.x1 ? (line.x1...line.x2) : (line.x2...line.x1)
                for n in range {
                    grid[line.y1][n] += 1
                }
            } else if line.vertical {
                let range = line.y2 > line.y1 ? (line.y1...line.y2) : (line.y2...line.y1)
                for n in range {
                    grid[n][line.x1] += 1
                }
            } else {
                let xStep = line.x2 > line.x1 ? 1 : -1
                var yArray: [Int] = []

                if line.y2 > line.y1 {
                    yArray = Array((line.y1...line.y2))
                } else {
                    yArray = Array(line.y2...line.y1).reversed()
                }

                var index = 0
                for x in stride(from: line.x1, through: line.x2, by: xStep) {
                    let y = yArray[index]
                    grid[y][x] += 1
                    index += 1
                }
            }
        }

        return grid.map({ $0.countWhere { $0 > 1 } }).sum()
    }
}
