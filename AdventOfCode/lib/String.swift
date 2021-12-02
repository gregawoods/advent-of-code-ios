//
//  String.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/16/20.
//

import Foundation

extension String {
    func toCsv() -> [Int] {
        return components(separatedBy: ",").map { Int($0)! }
    }
}
