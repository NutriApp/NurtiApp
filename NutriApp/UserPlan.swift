//
//  UserPlan.swift
//  NutriApp
//
//  Created by Kevin Tran on 4/7/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class UserPlan: NSObject {
    
    class func saveUserPlan(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let plan = PFObject(className: "UserPlan")
        
        var log = ["protein": [6, "oz(s)", true], "fruits": [2, "cup(s)", true], "vegetable": [3, "cup(s)", true], "grain": [3, "oz(s)", true], "dairy": [3, "cup(s)", true], "oil": [6, "tsp(s)", true]  ]
        
        // Add relevant fields to the object
        plan["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        

        
        // Save object (following function will save the object in Parse asynchronously)
        plan.saveInBackgroundWithBlock(completion)
    }

}
