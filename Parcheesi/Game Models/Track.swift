//
//  Track.swift
//  Parcheesi
//
//  Created by Ben Munson on 6/24/20.
//

import Foundation

let longSegmentLength = 6
let shortSegmentLength = 4
let segmentCount = 4

class Track {
    var spaces: [Space]
    init() {
        // Build spaces
        self.spaces = Array(repeating: TrackBuilder.trackSegment(), count: 4).reduce([], { (spaces, segment) -> [Space] in
            return spaces + segment
        })
    }
    
    var safeSpaces: [Int] {
        return self.spaces.enumerated().filter({ $0.element.isSafeSpace }).map({ $0.offset })
    }
    
    var entrySpaces: [Int] {
        return self.spaces.enumerated().filter({ $0.element.isEntryPoint }).map({ $0.offset })
    }
    
    var offramps: [Int] {
        return self.spaces.enumerated().filter({ $0.element.isOffRamp }).map({ $0.offset })
    }
}

struct TrackBuilder {
    static func trackSegment() -> [Space] {
        var spaces = [Space]()
        
        let entry = Space()
        entry.isSafeSpace = true
        entry.isEntryPoint = true
        spaces.append(entry)
        
        // create long segment
        for _ in 0..<longSegmentLength {
            spaces.append(Space())
        }
        
        // Create parking spot
        let firstParkingSpot = Space()
        firstParkingSpot.isSafeSpace = true
        spaces.append(firstParkingSpot)
        
        // Create short segment
        for _ in 0..<shortSegmentLength {
            spaces.append(Space())
        }
        
        // Create off-ramp
        let offRamp = Space()
        offRamp.isSafeSpace = true
        offRamp.isOffRamp = true
        spaces.append(offRamp)
        
        // Create short segment
        
        for _ in 0..<shortSegmentLength {
            spaces.append(Space())
        }
        
        return spaces
    }
}
