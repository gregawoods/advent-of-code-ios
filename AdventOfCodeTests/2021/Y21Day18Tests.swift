//
//  Y21Day18Tests.swift
//  AdventOfCodeTests
//
//  Created by Greg Woods on 12/20/21.
//

import XCTest
@testable import AdventOfCode

class Y21Day18Tests: XCTestCase {

    let sample = ["target area: x=20..30, y=-10..-5"]
    let input = FileReader(file: "day18_21").lines

    let day = Y21Day18()

    typealias Node = Y21Day18.Node

    func testParse() {
        for str in [
          "[1,2]",
          "[[1,2],3]",
          "[9,[8,7]]",
          "[[1,9],[8,5]]",
          "[[[[1,2],[3,4]],[[5,6],[7,8]]],9]",
          "[[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]",
          "[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]"
        ] {
            let node = Node.parse(pattern: str)
            XCTAssertEqual(node.toString, str)
        }
    }

    func testExplode() {
        let node = Node.parse(pattern: "[[[[[9,8],1],2],3],4]")
        day.process(node: node)
        XCTAssertEqual(node.toString, "[[[[0,9],2],3],4]")

        let node2 = Node.parse(pattern: "[7,[6,[5,[4,[3,2]]]]]")
        day.process(node: node2)
        XCTAssertEqual(node2.toString, "[7,[6,[5,[7,0]]]]")

        let node3 = Node.parse(pattern: "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")
        day.process(node: node3)
        XCTAssertEqual(node3.toString, "[[3,[2,[8,0]]],[9,[5,[7,0]]]]")
    }

    func testFullProcess() {
        let node = Node.parse(pattern: "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]")
        day.processFully(node: node)
        XCTAssertEqual(node.toString, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
    }

    func testAdd() {
        var result = Node(1)

        result = day.add(
            a: "[[[[4,3],4],4],[7,[[8,4],9]]]",
            b: "[1,1]")
        XCTAssertEqual(result.toString, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")

        result = day.add(
            a: "[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]",
            b: "[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]")
        XCTAssertEqual(result.toString, "[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]")

        result = day.add(
            a: "[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]",
            b: "[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]")
        XCTAssertEqual(result.toString, "[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]")
    }
 
    func testMagnitude() {
        let node = Node.parse(pattern: "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")
        XCTAssertEqual(node.magnitude, 3488)
    }

    func testPart1Sample() {
        let lines = """
        [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
        [[[5,[2,8]],4],[5,[[9,9],0]]]
        [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
        [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
        [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
        [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
        [[[[5,4],[7,7]],8],[[8,3],8]]
        [[9,3],[[9,9],[6,[4,9]]]]
        [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
        [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
        """.components(separatedBy: "\n")

        XCTAssertEqual(day.part1(lines), 4140)
    }

    func testPart1() throws {
        XCTAssertEqual(day.part1(input), 4391)
    }

    func testPart2Sample() {
        XCTAssertEqual(day.part2(sample), 1)
    }

    func testPart2() throws {
        XCTAssertEqual(day.part2(input), 1)
    }
}
