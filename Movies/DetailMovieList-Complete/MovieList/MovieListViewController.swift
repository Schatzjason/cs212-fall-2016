//
//  MovieListViewController.swift
//  MovieList
//
//  Created by ccsfcomputers on 10/29/15.
//  Copyright (c) 2015 Jason Schatz. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = [Movie]()
    
    // This will store out task for downloading movies.
    var task: NSURLSessionTask?
    
    
    // Create a search Task
    func taskForMoviesWithQuerry(querry: String) -> NSURLSessionTask {
    
        let parameters = ["query" : querry]
        
        let url = TMDBURLs.URLForResource(resource: TMDB.Resources.SearchMovie, parameters: parameters)
        
        // Some debugging support
        print(url)

        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: handleResponse)
        return task
    }
    
    
    // This method will be invoked on a background thread, when the data task completes
    
    func handleResponse(data: NSData?, response: NSURLResponse?, error: NSError?) {
        
        // Simple error handling
        if let error = error {
            print(error)
            return
        }
        
        // Update the view controller's state
        self.task = nil
        self.movies = self.moviesFromData(data)
        
        // Send the UI Updating work back to the main thread
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let task = self.task {
            task.cancel()
        }
        
        if searchText.isEmpty {
            self.task = nil
            self.movies = [Movie]()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        } else {
            self.task = self.taskForMoviesWithQuerry(searchText)
            self.task!.resume()
        }
    }
    
    
    // MARK: - Toggle UI while downloading
    
    func setUIToDownloading(isDownloading: Bool) {
        
        if isDownloading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        self.activityIndicator.hidden = isDownloading
        self.tableView.alpha = isDownloading ? 0.2 : 1.0
    }
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    var cellNumber = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TaskAwareTableViewCell
        
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
        } else {
            // Set a placeholder before we start the download
            cell.imageView!.image = UIImage(named: "placeHolder")
        
            // get url, 
            let url = TMDBURLs.URLForPosterWithPath(movie.posterPath!)

            // create task
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
                data, response, error in

                if let error = error {
                    print(error)
                }

                if let data = data, let image = UIImage(data: data) {
                    movie.posterImage = image
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.imageView!.image = image
                    }
                }
            }
            
            // resume task
            cell.taskToCancelWhenReused = task
            task.resume()
            
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
            // Get teh selected movie, by asking the table which row is selected
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedMovie = self.movies[selectedRow]
            
            // Get the destination view controller and set its movie property
            let detailController = segue.destinationViewController as! MovieDetailViewController
            detailController.movie = selectedMovie
        }
    }
    
    
    // MARK: - Parser
    
    func moviesFromData(data: NSData?) -> [Movie] {
        
        // No data, return an empty array
        guard let data = data else {
            return []
        }
        
        // Parse the Data into a JSON Object
        let JSONObject = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        
        // Insist that this object must be a dictionary
        guard let JSONDictionary = JSONObject as? [String : AnyObject] else {
            assertionFailure("Failed to parse data. data.length: \(data.length)")
            return [Movie]()
        }
        
        // Print the object, for now, so we can take a look
        //print(JSONDictionary)
        
        // Pretty Print the string, for debugging
        let prettyData = try! NSJSONSerialization.dataWithJSONObject(JSONObject, options: .PrettyPrinted)
        let prettyString = String(data: prettyData, encoding: NSUTF8StringEncoding)
        print(prettyString)
        
        let movieDictionaries = JSONDictionary[TMDB.Keys.Results] as! [[String : AnyObject]]
        
        let movies = movieDictionaries.map() {
            Movie(dictionary: $0)!
        }
        
        return movies
    }
}
