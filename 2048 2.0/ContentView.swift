//
//  ContentView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("2048 Game")
                    .font(.largeTitle)
                    .padding()
                
                GameView(viewModel: GameViewModel)

                // A button that, when tapped, will navigate to the GameView
                NavigationLink(destination: GameView(viewModel: GameViewModel(size: 4), username: "Player 1")) {
                    Text("Start Game")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                // You can add more buttons or views for other features
                // For example, a button to view high scores or settings
            }
        }
    }
}




