//
//  day2_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/1/21.
//

import Foundation

struct Y21_Day2 : DayProtocol {

    enum Dir: String {
        case forward
        case up
        case down
    }
    
    struct Step {
        var amount = 0
        var dir: Dir = .forward
    }
    
    fileprivate func parseStep(stepStr: String) -> Step {
        let parts = stepStr.components(separatedBy: " ")

        return Step(
            amount: Int(parts[1])!,
            dir: Dir(rawValue: parts[0])!
        )
    }
    
    func part1(_ input: [String]) -> Int {
        var x = 0
        var y = 0
        
        let steps = input.map({ str in
            return parseStep(stepStr: str)
        })
        
        for step in steps {
            switch step.dir {
            case .forward:
                x += step.amount
            case .down:
                y += step.amount
            case .up:
                y -= step.amount
            }
        }
        
        return x * y
    }
    
    func part2(_ input: [String]) -> Int {
        var x = 0
        var y = 0
        var aim = 0
        
        let steps = input.map({ str in
            return parseStep(stepStr: str)
        })
        
        for step in steps {
            switch step.dir {
            case .forward:
                x += step.amount
                y += (step.amount * aim)
            case .down:
                aim += step.amount
            case .up:
                aim -= step.amount
            }
        }
        
        return x * y
    }
}
