//
//  Day12.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/11/20.
//

import Foundation
import CoreGraphics

struct Day12: DayProtocol {

    let lines: [String]

    init() {
        self.lines = FileReader(file: "day12").lines
    }

    enum Dir: String {
        case N
        case S
        case E
        case W
    }

    class Ship {
        var dir = Dir.E
        var x = 0
        var y = 0

        init(_ x: Int = 0, _ y: Int = 0) {
            self.x = x
            self.y = y
        }

        func move(steps: Int, dir: Dir) {
            print("- Move \(steps) steps to the \(dir)")
            switch dir {
            case .N:
                self.y += steps
            case .E:
                self.x += steps
            case .S:
                self.y -= steps
            case .W:
                self.x -= steps
            }
            output()
        }

        func turn(direction: String, degrees: Int) {
            print("- Turn \(degrees) to the \(direction)")
            let turns = degrees / 90
            let compass: [Dir] = [.N, .E, .S, .W]
            var index = Int(compass.firstIndex(of: self.dir)!)
            let inc = direction == "L" ? -1 : 1

            for _ in 1...turns {
                index += inc
                if index < 0 {
                    index = 3
                } else if index > 3 {
                    index = 0
                }
            }

            self.dir = compass[index]
            output()
        }

        func rotate(originX: Int, originY: Int, direction: String, degrees: Int) {
            output()
            print("- Rotate \(degrees) \(direction) around point \(originX) \(originY)")

            // Convert degrees to radians
            let mult = direction == "R" ? -1 : 1
            let radians = Double(degrees * mult) * Double(Double.pi / 180.0)

            // Math time! https://stackoverflow.com/a/2259502
            let s = sin(radians)
            let c = cos(radians)

            let tempX = Double(self.x - originX)
            let tempY = Double(self.y - originY)

            let newX = round(tempX * c - tempY * s)
            let newY = round(tempX * s + tempY * c)

            self.x = Int(newX) + originX
            self.y = Int(newY) + originY

            output()
        }

        func output() {
            print("- Now at \(x) \(y) facing \(dir)")
        }

        var manhatten: Int {
            return abs(x) + abs(y)
        }
    }

    func moveShip(lines: [String]) -> Ship {
        let ship = Ship()

        for line in lines {
            print("# \(line)")
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

        return ship
    }

    func calculatePart1() -> Int {
        let ship = moveShip(lines: lines)
        return ship.manhatten
    }

    func moveShip2(lines: [String]) -> Ship {
        let ship = Ship()
        let waypoint = Ship(10, 1)

        for line in lines {
            print("# \(line)")
            let instruction = String(line.first!)
            let value = Int(line.replacingOccurrences(of: instruction, with: ""))!

            switch instruction {
            case "F":
                print("- Move to waypoint \(value) times")
                let diffX = waypoint.x - ship.x
                let diffY = waypoint.y - ship.y
                for _ in 1...value {
                    ship.x = waypoint.x
                    ship.y = waypoint.y
                    waypoint.x += diffX
                    waypoint.y += diffY
                }
                print("- Ship now at \(ship.x) \(ship.y)")
                print("- Waypoint now at \(waypoint.x) \(waypoint.y)")
            case "S", "N", "E", "W":
                let dir = Dir(rawValue: instruction)!
                waypoint.move(steps: value, dir: dir)
            case "R", "L":
                waypoint.rotate(originX: ship.x, originY: ship.y, direction: instruction, degrees: value)
            default:
                print("umm, this isnt right")
            }
        }

        return ship
    }

    func calculatePart2() -> Int {
        let ship = moveShip2(lines: lines)
        return ship.manhatten
    }
}
