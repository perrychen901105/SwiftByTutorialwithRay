//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/27.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
    func cellStateChanged(location: BoardLocation)
}




