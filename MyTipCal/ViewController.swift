//
//  ViewController.swift
//  MyTipCal
//
//  Created by Ziyang Tan on 9/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var tipDisplayLabel: UILabel!

    @IBOutlet weak var totalDisplayLabel: UILabel!

    @IBOutlet weak var seperatorView: UIView!

    var themeIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        var defaults = NSUserDefaults.standardUserDefaults()
        var intValue = defaults.integerForKey("selected_default_tip_segment")

        updateUITranparency(0)

        NSNotificationCenter.defaultCenter().removeObserver(self)
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "resetBillAmount",
            name:"resetBillAmount",
            object: nil
        )
    }

    func resetBillAmount() {
        if (!billField.text.isEmpty) {
            billField.text = ""
            updateUITranparency(0)
        }
    }

    func updateLabels() {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    func updateUITranparency(alpha: Int) {
        if (alpha == 1) {
            UIView.animateWithDuration(1.0, animations: {
                self.tipDisplayLabel.alpha = 1
                self.totalDisplayLabel.alpha = 1
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.seperatorView.alpha = 1
                self.tipControl.alpha = 1
            })
        }
        else {
            UIView.animateWithDuration(1.0, animations: {
                // This causes first view to fade in and second view to fade out
                self.tipDisplayLabel.alpha = 0
                self.totalDisplayLabel.alpha = 0
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.seperatorView.alpha = 0
                self.tipControl.alpha = 0
            })
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        var defaults = NSUserDefaults.standardUserDefaults()
        var tipValue = defaults.integerForKey("selected_default_tip_segment")
        var themeValue = defaults.integerForKey("selected_default_theme_segment")

        tipControl.selectedSegmentIndex = tipValue
        themeIndex = themeValue

        if (themeIndex == 0) {
            view.backgroundColor = UIColor.whiteColor()
        }
        else {
            view.backgroundColor = UIColor.grayColor()
        }

        updateLabels()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "settingsSegue") {
            let vc = segue.destinationViewController as SettingsViewController
            vc.segmentIndex = tipControl.selectedSegmentIndex
            vc.themeIndex = themeIndex
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {

        updateLabels()

        if (billField.text.isEmpty) {
            updateUITranparency(0)
        }
        else {
            updateUITranparency(1)
        }

    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

