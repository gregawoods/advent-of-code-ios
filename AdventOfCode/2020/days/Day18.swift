//
//  Day18.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/18/20.
//

import Foundation

struct Day18: DayProtocol {

    enum Operand: Character {
        case add = "+"
        case multiply = "*"
    }

    /*
     * A formula Component is made up of 3 values:
     * - An operand, add or multiply. (The first component in a formula has an implied + operand, starting from 0)
     * - The initial, or raw, value.
     * - A list of subcomponents
     *
     * Examples:
     * +2 == add, initial 2, no subcomponents
     * *5 == multiply, initial 5, no subcomponents
     * + (5 * 10) == add, initial 0, two subcomponents comprising of add 5 and multiplty 10
     *
     * Components and subcomponents can grow infinitely with increasing levels of parenthesis
     *
     * Finding the sum total is a matter of recursively solving all components
     */
    class Component {
        let operand: Operand
        var initial: Int
        var subcomponents: [Component] = []

        init(_ operand: Operand, _ initial: Int) {
            self.operand = operand
            self.initial = initial
        }

        var sum: Int {
            return subcomponents.reduce(initial) { (current, component) -> Int in
                if component.operand == .add {
                    return current + component.sum
                } else {
                    return current * component.sum
                }
            }
        }

        var sumV2: Int {
            if subcomponents.count == 0 {
                return initial
            }

            var compacted: [Component] = []
            var c = subcomponents.first!

            // Solve all the adds first
            for index in 1...subcomponents.count-1 {
                let c2 = subcomponents[index]
                if c2.operand == .add {
                    c = Component(c2.operand, c.sumV2 + c2.sumV2)
                } else {
                    compacted.append(c)
                    c = c2
                }
            }
            compacted.append(c)

            // All thats left should be multiplies
            return compacted.reduce(1) { (x, y) -> Int in
                return x * y.sumV2
            }
        }
    }

    func parseEquation(_ line: String) -> Component {
        var nextOperand = Operand.add
        var componentStack: [Component] = [Component(.add, 0)]

        for char in line.replacingOccurrences(of: " ", with: "") {
            if char == "+" || char == "*" {
                nextOperand = Operand(rawValue: char)!
            } else if char == "(" {
                let newComponent = Component(nextOperand, 0)
                componentStack[componentStack.count - 1].subcomponents.append(newComponent)
                componentStack.append(newComponent)
                nextOperand = .add
            } else if char == ")" {
                componentStack = componentStack.dropLast()
            } else {
                let intVal = Int(String(char))!
                componentStack[componentStack.count - 1].subcomponents.append(
                    Component(nextOperand, intVal)
                )
            }
        }

        return componentStack.first!
    }

    func part1(_ input: [String]) -> Int {
        return input.reduce(0) { (sum, equation) in
            return sum + parseEquation(equation).sum
        }
    }

    func part2(_ input: [String]) -> Int {
        return input.reduce(0) { (sum, equation) in
            return sum + parseEquation(equation).sumV2
        }
    }
}
