//
//  MovementTests.swift
//  ParcheesiTests
//
//  Created by Benjamin Munson on 7/5/20.
//

import XCTest
@testable import Parcheesi

class MovementTestSupport {
    static func objects() -> (Player, Game, [Piece]) {
        let me = Player(name: "Ben")
        let game = Game(players: [me])
        let pieces = game.pieces(for: me)
        return (me, game, pieces)
    }
}

class MovementTests: XCTestCase {

    func testMovementOfPieceInCircle() {
        let (me, game, pieces) = MovementTestSupport.objects()
        
        var roll = Roll(numbers: [3,6])
        var moves = MoveFactory.moves(for: pieces[0], with: roll, in: game)
        XCTAssert(moves.count == 0)
        
        roll = Roll(numbers: [5, 3])
        moves = MoveFactory.moves(for: pieces[0], with: roll, in: game)
        XCTAssert(moves.count == 1)
        XCTAssertEqual(moves[0], Move(start: .circle(me), end: .track(0)))
    }
    
    func testMovementOfPieceOnTrack() {
        let (_, game, pieces) = MovementTestSupport.objects()
        
        var roll = Roll(numbers: [6, 5])
        pieces[0].location = .track(5)
        var moves = MoveFactory.moves(for: pieces[0], with: roll, in: game)
        XCTAssertTrue(moves.contains(Move(start: .track(5), end: .track(16))))
        XCTAssertTrue(moves.contains(Move(start: .track(5), end: .track(10))))
        XCTAssertTrue(moves.contains(Move(start: .track(5), end: .track(11))))
        
        roll = Roll(numbers: [5, 5])
        moves = MoveFactory.moves(for: pieces[0], with: roll, in: game)
        for number in [2,4,5,7,9,10,12,14] {
            XCTAssertTrue(moves.contains(Move(start: .track(5), end: .track(5 + number))))
        }
    }
    
    func testMovementOfPieceWithBlockade() {
        let (_, game, pieces) = MovementTestSupport.objects()
        let player2 = game.players[1]
        let otherPieces = game.pieces(for: player2)
        
        otherPieces[0].location = .track(20)
        otherPieces[1].location = .track(20)
        
        let piece = pieces[0]
        piece.location = .track(14)
        
        let roll = Roll(numbers: [6, 2])
        let moves = MoveFactory.moves(for: piece, with: roll, in: game)
            
        XCTAssertEqual(moves.count, 1)
    }
        
    func testMovementOfPieceWithOffRamp() {
        let (me, game, pieces) = MovementTestSupport.objects()
        
        var piece = pieces[0]
        piece.location = .track(60)
        var roll = Roll(numbers: [2,6])
        var moves = MoveFactory.moves(for: piece, with: roll, in: game)

        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .ramp(me, 3))))
        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .ramp(me, 5))))
        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .track(62))))
        
        piece = game.pieces(for: game.players[1])[0]
        piece.location = .track(60)
        roll = Roll(numbers: [6, 5])
        moves = MoveFactory.moves(for: piece, with: roll, in: game)

        XCTAssert(moves.count > 0)
        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .track(66))))
        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .track(65))))
        XCTAssertTrue(moves.contains(Move(start: .track(60), end: .track(4))))
    }
    
}
