//
//  FavoriteMoviesViewController.swift
//  MovieList
//
//  Created by Jason Schatz on 11/15/16.
//  Copyright © 2016 Jason Schatz. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        movies = delegate.favorites
        
        tableView.reloadData()
    }
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    var cellNumber = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        
        // Get the movie associated with this row out of the array
        var movie = movies[indexPath.row]
        
        // Set the movie title
        cell.textLabel!.text = movie.title
        
        // Set the movie poster
        
        if movie.posterPath == nil {
            // api node has no imagepath
            cell.imageView!.image = UIImage(named: "noImage")
        } else if let image = movie.posterImage {
            // already cached
            cell.imageView!.image = image
            print("Image for \(movie.title) already cached")
        }
        
        return cell
    }
    
    // Step 5.1    Perform the segue when a row is tapped
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("Detail", sender: self)
    }
    
    
    // MARK: - handle segues
    
    // Step 5.2    Prepare for Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Detail" {
            // Get the selected movie, by asking the table which row is selected
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedMovie = self.movies[selectedRow]
            
            // Get the destination view controller and set its movie property
            let detailController = segue.destinationViewController as! MovieDetailViewController
            detailController.movie = selectedMovie
        }
    }
}
