//
//  ProfileEditViewController.swift
//  NutriApp
//
//  Created by user116674 on 4/7/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
    let uploadTap = UITapGestureRecognizer()
    var profileImage: PFFile?
    let user = PFUser.currentUser()
    var role: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idLabel.text = PFUser.currentUser()!.objectId
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Fill in text
        if user!["name"] != nil {
            nameField.text = user!["name"] as? String
        } else {
            nameField.text = "Full Name"
        }
        emailField.text = user!["email"] as? String
        ageField.text = user!["age"] as? String
        goalField.text = user!["goal"] as? String
        genderField.text = user!["gender"] as? String
        weightField.text = user!["weight"] as? String
        
        //Tap Gesture Recognizer
        uploadTap.addTarget(self, action: Selector("onUploadTap:"))
        uploadView.addGestureRecognizer(uploadTap)
        uploadView.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
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
            let imageToUpload = resize(image, newSize: CGSizeMake(750, 750))
            
            //Show image in preview image view
            self.profileImageView.image = imageToUpload
            self.profileImageView.hidden = false
            self.updateLabel.hidden = true
            self.uploadView.alpha = 1
            
            //Get PFFile fom image
            self.profileImage = userMedia.getPFFileFromImage(imageToUpload)!
            
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
        
        User.saveUserProfile(info, image: profileImage)
        
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
