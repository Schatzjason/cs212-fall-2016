//
//  DateStorage.swift
//  PersistentMasterDetail
//
//  Created by Jason Schatz on 11/15/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import Foundation

class DateStorage {
    
    private var _dates: [String]!
    
    init() {
        _dates = read()
    }
    
    func add(s: String) {
        _dates.append(s)
        write()
    }
    
    func remove(s: String) {
        if let index = _dates.index(of: s) {
            _dates.remove(at: index)
        }
        
        write()
    }
    
    var dates: [String] {
        return [String]()
    }
    
    // MARK: - Persistence
    
    func read() -> [String] {
        // bring over the read code from the VC
        return [String]()
    }
    
    func write() {
        // bring over the write code from the VC
    }
}
