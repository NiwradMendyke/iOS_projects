//
//  DetailsViewController.swift
//  Tumble_feed
//
//  Created by Darwin Mendyke on 8/8/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var post: NSDictionary = [:]

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var details: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        details.text = (post["caption"] as! String)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
