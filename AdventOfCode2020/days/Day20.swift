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

    struct Tile: Equatable {
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

        static func == (lhs: Tile, rhs: Tile) -> Bool {
            return lhs.id == rhs.id
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

        func getEdge(_ edge: Edge) -> [Bool] {
            switch edge {
            case.top:
                return topEdge
            case .right:
                return rightEdge
            case .bottom:
                return bottomEdge
            case .left:
                return leftEdge
            }
        }

        var edges: [[Bool]] {
            return [topEdge, rightEdge, bottomEdge, leftEdge]
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

    enum Edge: CaseIterable {
        case top
        case right
        case bottom
        case left
    }

    struct Match {
        let tileA: Int
        let tileB: Int
        let edgeA: Edge
        let edgeB: Edge
    }

    func calculatePart1(_ input: [String]) -> Int {
        var matches: [Int: [Edge: [Int]]] = [:]

        let tiles = input.map { Tile(input: $0) }

        for tileA in tiles {
            var temp: [Edge: [Int]] = [
                .top: [],
                .right: [],
                .bottom: [],
                .left: []
            ]
            for tileB in tiles {
                if tileA == tileB { continue }
                for edgeA in Edge.allCases {
                    for edgeB in Edge.allCases {
                        if tileA.getEdge(edgeA) == tileB.getEdge(edgeB) || tileA.getEdge(edgeA).reversed() == tileB.getEdge(edgeB) {
                            temp[edgeA]!.append(tileB.id)
                        }
                    }
                }
            }
            matches[tileA.id] = temp
        }

        var corners: [Int] = []

        matches.forEach { (id, edges) in
            let unmatched = edges.values.filter({ $0.count == 0 }).count
            if unmatched == 2 {
                corners.append(id)
            }
        }

        return corners.reduce(1, { $0 * $1 })
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
