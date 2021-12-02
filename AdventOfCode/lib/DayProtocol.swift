//
//  DayProtocol.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/3/20.
//

import Foundation

protocol DayProtocol {
    associatedtype InputType = [String]
    associatedtype ReturnPart1 = Int
    associatedtype ReturnPart2 = Int

    func part1(_ input: InputType) -> ReturnPart1
    func part2(_ input: InputType) -> ReturnPart2
}
