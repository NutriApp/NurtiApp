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

class ManageProgressViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var uploadView: UIView!
    let uploadTap = UITapGestureRecognizer()
    var imageToUpload: UIImage?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsField: UITextField!
    
    var plan: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        
        plan = PFUser.currentUser()!["plan"] as! NSDictionary

        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        //super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialViews() {
        //Visual layout
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ManageProgressCell", forIndexPath: indexPath) as! ManageProgressCell
        
        let item = indexPath.item
        
        var value = plan["protein"]![0] as! Float
        var state = plan["protein"]![2] as! Bool
        var unit = plan["protein"]![1] as! String
        
        switch item {
        case 0:
            cell.planTitle.text = "Protein"
            cell.planLabel.text = "Goal: \(value) \(unit)"
            cell.unit = unit
        case 1:
            value = plan["fruits"]![0] as! Float
            state = plan["fruits"]![2] as! Bool
            unit = plan["fruits"]![1] as! String
            cell.planTitle.text = "Fruit"
            cell.planLabel.text = "Goal: \(value) \(unit)"
            cell.unit = unit
        case 2:
            value = plan["vegetable"]![0] as! Float
            state = plan["vegetable"]![2] as! Bool
            unit = plan["vegetable"]![1] as! String
            cell.planTitle.text = "Vegetable"
            cell.planLabel.text = "Vegetable: Goal \(value) \(unit)"
            cell.unit = unit
        case 3:
            value = plan["grain"]![0] as! Float
            state = plan["grain"]![2] as! Bool
            unit = plan["grain"]![1] as! String
            cell.planTitle.text = "Grain"
            cell.planLabel.text = "Goal: \(value) \(unit)"
            cell.unit = unit
        case 4:
            value = plan["dairy"]![0] as! Float
            state = plan["dairy"]![2] as! Bool
            unit = plan["dairy"]![1] as! String
            cell.planTitle.text = "Dairy"
            cell.planLabel.text = "Goal: \(value) \(unit)"
            cell.unit = unit
        case 5:
            value = plan["oil"]![0] as! Float
            state = plan["oil"]![2] as! Bool
            unit = plan["oil"]![1] as! String
            cell.planTitle.text = "Oil"
            cell.planLabel.text = "Goal: \(value) \(unit)"
            cell.unit = unit
        default:
            print("Unrecognized menu index")
            return cell
        }
        
        
        if state {
            cell.planTitle.alpha = 1
            cell.planSlider.enabled = true
            cell.planSlider.alpha = 1
            cell.planLabel.alpha = 1
            cell.planInput.alpha = 1
        } else {
            cell.planTitle.alpha = 0.1
            cell.planSlider.enabled = false
            cell.planSlider.alpha = 0.1
            cell.planLabel.alpha = 0.1
            cell.planInput.alpha = 0.1

        }
        //cell.planSlider.value = value

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plan.count
    }

    @IBAction func onSliderChange(sender: UISlider) {
        
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
