//
//  MoveFactory.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/5/20.
//

import Foundation

//MARK: MoveFactory class
struct MoveFactory {
    static func moves(for piece: Piece, with roll: Roll, in game: Game) -> [Move] {
        var moves: [Move] = []
        let start = piece.location
        
        switch start {
        
        // No moves are possible in the home area
        case .home: return []
        
        // Player must hit the home area exactly
        case .ramp(let player, let index):
            let validRampIndexes = 0..<rampSpaceCount
            let combinations = roll.combinations.map({ $0 + index })
            for index in combinations {
                if validRampIndexes.contains(index) {
                    moves.append(Move(start: start, end: .ramp(player, index)))
                } else if index == rampSpaceCount {
                    moves.append(Move(start: start, end: .home))
                }
            }
        case .circle(let player):
            if roll.combinations.contains(entryRollNumber),
               let spaceIndex = game.entryPoints[player]
            {
                moves.append(Move(start: start, end: .track(spaceIndex)))
            }
        case .track(let location): ()
            guard let playerOffRamp = game.offRamps[piece.player] else {
                return []
            }
            let trackMax = game.track.spaces.endIndex-1
            let blockades = game.blockades()
            print("blockades", blockades)
            moves.append(contentsOf: roll.combinations
                .map({ $0 + location })
                .compactMap({ end -> (location: Int, isRamp: Bool)? in
                    let range = location...end
                    let isRamp = range.contains(playerOffRamp)
                    let subrange = range.suffix(from: range.index(range.startIndex, offsetBy: 1))
                    for s in blockades {
                        if subrange.contains(s) {
                            return nil
                        }
                    }
                    return (location: end, isRamp: isRamp)
                }).map({ data -> Location in
                    if data.isRamp {
                        let validRampIndexes = 0..<rampSpaceCount
                        let dest = data.location-playerOffRamp
                        if validRampIndexes.contains(dest) {
                            return .ramp(piece.player, dest)
                        } else {
                            return .home
                        }
                    } else {
                        let space = data.location > trackMax
                            ? data.location - trackMax
                            : data.location
                        return .track(space)
                    }
                }).map({ Move(start: start, end: $0) })
            )
        }
        return moves
    }
}
