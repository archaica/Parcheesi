//
//  TrackTests.swift
//  ParcheesiTests
//
//  Created by Ben Munson on 6/24/20.
//

import XCTest
@testable import Parcheesi

class TrackTests: XCTestCase {

    func testTrackGeneration() {
        let track = Track()

        XCTAssertEqual(track.spaces.count, 68)
        XCTAssertEqual(track.entrySpaces.count, 4)
        XCTAssertEqual(track.safeSpaces.count, 12)
        XCTAssertEqual(track.offramps.count, 4)
    }
    
}
