//
//  GameModel.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import Foundation

class GameModel {
    var grid: [[Tile?]]
    var score: Int = 0
    
    init(size: Int) {
        grid = Array(repeating: Array(repeating: nil, count: size), count: size)

            for row in 0..<size {
                for col in 0..<size {
                    grid[row][col] = Tile(value: 0, col: col, row: row)
                }
            }
        addRandomTile()
        addRandomTile()
    }
    
    // Functions to add tiles, move tiles, merge tiles, etc.
    
    func addRandomTile() {
        
    }
    
    
    // Movement functions
    func swipeLeft() {
        // Logic for swiping left
    }
    
    // Additional functions for other swipes
}
