//
//  ViewController.swift
//  ColorTable
//
//  Created by ccsfcomputers on 10/11/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedColor: UIColor?
    
    let colors = ["red", "orange", "yellow", "green", "blue", "indigo", "pink", "violet"];
    
    let colorDictionary: [String : UIColor] = [
        "red" : UIColor.redColor(),
        "orange" : UIColor.orangeColor(),
        "yellow" : UIColor.yellowColor(),
        "green" : UIColor.greenColor(),
        "blue" : UIColor.blueColor(),
        "violet" : UIColor.purpleColor()
    ]

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colors.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath)
        let colorCell = cell as! ColorCell
        
        let colorName = self.colors[indexPath.row]
        colorCell.colorLabel.text = colorName
        colorCell.colorView.backgroundColor = colorDictionary[colorName] ?? UIColor.lightGrayColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let colorName = colors[indexPath.row]
                
        self.selectedColor = colorDictionary[colorName] ?? UIColor.lightGrayColor()
        
        performSegueWithIdentifier("ShowColor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        
        controller.view.backgroundColor = selectedColor!
    }
}






