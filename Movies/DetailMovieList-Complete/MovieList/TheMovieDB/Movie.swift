//
//  Movie.swift
//  TheMovieDB
//
//  Created by Jason on 1/11/15.
//

import UIKit

struct Movie {
    
    struct Keys {
        static let Title = "title"
        static let PosterPath = "poster_path"
        static let ID = "id"
        
        // Step 1.2
        static let Overview = "overview"
    }
    
    var title = ""
    var id = 0
    var posterPath: String? = nil
    
    // Step 1.1
    var overview: String?
    
    init?(dictionary: [String : AnyObject]) {
        // Mandatory values
        guard
            let title = dictionary[Keys.Title] as? String,
            let id = dictionary[Keys.ID] as? Int
        else {
            return nil
        }
        
        // Optional value
        let posterPath = dictionary[Keys.PosterPath] as? String
        
        // Step 1.3
        let overview = dictionary[Keys.Overview] as? String
        
        // Pass them to the full initializer
        // Step 1.5
        self.init(title: title, id: id, posterPath: posterPath, overview: overview)
    }
    
    // Step 1.4
    init(title: String, id: Int, posterPath: String?, overview: String?) {
        self.title = title
        self.id = id
        self.posterPath = posterPath
        self.overview = overview
    }
}

extension Movie {
    /**
     posterImage is a computed property. From outside of the struct it should look like objects
     have a direct handle to their image. In fact, they store them in an imageCache. The
     cache stores the images into the documents directory, and keeps a resonable number of
     them in memory.
     */
    
    var posterImage: UIImage? {
        
        get {
            return TMDB.Caches.imageCache.imageWithIdentifier(posterPath)
        }
        
        set {
            TMDB.Caches.imageCache.storeImage(newValue, withIdentifier: posterPath!)
        }
    }
}



