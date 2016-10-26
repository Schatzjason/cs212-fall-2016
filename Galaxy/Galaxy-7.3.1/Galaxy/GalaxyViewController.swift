

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
            // Cancel Task, and nil it out
        } else {
            // Make a new task, and resume()
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
