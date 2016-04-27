//
//  HomeCell.swift
//  NutriApp
//
//  Created by Kevin Tran on 4/19/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var proteinPercent: UILabel!
    @IBOutlet weak var fruitsPercent: UILabel!
    @IBOutlet weak var vegiPercent: UILabel!
    @IBOutlet weak var grainPercent: UILabel!
    @IBOutlet weak var dairyPercent: UILabel!
    @IBOutlet weak var oilPercent: UILabel!
    
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var foodImage: PFImageView!
    
    @IBOutlet weak var cumalativeProteinPercent: UILabel!
    @IBOutlet weak var cumalativeFruitPercent: UILabel!
    @IBOutlet weak var cumaltiveVegiPercent: UILabel!
    @IBOutlet weak var cumaltiveGrainPercent: UILabel!
    @IBOutlet weak var cumaltiveDairyPercent: UILabel!
    @IBOutlet weak var cumaltiveOilPercent: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var media: PFObject? {
        didSet{
            let input = media!.valueForKey("input")! as! [Float]
            let plan = media!.valueForKey("current_plan")! as? [Float]
            let cumulativePlan = media!.valueForKey("cumulative")! as? [Float]
            
            let caption = media!.valueForKey("caption")! as? String
            
            if let image = media!.valueForKey("media")! as? PFFile {
                foodImage.file = image
                foodImage.loadInBackground()
            } else {
                foodImage.image = UIImage(named: "White_square_with_question_mark")
            }
            
            
            let username = media!.valueForKey("username_str")! as? String
            
            usernameLabel.text = username
            commentText.text = caption
            
            var percent = 0.0 as Float
            var cumulativePercent = 0.0 as Float
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = .ShortStyle
            
            let date = media!.valueForKey("created_at")! as! NSDate
            let dateString = formatter.stringFromDate(date)
            
            dateLabel.text = dateString
            
            
            for index in 0...5 {
                if plan![index] != 0 {
                    percent = input[index] / plan![index]
                    cumulativePercent = cumulativePlan![index] / plan![index]
                } else {
                    percent = 0.0
                }
                if cumulativePercent > 999.0 {
                    cumulativePercent = 999.0
                }
                switch index {
                case 0:
                    proteinPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumalativeProteinPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumalativeProteinPercent.textColor = UIColor.redColor()
                    } else {
                        cumalativeProteinPercent.textColor = UIColor.blackColor()

                    }
                case 1:
                    fruitsPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumalativeFruitPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumalativeFruitPercent.textColor = UIColor.redColor()
                    } else {
                        cumalativeFruitPercent.textColor = UIColor.blackColor()
                        
                    }
                case 2:
                    vegiPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumaltiveVegiPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumaltiveVegiPercent.textColor = UIColor.redColor()
                    } else {
                        cumaltiveVegiPercent.textColor = UIColor.blackColor()
                        
                    }
                case 3:
                    grainPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumaltiveGrainPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumaltiveGrainPercent.textColor = UIColor.redColor()
                    } else {
                        cumaltiveGrainPercent.textColor = UIColor.blackColor()
                        
                    }
                case 4:
                    dairyPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumaltiveDairyPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumaltiveDairyPercent.textColor = UIColor.redColor()
                    } else {
                        cumaltiveDairyPercent.textColor = UIColor.blackColor()
                        
                    }
                case 5:
                    oilPercent.text = String(format: "%.0f", percent*100) + "%"
                    cumaltiveOilPercent.text = String(format: "%.0f", cumulativePercent*100) + "%"
                    if input[index] != 0 {
                        cumaltiveOilPercent.textColor = UIColor.redColor()
                    } else {
                        cumaltiveOilPercent.textColor = UIColor.blackColor()
                        
                    }
                default:
                    print("Unrecognized menu index")
                }
            }

        }
    }

    
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
