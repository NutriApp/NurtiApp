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
    

    
    class func saveUserPlan (plan: AnyObject?) {
        let user = PFUser.currentUser()!
        user["plan"] = plan
        
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("successfully updated plan")
                NSNotificationCenter.defaultCenter().postNotificationName("endPlanSave", object: nil)
            } else {
                print("did not update plan")
            }
        }
        
    }
    
//    class func queryUserPlan(objectID: String, completion: PFBooleanResultBlock){
//        var query = PFQuery(className:"Plan")
//        query.getObjectInBackgroundWithId(objectID) {
//            (plan: PFObject?, error: NSError?) -> Void in
//            if error != nil {
//                print(error)
//            } else {
//                print(plan)
//            }
//        }
//
//    }

}
