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

    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    func toIntegerArray(_ splitter: String = ",") -> [Int] {
        let split = self.components(separatedBy: splitter)

        return split.filter { $0 != "" }.map { Int($0)! }
    }
}
