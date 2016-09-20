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
    
    @IBOutlet weak var tip_text: UIButton!
    
    var tip_amount = 0.15
    var fromView = false
    var bill_value = ""
    var tip_amount_label = "Below Average"
    //var currency = String(NSLocale.currentLocale().displayNameForKe)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.bill_Field.becomeFirstResponder()
        
        if (fromView) {
            bill_Field.text = bill_value
            change_Values()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "to_tipView") {
            let svc = segue.destinationViewController as! TipViewController
            
            fromView = false
            svc.toPass = bill_Field.text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calc_Tip(sender: AnyObject) {
        change_Values()
    }
    
    func change_Values() {
        //print(currency)
        tip_text.setTitle(tip_amount_label, forState: UIControlState.Normal)
        let bill = Double(bill_Field.text!) ?? 0
        let tip = bill * tip_amount
        let total = bill + tip
        
        tip_Label.text = String(format: "$%.2f", tip)
        total_Label.text = String(format: "$%.2f", total)
    }
}

