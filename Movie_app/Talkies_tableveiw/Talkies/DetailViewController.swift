//
//  DetailViewController.swift
//  Talkies
//
//  Created by Darwin Mendyke on 8/2/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UITextView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = (movie["title"] as! String)
        dateLabel.text = "Release date: " + (movie["release_date"] as! String)
        overviewLabel.text = (movie["overview"] as! String)
        
        let baseurl = "https://image.tmdb.org/t/p/original"
        if let posterpath = movie["poster_path"] as? String {
            let imageurl = NSURL(string: baseurl + posterpath)
            posterImage.setImageWithURL(imageurl!)
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
