//
//  Day7.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/6/20.
//

import Foundation

struct Day7: DayProtocol {

    let bags: [BagDef]

    init() {
        self.bags = FileReader(file: "day7").lines.map { BagDef(input: $0) }
    }

    func findBagByColor(_ color: String) -> BagDef {
        return self.bags.first { $0.color == color }!
    }

    func calculatePart1() -> Int {
        var count = 0

        bags.forEach { (bag) in
            if searchChildren(haystack: bag.holdColors, needle: "shiny gold") {
                count += 1
            }
        }

        return count
    }

    func searchChildren(haystack: [String], needle: String) -> Bool {
        if haystack.contains("shiny gold") {
            return true
        } else if haystack.count > 0 {
            return haystack.contains { (color) -> Bool in
                let bag = findBagByColor(color)
                return searchChildren(haystack: bag.holdColors, needle: needle)
            }
        }
        return false
    }

    func calculatePart2() -> Int {
        let goldBag = findBagByColor("shiny gold")

        return countChildren(colors: goldBag.holds)
    }

    func countChildren(colors: [String: Int]) -> Int {
        var total = 0

        for (color, count) in colors {
            total += count

            let bag = findBagByColor(color)
            let childCount = countChildren(colors: bag.holds)
            total += (count * childCount)
        }

        return total
    }

    struct BagDef {
        let color: String
        var holds: [String: Int]

        init(input: String) {
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
