//
//  GameView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI
import Foundation

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            ForEach(0..<viewModel.size, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.size, id: \.self) { column in
                        // Check if there is a tile at the given position
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
            // Determine direction and make corresponding move
        })
    }
}






