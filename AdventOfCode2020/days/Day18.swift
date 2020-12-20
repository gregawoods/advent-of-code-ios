//
//  Day18.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/18/20.
//

import Foundation

//protocol Day18Computable {
//    var operand: Day18.Operand { get }
//    var value: Int { get }
//}

struct Day18: DayProtocol {

//    typealias Computable = Day18Computable
//    struct Component: Computable {
//        let operand: Operand
//        let value: Int
//    }
//
//    struct NestedComponent: Computable {
//        let operand: Operand
//        var components: [Component] = []
//
//        var value: Int {
//            return 0 // add up sub components
//        }
//    }

    enum Operand: Character {
        case add = "+"
        case multiply = "*"
    }

    class Component {
        let operand: Operand
        let initial: Int
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

    func calculatePart1(_ input: [String]) -> Int {
        return input.reduce(0) { (sum, equation) in
            return sum + parseEquation(equation).sum
        }
    }

    func calculatePart2(_ input: [String]) -> Int {
        return 0
    }
}
