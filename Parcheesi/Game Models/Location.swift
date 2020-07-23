//
//  Location.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/3/20.
//

import Foundation

enum Location {
    case circle(Player) // the owner of the circle
    case track(Int) // the index of the space in the track
    case ramp(Player, Int) // the owner of the ramp, the index of the space in the ramp
    case home
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        switch (lhs, rhs) {
            case (.circle(let player1), .circle(let player2)):
                return player1 == player2
            case (.track(let track1), .track(let track2)):
                return track1 == track2
            case (.ramp(let player1, let index1), .ramp(let player2, let index2)):
                return player1 == player2 && index1 == index2
            case (.home, .home):
                return true
            default:
                return false
        }
    }
}
