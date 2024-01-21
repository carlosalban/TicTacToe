//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Carlos Alban on 1/21/24.
//

import Foundation

class GameViewModel: ObservableObject {
    enum Player: CustomStringConvertible {
        case x, o
        
        var description: String {
            switch self {
            case .o:
                "O"
            case .x:
                "X"
            }
        }
    }
    
    private static let cleanBoard = [[GameTile(id: 0, value: .empty), GameTile(id: 1, value: .empty), GameTile(id: 2, value: .empty)],
                                     [GameTile(id: 3, value: .empty), GameTile(id: 4, value: .empty), GameTile(id: 5, value: .empty)],
                                     [GameTile(id: 6, value: .empty), GameTile(id: 7, value: .empty), GameTile(id: 8, value: .empty)],]
    
    var currentPlayer: Player = .x // X always goes first
    var movesLeft = 9
    
    @Published var gameData = GameViewModel.cleanBoard
    @Published var gameStatusDescription: String = ""
    
    private(set) var isGameEnded: Bool = false
    
    init() {
        updateGameStatusDescriptionForCurrentPlayer()
    }
    
    init(currentPlayer: Player, movesLeft: Int = 9, gameData: [[GameTile]] = GameViewModel.cleanBoard, gameStatusDescription: String, isGameEnded: Bool) {
        self.currentPlayer = currentPlayer
        self.movesLeft = movesLeft
        self.gameData = gameData
        self.gameStatusDescription = gameStatusDescription
        self.isGameEnded = isGameEnded
        updateGameStatusDescriptionForCurrentPlayer()
    }
    
    func tileDisplayString(id: Int) -> String? {
        return tileData(id: id)?.displayValue
    }
    
    func playerTouchedTile(id: Int) {
        guard tileIsEnabled(id: id) && !isGameEnded else {
            return
        }
        
        let updatedValue: GameTile.Value = currentPlayer == .x ? .x : .o
        updateTileValue(id: id, updatedValue: updatedValue)
        movesLeft -= 1
        
        if didWinGame() {
            isGameEnded = true
            gameStatusDescription = "Player \(currentPlayer.description) wins!"
        } else if movesLeft < 1 {
            // No moves left, tie game
            isGameEnded = true
            gameStatusDescription = "Tie Game!"
        } else {
            // Next player's turn
            switch currentPlayer {
            case .x:
                currentPlayer = .o
            case .o:
                currentPlayer = .x
            }
            updateGameStatusDescriptionForCurrentPlayer()
        }
    }
    
    func resetGame() {
        gameData = Self.cleanBoard
        isGameEnded = false
        currentPlayer = .x
        movesLeft = 9
        updateGameStatusDescriptionForCurrentPlayer()
    }
    
    func didWinGame() -> Bool {
        var didWin = false
        let firstRowWin    = isWinningLine(values: gameData[0].map { $0.value })
        let secondRowWin   = isWinningLine(values: gameData[1].map { $0.value })
        let thirdRowWin    = isWinningLine(values: gameData[2].map { $0.value })
        let firstColWin    = isWinningLine(values: [gameData[0][0].value, gameData[1][0].value, gameData[2][0].value])
        let secondColWin   = isWinningLine(values: [gameData[0][1].value, gameData[1][1].value, gameData[2][1].value])
        let thirdColWin    = isWinningLine(values: [gameData[0][2].value, gameData[1][2].value, gameData[2][2].value])
        let topLeftDiaWin  = isWinningLine(values: [gameData[0][0].value, gameData[1][1].value, gameData[2][2].value])
        let topRightDiaWin = isWinningLine(values: [gameData[0][2].value, gameData[1][1].value, gameData[2][0].value])
        didWin = firstRowWin || secondRowWin || thirdRowWin || firstColWin || secondColWin || thirdColWin || topLeftDiaWin || topRightDiaWin
        return didWin
    }
    
    private func isWinningLine(values: [GameTile.Value]) -> Bool {
        let set = Set(values)
        return set.count == 1 && set.first != .empty
    }
    
    private func updateGameStatusDescriptionForCurrentPlayer() {
        gameStatusDescription = "Player turn: \(currentPlayer.description)"
    }
    
    private func tileIndicies(id: Int) -> (row: Int, col: Int)? {
        guard (0...8).contains(id) else {
            assertionFailure("Id is out of range! id: \(id)")
            return nil
        }
        let row = id / 3
        let col = id % 3
        return (row, col)
    }
    
    private func updateTileValue(id: Int, updatedValue: GameTile.Value) {
        guard let tileIndicies = tileIndicies(id: id) else { return }
        gameData[tileIndicies.row][tileIndicies.col] = GameTile(id: id, value: updatedValue)
    }
    
    private func tileData(id: Int) -> GameTile? {
        guard let tileIndicies = tileIndicies(id: id) else {
            return nil
        }
        return gameData[tileIndicies.row][tileIndicies.col]
    }
    
    private func tileIsEnabled(id: Int) -> Bool {
        let tile = tileData(id: id)
        return tile?.value == .empty
    }
}
