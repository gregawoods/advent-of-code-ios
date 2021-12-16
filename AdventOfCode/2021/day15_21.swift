//
//  day15_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/14/21.
//

import Foundation

struct Y21Day15: DayProtocol {

    class Vert: Equatable, Hashable {
        let x: Int
        let y: Int
        let weight: Int
        var distance = Int.max
        var visited = false

        init(_ x: Int, _ y: Int, weight: Int) {
            self.x = x
            self.y = y
            self.weight = weight
        }

        static func == (lhs: Vert, rhs: Vert) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(x)
            hasher.combine(y)
        }

        func neighbors(in grid: Grid) -> [Vert] {
            let nearby = [
                (x - 1, y),
                (x + 1, y),
                (x, y - 1),
                (x, y + 1)
            ]
            return nearby.map { grid.find($0, $1) }.filter { $0 != nil }.map { $0! }
        }
    }

    class Grid {
        let verts: [[Vert]]

        init(source: [[Vert]]) {
            self.verts = source
        }

        lazy var width: Int = { return verts[0].count }()
        lazy var height: Int = { return verts.count }()
        lazy var count: Int = { return verts.flatMap { $0 }.count }()

        func find(_ x: Int, _ y: Int) -> Vert? {
            if x < 0 || y < 0 || x >= width || y >= height {
                return nil
            }
            return verts[y][x]
        }
    }

    func findLowestUnvisited(verts: Set<Vert>) -> Vert {
        var it: Vert = verts.randomElement()!
        var min = Int.max

        for v in verts where v.distance < min {
            it = v
            min = it.distance
        }

        return it
    }

    func dijkstra(grid: Grid) -> Int {
        grid.find(0, 0)!.distance = 0

        var toVisit: Set<Vert> = [grid.find(0, 0)!]

        for _ in 0...(grid.count - 1) {
            let current = findLowestUnvisited(verts: toVisit)

            toVisit.remove(current)
            current.visited = true

            for neighbor in current.neighbors(in: grid) {
                if neighbor.visited { continue }

                let newDistance = current.distance + neighbor.weight
                if newDistance < neighbor.distance {
                    neighbor.distance = newDistance
                    toVisit.insert(neighbor)
                }
            }
        }

        return grid.find(grid.width - 1, grid.height - 1)!.distance
    }

    func part1(_ input: [String]) -> Int {
        var verts = [[Vert]]()

        for y in 0...(input.count - 1) {
            verts.append(
                input[y].enumerated().map({ (x, char) in
                    let weight = Int(String(char))!
                    return Vert(x, y, weight: weight)
                })
            )
        }

        let grid = Grid(source: verts)

        return dijkstra(grid: grid)
    }

    func part2(_ input: [String]) -> Int {
        var verts: [[Vert]] = Array(repeating: [], count: input.count * 5)

        for i in 0...4 {
            for (y, row) in input.enumerated() {
                for j in 0...4 {
                    for (x, char) in row.enumerated() {
                        var weight = Int(String(char))! + i + j
                        weight = weight <= 9 ? weight : weight % 9
                        let dx = j * input[y].count + x
                        let dy = i * input.count + y

                        verts[i * input.count + y].append(Vert(dx, dy, weight: weight))
                    }
                }
            }
        }

        let grid = Grid(source: verts)

        return dijkstra(grid: grid)
    }
}
