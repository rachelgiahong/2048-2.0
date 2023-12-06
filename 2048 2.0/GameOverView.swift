//
//  GameOverView.swift
//  2048 2.0
//
//  Created by Rachel on 12/5/23.
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    var restartAction: () -> Void
    var mainMenuAction: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Game Over!")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)

                Text("Your Score: \(score)")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)

                Button(action: restartAction) {
                    Text("Play Again")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }

                Button(action: mainMenuAction) {
                    Text("Main Menu")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 1234, restartAction: {}, mainMenuAction: {})
    }
}
