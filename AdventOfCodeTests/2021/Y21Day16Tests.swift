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
        XCTAssertEqual(packet.type, 4)
        XCTAssertEqual(packet.value, 2021)
    }

    func testComplexPacket() {
        var bits = "00111000000000000110111101000101001010010001001000000000".map { String($0) }
        let packet = Y21Day16().readPacket(&bits)!

        XCTAssertEqual(packet.version, 1)
        XCTAssertEqual(packet.type, 6)
        XCTAssertEqual(packet.value, nil)
        XCTAssertEqual(packet.subPackets.count, 2)
        XCTAssertEqual(packet.subPackets[0].value, 10)
        XCTAssertEqual(packet.subPackets[1].value, 20)
    }

    func testMoreComplexPacket() {
        var bits = "11101110000000001101010000001100100000100011000001100000".map { String($0) }
        let packet = Y21Day16().readPacket(&bits)!

        XCTAssertEqual(packet.version, 7)
        XCTAssertEqual(packet.type, 3)
        XCTAssertEqual(packet.value, nil)
        XCTAssertEqual(packet.subPackets.count, 3)
        XCTAssertEqual(packet.subPackets[0].value, 1)
        XCTAssertEqual(packet.subPackets[1].value, 2)
        XCTAssertEqual(packet.subPackets[2].value, 3)
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
        XCTAssertEqual(Y21Day16().part2(sample), 0)
    }

    func testPart2() throws {
        XCTAssertEqual(Y21Day16().part2(input), 0)
    }
}
