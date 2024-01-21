//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Carlos Alban on 1/19/24.
//

import XCTest
@testable import TicTacToe

final class TicTacToeTests: XCTestCase {
    
    private static let xWinRow0 =    [[GameTile(id: 0, value: .x), GameTile(id: 1, value: .x), GameTile(id: 2, value: .x)],
                                     [GameTile(id: 3, value: .empty), GameTile(id: 4, value: .empty), GameTile(id: 5, value: .empty)],
                                     [GameTile(id: 6, value: .empty), GameTile(id: 7, value: .empty), GameTile(id: 8, value: .empty)],]
    private static let xWinRow1 =    [[GameTile(id: 0, value: .empty), GameTile(id: 1, value: .empty), GameTile(id: 2, value: .empty)],
                                     [GameTile(id: 3, value: .x), GameTile(id: 4, value: .x), GameTile(id: 5, value: .x)],
                                     [GameTile(id: 6, value: .empty), GameTile(id: 7, value: .empty), GameTile(id: 8, value: .empty)],]
    private static let xWinRow2 =    [[GameTile(id: 0, value: .empty), GameTile(id: 1, value: .empty), GameTile(id: 2, value: .empty)],
                                     [GameTile(id: 3, value: .empty), GameTile(id: 4, value: .empty), GameTile(id: 5, value: .empty)],
                                     [GameTile(id: 6, value: .x), GameTile(id: 7, value: .x), GameTile(id: 8, value: .x)],]
    
    func testXRow0Win() {
        let viewModel = GameViewModel(currentPlayer: .x, movesLeft: 6, gameData: Self.xWinRow0, gameStatusDescription: "", isGameEnded: false)
        XCTAssertTrue(viewModel.didWinGame(), "Expected winning condition")
    }
    
    func testXRow1Win() {
        let viewModel = GameViewModel(currentPlayer: .x, movesLeft: 6, gameData: Self.xWinRow1, gameStatusDescription: "", isGameEnded: false)
        XCTAssertTrue(viewModel.didWinGame(), "Expected winning condition")
    }
    
    func testXRow2Win() {
        let viewModel = GameViewModel(currentPlayer: .x, movesLeft: 6, gameData: Self.xWinRow2, gameStatusDescription: "", isGameEnded: false)
        XCTAssertTrue(viewModel.didWinGame(), "Expected winning condition")
    }
}
