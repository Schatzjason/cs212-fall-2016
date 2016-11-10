//
//  TheMovieDB.swift
//  TheMovieDB
//
//  Created by Jason Schatz on 1/10/15.
//

import Foundation

struct TMDBURLs {

    // MARK: - URL Helper
    
    static let IDPlaceholder: String = "{id}"
        
    static func URLForResource(resource r: String, parameters p: [String : AnyObject]) -> NSURL {
        
        // make mutable copies of the resource and parameters
        var resource = r
        var parameters = p
        
        // Add in the API Key
        parameters["api_key"] = TMDB.Constants.ApiKey
        
        // Substitute the id parameter in place of the IDPlaceholder
        if resource.rangeOfString(IDPlaceholder) != nil {
            
            // get the id string from the parameters
            let id = "\(parameters[TMDB.Keys.ID]!)"
            
            // rewrite the resource with the {id} replaced with the parameter id
            resource = resource.stringByReplacingOccurrencesOfString(IDPlaceholder, withString: id)
            
            // remove the id from the parameters
            parameters.removeValueForKey(TMDB.Keys.ID)
        }
        
        // turn the remaining parameters into a string
        let paramString = parameterString(parameters)
        
        // Assemble the URL String
        let urlString = TMDB.Constants.BaseURL + resource + "?" + paramString
        
        // Create a URL
        let url = NSURL(string: urlString)!
        
        return url
    }
    
    // The methods for poster image URL's is almost exactly like the method for people's profile image
    // URL's.  The only diference is the value for the defalut value of the "size" parameter.
    //
    // TMDB has different constants for images sizes. You can find the arrays of size values in the TMDB struct
    static func URLForPosterWithPath(filePath: String, size: String? = TMDB.Images.PosterSizes[1]) -> NSURL {
        
        let baseURL = NSURL(string: TMDB.Constants.BaseImageURL)!
        
        return baseURL.URLByAppendingPathComponent(size!)!.URLByAppendingPathComponent(filePath)!
    }
    
    static func URLForProfileWithPath(filePath: String, size: String? = TMDB.Images.ProfileSizes[1]) -> NSURL {
        
        let baseURL = NSURL(string: TMDB.Constants.BaseImageURL)!
        
        return baseURL.URLByAppendingPathComponent(size!)!.URLByAppendingPathComponent(filePath)!
    }
    
    
    // Translate a dictionary of key/values into a URL encoded parameter string
    
    private static func parameterString(parameters: [String : AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        }
        
        // And array of strings. Each element will have the format "key=value"
        var urlKeyValuePairs = [String]()

        for (key, value) in parameters {
            
            // make sure that it is a string value
            let stringValue = "\(value)"
            
            // Escape it
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            // Append it
            
            if let escapedValue = escapedValue {
                let keyValuePair = "\(key)=\(escapedValue)"
                urlKeyValuePairs.append(keyValuePair)
            } else {
                print("Warning: trouble escaping string \"\(stringValue)\"")
            }
        }
        
        // Create a single string, separated with &'s
        return urlKeyValuePairs.joinWithSeparator("&")
    }
}
