//
//  day8_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/7/21.
//

import Foundation

struct Y21Day8: DayProtocol {

    func part1(_ input: [String]) -> Int {
        return input.map {
            Array($0.components(separatedBy: " ")[11...14])
        }.flatMap { $0 }.countWhere { str in
            [2, 4, 3, 7].contains(str.count)
        }
    }

    enum Segment: CaseIterable {
        case top
        case topLeft
        case topRight
        case mid
        case botLeft
        case botRight
        case bot
    }

    func part2(_ input: [String]) -> Int {
        return input.map { solveRow(row: $0) }.sum()
    }

    func solveRow(row: String) -> Int {
        let parts = row.components(separatedBy: " ")

        let inputs = parts[0...9].map { String($0.sorted()) }
        let outputs = parts[11...14].map { String($0.sorted()) }

        // Figure out the strings we know for sure
        let one = inputs.first(where: { $0.count == 2 })!
        let four = inputs.first(where: { $0.count == 4 })!
        let seven = inputs.first(where: { $0.count == 3 })!
        let eight = "abcdefg"

        // Figure out what the segments are
        var segments: [Segment: Character] = [:]

        // Top must be char present in "seven" but not present in "one"
        segments[.top] = seven.first(where: { !one.contains($0) })!

        // Middle segment is present in 7 numbers and one of those is "four"
        let possibleMids = Array(four).filter { !one.contains($0) }
        for pm in possibleMids {
            let count = inputs.countWhere { $0.contains(pm) }
            if count == 7 {
                segments[.mid] = pm
                continue
            }
        }

        // Top left is present in "four", not in "one", and is not the mid
        let topLeft = four.first { char in
            return !one.contains(char) && char != segments[.mid]
        }!
        segments[.topLeft] = topLeft

        // Top right is present in 8 numbers and one of them is "four"
        let possibleTopRights = Array(four)
        for pTR in possibleTopRights {
            if segments.values.contains(pTR) { continue }

            let count = inputs.countWhere { $0.contains(pTR) }
            if count == 8 {
                segments[.topRight] = pTR
                continue
            }
        }

        // Now bottom right is just the remaining piece of "one"
        let botRight = one.first { char in
            char != segments[.topRight]
        }!
        segments[.botRight] = botRight

        // Bottom is in 7 numbers including "eight"
        let possibleBots = Array(eight)
        for pB in possibleBots {
            if segments.values.contains(pB) { continue }

            let count = inputs.countWhere { $0.contains(pB) }
            if count == 7 {
                segments[.bot] = pB
                continue
            }
        }

        // Bottom left is the only one remaining
        segments[.botLeft] = eight.first { !segments.values.contains($0) }!

        // Phew! We should have all the segments mapped out now, so we can
        // reveal the output
        let results = outputs.map { translate(str: $0, segments: segments) }

        // done.... ?
        return Int(results.map { String($0) }.joined())!
    }

    func combineSegments(_ template: [Segment: Character], _ segments: [Segment]) -> String {
        return segments.map { String(template[$0]!) }.sorted().joined()
    }

    func translate(str: String, segments: [Segment: Character]) -> Int {
        let keys = [
            combineSegments(segments, [.top, .topRight, .botRight, .bot, .botLeft, .topLeft]), // zero
            combineSegments(segments, [.topRight, .botRight]),                                 // one
            combineSegments(segments, [.top, .topRight, .mid, .botLeft, .bot]),                // two
            combineSegments(segments, [.top, .topRight, .mid, .botRight, .bot]),               // three
            combineSegments(segments, [.topLeft, .topRight, .mid, .botRight]),                 // four
            combineSegments(segments, [.top, .topLeft, .mid, .botRight, .bot]),                // five
            combineSegments(segments, [.top, .topLeft, .mid, .botLeft, .botRight, .bot]),      // six
            combineSegments(segments, [.top, .topRight, .botRight]),                           // seven
            combineSegments(segments, Segment.allCases),                                       // eight
            combineSegments(segments, [.top, .topLeft, .topRight, .mid, .botRight, .bot])      // nine
        ]

        for (index, key) in keys.enumerated() where key == str {
            return index
        }

        return 0
    }
}
