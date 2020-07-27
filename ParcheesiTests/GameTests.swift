//
//  GameTests.swift
//  ParcheesiTests
//
//  Created by Benjamin Munson on 6/25/20.
//

import XCTest
@testable import Parcheesi

struct GameTestSupport {
    static func players() -> [Player] {
        return [
            "Ben",
            "Kazia",
            "Luke",
            "Riley"
        ].map({ Player(name: $0) })
    }
    
    static func pieces(for players: [Player]) -> [Piece] {
        return players
        .map({ Array(repeating: Piece(player: $0), count: pieceCount) }).reduce([], { $0 + $1 })
    }
    
}

class GameTests: XCTestCase {

    func testGameCreation() {
        let playerNames = ["Ben", "Kazia"]
        let game = Game(names: playerNames)
        let players = game.players
        
        XCTAssert(players.count == 4)
        
        XCTAssert(players[0].name == "Ben")
        XCTAssert(players[1].name == "Kazia")
        XCTAssert(players[2].name == "Player 3")
        XCTAssert(players[3].name == "Player 4")
    }
    
    func testEmptyGameCreation() {
        let game = Game(names: [])
        let players = game.players
        
        XCTAssert(players.count == 4)
        
        XCTAssert(players[0].name == "Player 1")
        XCTAssert(players[1].name == "Player 2")
        XCTAssert(players[2].name == "Player 3")
        XCTAssert(players[3].name == "Player 4")
    }

    func testOffRamps() {
        let p1 = Player(name: "Ben")
        let p2 = Player(name: "Kazia")
        let p3 = Player(name: "Luke")
        let p4 = Player(name: "Riley")
        let game = Game(players: [p1, p2, p3, p4])
        
        XCTAssertEqual(game.offRamp(for: p1), 63)
        XCTAssertEqual(game.offRamp(for: p2), 12)
        XCTAssertEqual(game.offRamp(for: p3), 29)
        XCTAssertEqual(game.offRamp(for: p4), 46)
    }
    
    func testBlockades() {
        let p1 = Player(name: "Ben")
        let p2 = Player(name: "Kazia")
        let p3 = Player(name: "Luke")
        let p4 = Player(name: "Riley")
        let game = Game(players: [p1, p2, p3, p4])

        let pieces = game.pieces(for: p1)
        pieces[0].location = .track(30)
        pieces[1].location = .track(30)
        pieces[2].location = .track(4)
        pieces[3].location = .track(24)
        
        let blockades = game.blockades()
        XCTAssertEqual(blockades.count, 1)
        XCTAssertEqual(blockades[0], 30)
    }
    
    func testNextPlayer() {
        let p1 = Player(name: "Ben")
        let p2 = Player(name: "Kazia")
        let p3 = Player(name: "Luke")
        let p4 = Player(name: "Riley")
        let game = Game(players: [p1, p2, p3, p4])
        
        XCTAssertEqual(game.nextPlayer(), p1)
        XCTAssertEqual(game.nextPlayer(), p2)
        XCTAssertEqual(game.nextPlayer(), p3)
        XCTAssertEqual(game.nextPlayer(), p4)
        XCTAssertEqual(game.nextPlayer(), p1)
    }
}
