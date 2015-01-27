//
//  DelegateMulticast.swift
//  SwiftReversi
//
//  Created by chenzhipeng on 15/1/27.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

class DelegateMulticast<T> {
    
    private var delegates = [T]()
    
    func addDelegate(delegate: T) {
        delegates.append(delegate)
    }
    
    func invokeDelegates(invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}

