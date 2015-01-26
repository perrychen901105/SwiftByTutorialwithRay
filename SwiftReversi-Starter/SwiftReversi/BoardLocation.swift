//
//  BoardLocation.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/26.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

struct BoardLocation {
    let row: Int, column: Int
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
