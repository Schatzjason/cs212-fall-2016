

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

            let URLString = "https://cdn.spacetelescope.org/archives/images/screen/opo0328a.jpg"
            let URL = NSURL(string: URLString)!
            let session = NSURLSession.sharedSession()
            
            self.task = session.dataTaskWithURL(URL, completionHandler: processDownloadedData)
            
            self.task!.resume()
            
            toggleViews(true)
        }
    }
    
    func processDownloadedData(data: NSData?, response: NSURLResponse?, error: NSError?) {
 
        let newImage = UIImage(data: data!)
        
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
