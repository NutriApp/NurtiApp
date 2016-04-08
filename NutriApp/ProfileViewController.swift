//
//  ProfileViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var profileImageView: PFImageView!


    var user = PFUser.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = PFUser.currentUser()!.objectId
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let name = user!["name"] as? String {
            nameLabel.text = name
        }
        if let email = user!["email"] as? String {
            emailLabel.text = email
        }
        if let weight = user!["weight"] as? String {
            weightLabel.text = weight
        }
        if let gender = user!["gender"] as? String {
            genderLabel.text = gender
        }
        if let age = user!["age"] as? String {
            ageLabel.text = age
        }
        if let role = user!["role"] as? String {
            roleLabel.text = role
        }
        if let goal = user!["goal"] as? String {
            goalLabel.text = goal
        }
        if let imageFile = user!["profilePicture"] as? PFFile {
            profileImageView.file = imageFile
            profileImageView.loadInBackground()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
