//
//  day17_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/17/21.
//

import Foundation

struct Y21Day17: DayProtocol {

    typealias Target = (
        x1: Int,
        x2: Int,
        y1: Int,
        y2: Int
    )

    // Returns the highest Y value if we hit the target box
    func testVelocity(vx: Int, vy: Int, box: Target) -> Int? {
        var hit = false
        var highestY = 0

        var vx = vx
        var vy = vy
        var x = 0
        var y = 0

        while hit == false {
            x += vx
            y += vy

            if y > highestY { highestY = y }

            if (box.x1...box.x2).contains(x) && (box.y1...box.y2).contains(y) {
                // we got a match!
                hit = true
            } else if x > box.x2 || y < box.y1 {
                // we overshot it!
                break
            } else {
                // update velocity and keep going
                vx = vx > 0 ? vx - 1 : vx
                vy -= 1
            }
        }

        return hit ? highestY : nil
    }

    func calculateHits(_ input: Target) -> [Int] {
        var velocities: [(Int, Int)] = []

        // build a set of semi-reasonable possible velocities
        for x in 1...input.x2 {
            for y in (input.y1)...(input.x1*2) {
                velocities.append((x, y))
            }
        }

        // find the y values
        let hits = velocities.compactMap({ v in
            return testVelocity(vx: v.0, vy: v.1, box: input)
        })

        return hits
    }

    func part1(_ input: Target) -> Int {
        return calculateHits(input).max()!
    }

    func part2(_ input: Target) -> Int {
        return calculateHits(input).count
    }
}
