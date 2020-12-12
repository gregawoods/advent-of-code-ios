//
//  Day8.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/8/20.
//

import Foundation

struct Day8: DayProtocol {

    func calculatePart1(_ input: [String]) -> Int {
        var game = Game(input)
        game.play()

        return game.accumulator
    }

    func calculatePart2(_ input: [String]) -> Int {
        return calculateFixedGame(lines: input)
    }

    func calculateFixedGame(lines: [String]) -> Int {
        for n in 0...(lines.count - 1) {
            var tempInput = lines

            if tempInput[n].contains("jmp") {
                tempInput[n] = tempInput[n].replacingOccurrences(of: "jmp", with: "nop")
            } else if tempInput[n].contains("nop") {
                tempInput[n] = tempInput[n].replacingOccurrences(of: "nop", with: "jmp")
            }

            var game = Game(tempInput)
            game.play()

            if game.terminated {
                return game.accumulator
            }
        }

        return 0
    }

    enum Action: String {
        case nop
        case acc
        case jmp
    }

    struct Instruction: Equatable {
        let action: Action
        let value: Int
    }

    struct Game {
        let instructions: [Instruction]
        var position = 0
        var accumulator = 0

        init(_ input: [String]) {
            self.instructions = input.map { line in
                let action = Action(
                    rawValue: line.components(separatedBy: " ")[0]
                )!
                var value = Int(line.components(separatedBy: CharacterSet.decimalDigits.inverted).last!)!
                if line.contains("-") {
                    value *= -1
                }
                return Instruction(action: action, value: value)
            }
        }

        mutating func play() {
            var visited: [Int] = []

            repeat {
                visited.append(position)
                let instruction = instructions[position]

                switch instruction.action {
                case .nop:
                    position += 1
                case .acc:
                    position += 1
                    accumulator += instruction.value
                case .jmp:
                    position += instruction.value
                }

            } while position < instructions.count && !visited.contains(position)
        }

        var terminated: Bool {
            return position >= instructions.count
        }
    }
}
