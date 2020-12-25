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

    class Tile: Equatable, Hashable {
        var black = true
        var white: Bool { !black }
        var x: Double
        var y: Double

        init(_ x: Double = 0, _ y: Double = 0) {
            self.x = x
            self.y = y
        }

        static func == (lhs: Tile, rhs: Tile) -> Bool {
            return lhs.x == rhs.x &&
                lhs.y == rhs.y
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(x)
            hasher.combine(y)
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

    func calculatePart1(_ input: [String]) -> Int {
        let lines = input.map { parseInstruction(input: $0) }
        var tiles: Set<Tile> = []

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

            if let tileIndex = tiles.firstIndex(of: Tile(x, y)) {
                tiles[tileIndex].black = !tiles[tileIndex].black
            } else {
                tiles.insert(Tile(x, y))
            }
        }

        return tiles.filter { $0.black }.count
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
