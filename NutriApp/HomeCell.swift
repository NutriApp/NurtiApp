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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
