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
import CoreData
import MBProgressHUD

protocol saveSliderDelegate: class {
    func saveSlider(picker: ManageProgressCell, value: Float, index: Int)
}

class ManageProgressViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var uploadView: UIView!
    let uploadTap = UITapGestureRecognizer()
    var imageToUpload: UIImage?
    var input: [Float]!
    var defaults = NSUserDefaults.standardUserDefaults()
    var currentPlan: [Float]!

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsField: UITextField!
    //@IBOutlet weak var slider: UISlider!
    
    var plan: NSDictionary!
    weak var delegate: saveSliderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViews()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        plan = PFUser.currentUser()!["plan"] as! NSDictionary
        

        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didPost:"), name: "EndPost", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("failedPost:"), name: "ErrorPost", object: nil)
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
        
        let initial: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        input = initial
        currentPlan = initial
        
        defaults.setObject(initial, forKey: "sliderValue")
        defaults.synchronize()
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
//        slider.tag = indexPath.item
        cell.planSlider.tag = item
        
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
        
        currentPlan[item] = value
        
        if state {
            cell.planTitle.alpha = 1
            cell.planSlider.enabled = true
            cell.planSlider.alpha = 1
//            slider.enabled = true
//            slider.alpha = 1
            cell.planLabel.alpha = 1
            cell.planInput.alpha = 1
        } else {
            cell.planTitle.alpha = 0.1
            cell.planSlider.enabled = false
            cell.planSlider.alpha = 0.1
//            slider.enabled = false
//            slider.alpha = 0.1
            cell.planLabel.alpha = 0.1
            cell.planInput.alpha = 0.1

        }
        //cell.planSlider.value = input[item]

        //print(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plan.count
    }
    
    func getCurrentPlan(){
        var value = plan["protein"]![0] as! Float

        for index in 0...5 {
            
        
            switch index {
            case 0:
                currentPlan[index] = value
            case 1:
                value = plan["fruits"]![0] as! Float
            case 2:
                value = plan["vegetable"]![0] as! Float
            case 3:
                value = plan["grain"]![0] as! Float
            case 4:
                value = plan["dairy"]![0] as! Float
            case 5:
                value = plan["oil"]![0] as! Float
            default:
                print("Unrecognized menu index")
            }
            currentPlan[index] = value

        }
    }
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        initialViews()
        tableView.reloadData()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }


    @IBAction func onPost(sender: UIBarButtonItem) {
        
        let value = defaults.objectForKey("sliderValue") as! [Float]!

        getCurrentPlan()
        
        let currentUser = PFUser.currentUser()!.username!
        var todayMedia: [PFObject]?
        
        var initial: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Posting"
        
        UserPlan.queryTodayPlan(currentUser) { (media: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                todayMedia = media
                if media?.count != 0 {
                        let temp = (media![0].valueForKey("cumulative")! as! [Float])
                        for index in 0...5 {
                            initial[index] = value[index] + temp[index]
                        }
                        //                    initial = initial + (media![item].valueForKey("input")! as! [Float])
                        print(media![0].valueForKey("cumulative")!)
                        print(initial)
                } else {
                    initial = value
                }
                
                UserPlan.postUserPost(self.imageToUpload, withCaption: self.commentsField.text, input: value, currentPlan: self.currentPlan, cumulative: initial) { (success: Bool, error: NSError?) -> Void in
                    if success {
                        print("user posted")
                        NSNotificationCenter.defaultCenter().postNotificationName("EndPost", object: nil)
                        
                    } else {
                        print(error)
                        NSNotificationCenter.defaultCenter().postNotificationName("ErrorPost", object: nil)

                    }
                }
            } else {
                print(error)
            }
        }
        

        
    }
    
    func didPost(notification: NSNotification) {
        //Stop loading indicator
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        //Go back to main profile page
//        navigationController?.popViewControllerAnimated(true)
    }
    
    func failedPost(notification: NSNotification) {
        //Stop loading indicator
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        
        //Show alert message
        let alertController = UIAlertController(title: "Error", message: "Error Posting",preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
//    func saveSlider(picker: ManageProgressCell, value:Float, index: Int) {
//        input[index] = value
//        print(input)
//    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
