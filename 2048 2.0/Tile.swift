//
//  Tile.swift
//  2048 2.0
//
//  Created by Devaj Gupta on 12/2/23.
//

import Foundation
class Tile {
    let value: Int
    let row: Int
    let col: Int
    private(set) var next: Tile?

    // Make sure all these properties are initialized before the initializer returns
    public init(value: Int, col: Int = 0, row: Int = 0, next: Tile? = nil) {
        self.value = value
        self.row = row
        self.col = col
        self.next = next
    }

    static func create(value: Int, col: Int, row: Int) -> Tile {
        return Tile(value: value, col: col, row: row)
    }

    func move(toCol col: Int, toRow row: Int) -> Tile {
        let result = Tile(value: value, col: col, row: row)
        self.next = result
        return result
    }

    func merge(with otherTile: Tile, toCol col: Int, toRow row: Int) -> Tile {
        assert(self.value == otherTile.value)
        let mergedTile = Tile(value: 2 * self.value, col: col, row: row)
        self.next = mergedTile
        otherTile.next = mergedTile
        return mergedTile
    }

    func distToNext() -> Int {
        guard let nextTile = next else {
            return 0
        }
        return max(abs(row - nextTile.row), abs(col - nextTile.col))
    }
   
}
