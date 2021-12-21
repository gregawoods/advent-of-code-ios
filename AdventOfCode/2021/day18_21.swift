//
//  day18_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/20/21.
//

import Foundation

struct Y21Day18: DayProtocol {

    class Node {
        var rawValue: Int?
        var parent: Node?

        var left: Node? {
            didSet {
                if let n = left {
                    n.parent = self
                }
            }
        }

        var right: Node? {
            didSet {
                if let n = right {
                    n.parent = self
                }
            }
        }

        init(_ raw: Int) {
            self.rawValue = raw
        }

        init() {}

        static func parse(pattern: String) -> Node {
            var current = Node()
            let chars = pattern.filter { $0 != "," }.dropFirst().dropLast()

            for char in chars {
                if char == "[" {
                    let newNode = Node()

                    if current.left == nil {
                        current.left = newNode
                    } else {
                        current.right = newNode
                    }
                    current = newNode
                } else if char == "]" {
                    if let p = current.parent {
                        current = p
                    }
                } else if let num = Int(String(char)) {
                    let newNode = Node(num)

                    if current.left == nil {
                        current.left = newNode
                    } else {
                        current.right = newNode
                    }
                }
            }

            return current
        }

        var toString: String {
            if let raw = rawValue {
                return String(raw)
            } else {
                return "[\(left!.toString),\(right!.toString)]"
            }
        }

        var allNodes: [Node] {
            if isRaw {
                return [self]
            } else {
                return [[self], left!.allNodes, right!.allNodes].flatMap { $0 }
            }
        }

        var depth: Int {
            var d = 0
            var p = parent
            while p != nil {
                d += 1
                p = p?.parent
            }
            return d
        }

        var magnitude: Int {
            if let raw = rawValue {
                return raw
            } else {
                return (left!.magnitude * 3) + (right!.magnitude * 2)
            }
        }

        var isRaw: Bool {
            return rawValue != nil
        }
    }

    @discardableResult func process(node topNode: Node) -> Bool {
        let allNodes = topNode.allNodes

        for (n, node) in allNodes.enumerated() {
            if node.depth >= 4 && !node.isRaw {
//                print("explode \(node.toString)")

                // Add to the left
                var k = n - 1
                while k >= 0 {
                    let p2 = allNodes[k]
                    if p2.isRaw {
                        p2.rawValue! += node.left!.rawValue!
                        break
                    } else {
                        k -= 1
                    }
                }

                // Add to the right
                var j = n + 3
                while j < allNodes.count {
                    let p2 = allNodes[j]
                    if p2.isRaw {
                        p2.rawValue! += node.right!.rawValue!
                        break
                    } else {
                        j += 1
                    }
                }

                // Set the node value to 0
                node.left = nil
                node.right = nil
                node.rawValue = 0
                return true
            }
        }

        for node in allNodes {
            if let raw = node.rawValue, raw >= 10 {
                // Split it into two rounded values
//                print("split! \(node.toString)")
                let div = Double(node.rawValue!) / 2.0
                node.left = Node(Int(floor(div)))
                node.right = Node(Int(ceil(div)))
                node.rawValue = nil
                return true
            }
        }

//        print("done")
        return false
    }

    func processFully(node: Node) {
//        print(node.toString)

        while true {
            let didWork = process(node: node)
//            print(node.toString)
            if !didWork { break }
        }
    }

    func add(a: String, b: String) -> Node {
        let node = Node.parse(pattern: "[\(a),\(b)]")
        processFully(node: node)
        return node
    }

    func part1(_ input: [String]) -> Int {
        var node = Node.parse(pattern: input[0])

        for n in 1...(input.count - 1) {
            node = add(a: node.toString, b: input[n])
        }

        return node.magnitude
    }

    func part2(_ input: [String]) -> Int {
        var mag = 0

        for (i, lineA) in input.enumerated() {
            for (j, lineB) in input.enumerated() {
                if i == j { continue }

                let newMagnitude = add(a: lineA, b: lineB).magnitude
                mag = newMagnitude > mag ? newMagnitude : mag
            }
        }

        return mag
    }
}
