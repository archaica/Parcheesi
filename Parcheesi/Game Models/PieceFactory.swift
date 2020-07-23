//
//  PieceFactory.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/5/20.
//

import Foundation

struct PieceFactory {
    static func pieces(for players: [Player]) -> [Piece] {
        return players
            .map({ (player) -> [Piece] in
                var pieces = [Piece]()
                for _ in 0..<pieceCount {
                    pieces.append(Piece(player: player))
                }
                return pieces
            })
            .reduce([], { $0 + $1 })
    }
}
