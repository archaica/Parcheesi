//
//  Piece.swift
//  Parcheesi
//
//  Created by Ben Munson on 6/24/20.
//

import Foundation

class Piece {
    var id = UUID()
    var player: Player
    var location: Location
    init(player: Player) {
        self.player = player
        self.location = .circle(player)
    }
}

extension Piece: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Piece:\(id) \(player) \(location)"
    }
}
