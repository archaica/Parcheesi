//
//  Turn.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/26/20.
//

import Foundation

fileprivate let maxDoublets = 2

class Turn {
    
    enum Errors: Error {
        case maxDoublets
    }
    
    var doublets: Int = 0
    var player: Player
    
    init(player: Player) {
        self.player = player
    }
    
    func roll() throws -> (roll: Roll, turnContinues: Bool) {
        guard doublets < maxDoublets else {
            throw Errors.maxDoublets
        }
        let roll = Roll()
        if roll.isDoublet {
            doublets += 1
        }
        return (roll, roll.isDoublet)
    }
}
