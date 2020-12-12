//
//  DayProtocol.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/3/20.
//

import Foundation

protocol DayProtocol {
    associatedtype InputType = [String]
    func calculatePart1(_ input: InputType) -> Int
    func calculatePart2(_ input: InputType) -> Int
}
