//
//  day1_2021.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/1/21.
//

import Foundation

struct Y21_Day1 : DayProtocol {

    func part1(_ input: [Int]) -> Int {
        var n = 0
        var last = 999999
        
        for x in input {
            if x > last {
                n += 1
            }
            last = x
        }
        
        return n
    }
    
    func part2(_ input: [Int]) -> Int {
        var newInput: [Int] = []
        
        for n in 2...(input.count - 1) {
            newInput.append(
                input[n] + input[n-1] + input[n-2]
            )
        }
        
        return part1(newInput)
    }
}
