//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/14/20.
//

import Foundation

struct Day14: DayProtocol {

    struct Line {
        var task: String
        var left: Int
        var right: String
    }

    class Computer {
        var mask: String = ""
        var memory: [Int: Int] = [:]
        var sum: Int {
            return Array(memory.values).sum()
        }

        func process(line: String) {
            let parsed = parseLine(line: line)

            if parsed.task == "mask" {
                self.mask = parsed.right
            } else {
                self.memory[parsed.left] = translatedValue(value: Int(parsed.right)!)
            }
        }

        func parseLine(line: String) -> Line {
            let parts = line.components(separatedBy: " = ")

            if parts[0] == "mask" {
                return Line(task: "mask", left: 0, right: parts[1])
            } else {
                let left = Int(
                    parts[0].replacingOccurrences(of: "mem[", with: "").replacingOccurrences(of: "]", with: "")
                )!
                return Line(task: "mem", left: left, right: parts[1])
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

    func part1(_ input: [String]) -> Int {
        let computer = Computer()

        for line in input {
            computer.process(line: line)
        }

        return computer.sum
    }

    class ComputerV2: Computer {
        override func process(line: String) {
            let parsed = parseLine(line: line)

            if parsed.task == "mask" {
                self.mask = parsed.right
            } else {
                let processed = preProcessMask(value: parsed.left)
                let addresses = maskToMemoryAddresses(inputMask: processed)
                let intVal = Int(parsed.right)!
                addresses.forEach { memory[$0] = intVal }
            }
        }

        func preProcessMask(value: Int) -> String {
            var binaryDigits = Array(String(value, radix: 2))

            repeat {
                binaryDigits.insert("0", at: 0)
            } while binaryDigits.count < 36

            var newDigits: [String] = []
            var index = 0

            for maskDigit in mask {
                if maskDigit == "X" || maskDigit == "1" {
                    newDigits.append(String(maskDigit))
                } else {
                    newDigits.append(String(binaryDigits[index]))
                }
                index += 1
            }

            return newDigits.joined()
        }

        func maskToMemoryAddresses(inputMask: String) -> [Int] {
            var digitArrays: [[String]] = []
            digitArrays.append([])

            for maskDigit in inputMask {
                if maskDigit == "X" {
                    let len = digitArrays.count
                    for n in 0...len-1 {
                        digitArrays[n].append("0")
                    }
                    for n in 0...len-1 {
                        var copy = digitArrays[n]
                        copy[copy.count-1] = "1"
                        digitArrays.append(copy)
                    }
                } else {
                    for n in 0...digitArrays.count-1 {
                        digitArrays[n].append(String(maskDigit))
                    }
                }
            }

            return digitArrays.map { Int($0.joined(), radix: 2)! }
        }
    }

    func part2(_ input: [String]) -> Int {
        let computer = ComputerV2()

        for line in input {
            computer.process(line: line)
        }

        return computer.sum
    }
}
