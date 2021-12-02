//
//  Day7.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/6/20.
//

import Foundation

struct Day7: DayProtocol {

    func findBagByColor(_ color: String, _ allBags: [BagDef]) -> BagDef {
        return allBags.first { $0.color == color }!
    }

    func part1(_ input: [String]) -> Int {
        var count = 0

        let bags = input.map { BagDef($0) }

        bags.forEach { (bag) in
            if searchChildren(haystack: bag.holdColors, needle: "shiny gold", allBags: bags) {
                count += 1
            }
        }

        return count
    }

    func searchChildren(haystack: [String], needle: String, allBags: [BagDef]) -> Bool {
        if haystack.contains("shiny gold") {
            return true
        }
        return haystack.contains { (color) -> Bool in
            let bag = findBagByColor(color, allBags)
            return searchChildren(haystack: bag.holdColors, needle: needle, allBags: allBags)
        }
    }

    func part2(_ input: [String]) -> Int {
        let bags = input.map { BagDef($0) }

        let goldBag = findBagByColor("shiny gold", bags)

        return countChildren(colors: goldBag.holds, allBags: bags)
    }

    func countChildren(colors: [String: Int], allBags: [BagDef]) -> Int {
        var total = 0

        for (color, count) in colors {
            total += count

            let bag = findBagByColor(color, allBags)
            let childCount = countChildren(colors: bag.holds, allBags: allBags)
            total += (count * childCount)
        }

        return total
    }

    struct BagDef {
        let color: String
        var holds: [String: Int]

        init(_ input: String) {
            self.color = input.components(separatedBy: " bags").first!
            self.holds = [:]

            if input.contains("no other bags") {
                return
            }

            let components = input.components(separatedBy: "contain ")
                .last!
                .components(separatedBy: ", ")

            components.forEach({ (line) in
                let parts = line.components(separatedBy: " ")
                let num = Int(parts.first!)
                let color = parts[1...(parts.count-2)].joined(separator: " ")
                self.holds[color] = num
            })
        }

        var holdColors: [String] {
            return Array(holds.keys)
        }
    }
}
