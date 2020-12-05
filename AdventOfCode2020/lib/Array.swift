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
