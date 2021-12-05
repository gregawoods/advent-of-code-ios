//
//  day5_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/4/21.
//

import Foundation

struct Y21_Day5 : DayProtocol {
    
    func parseLine(_ input: String) -> Line {
        let split = input.components(separatedBy: " -> ")
        let start = split[0].toIntegerArray()
        let end = split[1].toIntegerArray()

        return Line(x1: start[0], y1: start[1], x2: end[0], y2: end[1])
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
        let lines = input.map { parseLine($0) }
        var grid = buildGrid(lines: lines)

        for line in lines {
            if line.vertical || line.horizontal {
                for point in line.stride {
                    grid[point.y][point.x] += 1
                }
            }
        }

        return grid.map({ $0.countWhere { $0 > 1 } }).sum()
    }

    func part2(_ input: [String]) -> Int {
        let lines = input.map { parseLine($0) }
        var grid = buildGrid(lines: lines)

        for line in lines {
            for point in line.stride {
                grid[point.y][point.x] += 1
            }
        }

        return grid.map({ $0.countWhere { $0 > 1 } }).sum()
    }
}
