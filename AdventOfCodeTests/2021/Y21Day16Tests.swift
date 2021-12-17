//
//  Y21Day16Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/16/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day16Tests: XCTestCase {

    let sample = "110100101111111000101000"
    let input = FileReader(file: "day16_21").lines[0]

    func testSimplePacket() {
        var bits = "110100101111111000101000".map { String($0) }
        let packet = Y21Day16().readPacket(&bits)!

        XCTAssertEqual(packet.version, 6)
        XCTAssertEqual(packet.type, .literal)
        XCTAssertEqual(packet.literalValue, 2021)
    }

    func testComplexPacket() {
        var bits = "00111000000000000110111101000101001010010001001000000000".map { String($0) }
        let packet = Y21Day16().readPacket(&bits)!

        XCTAssertEqual(packet.version, 1)
        XCTAssertEqual(packet.type, .lessThan)
        XCTAssertEqual(packet.literalValue, nil)
        XCTAssertEqual(packet.subPackets.count, 2)
        XCTAssertEqual(packet.subPackets[0].literalValue, 10)
        XCTAssertEqual(packet.subPackets[1].literalValue, 20)
    }

    func testMoreComplexPacket() {
        var bits = "11101110000000001101010000001100100000100011000001100000".map { String($0) }
        let packet = Y21Day16().readPacket(&bits)!

        XCTAssertEqual(packet.version, 7)
        XCTAssertEqual(packet.type, .max)
        XCTAssertEqual(packet.literalValue, nil)
        XCTAssertEqual(packet.subPackets.count, 3)
        XCTAssertEqual(packet.subPackets[0].literalValue, 1)
        XCTAssertEqual(packet.subPackets[1].literalValue, 2)
        XCTAssertEqual(packet.subPackets[2].literalValue, 3)
    }

    func testPart1Sample() {
        XCTAssertEqual(Y21Day16().part1("8A004A801A8002F478"), 16)
        XCTAssertEqual(Y21Day16().part1("620080001611562C8802118E34"), 12)
        XCTAssertEqual(Y21Day16().part1("C0015000016115A2E0802F182340"), 23)
        XCTAssertEqual(Y21Day16().part1("A0016C880162017C3686B18A3D4780"), 31)
    }

    func testPart1() throws {
        XCTAssertEqual(Y21Day16().part1(input), 984)
    }

    func testPart2Sample() {
        XCTAssertEqual(Y21Day16().part2("C200B40A82"), 3)
        XCTAssertEqual(Y21Day16().part2("04005AC33890"), 54)
        XCTAssertEqual(Y21Day16().part2("880086C3E88112"), 7)
        XCTAssertEqual(Y21Day16().part2("CE00C43D881120"), 9)
        XCTAssertEqual(Y21Day16().part2("D8005AC2A8F0"), 1)
        XCTAssertEqual(Y21Day16().part2("F600BC2D8F"), 0)
        XCTAssertEqual(Y21Day16().part2("9C005AC2F8F0"), 0)
        XCTAssertEqual(Y21Day16().part2("9C0141080250320F1802104A08"), 1)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day16().part2(input), 1015320896946)
    }
}
