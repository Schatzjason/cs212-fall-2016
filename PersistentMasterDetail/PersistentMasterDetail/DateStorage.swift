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
        _dates = readFromFile() ?? [String]()
    }
    
    func insert(_ s: String, at: Int) {
        _dates.insert(s, at: at)
        writeToFile()
    }
    
    func remove(at: Int) {
        _dates.remove(at: at)
        writeToFile()
    }
    
    var dates: [String] {
        return _dates
    }
    
    // MARK: - Persistence
    
    func readFromFile() -> [String]? {
        
        // See if there is data in the file
        guard let data = NSData(contentsOf: datesURL) as? Data else {
            return nil
        }
        
        // Unserialize the data
        let options = JSONSerialization.ReadingOptions(rawValue: 0)
        
        return try? JSONSerialization.jsonObject(with: data, options: options) as! [String]
    }
    
    func writeToFile() {
        
        // create JSON Data from "objects"
        let data = try! JSONSerialization.data(withJSONObject: _dates, options: .prettyPrinted)
        
        // Print the URL for debugging
        print(datesURL)
        
        // Write the data to "datesFile" URL
        try! data.write(to: datesURL)
    }
    
    var datesURL: URL {
        return documentURL.appendingPathComponent("dates.json")!
    }
    
    var documentURL: NSURL {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        return NSURL(fileURLWithPath: path)
    }
}
