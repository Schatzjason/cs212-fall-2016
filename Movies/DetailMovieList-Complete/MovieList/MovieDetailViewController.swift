//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Jason Schatz on 11/9/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // Step 3.1    Add the movie property
    var movie: Movie!
    
    // Step 3.2    Add an outlet for the image view
    @IBOutlet var imageView: UIImageView!
    
    // Step 3.3    Add an outlet for the text view
    @IBOutlet var textView: UITextView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Step 4.1    Put the movies title into the navigation bar's title label
        self.navigationItem.title = movie.title
        
        // Step 4.2    Put the plot overview into the text view
        textView.text = movie.overview ?? ""
        
        // Step 4.3    Download the poster
        downloadPoster()
    }
    
    func downloadPoster() {
        
        // Make sure that there is a posterPath. If not, that's the end
        guard let path = movie.posterPath else {
            return
        }
        
        // Here is the URL for  a large movie poster
        let posterURL = TMDBURLs.URLForPosterWithPath(path, size: "original")
        
        // Step 6: Download the image here, similar to Galaxy
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(posterURL) { data, response, error in
            guard let data = data else {
                return
            }
            
            // create the image
            let image = UIImage(data: data)!
            
            // send a little bit of work back to the main queue
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = image
            }
        }
        
        // Don't forget to resume the task. Otherwise nothing happens.
        task.resume()
        
    }
}
