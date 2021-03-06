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
    
    class func postUserPost(image: UIImage?, withCaption caption: String?, input: AnyObject?, currentPlan: AnyObject?, cumulative: AnyObject?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let user = PFUser.currentUser()!

        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        if image == nil {
            media["media"] = NSNull()
        } else {
            media["media"] = getPFFileFromImage(image) // PFFile column type
        }
        media["author"] = user // Pointer column type that points to PFUser
        media["caption"] = caption
        media["created_at"] = NSDate()
        media["username_str"] = PFUser.currentUser()?.username!
        media["plan"] = user["plan"]
        media["current_plan"] = currentPlan
        media["input"] = input
        media["cumulative"] = cumulative
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                print("got image")
                return PFFile(name: "image.png", data: imageData)
            }
        }
        print("could not get image")
        return nil
    }
    
    class func queryUserPlan(objectID: String, completion: (PFQueryArrayResultBlock)){
        let query = PFQuery(className:"UserMedia")
        query.orderByDescending("createdAt")
        query.whereKey("username_str", equalTo: objectID)
        //query.whereKeyExists(objectID)
        query.findObjectsInBackgroundWithBlock(completion)


    }
    
    class func queryTodayPlan(objectID: String, completion: (PFQueryArrayResultBlock)){
        let now = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let midnightOfToday = cal!.startOfDayForDate(now)


        let query = PFQuery(className:"UserMedia")
        query.orderByDescending("createdAt")
        query.whereKey("username_str", equalTo: objectID)
        query.whereKey("updatedAt", greaterThanOrEqualTo: midnightOfToday)
        query.findObjectsInBackgroundWithBlock(completion)
        
        
    }

}
