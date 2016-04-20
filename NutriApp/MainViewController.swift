//
//  MainViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse


class MainViewController: UIViewController {
    
    var media: [PFObject]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()!.username!
        UserPlan.queryUserPlan(currentUser) { (media: [PFObject]?,error: NSError?) -> Void in
            if error == nil {
                print(media)
                self.media = media
            } else {
                print(error)
            }
        }

        // Do any additional setup after loading the view.
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
