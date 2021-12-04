//
//  Array.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/4/20.
//

import Foundation

extension Array {
    func countWhere(_ finder: (Element) -> Bool) -> Int {
        return filter(finder).count
    }
}

extension Array where Element: Numeric {
    func sum() -> Element {
        return reduce(0) { $0 + $1 }
    }
}

//extension Array where Element: StringProtocol {
//    func arrayOfInts() -> [Int] {
//        return map({ Int($0)! })
//    }
//}
//
////.filter { $0 != nil }

extension Array where Element: Equatable {
    func allIndicesOf(element: Element) -> [Int] {
        var indices: [Int] = []
        var index = 0
        forEach { e in
            if element == e {
                indices.append(index)
            }
            index += 1
        }
        return indices
    }
}
