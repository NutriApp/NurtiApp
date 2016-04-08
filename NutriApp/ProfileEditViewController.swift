//
//  ProfileEditViewController.swift
//  NutriApp
//
//  Created by user116674 on 4/7/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class ProfileEditViewController: UIViewController {
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var uploadView: UIView!
    var role: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = PFUser.currentUser()!.objectId
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func onRoleChange(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                role = "Client"
                break
            case 1:
                role = "Mentor"
                break
            default:
                break
        }
    }
    
    @IBAction func onSave(sender: AnyObject) {
        var info = [String: String]()
        info["name"] = nameField.text
        info["email"] = emailField.text
        info["age"] = ageField.text
        info["gender"] = genderField.text
        info["weight"] = weightField.text
        info["goal"] = goalField.text
        info["role"] = role
        
        User.saveUserProfile(info)
        
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
