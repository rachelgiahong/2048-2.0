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
    
  
    var size: Int {
            model.size
        }
    
    var playerName: String = ""
    
    var currentScore: Int {
            
        return grid.flatMap { $0 }.compactMap { $0 }.reduce(0) { $0 + ($1.getValue() ) }
        }
    
    init(size: Int) {
            model = GameModel(size: size)
        }
    
    func startGame() {
        model.startGame()
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

