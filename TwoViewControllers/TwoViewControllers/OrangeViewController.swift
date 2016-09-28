//
//  ViewController.swift
//  TwoViewControllers
//
//  Created by ccsfcomputers on 9/27/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit

class OrangeViewController: UIViewController {


    @IBAction func    showBlue(sender: UIButton) {
        // 1. Get a Blue View Controller
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("BlueViewController")
        let blueViewController = controller as! BlueViewController
        
        // 2. Configure the new View Controller
        blueViewController.number = Int(arc4random()) % 3
        
        // 3. Present the BlueVC
        showViewController(blueViewController, sender: self)
    }
}

