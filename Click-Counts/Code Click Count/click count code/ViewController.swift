//
//  ViewController.swift
//  click count code
//
//  Created by ccsfcomputers on 9/6/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model: Counter!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = Counter()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        //create the label
        let labelframe = CGRect(x: 100, y: 100, width: 140, height: 70)
        self.label = UILabel(frame: labelframe)
        self.view.addSubview(self.label)
        self.label.font = UIFont.systemFontOfSize(90)
        self.label.text = "\(self.model.count)"
        
        //create the increment button
        let button = UIButton(type: .System)
        button.frame = CGRect(x: 100, y: 200, width: 70, height: 70)
        button.setTitle("Plus", forState: .Normal)
        self.view.addSubview(button)
        
        //create the decrement button
        let minusButton = UIButton(type: .System)
        minusButton.frame = CGRect(x: 160, y: 200, width: 70, height: 70)
        minusButton.setTitle("Minus", forState: .Normal)
        self.view.addSubview(minusButton)
        
        //give the button a target action
        button.addTarget(self, action: #selector(incrementLabel), forControlEvents: .TouchDown)
        
        minusButton.addTarget(self, action: #selector(decrementLabel), forControlEvents: .TouchDown)
        
    }
    
    @objc func incrementLabel() {
        self.model.increment()
        self.label.text = "\(self.model.count)"
    }
    
    @objc func decrementLabel() {
        self.model.decrement()
        self.label.text = "\(self.model.count)"
    }

    


}

