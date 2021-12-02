//
//  Cache.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/10/20.
//

import Foundation

class Cache<T: Hashable, V> {
    var values: [T: V] = [:]

    func fetch(key: T, _ block: () -> V) -> V {
        if values[key] == nil {
            values[key] = block()
        }
        return values[key]!
    }
}
