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
    @IBOutlet weak var past_tip1: UILabel!
    @IBOutlet weak var past_tip2: UILabel!
    @IBOutlet weak var past_tip3: UILabel!
    @IBOutlet weak var past_total1: UILabel!
    @IBOutlet weak var past_total2: UILabel!
    @IBOutlet weak var past_total3: UILabel!
    
    @IBOutlet weak var bill_Field: UITextField!
    
    @IBOutlet weak var tip_text: UIButton!
    
    var tip_amount = 0.15
    var fromView = false
    var bill_value = ""
    var tip_amount_label = "Below Average"
    var currencySymbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol)! as! String
    
    //var pastValues = [String](count: 8, repeatedValue: "")
    
    //var enteredValue = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bill_Field.placeholder = currencySymbol
        self.bill_Field.becomeFirstResponder()
        
        //printPastValues()
        
        if (fromView) {
            bill_Field.text = bill_value
            change_Values()
        }
        else {
            tip_Label.text = currencySymbol + "0.00"
            total_Label.text = currencySymbol + "0.00"
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
        //updatePastValues()
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
        
        tip_Label.text = String(format: currencySymbol + "%.2f", tip)
        total_Label.text = String(format: currencySymbol + "%.2f", total)
        
        //enteredValue = true
    }
    
    /*func printPastValues() {
        print("printPastValues called")
        
        past_tip3.text = pastValues[6]
        past_tip2.text = pastValues[4]
        past_tip1.text = pastValues[2]
        past_total3.text = pastValues[7]
        past_total2.text = pastValues[5]
        past_total1.text = pastValues[3]
    }
    
    func updatePastValues() {
        print("updatePastValues called")
        
        let newTip = tip_Label.text as String!
        let newTotal = total_Label.text as String!
    
        if (enteredValue && newTotal != pastValues[1]) {
            pastValues[7] = pastValues[5]
            pastValues[5] = pastValues[3]
            pastValues[3] = pastValues[1]
            pastValues[1] = newTotal
            pastValues[6] = pastValues[4]
            pastValues[4] = pastValues[2]
            pastValues[2] = pastValues[0]
            pastValues[0] = newTip
        }
        printPastValues()
    }*/
}

