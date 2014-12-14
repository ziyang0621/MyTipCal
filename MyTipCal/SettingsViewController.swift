//
//  SettingsViewController.swift
//  MyTipCal
//
//  Created by Ziyang Tan on 9/18/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentControl: UISegmentedControl!

    @IBOutlet weak var themeControl: UISegmentedControl!

    var segmentIndex = 0
    var themeIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateBackgroundColor() {
        if (themeControl.selectedSegmentIndex == 0) {
            view.backgroundColor = UIColor.whiteColor()
        }
        else {
            view.backgroundColor = UIColor.grayColor()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.grayColor()
        defaultPercentControl.selectedSegmentIndex = segmentIndex

        themeControl.selectedSegmentIndex = themeIndex
        updateBackgroundColor()
    }

    @IBAction func onControlChanged(sender: AnyObject) {

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(themeControl.selectedSegmentIndex, forKey: "selected_default_theme_segment")
        defaults.synchronize()

        updateBackgroundColor()
    }

    @IBAction func onOkTap(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[defaultPercentControl.selectedSegmentIndex]

        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultPercentControl.selectedSegmentIndex, forKey: "selected_default_tip_segment")
        defaults.synchronize()

        dismissViewControllerAnimated(true, completion: nil)
    }
}
