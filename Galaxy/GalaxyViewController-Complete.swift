

import UIKit

class GalaxyViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var task: NSURLSessionDataTask? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleViews(false)
    }
    
    @IBAction func downloadOrCancel() {

        if let task = self.task {
            // Cancel
            task.cancel()
            self.task = nil
            toggleViews(false)
            
        } else {

            let URLString = GalaxyURLs.nextURLString
            let URL = NSURL(string: URLString)!
            let request = NSURLRequest(URL: URL, cachePolicy: .ReturnCacheDataElseLoad , timeoutInterval: 10)
            let session = NSURLSession.sharedSession()
            
            self.task = session.dataTaskWithRequest(request, completionHandler: processInBackground)
            
            self.task!.resume()
            
            toggleViews(true)
        }
    }
    
    func processInBackground(data: NSData?, response: NSURLResponse?, error: NSError?) {
 
        // Handle the error
        if let error = error {
            print(error)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.imageView.image = nil
                self.toggleViews(false)
            }
            
            return
        }
        
        // Handle the data
        let newImage = UIImage(data: data!)
        self.task = nil

        dispatch_async(dispatch_get_main_queue()) {
            self.imageView.image = newImage
            self.toggleViews(false)
        }
    }
        
    func toggleViews(isDownloading: Bool) {
    
        // Button
        let buttonTitle = isDownloading ? "Cancel" : "Start"
        button.setTitle(buttonTitle, forState: .Normal)
        
        // Activity Indicator
        if isDownloading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        
        // Image View
        imageView.hidden = isDownloading
    }
}
