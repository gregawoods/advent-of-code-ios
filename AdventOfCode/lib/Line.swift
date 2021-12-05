//
//  Line.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/5/21.
//

import Foundation

struct Line {
    let a: Point
    let b: Point
    
    init(x1: Int, y1: Int, x2: Int, y2: Int) {
        self.a = Point(x1, y1)
        self.b = Point(x2, y2)
    }

    var x1: Int { a.x }
    var x2: Int { b.x }
    var y1: Int { a.y }
    var y2: Int { b.y }
    
    var horizontal: Bool { a.y == b.y }
    var vertical: Bool { a.x == b.x }

    var xStride: [Int] {
        return a.x < b.x ? Array(a.x...b.x) : (b.x...a.x).reversed()
    }
    
    var yStride: [Int] {
        return a.y < b.y ? Array(a.y...b.y) : (b.y...a.y).reversed()
    }

    var stride: [Point] {
        if horizontal {
            return xStride.map { x in
                Point(x, a.y)
            }
        } else if vertical {
            return yStride.map { y in
                Point(a.x, y)
            }
        } else {
            return xStride.enumerated().map { (index, x) in
                Point(x, yStride[index])
            }
        }
    }
}
