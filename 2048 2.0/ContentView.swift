//
//  ContentView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel(size: 4)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("2048 Game")
                    .font(.largeTitle)
                    .padding()
                
                GameView(viewModel: viewModel)
                NavigationLink(destination: GameView(viewModel: GameViewModel(size: 4))) {
                    Text("Start Game")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }

            }
        }
    }
}
