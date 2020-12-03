//
//  Day1.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/2/20.
//

import Foundation

struct Day1 {
    
    let lines: [Int]
    
    init() {
        self.lines = FileReader(file: "day1").arrayOfInts
    }
    
    func calculate() -> Int {
        for x in lines {
            let y = 2020 - x
            if (lines.contains(y)) {
                return x * y
            }
        }
        return -1
    }

    func calculatePart2() -> Int {
        for x in lines {
            for y in lines {
                let z = 2020 - x - y
                if (lines.contains(z)) {
                    return x * y * z
                }
            }
        }
        return -1
    }
}
