//
//  UploadViewController.swift
//  InstaParse
//
//  Created by Darwin Mendyke on 8/16/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let vc = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickFromCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            vc.delegate = self
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            vc.allowsEditing = false
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        print("calling useCamera")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            print("sourceType is available")
            vc.delegate = self
            vc.sourceType = UIImagePickerControllerSourceType.Camera;
            vc.allowsEditing = false
            self.presentViewController(vc, animated: true, completion: nil)
            print("presented viewController")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
        
        //let cc = CaptionEditController()
        let cc = (self.storyboard?.instantiateViewControllerWithIdentifier("captionEdit")) as? CaptionEditController
        
        let size = CGSize(width: 375, height: 330)
        cc?.passedImage = resize(chosenImage, newSize: size)
        
        self.presentViewController(cc!, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("didCancel was called")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        print("resize called")
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        /*PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
            if (PFUser.currentUser() == nil) {
                print("User logged out is successful")
            }
        }*/
        
    }
}
