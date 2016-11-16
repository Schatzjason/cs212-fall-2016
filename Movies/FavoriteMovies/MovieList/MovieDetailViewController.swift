//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Jason Schatz on 11/9/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    

    var movie: Movie!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = movie.title
        
        textView.text = movie.overview ?? ""
        
        downloadPoster()
        setAddButtonTitle()
    }
    
    @IBAction func toggleFavoriteStatus(sender: UIBarButtonItem) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

        if let index = delegate.favorites.indexOf({$0.id == movie.id}) {
            delegate.favorites.removeAtIndex(index)
        } else {
            delegate.favorites.append(movie)
        }
        
        setAddButtonTitle()
    }
    
    private func setAddButtonTitle() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let title = delegate.favorites.indexOf({$0.id == movie.id}) != nil ? "Remove" : "Add"
        
        favoriteButton.title = title
    }

    
    func downloadPoster() {
        
        guard let path = movie.posterPath else {
            return
        }
        
        let posterURL = TMDBURLs.URLForPosterWithPath(path, size: "original")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(posterURL) { data, response, error in
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)!
            
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = image
            }
        }
        
        task.resume()
    }
}
