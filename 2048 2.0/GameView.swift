//
//  GameView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            // Display the current score
            Text("Score: \(viewModel.currentScore)")
                .font(.headline)
                .padding()

            // Display the game board
            ForEach(0..<viewModel.size, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.size, id: \.self) { column in
                        if let tile = viewModel.grid[row][column] {
                            // If there is a tile, display its value
                            Text("\(tile.getValue())")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(8)
                        } else {
                            // If there is not a tile, display an empty space
                            Text("")
                                .frame(width: 60, height: 60)
                                .background(Color.blue.opacity(0.5))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .gesture(DragGesture().onEnded { gesture in
            // Add logic to determine direction and call viewModel methods to update the game state
        })
        .onAppear {
            viewModel.startGame() // Start the game when this view appears
        }
    }
}

