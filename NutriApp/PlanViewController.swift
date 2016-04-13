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
    @IBOutlet weak var oilSwitch: UISwitch!
    @IBOutlet weak var oilSlider: UISlider!
    
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fruitLabel: UILabel!
    @IBOutlet weak var vegetableLabel: UILabel!
    @IBOutlet weak var grainLabel: UILabel!
    @IBOutlet weak var dairyLabel: UILabel!
    @IBOutlet weak var oilLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var plan: NSDictionary!
    var oldPlan: NSDictionary!
    let user = PFUser.currentUser()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        plan = PFUser.currentUser()!["plan"] as! NSDictionary
        oldPlan = plan


        saveButton.hidden = true
        cancelButton.hidden = true
        
        displayPlan()
    }
    
    //let log = ["protein": [6, "oz(s)", true], "fruits": [2, "cup(s)", true], "vegetable": [3, "cup(s)", true], "grain": [3, "oz(s)", true], "dairy": [3, "cup(s)", true], "oil": [6, "tsp(s)", true]  ]
    func displayPlan(){
//        print(plan)
        var value = plan["protein"]![0] as! Float
        proteinSlider.value = value
        var state = plan["protein"]![2] as! Bool
        proteinSwitch.setOn(state, animated: false)
        var unit = plan["protein"]![1] as! String
        proteinLabel.text = "Protein: \(value) \(unit)"
        
        value = plan["fruits"]![0] as! Float
        fruitSlider.value = value
        state = plan["fruits"]![2] as! Bool
        fruitSwitch.setOn(state, animated: false)
        unit = plan["fruits"]![1] as! String
        fruitLabel.text = "Fruit: \(value) \(unit)"
        
        value = plan["vegetable"]![0] as! Float
        vegetableSlider.value = value
        state = plan["vegetable"]![2] as! Bool
        vegetableSwitch.setOn(state, animated: false)
        unit = plan["vegetable"]![1] as! String
        vegetableLabel.text = "Vegetable: \(value) \(unit)"
        
        value = plan["grain"]![0] as! Float
        grainSlider.value = value
        state = plan["grain"]![2] as! Bool
        grainSwitch.setOn(state, animated: false)
        unit = plan["grain"]![1] as! String
        grainLabel.text = "Grain: \(value) \(unit)"
        
        value = plan["dairy"]![0] as! Float
        dairySlider.value = value
        state = plan["dairy"]![2] as! Bool
        dairySwitch.setOn(state, animated: false)
        unit = plan["dairy"]![1] as! String
        dairyLabel.text = "Dairy: \(value) \(unit)"
        
        value = plan["oil"]![0] as! Float
        oilSlider.value = value
        state = plan["oil"]![2] as! Bool
        oilSwitch.setOn(state, animated: false)
        unit = plan["oil"]![1] as! String
        oilLabel.text = "Oil: \(value) \(unit)"
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
    
    //let log = ["protein": [6, "oz(s)", true], "fruits": [2, "cup(s)", true], "vegetable": [3, "cup(s)", true], "grain": [3, "oz(s)", true], "dairy": [3, "cup(s)", true], "oil": [6, "tsp(s)", true]  ]
    @IBAction func onSave(sender: UIButton) {
        saveButton.hidden = true
        cancelButton.hidden = true
        
        let valueP = proteinSlider.value
        let stateP = proteinSwitch.on
        let unitP = plan["protein"]![1] as! String
        
        let valueF = fruitSlider.value
        let stateF = fruitSwitch.on
        let unitF = plan["fruits"]![1] as! String
        
        let valueV = vegetableSlider.value
        let stateV = vegetableSwitch.on
        let unitV = plan["vegetable"]![1] as! String
        
        let valueG = grainSlider.value
        let stateG = grainSwitch.on
        let unitG = plan["grain"]![1] as! String
        
        let valueD = dairySlider.value
        let stateD = dairySwitch.on
        let unitD = plan["dairy"]![1] as! String
        
        let valueO = oilSlider.value
        let stateO = oilSwitch.on
        let unitO = plan["oil"]![1] as! String
        
        
        let newPlan = [
            "protein": [valueP, unitP, stateP],
            "fruits": [valueF, unitF, stateF],
            "vegetable": [valueV, unitV, stateV],
            "grain": [valueG, unitG, stateG],
            "dairy": [valueD, unitD, stateD],
            "oil": [valueO, unitO, stateO],
        ]
        
        //var myDict: NSDictionary = ["plan" : newPlan]
        
        UserPlan.saveUserPlan(newPlan)
        plan = PFUser.currentUser()!["plan"] as! NSDictionary
        
        oldPlan = plan
        saveButton.hidden = true
        cancelButton.hidden = true

    }
    
    @IBAction func onCancel(sender: UIButton) {
        plan = oldPlan
        displayPlan()
        saveButton.hidden = true
        cancelButton.hidden = true
    }
    
    @IBAction func onValueChanged(sender: AnyObject?) {
        
        saveButton.hidden = false
        cancelButton.hidden = false
        
        //Need to make slide snap
        var value = proteinSlider.value
        var unit = plan["protein"]![1] as! String
        proteinLabel.text = "Protein: \(value) \(unit)"
        
        value = fruitSlider.value
        unit = plan["fruits"]![1] as! String
        fruitLabel.text = "Fruit: \(value) \(unit)"
        
        value = vegetableSlider.value
        unit = plan["vegetable"]![1] as! String
        vegetableLabel.text = "Vegetable: \(value) \(unit)"
        
        value = grainSlider.value
        unit = plan["grain"]![1] as! String
        grainLabel.text = "Grain: \(value) \(unit)"
        
        value = dairySlider.value
        unit = plan["dairy"]![1] as! String
        dairyLabel.text = "Dairy: \(value) \(unit)"
        
        value = oilSlider.value
        unit = plan["oil"]![1] as! String
        oilLabel.text = "Oil: \(value) \(unit)"
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
