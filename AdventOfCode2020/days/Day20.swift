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

    class Tile: Equatable, Hashable {
        let id: Int
        var grid: [Point]

        var tTop: Tile?
        var tRight: Tile?
        var tBottom: Tile?
        var tLeft: Tile?
        
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

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
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

        func rotateRight() {
            self.grid = grid.map { point in
                var copy = point
                copy.rotate(degrees: 90, aroundX: 4.5, aroundY: 4.5)
                return copy
            }
        }

        func rotateLeft() {
            self.grid = grid.map { point in
                var copy = point
                copy.rotate(degrees: -90, aroundX: 4.5, aroundY: 4.5)
                return copy
            }
        }

        func flipX() {
            self.grid = grid.map { point in
                var copy = point
                let diff = (Double(point.x) - 4.5) * 2
                copy.x -= Int(diff)
                return copy
            }
        }

        func flipY() {
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

        var neighbor: Edge {
            switch self {
            case .top:
                return .bottom
            case .right:
                return .left
            case .bottom:
                return .top
            case .left:
                return .right
            }
        }
    }

    struct Match {
        let tileA: Int
        let tileB: Int
        let edgeA: Edge
        let edgeB: Edge
    }

    typealias MatchDict = [Tile: [Tile]]

    func buildMatches(tiles: [Tile]) -> MatchDict {
        var matches: MatchDict = [:]

        for tileA in tiles {
            var temp: [Tile] = []
            for tileB in tiles {
                if tileA == tileB { continue }
                for edgeA in Edge.allCases {
                    for edgeB in Edge.allCases {
                        let computedEdgeA = tileA.getEdge(edgeA)
                        let computedEdgeB = tileB.getEdge(edgeB)
                        if computedEdgeA == computedEdgeB || computedEdgeA.reversed() == computedEdgeB {
                            temp.append(tileB)
                        }
                    }
                }
            }
            matches[tileA] = temp
        }

        return matches
    }

    func calculatePart1(_ input: [String]) -> Int {
        let tiles = input.map { Tile(input: $0) }
        let matches = buildMatches(tiles: tiles)
        var corners: [Tile] = []

        matches.forEach { (tile, matches) in
            if matches.count == 2 {
                corners.append(tile)
            }
        }

        return corners.reduce(1, { $0 * $1.id })
    }

    func calculatePart2(_ input: [String]) -> Int {
        let tiles = input.map { Tile(input: $0) }
        let matches = buildMatches(tiles: tiles)

        rotateNeighborsRecursively(tile: tiles.first!, allMatches: matches)

        // Find top left and build grid system from there
        var anchor = tiles.first { tile in
            tile.tTop == nil && tile.tLeft == nil
        }!
        var current = anchor

        var xOffset = 0
        var yOffset = 0
        var image: [Point] = []

        // Combine all tiles into an image
        repeat {
            for point in current.grid {
                if point.x == 0 || point.x == 9 || point.y == 0 || point.y == 9 { continue }
                let newPoint = Point(point.x + xOffset - 1, point.y + yOffset - 1, point.active)
                image.append(newPoint)
            }
            if let nextTile = current.tRight {
                current = nextTile
                xOffset = image.last!.x
            } else if let nextTile = anchor.tBottom {
                anchor = nextTile
                current = nextTile
                xOffset = 0
                yOffset = image.last!.y
            } else {
                break
            }
        } while true

        return 0
    }

    func rotateNeighborsRecursively(tile tileA: Tile, allMatches: MatchDict) {
        if (tileA.tLeft != nil) || (tileA.tRight != nil) || (tileA.tTop != nil) || (tileA.tBottom != nil) { return }

        for tileB in allMatches[tileA]! {
            var matched = false
            repeat {
                for edgeA in Edge.allCases {
                    for _ in 1...4 {
                        let computedEdgeA = tileA.getEdge(edgeA)
                        let computedEdgeB = tileB.getEdge(edgeA.neighbor)
                        if computedEdgeA == computedEdgeB {
                            switch edgeA {
                            case .top:
                                tileA.tTop = tileB
                            case .right:
                                tileA.tRight = tileB
                            case .bottom:
                                tileA.tBottom = tileB
                            case .left:
                                tileA.tLeft = tileB
                            }
                            matched = true
                        } else if computedEdgeA == computedEdgeB.reversed() {
                            if edgeA == .left || edgeA == .right {
                                tileB.flipY()
                            } else {
                                tileB.flipX()
                            }
                            switch edgeA {
                            case .top:
                                tileA.tTop = tileB
                            case .right:
                                tileA.tRight = tileB
                            case .bottom:
                                tileA.tBottom = tileB
                            case .left:
                                tileA.tLeft = tileB
                            }
                            matched = true
                        } else {
                            tileB.rotateRight()
                        }
                    }
                }
            } while matched == false

            rotateNeighborsRecursively(tile: tileB, allMatches: allMatches)
        }
    }
    
//    func addPointsToImage(points: [Point], offsetX: Int, offsetY: Int) -> [Point] {
//        var newPoints = points
//
//        for point in
//
//        return newPoints
//    }

    // Rotates and flips tileB until it aligns with tileA
    // Then, returns the edge of the connection (relative to A)
    //
    func rotateTillAlligned(tileA: Tile, tileB: Tile) -> Edge {
        repeat {
            for edgeA in Edge.allCases {
                for _ in 1...4 {
                    let computedEdgeA = tileA.getEdge(edgeA)
                    let computedEdgeB = tileB.getEdge(edgeA.neighbor)
                    if computedEdgeA == computedEdgeB {
                        return edgeA
                    } else if computedEdgeA == computedEdgeB.reversed() {
                        if edgeA == .left || edgeA == .right {
                            tileB.flipY()
                        } else {
                            tileB.flipX()
                        }
                        return edgeA
                    }
                    tileB.rotateRight()
                }
            }
        } while true
    }
}
