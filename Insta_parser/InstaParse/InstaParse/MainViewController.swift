//
//  MainViewController.swift
//  InstaParse
//
//  Created by Darwin Mendyke on 8/15/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var instaPosts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        getPosts()
        
        //self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection called")
                
        if let instaPosts = instaPosts {
            return instaPosts.count
        }
        else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath called")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCellMain", forIndexPath: indexPath) as! PostViewCell
        
        let post = instaPosts![indexPath.row]
        
        print("row \(indexPath.row)")
        print(post["caption"])
        
        return cell
    }
    
    func getPosts() {
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                self.instaPosts = posts
                print("Successfully retrieved the posts")
            } else {
                print("Was unable to retrieve the posts")
            }
        }
        
        self.tableView.reloadData()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
            if (PFUser.currentUser() == nil) {
                print("User logged out is successful")
            }
        }
        
    }

}
