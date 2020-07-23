//
//  Player.swift
//  Parcheesi
//
//  Created by Ben Munson on 6/24/20.
//

import Foundation

class Player {
    var id = UUID()
    var name: String
    var isComputer = false
 
    init(name: String) {
        self.name = name
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Player: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension Player: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Player:\(name)"
    }
}
