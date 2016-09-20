//
//  DetailsViewController.swift
//  Tumble_feed
//
//  Created by Darwin Mendyke on 8/8/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    var post: NSDictionary = [:]

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var details: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        if let photos = post.valueForKeyPath("photos") as? [NSDictionary] {
            let imageUrlString = photos[0].valueForKeyPath("original_size.url") as? String
            
            if let imageUrl = NSURL(string: imageUrlString!) {
                photo.setImageWithURL(imageUrl)
            }
            else {
                print("imageURLString is nil")
            }
        }
        else {
            print("photo is nil")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! FullScreenViewController
        cell.fullImage = photo
    }
    
    func viewForZoomingInScrollView(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
}
