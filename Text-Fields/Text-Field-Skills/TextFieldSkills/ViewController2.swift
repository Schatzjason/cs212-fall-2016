//
//  ViewController2.swift
//  TextFieldSkills
//
//  Created by Jason Schatz on 9/20/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet var textField: UITextField!
    
    let lighteningString = "⚡"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the Button
        let button = UIButton(type: .Custom)
        let boltImage = UIImage(named: "lightening-bolt")!
        button.setImage(boltImage, forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        
        // Add Target Method
        button.addTarget(self, action: #selector(addLightening), forControlEvents: .TouchDown)
        
        // Place the button in the right side of the text field
        textField.rightView = button
        textField.rightViewMode = .Always
    }
    
    
    // MARK: -  Repalce Spaces ⚡
    
    @IBAction func addLightening(sending: UIButton) {
        let newString = textField.text!.stringByReplacingOccurrencesOfString(" ", withString: lighteningString)
        
        textField.resignFirstResponder()
        
        textField.text = newString
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
}





