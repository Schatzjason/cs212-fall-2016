//
//  ViewController.swift
//  Storyboard Click Count
//
//  Created by ccsfcomputers on 9/6/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model: Int = 0
    
    @IBOutlet var label: UILabel!
    
    @IBAction func incrementCount() {
        self.model += 1
        self.label.text = "\(self.model)"
    }
}

