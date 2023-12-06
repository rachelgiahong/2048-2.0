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
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("3076")
                        .font(.system(size: 60, weight:
                                .black, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
                        .padding(.bottom, 50)
                    
                    GameView(viewModel: viewModel)
                    NavigationLink(destination: GameView(viewModel: GameViewModel(size: 4))) {
                        Text("Play Game")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                }
            }
        }
    }
}
