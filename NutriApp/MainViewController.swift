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
