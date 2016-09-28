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
    
    var usersThrow: RPS!
    
    @IBOutlet var label: UILabel!
    
    @IBAction func dismissMyself(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        label.text = "\(number)"
    }
}
