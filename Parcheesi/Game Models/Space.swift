//
//  Space.swift
//  Parcheesi
//
//  Created by Ben Munson on 6/24/20.
//

import Foundation

class Space {
    var id = UUID()
    var isSafeSpace: Bool = false
    var isEntryPoint: Bool = false
    var isOffRamp: Bool = false
}

extension Space: Equatable {
    static func == (lhs: Space, rhs: Space) -> Bool {
        return lhs.id == rhs.id
    }
}
