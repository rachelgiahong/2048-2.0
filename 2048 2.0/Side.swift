//
//  Side.swift
//  2048 2.0
//
//  Created by Cassie Aquino on 12/2/23.
//

import Foundation

enum Side {
    case north, east, south, west

    // Computed properties instead of stored properties
    public var col0: Int {
        switch self {
        case .north, .south:
            return 0
        case .east:
            return 1
        case .west:
            return -1
        }
    }

    public var row0: Int {
        switch self {
        case .north:
            return 0
        case .east, .west:
            return 1
        case .south:
            return -1
        }
    }

    public var dcol: Int {
        switch self {
        case .east:
            return 1
        case .west:
            return -1
        case .north, .south:
            return 0
        }
    }

    public var drow: Int {
        switch self {
        case .north:
            return 1
        case .south:
            return -1
        case .east, .west:
            return 0
        }
    }

    // Methods or computed properties that use the computed properties
    func col(_ c: Int, _ r: Int, _ size: Int) -> Int {
        return col0 * (size - 1) + c * drow + r * dcol
    }

    func row(_ c: Int, _ r: Int, _ size: Int) -> Int {
        return row0 * (size - 1) - c * dcol + r * drow
    }

    // Static method to get the opposite side
    static func opposite(_ side: Side) -> Side {
        switch side {
        case .north:
            return .south
        case .south:
            return .north
        case .east:
            return .west
        case .west:
            return .east
        }
    }
}
