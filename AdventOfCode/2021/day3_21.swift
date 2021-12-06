//
//  day3_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/2/21.
//

import Foundation

struct Y21Day3: DayProtocol {

    func part1(_ input: [String]) -> Int {
        let length = input.first!.count
        var gamma = ""
        var epsilon = ""

        for n in 0...(length - 1) {
            let ones = input.countWhere { $0[n] == "1" }

            if ones > (input.count - ones) {
                // one is most common
                gamma += "1"
                epsilon += "0"
            } else {
                // zero is most common
                gamma += "0"
                epsilon += "1"
            }
        }

        return Int(gamma, radix: 2)! * Int(epsilon, radix: 2)!
    }

    func part2(_ input: [String]) -> Int {
        let length = input.first!.count

        var listOxy = input
        var listCo2 = input

        for n in 0...(length - 1) {
            let ones = listOxy.countWhere { $0[n] == "1" }
            let onesMost = ones >= (listOxy.count - ones)
            listOxy = listOxy.filter { onesMost ? $0[n] == "1" : $0[n] == "0" }

            if listOxy.count == 1 { break }
        }

        for n in 0...(length - 1) {
            let ones = listCo2.countWhere { $0[n] == "1" }
            let onesMost = ones >= (listCo2.count - ones)
            listCo2 = listCo2.filter { onesMost ? $0[n] == "0" : $0[n] == "1" }

            if listCo2.count == 1 { break }
        }

        let oxy = Int(listOxy.first!, radix: 2)!
        let co2 = Int(listCo2.first!, radix: 2)!

        return oxy * co2
    }
}
