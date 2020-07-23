//
//  RollTests.swift
//  ParcheesiTests
//
//  Created by Ben Munson on 7/1/20.
//

import XCTest
@testable import Parcheesi

class RollTests: XCTestCase {

    func testRolls() {
        var roll = Roll(numbers: [1,5])
        XCTAssertFalse(roll.isDoublet)
        
        roll = Roll(numbers: [5,5])
        XCTAssertTrue(roll.isDoublet)
    }
    
    func testCombinations() {
        var roll = Roll(numbers: [4,5])
        var combinations = roll.combinations
        XCTAssertEqual(combinations.sorted(), [4,5,9])

        roll = Roll(numbers: [5,5])
        combinations = roll.combinations
        XCTAssertEqual(combinations.sorted(), [2,4,5,7,9,10,12,14])
    }
}
