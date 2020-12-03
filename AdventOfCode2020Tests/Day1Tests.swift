//
//  Day1Tests.swift
//  AdventOfCode2020Tests
//
//  Created by Greg Woods on 12/2/20.
//

import XCTest
@testable import AdventOfCode2020

class Day1Tests: XCTestCase {

    override func setUpWithError() throws {
        
    }
    
    func testCalculate() throws {
        let day = Day1()
        let result = day.calculate()
        
        XCTAssertTrue(result > 0)
        print("Day1 Part 1: \(result)")
    }
    
    func testCalculateV2() throws {
        let day = Day1()
        let result = day.calculatePart2()

        XCTAssertTrue(result > 0)
        print("Day1 Part 2: \(result)")
    }
}
