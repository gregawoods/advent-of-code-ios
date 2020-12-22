//
//  Day12.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/11/20.
//

import Foundation
import CoreGraphics

struct Day12: DayProtocol {

    enum Dir: String {
        case N
        case E
        case S
        case W
    }

    class Ship {
        var dir = Dir.E
        var point: Point

        init(_ x: Int = 0, _ y: Int = 0) {
            self.point = Point(x, y)
        }

        func move(steps: Int, dir: Dir) {
            switch dir {
            case .N:
                point.y += steps
            case .E:
                point.x += steps
            case .S:
                point.y -= steps
            case .W:
                point.x -= steps
            }
        }

        let compass: [Dir] = [.N, .E, .S, .W]

        func turn(direction: String, degrees: Int) {
            let turns = degrees / 90 * (direction == "L" ? -1 : 1)
            let index = Int(compass.firstIndex(of: self.dir)!)
            var newIndex = index + turns

            if newIndex > 3 {
                newIndex -= 4
            } else if newIndex < 0 {
                newIndex += 4
            }

            self.dir = compass[newIndex]
        }

        func rotate(degrees: Int, direction: String, aroundX: Int, aroundY: Int) {
            let multiplier = direction == "R" ? -1 : 1

            point.rotate(degrees: degrees * multiplier, aroundX: Double(aroundX), aroundY: Double(aroundY))
        }

        var manhatten: Int {
            return abs(point.x) + abs(point.y)
        }

        var x: Int { point.x }
        var y: Int { point.y }
    }

    func calculatePart1(_ input: [String]) -> Int {
        let ship = Ship()

        for line in input {
            let instruction = String(line.first!)
            let value = Int(line.replacingOccurrences(of: instruction, with: ""))!

            switch instruction {
            case "F":
                ship.move(steps: value, dir: ship.dir)
            case "S", "N", "E", "W":
                let dir = Dir(rawValue: instruction)!
                ship.move(steps: value, dir: dir)
            case "R", "L":
                ship.turn(direction: instruction, degrees: value)
            default:
                print("umm, this isnt right")
            }
        }

        return ship.manhatten
    }

    func calculatePart2(_ input: [String]) -> Int {
        let ship = Ship()
        let waypoint = Ship(10, 1)

        for line in input {
            let instruction = String(line.first!)
            let value = Int(line.replacingOccurrences(of: instruction, with: ""))!

            switch instruction {
            case "F":
                let diffX = waypoint.x - ship.x
                let diffY = waypoint.y - ship.y
                for _ in 1...value {
                    ship.point.x = waypoint.x
                    ship.point.y = waypoint.y
                    waypoint.point.x += diffX
                    waypoint.point.y += diffY
                }
            case "S", "N", "E", "W":
                let dir = Dir(rawValue: instruction)!
                waypoint.move(steps: value, dir: dir)
            case "R", "L":
                waypoint.rotate(degrees: value, direction: instruction, aroundX: ship.x, aroundY: ship.y)
            default:
                print("umm, this isnt right")
            }
        }

        return ship.manhatten
    }
}
