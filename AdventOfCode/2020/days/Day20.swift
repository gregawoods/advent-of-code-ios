//
//  Day20.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/21/20.
//

import Foundation

// swiftlint:disable type_body_length
struct Day20: DayProtocol {

    struct Point: Coordinate {
        var x: Int
        var y: Int
        var active: Bool

        init(_ x: Int, _ y: Int) {
            self.init(x, y, false)
        }

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

        init(rawGrid: [Point]) {
            self.id = 0
            self.grid = rawGrid
        }

        static func == (lhs: Tile, rhs: Tile) -> Bool {
            return lhs.id == rhs.id
        }

        func debug() {
            var debug: String = ""
            for y in 0...maxY {
                for x in 0...maxX {
                    let char = activeAt(x, y) ? "#" : "."
                    debug += char
                }
                debug += "\n"
            }
            print(debug)
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        var topEdge: [Bool] {
            return grid.filter { $0.y == 0 }.sorted(by: { $0.x < $1.x }).map { $0.active }
        }
        var rightEdge: [Bool] {
            return grid.filter { $0.x == maxX }.sorted(by: { $0.y < $1.y }).map { $0.active }
        }
        var bottomEdge: [Bool] {
            return grid.filter { $0.y == maxY }.sorted(by: { $0.x < $1.x }).map { $0.active }
        }
        var leftEdge: [Bool] {
            return grid.filter { $0.x == 0 }.sorted(by: { $0.y < $1.y }).map { $0.active }
        }

        lazy var maxX: Int  = {
            return grid.map { $0.x }.max()!
        }()
        lazy var maxY: Int = {
            return grid.map { $0.y }.max()!
        }()
        lazy var midX: Double = {
            return Double(maxX) / 2.0
        }()
        lazy var midY: Double = {
            return Double(maxY) / 2.0
        }()

        var activeCount: Int {
            return grid.countWhere { $0.active }
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
                copy.rotate(degrees: 90, aroundX: midX, aroundY: midY)
                return copy
            }
        }

        func rotateLeft() {
            self.grid = grid.map { point in
                var copy = point
                copy.rotate(degrees: -90, aroundX: midX, aroundY: midY)
                return copy
            }
        }

        func flipX() {
            self.grid = grid.map { point in
                var copy = point
                let diff = (Double(point.x) - midX) * 2
                copy.x -= Int(diff)
                return copy
            }
        }

        func flipY() {
            self.grid = grid.map { point in
                var copy = point
                let diff = (Double(point.y) - midY) * 2
                copy.y -= Int(diff)
                return copy
            }
        }

        func activeAt(_ x: Int, _ y: Int) -> Bool {
            let point = grid.first(where: { $0.x == x && $0.y == y })
            return point?.active ?? false
        }

        func setActiveAt(_ x: Int, _ y: Int, active: Bool) {
            guard let index = grid.firstIndex(where: { $0.x == x && $0.y == y }) else { return }
            grid[index].active = active
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

    func part1(_ input: [String]) -> Int {
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

    func part2(_ input: [String]) -> Int {
        let tiles = input.map { Tile(input: $0) }

        // Search for sides that match
        let matches = buildMatches(tiles: tiles)

        // Rotate tiles until they are lined up
        rotateNeighborsRecursively(tile: tiles.first!, allMatches: matches)

        // Find top left and build grid system from there
        var anchor = tiles.first { tile in
            tile.tTop == nil && tile.tLeft == nil
        }!
        var current = anchor

        let step = 8
        var xOffset = 0
        var yOffset = 0
        var allPoints: [Point] = []

        // Combine all tiles into an image, slicing out the "outer" portion of each tile
        repeat {
            for point in current.grid {
                if point.x == 0 || point.x == 9 || point.y == 0 || point.y == 9 { continue }
                let newPoint = Point(point.x + xOffset - 1, point.y + yOffset - 1, point.active)
                allPoints.append(newPoint)
            }
            if let nextTile = current.tRight {
                current = nextTile
                xOffset += step
            } else if let nextTile = anchor.tBottom {
                anchor = nextTile
                current = nextTile
                xOffset = 0
                yOffset += step
            } else {
                break
            }
        } while true

        let image = Tile(rawGrid: allPoints)

        // Rotate and flip the image until we find some monsters
        for n in 0...7 {
            if let found = searchForMonsters(image: image) {
                found.forEach { coord in
                    image.setActiveAt(coord[0], coord[1], active: false)
                }
                break
            }
            image.rotateRight()
            if n == 3 {
                image.flipY()
            }
        }

        return image.activeCount
    }

    // Starting with a corner tile, we rotate and flip neighboring tiles until they match up
    // Continue rotating neighbors recursively
    // swiftlint:disable cyclomatic_complexity
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

    // Search every point for a monster
    func searchForMonsters(image: Tile) -> [[Int]]? {
        let maxX = image.maxX
        let maxY = image.maxY
        let cache: Cache<[Int], Bool> = Cache()
        var monsters: [[Int]] = []

        for x in 0...maxX {
            for y in 0...maxY {
                let coords = coordsForMonster(x: x, y: y)
                if coords.allSatisfy({ set in
                    return cache.fetch(key: set, { image.activeAt(set[0], set[1]) })
                }) {
                    monsters += coords
                }
            }
        }

        return monsters.count > 0 ? monsters : nil
    }

    // Coordinates for a monster given an origin point
    func coordsForMonster(x: Int, y: Int) -> [[Int]] {
        return [
            [x, y],
            [x + 1, y + 1],
            [x + 4, y + 1],
            [x + 5, y],
            [x + 6, y],
            [x + 7, y + 1],
            [x + 10, y + 1],
            [x + 11, y],
            [x + 12, y],
            [x + 13, y + 1],
            [x + 16, y + 1],
            [x + 17, y],
            [x + 18, y],
            [x + 18, y - 1],
            [x + 19, y]
        ]
    }
}
