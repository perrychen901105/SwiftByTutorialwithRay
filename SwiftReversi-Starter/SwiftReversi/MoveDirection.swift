//
//  MoveDirection.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/27.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

enum MoveDirection {
    case North, South, East, West, NorthEast, NorthWest, SouthEast, SouthWest
    
    // calculate the new BoardLocation from an existing location and the current direction
    func move(loc: BoardLocation) -> BoardLocation {
        switch self {
        case .North:
            return BoardLocation(row: loc.row-1, column: loc.column)
        case .South:
            return BoardLocation(row: loc.row+1, column: loc.column)
        case .East:
            return BoardLocation(row: loc.row, column: loc.column-1)
        case .West:
            return BoardLocation(row: loc.row, column: loc.column+1)
        case .NorthEast:
            return BoardLocation(row: loc.row-1, column: loc.column-1)
        case .NorthWest:
            return BoardLocation(row: loc.row-1, column: loc.column+1)
        case .SouthEast:
            return BoardLocation(row: loc.row+1, column: loc.column-1)
        case .SouthWest:
            return BoardLocation(row: loc.row+1, column: loc.column+1)
        }
    }
    
    static let directions: [MoveDirection] = [.North, .South, .East, .West, .NorthEast, .NorthWest, .SouthWest, .SouthEast]
}

