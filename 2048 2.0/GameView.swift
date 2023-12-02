//
//  GameView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI
import Foundation

struct GameView: View {
    @ObservedObject var viewModel: GameView
    
    var body: some View {
        // A grid of views representing the game board
        VStack {
            ForEach(0..<viewModel.size, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.size, id: \.self) { column in
                        Text("\(viewModel.grid[row][column])")
                            .frame(width: 60, height: 60)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(8)
                    }
                }
            }
        }
        .gesture(DragGesture()
            .onEnded { gesture in
                // Determine direction and make corresponding move
            }
        )
    }
}





