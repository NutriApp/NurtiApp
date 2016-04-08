//
//  StartViewController.swift
//  NutriApp
//
//  Created by user116674 on 4/3/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //REMEMBER USER ACROSS APP RESTARTS
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        PFUser.logOut()
        //If user is already signed in
        if PFUser.currentUser() != nil {
            //segue to home screen
            self.performSegueWithIdentifier("toMainSegue", sender: nil)
            print("current user detected")
            //If there is no user currently signed in
        } else {
            //segue to login screen
            self.performSegueWithIdentifier("toLoginSegue", sender: nil)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    

}
