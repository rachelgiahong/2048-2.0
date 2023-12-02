//
//  MainMenuView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import SwiftUI

struct MainMenuView: View {
    @State private var username: String = ""
    @State private var isGameViewActive: Bool = false
    @StateObject private var viewModel = GameViewModel(size: 4) // Initialize the GameViewModel here

    var body: some View {
        NavigationView {
            VStack {
                Text("2048 Game")
                    .font(.largeTitle)

                TextField("Please enter your name:", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                NavigationLink(destination: GameView(viewModel: viewModel, username: username), isActive: $isGameViewActive) {
                    Button("Start Game") {
                        isGameViewActive = true
                    }
                }
            }
        }
    }
}



