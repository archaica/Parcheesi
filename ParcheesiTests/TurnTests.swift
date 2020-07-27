//
//  TurnTests.swift
//  ParcheesiTests
//
//  Created by Benjamin Munson on 7/26/20.
//

import XCTest
@testable import Parcheesi

class TurnTests: XCTestCase {

    func testDoublets() {
        let p = Player(name: "Ben")
        let turn = Turn(player: p)
        
        XCTAssertNoThrow(try turn.roll())
        turn.doublets = 1
        XCTAssertNoThrow(try turn.roll())
        turn.doublets = 2
        XCTAssertThrowsError(try turn.roll())
        
    }
    
}
