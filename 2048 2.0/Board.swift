//
//  Board.swift
//  2048 2.0
//
//  Created by Cassie Aquino on 12/2/23.
//

import Foundation

class Board {
    private var values: [[Tile?]]
    private var viewPerspective: Side
    
    var grid: [[Tile?]] {
        var tilesGrid = [[Tile?]]()
        let size = self.size()
        for row in 0..<size {
            var rowTiles = [Tile?]()
            for col in 0..<size {
                rowTiles.append(self.tile(col: col, row: row)) // Use `self` instead of `board`
            }
            tilesGrid.append(rowTiles)
        }
        return tilesGrid
    }

    init(size: Int) {
        guard size > 0 else {
            fatalError("Invalid size: \(size). Size must be greater than 0.")
        }

        values = Array(repeating: Array(repeating: nil, count: size), count: size)
        viewPerspective = Side.north
    }
    
    init(rawValues: [[Int]]) {
            let size = rawValues.count
            values = Array(repeating: Array(repeating: nil, count: size), count: size)
            viewPerspective = Side.north

            for col in 0..<size {
                for row in 0..<size {
                    let value = rawValues[size - 1 - row][col]
                    if value != 0 {
                        let tile = Tile.create(value: value, col: col, row: row)
                        addTile(tile: tile)
                    }
                }
            }
        }
    
    func spawnRandomTile() {
           let emptyPositions = findEmptyPositions()
           
           guard let randomPosition = emptyPositions.randomElement() else {
               return // No available positions to place a new tile
           }
           
           let tileValue = Int.random(in: 1...10) == 1 ? 4 : 2 // 10% chance of being a 4
           let newTile = Tile(value: tileValue, col: randomPosition.col, row: randomPosition.row)
           self.setTile(newTile, at: randomPosition)
       }
    
    private func setTile(_ tile: Tile, at position: (row: Int, col: Int)) {
            values[position.row][position.col] = tile
        }
    
    private func findEmptyPositions() -> [(row: Int, col: Int)] {
            var emptyPositions = [(row: Int, col: Int)]()
            for row in 0..<self.size() {
                for col in 0..<self.size() {
                    if self.tile(col: col, row: row) == nil {
                        emptyPositions.append((row, col))
                    }
                }
            }
            return emptyPositions
        }

    func setViewingPerspective(side: Side) {
        viewPerspective = side
    }

    func size() -> Int {
        return values.count
    }

    func tile(col: Int, row: Int) -> Tile? {
        return values[viewPerspective.col(col, row, size())][viewPerspective.row(col, row, size())]
    }

    func clear() {
        values = Array(repeating: Array(repeating: nil, count: size()), count: size())
    }

    func addTile(tile: Tile) {
        values[tile.getCol()][tile.getRow()] = tile
    }

    func move(col: Int, row: Int, tile: Tile) -> Bool {
        let pcol = viewPerspective.col(col, row, size())
        let prow = viewPerspective.row(col, row, size())

        guard tile.getCol() != pcol || tile.getRow() != prow else {
            return false
        }

        let tile1 = self.tile(col: col, row: row)
        values[tile.getCol()][tile.getRow()] = nil

        if let tile1 = tile1 {
            values[pcol][prow] = tile.merge(col: pcol, row: prow, otherTile: tile1)
            return true
        } else {
            values[pcol][prow] = tile.move(col: pcol, row: prow)
            return false
        }
    }
    
    func makeIterator() -> AllTileIterator {
        return AllTileIterator(board: self)
    }

    var description: String {
        var result = "\n[\n"

        for row in stride(from: size() - 1, through: 0, by: -1) {
            for col in 0..<size() {
                if let currentTile = tile(col: col, row: row) {
                    result += String(format: "|%4d", currentTile.getValue())
                } else {
                    result += "|    "
                }
            }
            result += "|\n"
        }

        return result
    }
}

class AllTileIterator: IteratorProtocol {
    private let board: Board
    private var r: Int
    private var c: Int

    init(board: Board) {
        self.board = board
        r = 0
        c = 0
    }

    func next() -> Tile? {
        let tile = board.tile(col: c, row: r)
        c += 1

        if c == board.size() {
            c = 0
            r += 1
        }

        return tile
    }
}
