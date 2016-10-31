//
//  TaskAwareTableViewCell.swift
//  MovieList
//
//  Created by ccsfcomputers on 4/12/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class TaskAwareTableViewCell: UITableViewCell {
    
    var taskToCancelWhenReused: NSURLSessionTask? {
        
        willSet {
            if let task = taskToCancelWhenReused {
                print("canceling task...")
                task.cancel()
            }
        }
    }
    
}
