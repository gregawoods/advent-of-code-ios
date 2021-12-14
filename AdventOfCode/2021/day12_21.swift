//
//  day12_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/11/21.
//

import Foundation

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
        let result = explorePaths(caves)
        return result.count
    }

    func explorePaths(_ caves: CaveSystem, current: String = "start", pathSoFar: [String] = []) -> [[String]] {
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
                    contentsOf: explorePaths(caves, current: connection, pathSoFar: p)
                )
            }
        }

        return pathsFound
    }

    func part2(_ input: [String]) -> Int {
        let caves = parseInput(input)
        let result = explorePathsV2(caves)
        return result.count
    }

    func explorePathsV2(_ caves: CaveSystem, current: String = "start", pathSoFar: [String] = []) -> [[String]] {
        var p = pathSoFar
        p.append(current)

        var pathsFound: [[String]] = []

        for connection in caves[current]! {
            if connection == "start" {
                // you cant go back to start
                continue
            } else if connection == "end" {
                // we're done
                pathsFound.append(p)
            } else if connection.first!.isLowercase && p.contains(connection) {
                // now that we've repeated a small cave, switch to explore version 1
                pathsFound.append(
                    contentsOf: explorePaths(caves, current: connection, pathSoFar: p)
                )
            } else {
                // keep exploring
                pathsFound.append(
                    contentsOf: explorePathsV2(caves, current: connection, pathSoFar: p)
                )
            }
        }

        return pathsFound
    }
}
