//
//  ViewController.swift
//  TwoViewControllers
//
//  Created by ccsfcomputers on 9/27/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit

private enum SegueIdentifier: String {
    case PresentBlue, PresentRed
}

class OrangeViewController: UIViewController {

    let PresentBlue = "PresentBlue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Go Orange", style: .Plain, target: nil, action:nil)

        self.navigationItem.title = "Orange!"
        
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func backWasPressed() {
        print("back was pressed")
    }
    
    @IBAction func showBlue(sender: UIButton) {
        let c = self.storyboard!.instantiateViewControllerWithIdentifier("BlueViewController")
        
        self.navigationController!.pushViewController(c, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let segueID = SegueIdentifier(rawValue: segue.identifier!)!
        
        switch segueID {
        case .PresentBlue:
            let blueVC = segue.destinationViewController as! BlueViewController
            blueVC.number = 55
        case .PresentRed:
            print("Present red...")
        }
    }
}

