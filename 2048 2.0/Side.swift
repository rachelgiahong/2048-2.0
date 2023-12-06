//
//  Side.swift
//  2048 2.0
//
//  Created by Cassie Aquino on 12/2/23.
//

import Foundation

enum Side {
    case north, east, south, west

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

   
    func col(_ c: Int, _ r: Int, _ size: Int) -> Int {
        switch self {
        case .north:
            return c
        case .south:
            return size - 1 - c
        case .east:
            return r
        case .west:
            return size - 1 - r
        }
    }

    func row(_ c: Int, _ r: Int, _ size: Int) -> Int {
        switch self {
        case .north:
            return r
        case .south:
            return size - 1 - r
        case .east:
            return size - 1 - c
        case .west:
            return c
        }
    }

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
