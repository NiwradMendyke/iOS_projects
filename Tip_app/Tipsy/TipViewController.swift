//
//  TipViewController.swift
//  Tipsy Tips
//
//  Created by Darwin Mendyke on 7/27/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    var toPass:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let mvc = segue.destinationViewController as! ViewController
        //print(mvc)
        mvc.fromView = true
        mvc.bill_value = toPass
        
        if (segue.identifier == "dough") {
            mvc.tip_amount = 0.4
            mvc.tip_amount_label = "Frickin Rich"
        }
        if (segue.identifier == "super_generous") {
            mvc.tip_amount = 0.3
            mvc.tip_amount_label = "Super Generous"
        }
        if (segue.identifier == "sorta_generous") {
            mvc.tip_amount = 0.25
            mvc.tip_amount_label = "Sorta Generous"
        }
        if (segue.identifier == "above_avg") {
            mvc.tip_amount = 0.2
            mvc.tip_amount_label = "Above Average"
        }
        if (segue.identifier == "below_avg") {
            mvc.tip_amount = 0.15
            mvc.tip_amount_label = "Below Average"
        }
        if (segue.identifier == "kinda_cheap") {
            mvc.tip_amount = 0.1
            mvc.tip_amount_label = "Kinda Cheap"
        }
        if (segue.identifier == "dirt_cheap") {
            mvc.tip_amount = 0.05
            mvc.tip_amount_label = "Dirt Cheap"
        }
        if (segue.identifier == "seriously") {
            mvc.tip_amount = 0.0
            mvc.tip_amount_label = "Asshole Mode"
        }
        
        print(toPass)
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
