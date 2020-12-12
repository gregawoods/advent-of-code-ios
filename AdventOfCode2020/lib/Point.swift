//
//  Point.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/12/20.
//

import Foundation

struct Point {
    var x: Int
    var y: Int

    init(_ x: Int = 0, _ y: Int = 0) {
        self.x = x
        self.y = y
    }

    mutating func rotate(degrees: Int, around: Point = Point()) {
        let radians = Double(degrees) * Double(Double.pi / 180.0)

        let s = sin(radians)
        let c = cos(radians)

        let tempX = Double(self.x - around.x)
        let tempY = Double(self.y - around.y)

        let newX = round(tempX * c - tempY * s)
        let newY = round(tempX * s + tempY * c)

        self.x = Int(newX) + around.x
        self.y = Int(newY) + around.y
    }
}
