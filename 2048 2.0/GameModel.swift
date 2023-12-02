//
//  GameModel.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import Foundation

class GameModel {
    var grid: [[Int]]
    var score: Int = 0
    
    init(size: Int) {
        grid = Array(repeating: Array(repeating: 0, count: size), count: size)
        // Initialize with two tiles
        addRandomTile()
        addRandomTile()
    }
    
    // Functions to add tiles, move tiles, merge tiles, etc.
    
    func addRandomTile() {
        // Logic to add a new tile at a random position
    }
    
    // Movement functions
    func swipeLeft() {
        // Logic for swiping left
    }
    
    // Additional functions for other swipes
}
