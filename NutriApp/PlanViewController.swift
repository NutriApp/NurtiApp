//
//  PlanViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class PlanViewController: UITableViewController {

    @IBOutlet weak var goalText: UITextView!
    @IBOutlet weak var proteinSwitch: UISwitch!
    @IBOutlet weak var proteinSlider: UISlider!
    @IBOutlet weak var fruitSwitch: UISwitch!
    @IBOutlet weak var fruitSlider: UISlider!
    @IBOutlet weak var vegetableSwitch: UISwitch!
    @IBOutlet weak var vegetableSlider: UISlider!
    @IBOutlet weak var grainSwitch: UISwitch!
    @IBOutlet weak var grainSlider: UISlider!
    @IBOutlet weak var dairySwitch: UISwitch!
    @IBOutlet weak var dairySlider: UISlider!
    @IBOutlet weak var oilSwitch: UIView!
    @IBOutlet weak var oilSlider: UISlider!
    
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fruitLabel: UILabel!
    @IBOutlet weak var vegetableLabel: UILabel!
    @IBOutlet weak var grainLabel: UILabel!
    @IBOutlet weak var dairyLabel: UILabel!
    @IBOutlet weak var oilLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onSave(sender: UIButton) {
    }
    
    @IBAction func onCancel(sender: UIButton) {
    }
    
    //TBD: Need to add database component and local save for the plan settings

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
