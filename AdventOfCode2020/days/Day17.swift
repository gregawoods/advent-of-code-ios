//
//  Day17.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/17/20.
//

import Foundation

struct Day17: DayProtocol {

    struct Point: Equatable, Hashable {
        let x: Int
        let y: Int
        let z: Int
        var w: Int = 0
        var active: Bool

        init(_ x: Int, _ y: Int, _ z: Int, _ active: Bool = false) {
            self.x = x
            self.y = y
            self.z = z
            self.active = active
        }

        init(_ x: Int, _ y: Int, _ z: Int, _ w: Int, _ active: Bool = false) {
            self.x = x
            self.y = y
            self.z = z
            self.w = w
            self.active = active
        }

        static func == (lhs: Point, rhs: Point) -> Bool {
            return lhs.x == rhs.x &&
                lhs.y == rhs.y &&
                lhs.z == rhs.z &&
                lhs.w == rhs.w
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(x)
            hasher.combine(y)
            hasher.combine(z)
            hasher.combine(w)
        }
    }

    struct Grid {
        let width: Int
        let height: Int
        var points: Set<Point>

        init(input: [String]) {
            self.width = input.count
            self.height = input.first!.count
            self.points = []

            var y = 0
            for line in input {
                var x = 0
                for char in line {
                    points.insert(Point(x, y, 0, char == "#"))
                    x += 1
                }
                y += 1
            }
        }

        func activeAt(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0) -> Bool {
            if let index = points.firstIndex(of: Point(x, y, z, w)) {
                return points[index].active
            }
            return false
        }

        mutating func setActiveAt(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0, active: Bool) {
            points.remove(Point(x, y, z, w))

            points.insert(Point(x, y, z, w, active))
        }

        func activeNeighbors(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0) -> Int {
            var count = 0

            for nw in (w - 1)...(w + 1) {
                for nz in (z - 1)...(z + 1) {
                    for ny in (y - 1)...(y + 1) {
                        for nx in (x - 1)...(x + 1) {
                            if nw == w && nz == z && ny == y && nx == x { continue }

                            if activeAt(nx, ny, nz, nw) {
                                count += 1
                            }
                        }
                    }
                }
            }

            return count
        }

        var activePoints: Int {
            points.filter({ $0.active }).count
        }
        var minX: Int { points.map { $0.x }.min()! }
        var maxX: Int { points.map { $0.x }.max()! }
        var minY: Int { points.map { $0.y }.min()! }
        var maxY: Int { points.map { $0.y }.max()! }
        var minZ: Int { points.map { $0.z }.min()! }
        var maxZ: Int { points.map { $0.z }.max()! }
        var minW: Int { points.map { $0.w }.min()! }
        var maxW: Int { points.map { $0.z }.max()! }
    }

    func calculatePart1(_ input: [String]) -> Int {
        var grid = Grid(input: input)

        for _ in 0...5 {
            var newGrid = grid

            for x in grid.minX-1...grid.maxX+1 {
                for y in grid.minY-1...grid.maxY+1 {
                    for z in grid.minZ-1...grid.maxZ+1 {
                        let activeNeighbors = grid.activeNeighbors(x, y, z)

                        if grid.activeAt(x, y, z) {
                            if activeNeighbors != 2 && activeNeighbors != 3 {
                                newGrid.setActiveAt(x, y, z, active: false)
                            }
                        } else if activeNeighbors == 3 {
                            newGrid.setActiveAt(x, y, z, active: true)
                        }
                    }
                }
            }

            grid = newGrid
        }

        return grid.activePoints
    }

    func calculatePart2(_ input: [String]) -> Int {
        var grid = Grid(input: input)

        for _ in 0...5 {
            var newGrid = grid

            for x in grid.minX-1...grid.maxX+1 {
                for y in grid.minY-1...grid.maxY+1 {
                    for z in grid.minZ-1...grid.maxZ+1 {
                        for w in grid.minW-1...grid.maxW+1 {
                            let activeNeighbors = grid.activeNeighbors(x, y, z, w)

                            if grid.activeAt(x, y, z, w) {
                                if activeNeighbors != 2 && activeNeighbors != 3 {
                                    newGrid.setActiveAt(x, y, z, w, active: false)
                                }
                            } else if activeNeighbors == 3 {
                                newGrid.setActiveAt(x, y, z, w, active: true)
                            }
                        }
                    }
                }
            }

            grid = newGrid
        }

        return grid.activePoints
    }
}
