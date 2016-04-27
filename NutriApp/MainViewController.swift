//
//  MainViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse


class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var media: [PFObject]?
    var todayMedia: [PFObject]?
    var todayPlan: [Float]?
    
    var input: [Float]!
    var plan: [Float]!

    @IBOutlet weak var protienPercent: UILabel!
    @IBOutlet weak var fruitsPercent: UILabel!
    @IBOutlet weak var vegiPercent: UILabel!
    @IBOutlet weak var grainPercent: UILabel!
    @IBOutlet weak var dairyPercent: UILabel!
    @IBOutlet weak var oilPercent: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(aimated: Bool) {
        fetchMedia()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //       let log = ["protein": [6, "oz(s)", true], "fruits": [2, "cup(s)", true], "vegetable": [3, "cup(s)", true], "grain": [3, "oz(s)", true], "dairy": [3, "cup(s)", true], "oil": [6, "tsp(s)", true]  ]
    func fetchMedia(){
        let currentUser = PFUser.currentUser()!.username!
        UserPlan.queryUserPlan(currentUser) { (media: [PFObject]?,error: NSError?) -> Void in
            if error == nil {
//                print(media)
                self.media = media
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
        

        UserPlan.queryTodayPlan(currentUser) { (media: [PFObject]?, error: NSError?) -> Void in
            if ((error == nil) && (media != nil)) {
                self.todayMedia = media
                let todayProgress = (media![0].valueForKey("cumulative")! as! [Float])
                self.todayPlan = (media![0].valueForKey("current_plan")! as! [Float])
                print(todayProgress)
                var percent = 0.0 as Float
                for index in 0...5 {
                    if self.todayPlan![index] != 0 {
                        percent = todayProgress[index] / self.todayPlan![index]
                    } else {
                        percent = 0.0
                    }
                    switch index {
                    case 0:
                        self.protienPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.protienPercent.hidden = false
                    case 1:
                        self.fruitsPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.fruitsPercent.hidden = false
                    case 2:
                        self.vegiPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.vegiPercent.hidden = false
                    case 3:
                        self.grainPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.grainPercent.hidden = false
                    case 4:
                        self.dairyPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.dairyPercent.hidden = false
                    case 5:
                        self.oilPercent.text = String(format: "%.1f", percent*100) + "%"
                        self.oilPercent.hidden = false
                    default:
                        print("Unrecognized menu index")
                    }
                }
            } else {
                print(error)
            }
        }
        
        if todayPlan == nil {
            self.protienPercent.text = "0%"
            self.protienPercent.hidden = false
            self.fruitsPercent.text = "0%"
            self.fruitsPercent.hidden = false
            self.vegiPercent.text = "0%"
            self.vegiPercent.hidden = false
            self.grainPercent.text = "0%"
            self.grainPercent.hidden = false
            self.dairyPercent.text = "0%"
            self.dairyPercent.hidden = false
            self.oilPercent.text = "0%"
            self.oilPercent.hidden = false
        }
        
//        UserPlan.queryTodayPlan(currentUser) { (todayMedia: [PFObject]?, error: NSError?) -> Void in
//            if error == nil {
//                print(todayMedia)
//            } else {
//                print(error)
//            }
//        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        
        input = media![indexPath.row].valueForKey("input")! as! [Float]
        plan = media![indexPath.row].valueForKey("current_plan")! as? [Float]
        let cumulativePlan = media![indexPath.row].valueForKey("cumulative")! as? [Float]

        let caption = media![indexPath.row].valueForKey("caption")! as? String

        
        if let image = media![indexPath.row].valueForKey("media")! as? PFFile {
            cell.foodImage.file = image
            cell.foodImage.loadInBackground()
        } else {
            cell.foodImage.image = UIImage(named: "White_square_with_question_mark")
        }
        let username = media![indexPath.row].valueForKey("username_str")! as? String

        cell.usernameLabel.text = username
        cell.commentText.text = caption
        
        var percent = 0.0 as Float
        var cumulativePercent = 0.0 as Float

        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = .ShortStyle
        
        let date = media![indexPath.row].valueForKey("created_at")! as! NSDate
        let dateString = formatter.stringFromDate(date)
        
        cell.dateLabel.text = dateString
                
        for index in 0...5 {
            if plan[index] != 0 {
                percent = input[index] / plan[index]
                cumulativePercent = cumulativePlan![index] / plan[index]
            } else {
                percent = 0.0
            }
            if cumulativePercent > 999.0 {
                cumulativePercent = 999.0
            }
            switch index {
            case 0:
                cell.proteinPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumalativeProteinPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
            case 1:
                cell.fruitsPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumalativeFruitPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
            case 2:
                cell.vegiPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumaltiveVegiPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"

            case 3:
                cell.grainPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumaltiveGrainPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"

            case 4:
                cell.dairyPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumaltiveDairyPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"

            case 5:
                cell.oilPercent.text = String(format: "%.0f", percent*100) + "%"
                cell.cumaltiveOilPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"

            default:
                print("Unrecognized menu index")
            }
        }

        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let media = media {
            return media.count
        } else {
            return 0
        }
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
