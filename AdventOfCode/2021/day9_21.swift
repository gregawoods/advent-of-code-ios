//
//  day9_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/8/21.
//

import Foundation
import SwiftUI

struct Y21Day9: DayProtocol {

    func part1(_ input: [String]) -> Int {
        let grid = buildGrid(input)
        var sum = 0

        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) {
                let element = grid[y][x]

                if let left = grid.get(y)?.get(x - 1), left <= element { continue }
                if let right = grid.get(y)?.get(x + 1), right <= element { continue }
                if let top = grid.get(y - 1)?.get(x), top <= element { continue }
                if let bottom = grid.get(y + 1)?.get(x), bottom <= element { continue }

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

                if let left = grid.get(y)?.get(x - 1), left <= element { continue }
                if let right = grid.get(y)?.get(x + 1), right <= element { continue }
                if let top = grid.get(y - 1)?.get(x), top <= element { continue }
                if let bottom = grid.get(y + 1)?.get(x), bottom <= element { continue }

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
        neighbors.insert(Point(x, y))

        if !neighbors.contains(Point(x - 1, y)), let val = grid.get(y)?.get(x - 1), val != 9 {
            neighbors = neighbors.union(findNeighbors(x: x - 1, y: y, grid: grid, neighbors: neighbors))
        }

        if !neighbors.contains(Point(x + 1, y)), let val = grid.get(y)?.get(x + 1), val != 9 {
            neighbors = neighbors.union(findNeighbors(x: x + 1, y: y, grid: grid, neighbors: neighbors))
        }

        if !neighbors.contains(Point(x, y - 1)), let val = grid.get(y - 1)?.get(x), val != 9 {
            neighbors = neighbors.union(findNeighbors(x: x, y: y - 1, grid: grid, neighbors: neighbors))
        }

        if !neighbors.contains(Point(x, y + 1)), let val = grid.get(y + 1)?.get(x), val != 9 {
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
