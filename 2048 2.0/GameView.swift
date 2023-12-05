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
        .gesture(
            DragGesture().onEnded { gesture in
                let dragThreshold: CGFloat = 100.0 // Define the minimum distance for a swipe to be recognized

                let verticalAmount = gesture.translation.height
                let horizontalAmount = gesture.translation.width

                if abs(horizontalAmount) > abs(verticalAmount) {
                    if horizontalAmount < -dragThreshold {
                        // Swipe Left
                        viewModel.swipeLeft()
                    } else if horizontalAmount > dragThreshold {
                        // Swipe Right
                        viewModel.swipeRight()
                    }
                } else {
                    if verticalAmount < -dragThreshold {
                        // Swipe Up
                        viewModel.swipeUp()
                    } else if verticalAmount > dragThreshold {
                        // Swipe Down
                        viewModel.swipeDown()
                    }
                }
            }
        )
        .onAppear {
            viewModel.startGame() // Start the game when this view appears
        }
    }
}

