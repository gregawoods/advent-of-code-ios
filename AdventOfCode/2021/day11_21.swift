//
//  day11_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/10/21.
//

import Foundation

struct Y21Day11: DayProtocol {

    func part1(_ input: [String]) -> Int {
        var grid: [[Int]] = []

        for (y, row) in input.enumerated() {
            grid.append([])

            for (x, char) in row.enumerated() {
                let val = Int(String(char))!
                grid[y].append(val)
            }
        }

        var flashes = 0

        for _ in 0...99 {
            flashes += runGrid(grid: &grid)
        }

        return flashes
    }

    func runGrid(grid: inout [[Int]]) -> Int {
        // increment all by 1
        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) {
                grid[y][x] += 1
            }
        }

        // check for flashes
        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) where grid[y][x] > 9 {
                grid[y][x] = 0
                grid = processNeighbors(grid: grid, x: x, y: y)
            }
        }

        // count and reset to 0
        var count = 0
        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) where grid[y][x] == 0 {
                count += 1
            }
        }

        return count
    }

    func processNeighbors(grid: [[Int]], x: Int, y: Int) -> [[Int]] {
        var g = grid

        let spotsToCheck = [
            (x - 1, y - 1),
            (x, y - 1),
            (x + 1, y - 1),
            (x - 1, y),
            (x + 1, y),
            (x - 1, y + 1),
            (x, y + 1),
            (x + 1, y + 1)
        ]

        for (x2, y2) in spotsToCheck {
            if x2 < 0 || y2 < 0 || y2 >= g.count || x2 >= g[0].count { continue }
            if g[y2][x2] == 0 { continue } // skip if already flashed

            g[y2][x2] += 1

            if g[y2][x2] > 9 {
                g[y2][x2] = 0
                g = processNeighbors(grid: g, x: x2, y: y2)
            }
        }

        return g
    }
    
    func part2(_ input: [String]) -> Int {
        var grid: [[Int]] = []

        for (y, row) in input.enumerated() {
            grid.append([])

            for (x, char) in row.enumerated() {
                let val = Int(String(char))!
                grid[y].append(val)
            }
        }

        var i = 0

        while true {
            i += 1
            _ = runGrid(grid: &grid)

            let all =  grid.flatMap { $0 }

            if all.allSatisfy({ $0 == 0 }) {
                return i
            }
        }

        return 0
    }
}
