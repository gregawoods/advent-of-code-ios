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

    class Packet {
        let version: Int
        var type: Int
        var subPackets: [Packet] = []
        var value: Int?

        init(version: Int, type: Int) {
            self.version = version
            self.type = type
        }

        var totalVersion: Int {
            return version + subPackets.map { $0.totalVersion }.sum()
        }
    }

    let kPacketTypeLiteral = 4
    let kLengthTypeLength = 0

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

    func part1(_ input: String) -> Int {
        // This would be the smart way to convert the input, but the resulting Integer so so big
        // it overflows the maximum storable value for an integer!
        //
        // let hex = "D2FE28"
        // let int = Int(hex, radix: 16)!
        // let bin = String(int, radix: 2)
        
        let binaryString = input.map { conversionTable[$0]! }.joined()
        var bits = binaryString.map { String($0) }
        let packet = readPacket(&bits)!

        return packet.totalVersion
    }
    
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

        var packet = Packet(version: version, type: type)

        if packet.type == kPacketTypeLiteral {
            // Read the literal value
            var literalBits = [String]()
            while true {
                let control = bits.removeFirst()
                literalBits.append(contentsOf: bits.take(4))
                if control == "0" { break }
            }
            packet.value = Int(literalBits.joined(), radix: 2)!
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

    func parsePacket(_ source: [String]) -> Packet {
        var bits = source

        let versionString = bits.take(3).joined()
        let version = Int(versionString, radix: 2)!

        let typeString = bits.take(3).joined()
        let type = Int(typeString, radix: 2)!

        var packet = Packet(version: version, type: type)
        return packet
    }

    func part2(_ input: String) -> Int {
        return 0
    }
}
