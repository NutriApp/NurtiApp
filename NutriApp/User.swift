//
//  User.swift
//  NutriApp
//
//  Created by user116674 on 4/5/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    class func getUserInfo (id: String?, completion: (user: PFUser?, error: ErrorType?) -> ()) {
        var user: PFUser
        do {
            try user = PFQuery.getUserObjectWithId(id!)
            completion(user: user, error: nil)
            print("got user")
        } catch {
            completion(user: nil, error: error)
            print("failed to get user")
        }
    }
    
    class func saveUserProfile (info: [String: String]?) {
        let user = PFUser.currentUser()!
        if info!["name"] != nil {
            user["name"] = info!["name"]
        }
        if info!["email"] != nil {
            user["email"] = info!["email"]
        }
        if info!["age"] != nil {
            user["age"] = info!["age"]
        }
        if info!["gender"] != nil {
            user["gender"] = info!["gender"]
        }
        if info!["weight"] != nil {
            user["weight"] = info!["weight"]
        }
        if info!["goal"] != nil {
            user["goal"] = info!["goal"]
        }
        if info!["role"] != nil {
            user["role"] = info!["role"]
        }
        
        user.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("successfully updated profile")
            } else {
                print("did not update profile")
            }
        }

    }
    
}
