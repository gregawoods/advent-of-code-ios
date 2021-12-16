//
//  day15_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/14/21.
//

import Foundation

struct Y21Day15: DayProtocol {

    struct Vert {
        let weight: Int
        var visited = false
        var distance = Int.max

        init(weight: Int) {
            self.weight = weight
        }
    }

    typealias Position = (x: Int, y: Int)

    func findLowestUnvisited(verts: [[Vert]]) -> Position {
        var cx = 0
        var cy = 0
        var min = Int.max

        for y in 0...(verts.count - 1) {
            for x in 0...(verts[y].count - 1) {
                if !verts[y][x].visited && verts[y][x].distance < min {
                    cx = x
                    cy = y
                    min = verts[y][x].distance
                }
            }
        }

        return (cx, cy)
    }

    func dijkstra(grid source: [[Vert]]) -> Int {
        var grid = source

        grid[0][0].visited = true
        grid[0][0].distance = 0

        let iterations = grid.count * grid[0].count

        for _ in 0...(iterations - 1) {
            let position = findLowestUnvisited(verts: grid)
            grid[position.y][position.x].visited = true

            if position.y == grid.count - 1 && position.x == grid[0].count - 1 {
                break
            }

            let nearby: [Position] = [
                (position.x - 1, position.y),
                (position.x + 1, position.y),
                (position.x, position.y - 1),
                (position.x, position.y + 1)
            ].filter { (x, y) in
                return x >= 0 && y >= 0 && x < grid[0].count && y < grid.count && !grid[y][x].visited
            }

            for neighbor in nearby {
                let newDistance = grid[position.y][position.x].distance + grid[neighbor.y][neighbor.x].weight

                if newDistance < grid[neighbor.y][neighbor.x].distance {
                    grid[neighbor.y][neighbor.x].distance = newDistance
                }
            }
        }

        return grid[grid.count - 1][grid[0].count - 1].distance
    }

    func part1(_ input: [String]) -> Int {
        var grid = [[Vert]]()

        for row in input {
            grid.append(
                row.map({ char in
                    return Vert(weight: Int(String(char))!)
                })
            )
        }

        return dijkstra(grid: grid)
    }

    func part2(_ input: [String]) -> Int {
        var grid: [[Vert]] = Array(repeating: [], count: input.count * 5)

        for i in 0...4 {
            for (y, row) in input.enumerated() {
                for j in 0...4 {
                    for char in row {
                        var weight = Int(String(char))! + i + j
                        weight = weight <= 9 ? weight : weight % 9
                        grid[i * input.count + y].append(Vert(weight: weight))
                    }
                }
            }
        }

        return dijkstra(grid: grid)
    }
}
