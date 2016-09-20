//
//  ViewController3.swift
//  TextFieldSkills
//
//  Created by Jason Schatz on 9/20/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITextFieldDelegate {
    
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
        
        // Register for Keyboard Notifications
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self, selector: #selector(keyboardShows), name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHides), name: UIKeyboardWillHideNotification, object: nil)
    }
    

    // MARK: -  Repalce Spaces ⚡
    
    @IBAction func addLightening(sending: UIButton) {
        let newString = textField.text!.stringByReplacingOccurrencesOfString(" ", withString: lighteningString)
        
        textField.resignFirstResponder()
        
        textField.text = newString
    }
    
    
    // MARK: - Keyboard Adjustments
    
    var originalFrame: CGRect!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Let the text field's constraints be re-configured programmatically
        self.textField.translatesAutoresizingMaskIntoConstraints = true
    }
    

    @objc func keyboardShows(notification: NSNotification) {
        
        // Cache the old frame
        originalFrame = self.view.frame
        
        // Calculate the new frame
        let keyboardSize = notification.userInfo![UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        let newOrigin = CGPoint(x: originalFrame.origin.x, y: originalFrame.origin.y - keyboardSize.height)
        let insets = CGRect(origin: newOrigin, size: originalFrame.size)
        
        // Set the frame, with animation.
        UIView.animateWithDuration(0.3) {
            self.view.frame = insets
        }
    }
    
    @objc func keyboardHides(notification: NSNotification) {
        UIView.animateWithDuration(0.3) {
            self.view.frame = self.originalFrame
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
