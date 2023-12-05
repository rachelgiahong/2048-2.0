//
//  GameViewModel.swift
//  2048 2.0
//
//  Created by Rachel on 12/2/23.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var model: GameModel
    
    var grid: [[Tile?]] {
        model.board.getValues()
    }
    
    // Use a computed property to get the size from the model
    var size: Int {
        model.size // If size is a property in GameModel, access it without parentheses
    }
    
    var playerName: String = "" // Set this when you initialize the GameViewModel
    
    var currentScore: Int {
        // Adjust this calculation based on your GameModel and Tile class implementations
        return grid.flatMap { $0 }.compactMap { $0 }.reduce(0) { $0 + ($1.getValue() ?? 0) }
    }
    
    init(size: Int) {
        model = GameModel(size: size)
        // After initializing the GameModel, call the startGame method
        startGame() // Make sure this method exists and is implemented in GameModel
    }
    
    func startGame() {
        model.startGame() // Delegate the call to the model's startGame method
    }
    
    // Implement swipe methods which call model's respective methods and send updates to the view
    func swipeUp() {
        model.tilt(side: Side.north)
    }
    
    func swipeDown() {
        model.tilt(side: Side.south)
    }
    
    func swipeLeft() {
        model.tilt(side: Side.east)
    }
    
    func swipeRight() {
        model.tilt(side: Side.west)
    }
    
}

