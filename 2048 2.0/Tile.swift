//
//  Tile.swift
//  2048 2.0
//
//  Created by Devaj Gupta on 12/2/23.
//

import Foundation

class Tile: Equatable {
    private let value: Int
    private let row: Int
    private let col: Int
    private var next: Tile?

    private init(value: Int, col: Int, row: Int) {
        self.value = value
        self.row = row
        self.col = col
        self.next = nil
    }

    func getRow() -> Int {
        return row
    }

    func getCol() -> Int {
        return col
    }

    func getValue() -> Int {
        return value
    }

    func getNext() -> Tile {
        return next ?? self
    }

    static func create(value: Int, col: Int, row: Int) -> Tile {
        return Tile(value: value, col: col, row: row)
    }

    func move(col: Int, row: Int) -> Tile {
        let result = Tile(value: value, col: col, row: row)
        next = result
        return result
    }

    func merge(col: Int, row: Int, otherTile: Tile) -> Tile {
        precondition(value == otherTile.getValue(), "Values must be equal for merging.")
        let mergedTile = Tile(value: 2 * value, col: col, row: row)
        
        if let unwrappedNext = next {
            unwrappedNext.next = mergedTile
        }
        next = mergedTile
        
        if let unwrappedOtherNext = otherTile.next {
            unwrappedOtherNext.next = mergedTile
        }
        otherTile.next = mergedTile

        return mergedTile
    }

    func distToNext() -> Int {
        if next == nil {
            return 0
        } else {
            return max(abs(row - next!.getRow()), abs(col - next!.getCol()))
        }
    }

    static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.value == rhs.value && lhs.row == rhs.row && lhs.col == rhs.col
    }

    var description: String {
        return "\(value)@(\(col), \(row))"
    }
}
