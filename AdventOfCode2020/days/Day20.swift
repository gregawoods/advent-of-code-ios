//
//  Day20.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/21/20.
//

import Foundation

struct Day20: DayProtocol {

    struct Point: Rotatable {
        var x: Int
        var y: Int
        var active: Bool

        init(_ x: Int = 0, _ y: Int = 0, _ active: Bool = false) {
            self.x = x
            self.y = y
            self.active = active
        }
    }

    struct Tile {
        let id: Int
        var grid: [Point]

        init(input: String) {
            let lines = input.components(separatedBy: "\n")

            self.id = Int(lines.first!.trimmingCharacters(in: CharacterSet(charactersIn: "Tile :")))!

            var grid: [Point] = []

            var y = 0
            for line in lines.dropFirst() {
                var x = 0
                for element in line {
                    grid.append(Point(x, y, element == "#"))
                    x += 1
                }
                y += 1
            }

            self.grid = grid
        }

        var topEdge: [Bool] {
            return grid.filter { $0.y == 0 }.sorted(by: { $0.x < $1.x }).map { $0.active }
        }
        var rightEdge: [Bool] {
            return grid.filter { $0.x == 9 }.sorted(by: { $0.y < $1.y }).map { $0.active }
        }
        var bottomEdge: [Bool] {
            return grid.filter { $0.y == 9 }.sorted(by: { $0.x < $1.x }).map { $0.active }
        }
        var leftEdge: [Bool] {
            return grid.filter { $0.x == 0 }.sorted(by: { $0.y < $1.y }).map { $0.active }
        }

        mutating func rotateRight() {
            self.grid = grid.map { point in
                var copy = point
                copy.rotate(degrees: 90, aroundX: 4.5, aroundY: 4.5)
                return copy
            }
        }

        mutating func rotateLeft() {
            self.grid = grid.map { point in
                var copy = point
                copy.rotate(degrees: -90, aroundX: 4.5, aroundY: 4.5)
                return copy
            }
        }

        mutating func flipX() {
            self.grid = grid.map { point in
                var copy = point
                let diff = (Double(point.x) - 4.5) * 2
                copy.x -= Int(diff)
                return copy
            }
        }

        mutating func flipY() {
            self.grid = grid.map { point in
                var copy = point
                let diff = (Double(point.y) - 4.5) * 2
                copy.y -= Int(diff)
                return copy
            }
        }

        func activeAt(_ x: Int, _ y: Int) -> Bool {
            let point = grid.first(where: { $0.x == x && $0.y == y })
            return point?.active ?? false
        }
    }

    func calculatePart1(_ input: [String]) -> Int {
        return 0
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
