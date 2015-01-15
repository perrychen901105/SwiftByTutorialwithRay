//
//  Person.swift
//  MemoryLeakTest
//
//  Created by chenzhipeng on 15/1/15.
//  Copyright (c) 2015年 chenzhipeng. All rights reserved.
//

import Foundation

class Person {
    let name: String
    private let actionClosure: (() -> ())!
    
    init(name: String) {
        self.name = name
        actionClosure = {
            // defines a capture list for the closure, detailing the ownership semantics for the variables and constants that the closure captures. The capture list appears before the closure signature, and contains a list of variables inside square brackets.
            [unowned self] () -> () in
            println("I am \(self.name)")
        }
    }
    
    func performAction() {
        actionClosure()
    }
    
    deinit {
        println("\(name) is being deinitailized")
    }
    
}
