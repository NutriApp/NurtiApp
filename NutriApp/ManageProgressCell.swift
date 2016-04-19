//
//  ManageProgressCell.swift
//  NutriApp
//
//  Created by Kevin Tran on 4/13/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit
import CoreData

class ManageProgressCell: UITableViewCell {

    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var planSlider: UISlider!
    @IBOutlet weak var planTitle: UILabel!
    @IBOutlet weak var planInput: UILabel!

    var currentSlider: Float!
    weak var delegate: saveSliderDelegate?
    var defaults = NSUserDefaults.standardUserDefaults()

    
    var unit: String! {
        didSet{
            let value = defaults.objectForKey("sliderValue") as! [Float]!
            currentSlider = value[planSlider.tag]
            planSlider.value = currentSlider
            planInput.text = "Input: \(currentSlider) \(unit)"
        }
    }
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
        let value = defaults.objectForKey("sliderValue") as! [Float]!
        
        currentSlider = value[planSlider.tag]
        print(value)
        
        if currentSlider != nil {
            planSlider.value = currentSlider
        }
        planInput.text = "Input: \(currentSlider) \(unit)"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSliderChange(sender: UISlider) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var value = defaults.objectForKey("sliderValue") as! [Float]!
        value[planSlider.tag] = planSlider.value
        defaults.setObject(value, forKey: "sliderValue")
        defaults.synchronize()
        
        currentSlider = planSlider.value
        
        delegate?.saveSlider(self, value: planSlider.value, index: planSlider.tag)

        planInput.text = "Input: \(currentSlider) \(unit)"
    }
}
