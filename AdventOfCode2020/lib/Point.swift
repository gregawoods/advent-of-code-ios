//
//  Point.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/12/20.
//

import Foundation

protocol Coordinate {
    var x: Int { get set }
    var y: Int { get set }
}

extension Coordinate {
    mutating func rotate(degrees: Int, aroundX: Double = 0, aroundY: Double = 0) {
        let radians = Double(degrees) * Double(Double.pi / 180.0)

        let s = sin(radians)
        let c = cos(radians)

        let tempX = Double(self.x) - aroundX
        let tempY = Double(self.y) - aroundY

        let newX = tempX * c - tempY * s
        let newY = tempX * s + tempY * c

        self.x = Int(round(newX + aroundX))
        self.y = Int(round(newY + aroundY))
    }
}

extension Array where Element: Coordinate {
    func findAt(x: Int, y: Int) -> Element? {
        return first(where: { coord in
            coord.x == x && coord.y == y
        })
    }
}

struct Point: Coordinate {
    var x: Int
    var y: Int

    init(_ x: Int = 0, _ y: Int = 0) {
        self.x = x
        self.y = y
    }
}
