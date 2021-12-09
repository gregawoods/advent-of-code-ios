//
//  day9_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/8/21.
//

import Foundation

struct Y21Day9: DayProtocol {

    func part1(_ input: [String]) -> Int {
        var grid: [[Int]] = []
        var sum = 0
  
        for row in input {
            grid.append([])

            for char in row {
                grid[grid.count - 1].append(Int(String(char))!)
            }
        }

        for y in 0...(grid.count - 1) {
            for x in 0...(grid[y].count - 1) {
                let element = grid[y][x]
                print(element)

                if x > 0 {
                    let left = grid[y][x - 1]
                    if left <= element { continue }
                }

                if x < (grid[y].count - 1) {
                    let right = grid[y][x + 1]
                    if right <= element { continue }
                }

                if y > 0 {
                    let top = grid[y - 1][x]
                    if top <= element { continue }
                }

                if y < (grid.count - 1) {
                    let bottom = grid[y + 1][x]
                    if bottom <= element { continue }
                }

                sum += (element + 1)
            }
        }

        return sum
    }

    func part2(_ input: [String]) -> Int {
        return 0
    }
}
