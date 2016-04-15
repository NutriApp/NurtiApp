//
//  ManageProgressCell.swift
//  NutriApp
//
//  Created by Kevin Tran on 4/13/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class ManageProgressCell: UITableViewCell {

    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var planSlider: UISlider!
    @IBOutlet weak var planTitle: UILabel!
    @IBOutlet weak var planInput: UILabel!
    
    var unit: String! {
        didSet{
           // planInput.text = "Input: \(planSlider.value) \(unit)"
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

//    @IBAction func onSliderChange(sender: UISlider) {
//        planInput.text = "Input: \(planSlider.value) \(unit)"
//    }
}
