//
//  Day21.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/21/20.
//

import Foundation

struct Day21: DayProtocol {

    typealias AllergenDict = [String: Set<String>]

    func calculatePart1(_ input: [String]) -> Int {

        var dict: AllergenDict = [:]
        var allIngrediants: Set<String> = []

        for line in input {
            let parts = line.components(separatedBy: " (contains ")
            let ingrediants = Set(parts[0].components(separatedBy: " "))
            let allergens = parts[1].replacingOccurrences(of: ")", with: "").components(separatedBy: ", ")

            for allergen in allergens {
                if dict[allergen] == nil {
                    dict[allergen] = ingrediants
                } else {
                    dict[allergen] = dict[allergen]!.intersection(ingrediants)
                }
            }

            allIngrediants = allIngrediants.union(ingrediants)
        }

        let allergenic = Set(dict.values.flatMap { $0 })
        let nonAllergenic = allIngrediants.subtracting(allergenic)

        return nonAllergenic.reduce(0, { (current, ingrediant) in
            return current + input.countWhere { $0.components(separatedBy: " ").contains(ingrediant) }
        })
    }

    func calculatePart2(_ input: [String]) -> String {
        var dict: AllergenDict = [:]

        for line in input {
            let parts = line.components(separatedBy: " (contains ")
            let ingrediants = Set(parts[0].components(separatedBy: " "))
            let allergens = parts[1].replacingOccurrences(of: ")", with: "").components(separatedBy: ", ")

            for allergen in allergens {
                if dict[allergen] == nil {
                    dict[allergen] = ingrediants
                } else {
                    dict[allergen] = dict[allergen]!.intersection(ingrediants)
                }
            }
        }

        repeat {
            dict = reduceAllergens(dict: dict)
        } while !dict.values.allSatisfy { $0.count == 1 }

        return dict.keys.sorted().reduce([], { current, key in
            return current + dict[key]!
        }).joined(separator: ",")
    }

    func reduceAllergens(dict: AllergenDict) -> AllergenDict {
        var newDict = dict
        let solvedList = dict.filter { $1.count == 1 }

        solvedList.forEach { key, val in
            let elementsWithIngrediant = newDict.filter { $0 != key && $1.contains(val.first!) }
            elementsWithIngrediant.forEach { innerKey, innerVal in
                newDict[innerKey] = innerVal.subtracting(val)
            }
        }

        return newDict
    }
}
