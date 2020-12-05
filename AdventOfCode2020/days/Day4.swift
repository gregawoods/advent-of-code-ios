//
//  Day4.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/4/20.
//

import Foundation

struct Day4: DayProtocol {

    let passports: [Passport]

    init() {
        self.passports = FileReader(file: "day4").chunksByNewline.map { input in
            Passport(input: input)
        }
    }

    func calculatePart1() -> Int {
        return passports.countWhere { $0.hasRequiredFields }
    }

    func calculatePart2() -> Int {
        return passports.countWhere { $0.hasValidData }
    }

    typealias Validator = (String) -> Bool

    struct Passport {
        var data: [String: String]

        init(input: String) {
            self.data = [:]

            let splitters = CharacterSet(arrayLiteral: " ", "\n")

            input.components(separatedBy: splitters).forEach { (part) in
                let keyVal = part.components(separatedBy: ":")
                self.data[keyVal[0]] = keyVal[1]
            }
        }

        let validations: [String: Validator] = [
            "byr": { input in
                return (1920...2002).contains(Int(input)!)
            },
            "iyr": { input in
                return (2010...2020).contains(Int(input)!)
            },
            "eyr": { input in
                return (2020...2030).contains(Int(input)!)
            },
            "hgt": { input in
                if input.contains("cm") {
                    let val = Int(input.replacingOccurrences(of: "cm", with: ""))!
                    return (150...193).contains(val)
                } else if input.contains("in") {
                    let val = Int(input.replacingOccurrences(of: "in", with: ""))!
                    return (59...76).contains(val)
                }
                return false
            },
            "hcl": { input in
                return input.range(of: #"^#[\da-f]{6}$"#, options: .regularExpression) != nil
            },
            "ecl": { input in
                return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(input)
            },
            "pid": { input in
                return input.range(of: #"^\d{9}$"#, options: .regularExpression) != nil
            }
        ]

        var hasRequiredFields: Bool {
            let providedKeys = Set(data.keys)
            let requiredFields = Set(validations.keys)

            return requiredFields.isSubset(of: providedKeys)
        }

        var hasValidData: Bool {
            if !hasRequiredFields {
                return false
            }

            for item in data {
                if let validator = validations[item.key] {
                    let valid = validator(item.value)
                    if !valid {
                        return false
                    }
                }
            }

            return true
        }
    }
}
