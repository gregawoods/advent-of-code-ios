//
//  day9_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/8/21.
//

import Foundation

struct Y21Day9: DayProtocol {

    func part1(_ input: [String]) -> Int {
        let grid = buildGrid(input)
        var sum = 0

        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) {
                let element = grid[y][x]

                if x > 0 {
                    let left = grid[y][x - 1]
                    if left <= element { continue }
                }

                if x < (grid[y].count - 1) {
                    let right = grid[y][x + 1]
                    if right <= element { continue }
                }

                if y > 0 {
                    let top = grid[y - 1][x]
                    if top <= element { continue }
                }

                if y < (grid.count - 1) {
                    let bottom = grid[y + 1][x]
                    if bottom <= element { continue }
                }

                sum += (element + 1)
            }
        }

        return sum
    }

    func part2(_ input: [String]) -> Int {
        let grid = buildGrid(input)
        var basins: [Int] = []

        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) {
                let element = grid[y][x]

                if x > 0 {
                    let left = grid[y][x - 1]
                    if left <= element { continue }
                }

                if x < (grid[y].count - 1) {
                    let right = grid[y][x + 1]
                    if right <= element { continue }
                }

                if y > 0 {
                    let top = grid[y - 1][x]
                    if top <= element { continue }
                }

                if y < (grid.count - 1) {
                    let bottom = grid[y + 1][x]
                    if bottom <= element { continue }
                }

                let n = findNeighbors(x: x, y: y, grid: grid)
                basins.append(n.count)
            }
        }

        basins = basins.sorted()

        let top3 = basins[(basins.count-3)...(basins.count-1)]

        return top3.reduce(1) { $0 * $1 }
    }

    func findNeighbors(x: Int, y: Int, grid: [[Int]], neighbors n: Set<Point> = []) -> Set<Point> {
        var neighbors = n

        if x > 0 && grid[y][x - 1] != 9 && !neighbors.contains(Point(x - 1, y)) {
            neighbors.insert(Point(x - 1, y))
            neighbors = neighbors.union(findNeighbors(x: x - 1, y: y, grid: grid, neighbors: neighbors))
        }

        if x < (grid[y].count - 1) && grid[y][x + 1] != 9 && !neighbors.contains(Point(x + 1, y)) {
            neighbors.insert(Point(x + 1, y))
            neighbors = neighbors.union(findNeighbors(x: x + 1, y: y, grid: grid, neighbors: neighbors))
        }

        if y > 0 && grid[y - 1][x] != 9 && !neighbors.contains(Point(x, y - 1)) {
            neighbors.insert(Point(x, y - 1))
            neighbors = neighbors.union(findNeighbors(x: x, y: y - 1, grid: grid, neighbors: neighbors))
        }

        if y < (grid.count - 1) && grid[y + 1][x] != 9 && !neighbors.contains(Point(x, y + 1)) {
            neighbors.insert(Point(x, y + 1))
            neighbors = neighbors.union(findNeighbors(x: x, y: y + 1, grid: grid, neighbors: neighbors))
        }

        return neighbors
    }

    func buildGrid(_ input: [String]) -> [[Int]] {
        var grid: [[Int]] = []

        for row in input {
            grid.append([])

            for char in row {
                grid[grid.count - 1].append(Int(String(char))!)
            }
        }

        return grid
    }
}
