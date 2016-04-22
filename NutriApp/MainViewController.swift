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
    
    func fetchMedia(){
        let currentUser = PFUser.currentUser()!.username!
//        UserPlan.queryUserPlan(currentUser) { (media: [PFObject]?,error: NSError?) -> Void in
//            if error == nil {
//                print(media)
//                self.media = media
//                self.tableView.reloadData()
//            } else {
//                print(error)
//            }
//        }
        

        UserPlan.queryTodayPlan(currentUser) { (media: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                self.todayMedia = media
                let todayProgress = (media![0].valueForKey("cumulative")! as! [Float])
                print(todayProgress)
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
