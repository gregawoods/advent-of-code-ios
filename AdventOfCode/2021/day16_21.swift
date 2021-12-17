//
//  day16_21.swift
//  AdventOfCode
//
//  Created by Greg Woods on 12/16/21.
//

import Foundation

extension Array {
    mutating func take(_ n: Int) -> [Element] {
        let result = Array(prefix(n))
        removeFirst(n)
        return result
    }
}

struct Y21Day16: DayProtocol {

    enum PacketType: Int {
        case sum = 0
        case product = 1
        case min = 2
        case max = 3
        case literal = 4
        case greaterThan = 5
        case lessThan = 6
        case equalTo = 7
    }

    class Packet {
        let version: Int
        var type: PacketType
        var subPackets: [Packet] = []
        var literalValue: Int?

        init(version: Int, type: Int) {
            self.version = version
            self.type = PacketType(rawValue: type)!
        }

        var totalVersion: Int { version + subPackets.map { $0.totalVersion }.sum() }

        var subValues: [Int] { subPackets.map { $0.value } }

        var value: Int {
            switch type {
            case .sum:
                return subValues.sum()
            case .product:
                return subValues.reduce(1, *)
            case .min:
                return subValues.min()!
            case .max:
                return subValues.max()!
            case .literal:
                return literalValue!
            case .greaterThan:
                let gt = subPackets[0].value > subPackets[1].value
                return gt ? 1 : 0
            case .lessThan:
                let lt = subPackets[0].value < subPackets[1].value
                return lt ? 1 : 0
            case .equalTo:
                let eq = subPackets[0].value == subPackets[1].value
                return eq ? 1 : 0
            }
        }
    }

    let kLengthTypeLength = 0

    func readPacket(_ bits: inout [String]) -> Packet? {
        if bits.allSatisfy({ $0 == "0" }) {
            return nil
        }

        // Read the version
        let versionString = bits.take(3).joined()
        let version = Int(versionString, radix: 2)!

        // Read the type
        let typeString = bits.take(3).joined()
        let type = Int(typeString, radix: 2)!

        let packet = Packet(version: version, type: type)

        if packet.type == .literal {
            // Read the literal value
            var literalBits = [String]()
            while true {
                let control = bits.removeFirst()
                literalBits.append(contentsOf: bits.take(4))
                if control == "0" { break }
            }
            packet.literalValue = Int(literalBits.joined(), radix: 2)!
        } else {
            // Read nested packets
            let lengthBit = Int(bits.removeFirst())!

            if lengthBit == kLengthTypeLength {
                // Read length n bits
                let lengthBits = bits.take(15).joined()
                let subPacketLength = Int(lengthBits, radix: 2)!
                var subPacketBits = bits.take(subPacketLength)
                while let subPacket = readPacket(&subPacketBits) {
                    packet.subPackets.append(subPacket)
                }
            } else {
                // Read count n packets
                let countBits = bits.take(11).joined()
                let subPacketCount = Int(countBits, radix: 2)!
                for _ in 1...subPacketCount {
                    packet.subPackets.append(readPacket(&bits)!)
                }
            }
        }

        return packet
    }

    // This would be the smart way to convert from hex to binary, but the resulting
    // Integer so so big it overflows the maximum storable value for an integer!
    //
    // let hex = "D2FE28"
    // let int = Int(hex, radix: 16)!
    // let bin = String(int, radix: 2)

    func part1(_ input: String) -> Int {
        let binaryString = input.map { conversionTable[$0]! }.joined()
        var bits = binaryString.map { String($0) }
        let packet = readPacket(&bits)!

        return packet.totalVersion
    }

    func part2(_ input: String) -> Int {
        let binaryString = input.map { conversionTable[$0]! }.joined()
        var bits = binaryString.map { String($0) }
        let packet = readPacket(&bits)!

        return packet.value
    }

    let conversionTable: [Character: String] = [
        "0": "0000",
        "1": "0001",
        "2": "0010",
        "3": "0011",
        "4": "0100",
        "5": "0101",
        "6": "0110",
        "7": "0111",
        "8": "1000",
        "9": "1001",
        "A": "1010",
        "B": "1011",
        "C": "1100",
        "D": "1101",
        "E": "1110",
        "F": "1111"
    ]
}
