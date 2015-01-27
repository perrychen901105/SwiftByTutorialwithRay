//
//  BoardCellState.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/26.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

enum BoardCellState {
    case Empty, Black, White
    
    
    func invert() -> BoardCellState {
        if self == Black {
            return White
        } else if self == White {
            return Black
        }
        assert(self != Empty, "cannnot invert the empty state")
        return Empty
    }
}




