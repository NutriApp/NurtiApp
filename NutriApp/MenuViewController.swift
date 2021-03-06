//
//  MenuViewController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse

class MenuViewController: UITableViewController {

    @IBOutlet var menuTableView: UITableView! {
        didSet{
            menuTableView.delegate = self
            menuTableView.bounces = false
        }
    }
    
    struct Notifications {
        static let MainSelected = "MainSelected"
        static let ManageProgressSelected = "ManageProgressSelected"
        static let PlanSelected = "PlanSelected"
        static let ManageSupporterSelected = "ManageSupporterSelected"
        static let SupportingSelected = "SupportingSelected"
        static let CalendarSelected = "CalendarSelected"
        static let ProfileSelected = "ProfileSelected"
        static let LogOutSelected = "LogoutSelected"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = indexPath.item
        let center = NSNotificationCenter.defaultCenter()
        
        switch item {
        case 0:
            center.postNotification(NSNotification(name: Notifications.MainSelected, object: self))
        case 1:
            center.postNotification(NSNotification(name: Notifications.ManageProgressSelected, object: self))
        case 2:
            center.postNotification(NSNotification(name: Notifications.PlanSelected, object: self))
        case 3:
            center.postNotification(NSNotification(name: Notifications.ManageSupporterSelected, object: self))
        case 4:
            center.postNotification(NSNotification(name: Notifications.SupportingSelected, object: self))
        case 5:
            center.postNotification(NSNotification(name: Notifications.CalendarSelected, object: self))
        case 6:
            center.postNotification(NSNotification(name: Notifications.ProfileSelected, object: self))
        default:
            print("Unrecognized menu index")
            return
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
