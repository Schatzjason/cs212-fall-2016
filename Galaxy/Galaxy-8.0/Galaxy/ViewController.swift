

import UIKit

class GalaxyViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var isDownloading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleViews(false)
    }
    
    @IBAction func downloadOrCancel() {

        isDownloading = !isDownloading
        
        toggleViews(isDownloading)
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
