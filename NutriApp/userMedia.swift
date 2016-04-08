//
//  userMedia.swift
//  NutriApp
//
//  Created by user116674 on 4/7/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class userMedia: NSObject {
    
    //Convert image to storabl PFFile
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

}
