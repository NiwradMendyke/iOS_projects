//
//  CaptionEditController.swift
//  InstaParse
//
//  Created by Darwin Mendyke on 8/18/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CaptionEditController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet weak var captionBox: UITextField!
    
    var passedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = passedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(captionBox.text!)
        
        Post.postUserImage(imageView.image, withCaption: captionBox.text!) {
            (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("Upload successful")
            } else {
                print(error)
            }
        }
    }
}
