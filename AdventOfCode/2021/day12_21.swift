//
//  day12_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/11/21.
//

import Foundation

extension String {
    var isAllLowercase: Bool {
        for char in self where char.isUppercase {
            return false
        }
        return true
    }
}

struct Y21Day12: DayProtocol {

    typealias CaveSystem = [String: [String]]

    func parseInput(_ input: [String]) -> CaveSystem {
        var caves: CaveSystem = [:]

        for line in input {
            let split = line.components(separatedBy: "-")
            let caveA = split[0]
            let caveB = split[1]

            if caves.keys.contains(caveA) {
                caves[caveA]?.append(caveB)
            } else {
                caves[caveA] = [caveB]
            }

            if caves.keys.contains(caveB) {
                caves[caveB]?.append(caveA)
            } else {
                caves[caveB] = [caveA]
            }
        }

        return caves
    }

    func part1(_ input: [String]) -> Int {
        let caves = parseInput(input)
        let result = explorePaths(current: "start", caves: caves, pathSoFar: [])
        return result.count
    }

    func explorePaths(current: String, caves: CaveSystem, pathSoFar: [String]) -> [[String]] {
        var p = pathSoFar
        p.append(current)

        var pathsFound: [[String]] = []

        for connection in caves[current]! {
            if connection == "end" {
                // we're done
                pathsFound.append(p)
            } else if connection.first!.isLowercase && pathSoFar.contains(connection) {
                // don't go into the same small cave twice
                continue
            } else {
                // keep exploring
                pathsFound.append(
                    contentsOf: explorePaths(current: connection, caves: caves, pathSoFar: p)
                )
            }
        }

        return pathsFound
    }

    func part2(_ input: [String]) -> Int {
        let caves = parseInput(input)
        let result = explorePathsV2(current: "start", caves: caves, pathSoFar: [])
        return result.count
    }

    func explorePathsV2(current: String, caves: CaveSystem, pathSoFar: [String], repeated: Bool = false) -> [[String]] {
        var p = pathSoFar
        p.append(current)

        var r = repeated
        if !r { r = hasRepeatedSmallCave(paths: p) }

        var pathsFound: [[String]] = []

        for connection in caves[current]! {
            if connection == "start" {
                // you cant go back to start
                continue
            } else if connection == "end" {
                // we're done
                pathsFound.append(p)
            } else if connection.first!.isLowercase && r && p.contains(connection) {
                // don't go into the same small cave twice
                continue
            } else {
                // keep exploring
                if r {
                    pathsFound.append(
                        contentsOf: explorePaths(current: connection, caves: caves, pathSoFar: p)
                    )
                } else {
                    pathsFound.append(
                        contentsOf: explorePathsV2(current: connection, caves: caves, pathSoFar: p, repeated: r)
                    )
                }
            }
        }

        return pathsFound
    }

    func hasRepeatedSmallCave(paths: [String]) -> Bool {
        var p2: [String] = []

        for item in paths {
            if item.first!.isUppercase { continue }
            if p2.contains(item) { return true }
            p2.append(item)
        }

        return false
    }
}
