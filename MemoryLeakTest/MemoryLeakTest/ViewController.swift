//
//  ViewController.swift
//  MemoryLeakTest
//
//  Created by chenzhipeng on 15/1/15.
//  Copyright (c) 2015年 chenzhipeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person(name: "bob")
        person.performAction()
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

