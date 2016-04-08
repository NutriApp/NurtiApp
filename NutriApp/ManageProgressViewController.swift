//
//  ManageProgressViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ManageProgressViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var uploadView: UIView!
    let uploadTap = UITapGestureRecognizer()
    var imageToUpload: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initialViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialViews() {
        //Visual layout
        foodImageView.image = nil
        foodImageView.hidden = true
        uploadView.alpha = 0.8
        uploadLabel.hidden = false
        
        //Tap Gesture Recognizer
        uploadTap.addTarget(self, action: Selector("onUploadTap:"))
        uploadView.addGestureRecognizer(uploadTap)
        uploadView.userInteractionEnabled = true
    }
    
    //Upload image tapped
    func onUploadTap(recognizer: UITapGestureRecognizer) {
        //Open image picker
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //Get image from image picker
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imageToUpload = resize(image, newSize: CGSizeMake(750, 750))
            
            //Show image in preview image view
            self.foodImageView.image = imageToUpload
            self.foodImageView.hidden = false
            self.uploadLabel.hidden = true
                
            //Dismiss image picker
            self.dismissViewControllerAnimated(true, completion: nil)
            
            //Remove tap gesture recognizer from upload view
            uploadView.removeGestureRecognizer(uploadTap)
    }
    
    //Resize image to fit in Parse's limits
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
