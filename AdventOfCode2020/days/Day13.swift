//
//  Day13.swift
//  AdventOfCode2020
//
//  Created by Greg Woods on 12/12/20.
//

import Foundation

struct Day13: DayProtocol {

    func calculatePart1(_ input: [String]) -> Int {
        let minimum = Int(input[0])!

        let busses: [[Int]] = input[1].components(separatedBy: ",").filter({ $0 != "x" }).map({ busId in
            let interval = Int(busId)!
            let soonest = findFirstDeparture(interval: interval, minimum: minimum)
            return [interval, soonest]
        })

        let bus = busses.sorted { (a, b) -> Bool in
            a[1] < b[1]
        }.first!

        return bus[0] * (bus[1] - minimum)
    }

    func findFirstDeparture(interval: Int, minimum: Int) -> Int {
        let div = ceil(Double(minimum) / Double(interval))
        let result = Int(div) * interval

        return result
    }

    struct Bus {
        let interval: Int
        let index: Int
    }

    func calculatePart2(_ input: [String]) -> Int {

        var busses: [Bus] = []

        for (index, busId) in input[1].components(separatedBy: ",").enumerated() {
            if busId == "x" { continue }

            busses.append(Bus(interval: Int(busId)!, index: index))
        }

        busses = busses.sorted(by: { (a, b) -> Bool in
            a.interval > b.interval
        })

        for index in 1... {
            let time = index * busses[0].interval

            if checkMinute(busses: busses, minute: time) {
                return time - busses[0].index
            }
        }

        return 0
    }

    func checkMinute(busses: [Bus], minute: Int) -> Bool {
        for bus in busses[1...(busses.count-1)] {
            let newTime = minute + (bus.index - busses[0].index)
            if newTime % bus.interval != 0 {
                return false
            }
        }
        return true
    }
}
