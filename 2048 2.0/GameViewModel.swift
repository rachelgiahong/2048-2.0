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
    
    var grid: [[Int]] {
        model.grid
    }
    
    var size: Int {
        model.grid.count
    }
    
    init(size: Int) {
        model = GameModel(size: size)
    }
    
    // Call model functions based on user input
    func swipeLeft() {
        model.swipeLeft()
        objectWillChange.send() // Notify the view to update
    }
    
    // Additional methods for other swipes
}
