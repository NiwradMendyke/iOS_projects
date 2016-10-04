//
//  LogInViewController.swift
//  Messenger
//
//  Created by Darwin Mendyke on 10/1/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (PFUser.current() != nil) {
            PFUser.logOut()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpAction(_ sender: AnyObject) {
        if (emailField.text == "" || passwordField.text == "") {
            createAlert(message: "Both fields need input")
            return
        }
        
        let email = emailField.text
        let password = passwordField.text
        
        let user = PFUser()
        user.username = email
        user.password = password
       
        user.signUpInBackground(block: { (succeed, error) -> Void in
            // Stop the spinner
            if ((error) != nil) {
                self.createAlert(message: "Failed to sign up")
                return
            }
            else {
                print("signed up")
                self.performSegue(withIdentifier: "FromSignUp", sender: nil)
            }
        })
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        if (emailField.text == "" || passwordField.text == "") {
            createAlert(message: "Both fields need input")
            return
        }
        
        let email = emailField.text
        let password = passwordField.text
        PFUser.logInWithUsername(inBackground: email!, password: password!, block: { (user, error) -> Void in
            if (error != nil) {
                self.createAlert(message: "Failed to log in")
                return
            }
            else {
                print(email! + " logged in successfully")
                self.performSegue(withIdentifier: "FromLogIn", sender: nil)
            }
        })
    }
    
    func createAlert(message: String) {
        let alertController1 = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController1.addAction(OKAction)
        self.present(alertController1, animated: true)
    }
}
