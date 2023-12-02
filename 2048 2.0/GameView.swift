//
//  GameView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import Foundation

class Game2048 {
    var grid: [[Int]]
    let gridSize: Int
    var score: Int = 0

    init(size: Int) {
        self.gridSize = size
        self.grid = Array(repeating: Array(repeating: 0, count: size), count: size)
        addNewTile()
        addNewTile()
    }

    func addNewTile() {
        var emptyTiles = [(Int, Int)]()
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                if grid[i][j] == 0 {
                    emptyTiles.append((i, j))
                }
            }
        }
        
        if let randomTile = emptyTiles.randomElement() {
            grid[randomTile.0][randomTile.1] = (Int.random(in: 1...10) == 1) ? 4 : 2
        }
    }

    func swipeLeft() {
        for i in 0..<gridSize {
            var tempRow = grid[i].filter { $0 != 0 } // Remove all zeros
            for j in 1..<tempRow.count {
                if tempRow[j] == tempRow[j - 1] {
                    tempRow[j - 1] *= 2
                    tempRow[j] = 0
                    score += tempRow[j - 1]
                }
            }
            tempRow = tempRow.filter { $0 != 0 } // Remove all zeros again after merging
            grid[i] = tempRow + Array(repeating: 0, count: gridSize - tempRow.count)
        }
        addNewTile()
    }
    
    // You need to implement swipeRight, swipeUp, and swipeDown by modifying the logic above

    func isGameOver() -> Bool {
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                if grid[i][j] == 0 ||
                   (i < gridSize - 1 && grid[i][j] == grid[i + 1][j]) ||
                   (j < gridSize - 1 && grid[i][j] == grid[i][j + 1]) {
                    return false
                }
            }
        }
        return true
    }
    
    func printGrid() {
        for row in grid {
            print(row)
        }
        print("Score: \(score)")
    }
}


import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var game: Game2048
    @Published var gameOver: Bool = false

    init(size: Int) {
        self.game = Game2048(size: size)
    }

    func swipeLeft() {
        game.swipeLeft()
        checkGameOver()
    }

    // Add similar methods for swipeRight, swipeUp, swipeDown

    private func checkGameOver() {
        if game.isGameOver() {
            gameOver = true
        }
    }
}

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    var username: String

    var body: some View {
        VStack {
            Text("Welcome Back, \(username)!")
                .font(.headline)

            // Add gesture recognizers here for swiping and call viewModel methods

            ForEach(0..<viewModel.game.gridSize, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.game.gridSize, id: \.self) { column in
                        Text("\(viewModel.game.grid[row][column])")
                            .frame(width: 60, height: 60)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .padding(4)
                    }
                }
            }

            if viewModel.gameOver {
                Text("Game Over!")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.game.printGrid() // For debugging, can be removed later
        }
    }
}




