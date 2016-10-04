//
//  ChatViewController.swift
//  Messenger
//
//  Created by Darwin Mendyke on 10/2/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var chatTable: UITableView!
    
    var messages : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.dataSource = self
        chatTable.estimatedRowHeight = 100
        chatTable.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
        
        getMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //getMessages()
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("calling cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageViewCell
        
        //getMessages()
        let text = messages[messages.count - 1 - indexPath.row]
        
        let user = text["user"] as! String?
        cell.messageLabel.text = user! + ":" + (text["text"] as! String?)!
        
        return cell
    }
    
    @IBAction func sendMessage(_ sender: AnyObject) {
        let message = PFObject(className:"Message_2016")
        message["text"] = messageField.text!
        message["user"] = PFUser.current()?.username
        message.saveInBackground {
            (success, error) -> Void in
            if (success) {
                print("Successfully sent: " + self.messageField.text!)
                self.getMessages()
            }
            else {
                print("Failed to send")
            }
        }
    }
    
    func getMessages() {
        print(PFUser.current()?.username)
        
        let query = PFQuery(className:"Message_2016")
        //query.whereKey("user", equalTo:currentUser?.username)
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                print("no error in retrieving search query")
                // The find succeeded.
                // Do something with the found objects
                var temp_list = [PFObject]()
                
                print(objects?.count)
                for object in objects! {
                    if ((object["user"] as! String?) == (PFUser.current()?.username)) {
                        temp_list.append(object)
                    }
                }
                
                print(temp_list.count)
                temp_list.sorted(by: { $0.createdAt! > $1.createdAt! })
                
                self.messages = temp_list
                print("filled messages")
                print(self.messages.count)
                self.chatTable.reloadData()
            }
            else {
                // Log details of the failure
                print("Could not get messages")
            }
        }
        
        print("calling reloadData")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
