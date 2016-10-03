//
//  MoviesViewController.swift
//  Talkies
//
//  Created by Darwin Mendyke on 8/1/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var movies: [NSDictionary]?
    
    var filteredMovies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //movieSearch = UISearchBar()
        movieSearch.delegate = self
        //navigationItem.titleView = movieSearch
        
        let request = getRequest()
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                        print("response: \(responseDictionary)")
                        
                        // Hide HUD once the network request comes back (must be done on main UI thread)
                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                    
                        self.movies = responseDictionary["results"] as? [NSDictionary]
                        self.filteredMovies = self.movies
                        self.tableView.reloadData()
                    }
            }
        })
        task.resume()
    
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredMovies = filteredMovies {
            return filteredMovies.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = filteredMovies![indexPath.row]
        
        let baseurl = "http://image.tmdb.org/t/p/w500"
        if let posterpath = movie["poster_path"] as? String {
            let imageurl = NSURL(string: baseurl + posterpath)
            cell.posterImage.setImageWithURL(imageurl!)
        }
        
        cell.titleLabel.text = (movie["title"] as! String)
        cell.overviewLabel.text = (movie["overview"] as! String)
        
        print("row \(indexPath.row)")
        
        return cell
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            filteredMovies = movies!.filter({(dataItem: NSDictionary) -> Bool in
                // If dataItem matches the searchText, return true to include it
                let title = dataItem["title"] as! String
                
                if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(movieSearch: UISearchBar) {
        self.movieSearch.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(movieSearch: UISearchBar) {
        movieSearch.showsCancelButton = false
        movieSearch.text = ""
        movieSearch.resignFirstResponder()
        filteredMovies = movies
        tableView.reloadData()
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // creates another request
        let request = getRequest()
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            
            // ... Use the new data to update the data source ...
                                                                        
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
                                                                        
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        });
        task.resume()
    }
    
    // Creates a new request for movie data
    // Used twice in the above code
    func getRequest() -> NSURLRequest {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        return request
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! MovieCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = filteredMovies![(indexPath?.row)!]
        
        let detailView = segue.destinationViewController as? DetailViewController
        
        detailView!.movie = movie
    }
}




