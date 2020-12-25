//
//  Day24.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/24/20.
//

import Foundation

struct Day24: DayProtocol {

    enum Move {
        case e
        case se
        case sw
        case w
        case nw
        case ne
    }

    struct Tile {
        var black = true

        mutating func flip() {
            self.black = !self.black
        }
    }

    func parseInstruction(input: String) -> [Move] {
        var previous: Character = "-"
        var moves: [Move] = []

        for char in input {
            if char == "e" {
                if previous == "s" {
                    moves.append(.se)
                } else if previous == "n" {
                    moves.append(.ne)
                } else {
                    moves.append(.e)
                }
            } else if char == "w" {
                if previous == "s" {
                    moves.append(.sw)
                } else if previous == "n" {
                    moves.append(.nw)
                } else {
                    moves.append(.w)
                }
            }

            previous = char
        }

        return moves
    }

    typealias TileDict = [[Double]: Tile]

    func runInitialMoves(_ input: [String]) -> TileDict {
        let lines = input.map { parseInstruction(input: $0) }
        var tiles: TileDict = [:]

        for line in lines {
            var x: Double = 0
            var y: Double = 0

            for move in line {
                switch move {
                case .e:
                    x += 1
                case .se:
                    x += 0.5
                    y -= 1
                case .sw:
                    x -= 0.5
                    y -= 1
                case .w:
                    x -= 1
                case .nw:
                    x -= 0.5
                    y += 1
                case .ne:
                    x += 0.5
                    y += 1
                }
            }

            if var tile = tiles[[x, y]] {
                tile.flip()
                tiles[[x, y]] = tile
            } else {
                tiles[[x, y]] = Tile()
            }
        }

        return tiles
    }

    func calculatePart1(_ input: [String]) -> Int {
        let tiles = runInitialMoves(input)

        return tiles.filter { $0.value.black }.count
    }

    func calculatePart2(_ input: [String]) -> Int {
        var tiles = runInitialMoves(input)

        for _ in 0...99 {
            tiles = runFlipLogic(dict: tiles)
        }

        return tiles.filter { $0.value.black }.count
    }

    func neighborsFromPoint(_ point: [Double]) -> [[Double]] {
        let x = point.first!
        let y = point.last!
        return [
            [x - 1, y],
            [x - 0.5, y + 1],
            [x + 0.5, y + 1],
            [x + 1, y],
            [x + 0.5, y - 1],
            [x - 0.5, y - 1]
        ]
    }

    func runFlipLogic(dict: TileDict) -> TileDict {
        var newDict = dict

        var whiteTilesToCheck: Set<[Double]> = []

        for (key, tile) in dict.filter({ $0.value.black }) {
            let neighbors = neighborsFromPoint(key)
            let blackNeighbors = neighbors.countWhere { point in
                if let tile = dict[point], tile.black {
                    return true
                } else {
                    whiteTilesToCheck.insert(point)
                    return false
                }
            }
            if blackNeighbors == 0 || blackNeighbors > 2 {
                var newTile = tile
                newTile.flip()
                newDict[key] = newTile
            }
        }

        whiteTilesToCheck.forEach { key in
            let neighbors = neighborsFromPoint(key)
            let blackNeighbors = neighbors.countWhere { point in
                return dict[point]?.black ?? false
            }
            if blackNeighbors == 2 {
                newDict[key] = Tile()
            }
        }

        return newDict
    }
}
