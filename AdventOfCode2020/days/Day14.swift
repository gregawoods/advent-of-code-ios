//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/14/20.
//

import Foundation

struct Day14: DayProtocol {

    struct Computer {
        var mask: String = ""
        var memory: [Int: Int] = [:]
        var sum: Int {
            return Array(memory.values).sum()
        }

        mutating func process(line: String) {
            let parts = line.components(separatedBy: " = ")

            if parts[0] == "mask" {
                self.mask = parts[1]
            } else {
                let address = Int(
                    parts[0].replacingOccurrences(of: "mem[", with: "").replacingOccurrences(of: "]", with: "")
                )!
                self.memory[address] = translatedValue(value: Int(parts[1])!)
            }
        }

        func translatedValue(value: Int) -> Int {
            var binaryDigits = Array(String(value, radix: 2))

            repeat {
                binaryDigits.insert("0", at: 0)
            } while binaryDigits.count < 36

            var newDigits: [String] = []
            var index = 0

            for maskDigit in mask {
                if maskDigit == "1" || maskDigit == "0" {
                    newDigits.append(String(maskDigit))
                } else {
                    let digit = String(binaryDigits[index])
                    newDigits.append(digit)
                }
                index += 1
            }

            return Int(newDigits.joined(), radix: 2)!
        }
    }

    func calculatePart1(_ input: [String]) -> Int {
        var computer = Computer()

        for line in input {
            computer.process(line: line)
        }

        return computer.sum
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
