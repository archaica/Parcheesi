//
//  Move.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 7/3/20.
//

import Foundation

struct Move {
    var start: Location
    var end: Location
}

extension Move: Equatable {
    static func == (lhs: Move, rhs: Move) -> Bool {
        return
            lhs.start == rhs.start &&
            lhs.end == rhs.end
    }
}
