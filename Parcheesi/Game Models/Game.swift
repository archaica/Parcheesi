//
//  Game.swift
//  Parcheesi
//
//  Created by Benjamin Munson on 6/25/20.
//

import Foundation

//MARK: constants
let pieceCount = 4
let mandatoryPlayerCount = 4
let entryRollNumber = 5
let rampSpaceCount = 7

//MARK: Game class
class Game {

    var players: [Player]
    var pieces: [Piece]
    var entryPoints: [Player: Int]
    var offRamps: [Player: Int]
    var track: Track
        
    //MARK: root initializer
    init(players: [Player], pieces: [Piece], entryPoints: [Player: Int], offRamps: [Player: Int]) {
        self.track = Track()
        self.players = players
        self.pieces = pieces
        self.entryPoints = entryPoints
        self.offRamps = offRamps
    }
    
    //MARK: initialize with names
    convenience init(names: [String]) {
        var players = [Player]()
        for name in names {
            players.append(Player(name: name))
        }
        self.init(players: players)
    }
    
    //MARK: initialize with player objects
    convenience init(players: [Player]) {
        var players = players
        if players.count > mandatoryPlayerCount {
            players = players.suffix(mandatoryPlayerCount)
        }
        if players.count < mandatoryPlayerCount {
            for i in players.count..<mandatoryPlayerCount {
                let name = "Player \(i+1)"
                players.append(Player(name: name))
            }
        }

        // create pieces

        let pieces = PieceFactory.pieces(for: players)

        // create track
        
        let track = Track()

        var entryPoints = [Player: Int]()
        for (index, spaceIndex) in track.entrySpaces.enumerated() {
            entryPoints[players[index]] = spaceIndex
        }

        // create offramps
        
        var offRamps = [Player: Int]()
        let offRampSpaces = track.offramps
        for (index, player) in players.enumerated() {
            let space: Int
            switch index {
                case 0: space = offRampSpaces.last!
                default: space = offRampSpaces[index-1]
            }
            offRamps[player] = space
        }        
        self.init(players: players, pieces: pieces, entryPoints: entryPoints, offRamps: offRamps)
    }
    
    func pieces(for player: Player) -> [Piece] {
        return pieces.filter({ $0.player == player })
    }
    
    func offRamp(for player: Player) -> Int {
        return offRamps[player] ?? 0
    }
    
    func blockades() -> [Int] {
        let spaces = pieces.compactMap({ piece -> Int? in
            if case .track(let space) = piece.location {
                return space
            }
            return nil
        })
        return findDuplicates(arr: spaces)
    }
    
    private func findDuplicates<T: Hashable>(arr: Array<T>) -> [T] {
        var set = Set<T>()
        var dupes = [T]()
        for i in arr {
            if set.insert(i).inserted == false && dupes.contains(i) == false {
                dupes.append(i)
            }
        }
        return dupes
    }
}


