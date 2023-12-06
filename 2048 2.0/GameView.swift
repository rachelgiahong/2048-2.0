//
//  GameView.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//


import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var playerName: String = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.pink.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("3072")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top, 5)

                HStack {
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.3))
                                        .frame(width: 200, height: 50)
                    Spacer()
                    Spacer()
                                }
                                .overlay(
                                
                                    HStack {
                                        Text("\(playerName)'s Score: \(viewModel.currentScore)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                        Spacer()
                                        Spacer()
                                    }
                                )
                                .padding(.leading, 30)
                                .padding(.bottom, 50)
                    

                
            
                ForEach(0..<viewModel.size, id: \.self) { row in
                    HStack {
                        ForEach(0..<viewModel.size, id: \.self) { column in
                            if let tile = viewModel.grid[row][column] {
                                Text("\(tile.getValue())")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.5))
                                    .cornerRadius(8)
                            } else {
                                Text("")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.5))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
        }
        .gesture(
            DragGesture().onEnded { gesture in
                let dragThreshold: CGFloat = 100.0

                let verticalAmount = gesture.translation.height
                let horizontalAmount = gesture.translation.width

                if abs(horizontalAmount) > abs(verticalAmount) {
                    if horizontalAmount < -dragThreshold {
                        viewModel.swipeLeft()
                    } else if horizontalAmount > dragThreshold {

                        viewModel.swipeRight()
                    }
                } else {
                    if verticalAmount < -dragThreshold {
                        viewModel.swipeUp()
                    } else if verticalAmount > dragThreshold {
                        viewModel.swipeDown()
                    }
                }
            }
        )
        .onAppear {
            viewModel.startGame()
        }
    }
}
