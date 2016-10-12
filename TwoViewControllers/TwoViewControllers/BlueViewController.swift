//
//  BlueViewController.swift
//  TwoViewControllers
//
//  Created by ccsfcomputers on 9/27/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit

enum RPS {
    case Rock, Paper, Scissors  
}

class BlueViewController: UIViewController {
    
    var number: Int!
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationItem.title = "Blue!"
    }
    
    @IBAction func dismissMyself(sender: UIButton) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
                
        //label.text = "\(number ?? -1)"
    }
}
