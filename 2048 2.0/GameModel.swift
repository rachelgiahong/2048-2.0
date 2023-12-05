//
//  GameModel.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import Foundation
import Combine

class GameModel: ObservableObject {
    @Published var board: Board
    @Published var score: Int
    @Published var maxScore: Int
    @Published var gameOver: Bool

    static let MAX_PIECE = 2048

    // Assuming Board has a size property, grid array and methods for game logic
    init(size: Int) {
        board = Board(size: size)
        score = 0
        maxScore = 0
        gameOver = false
    }
    
    // The size of the board is a computed property that retrieves the size from the Board object
    var size: Int {
        board.size()
    }

    func startGame() {
            board.clear()
            board.spawnRandomTile()
            board.spawnRandomTile()
        }
        
    
    func isGameOver() -> Bool {
        // Implement game over logic here
        return gameOver
    }
    
    
    
    func currentScore() -> Int {
        // Implement current score calculation here
        return score
    }
    
    func currentMaxScore() -> Int {
        return maxScore
    }
    
    func clear() {
        score = 0
        gameOver = false
        board.clear()
        objectWillChange.send()
    }
    
    func hotStartAnnounce() {
        objectWillChange.send()
    }
    
    func addTile(tile: Tile) {
        board.addTile(tile: tile)
        checkGameOver()
        objectWillChange.send()
    }
    
    func tilt(side: Side) {
        moveTopTile(board: board, side: side)
        score += columnMerge(board: board, side: side)
        columnMove(board: board, side: side)
        checkGameOver()
    }
    
    func columnMerge(board: Board, side: Side) -> Int {
        board.setViewingPerspective(side: side)
        var score = 0
        for c in 0..<board.size() {
            for row_topTile in (1..<board.size()).reversed() {
                guard let topTile = board.tile(col: c, row: row_topTile) else {
                    continue
                }
                
                for r in (0..<row_topTile).reversed() {
                    guard let currTile = board.tile(col: c, row: r) else {
                        continue
                    }
                    
                    if topTile.getValue() != currTile.getValue() {
                        break
                    } else if topTile.getValue() == currTile.getValue() {
                        board.move(col: c, row: row_topTile, tile: currTile)
                        score += topTile.getValue() * 2
                        break
                    }
                }
            }
        }
        board.setViewingPerspective(side: Side.north)
        return score
    }
    
    func moveTopTile(board: Board, side: Side) {
        board.setViewingPerspective(side: side)
        for c in 0..<board.size() {
            for r in (0..<board.size()).reversed() {
                guard let topTile = board.tile(col: c, row: r) else {
                    continue
                }
                
                board.move(col: c, row: board.size() - 1, tile: topTile)
                break
            }
        }
        board.setViewingPerspective(side: Side.north)
    }
    
    func columnMove(board: Board, side: Side) {
        board.setViewingPerspective(side: side)
        var rParameter = board.size() - 2
        
        for c in 0..<board.size() {
            for r in (0..<board.size()).reversed() {
                guard let tile = board.tile(col: c, row: r), rParameter >= 0 else {
                    continue
                }
                
                board.move(col: c, row: rParameter, tile: tile)
                rParameter -= 1
            }
            rParameter = board.size() - 2
        }
        board.setViewingPerspective(side: Side.north)
    }
    
    private func checkGameOver() {
        gameOver = GameModel.checkGameOver(board: board)
    }
    
    private static func checkGameOver(board: Board) -> Bool {
        return maxTileExists(board: board) || !GameModel.atLeastOneMoveExists(b: board)
    }
    
    static func emptySpaceExists(board: Board) -> Bool {
        for c in 0..<board.size() {
            for r in 0..<board.size() {
                if board.tile(col: c, row: r) == nil {
                    return true
                }
            }
        }
        return false
    }
    
    static func maxTileExists(board: Board) -> Bool {
        for c in 0..<board.size() {
            for r in 0..<board.size() {
                if let tile = board.tile(col: c, row: r), tile.getValue() == MAX_PIECE {
                    return true
                }
            }
        }
        return false
    }
    
    private static func atLeastOneMoveExists(b: Board) -> Bool {
        for c in 0..<b.size() {
            for r in 0..<b.size() {
                if b.tile(col: c, row: r) == nil {
                    return true
                } else if let currentTile = b.tile(col: c, row: r) {
                    if c != 3 && b.tile(col: c + 1, row: r) != nil {
                        if currentTile.getValue() == b.tile(col: c + 1, row: r)!.getValue() {
                            return true
                        }
                    }
                    if c != 0 && b.tile(col: c - 1, row: r) != nil {
                        if currentTile.getValue() == b.tile(col: c - 1, row: r)!.getValue() {
                            return true
                        }
                    }
                    if r != 3 && b.tile(col: c, row: r + 1) != nil {
                        if currentTile.getValue() == b.tile(col: c, row: r + 1)!.getValue() {
                            return true
                        }
                    }
                    if r != 0 && b.tile(col: c, row: r - 1) != nil {
                        if currentTile.getValue() == b.tile(col: c, row: r - 1)!.getValue() {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
}

