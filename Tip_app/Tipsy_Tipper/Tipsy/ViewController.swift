//
//  ViewController.swift
//  Tipsy
//
//  Created by Darwin Mendyke on 7/26/16.
//  Copyright © 2016 Darwin Mendyke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tip_Label: UILabel!
    @IBOutlet weak var total_Label: UILabel!
    
    @IBOutlet weak var bill_Field: UITextField!
    
    @IBOutlet weak var tip_Type: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calc_Tip(sender: AnyObject) {
        let tip_percents = [0.1, 0.15, 0.2]
        
        let bill = Double(bill_Field.text!) ?? 0
        let tip = bill * tip_percents[tip_Type.selectedSegmentIndex]
        let total = bill + tip
        
        tip_Label.text = String(format: "$%.2f", tip)
        total_Label.text = String(format: "$%.2f", total)
    }
}

