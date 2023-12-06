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
    @StateObject private var viewModel = GameViewModel(size: 4)

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("in multiples of 3!")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    
                    Text("3072")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        
                    TextField("Please enter your name:", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    NavigationLink(isActive: $isGameViewActive) {
                        GameView(viewModel: viewModel, playerName: username)
                    } label: {
                        Text("Play Game!")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    
                }
            }
        }
    }
}


