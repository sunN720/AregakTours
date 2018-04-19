//
//  TourTableViewCell.swift
//  AregakTours
//
//  Created by toxicsun on 3/3/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import UIKit

class TourTableViewCell {
    
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    @IBOutlet weak var mealButton: UIButton!
    @IBOutlet weak var DateButton: UIButton!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    // MARK: -  public methods
    func setupCell() {
        carButton.button(imageName: "", text: "10000amd")
        guideButton.button(imageName: "", text: "10000amd")
        mealButton.button(imageName: "", text: "10000amd")
        mealButton.titleLabel?.text = "Date"
        
        titleLable.textSepearatedByDot("text blah blah")
    }
}

// MARK: -  private methods
fileprivate extension TourTableViewCell {
    func openDatePicker() {
        
    }
}

// MARK: -  IBActions
fileprivate extension TourTableViewCell {
    
    @IBAction func carTapped(_ sender: Any) {
        
    }
    
    @IBAction func guideTapped(_ sender: Any) {
        
    }
    
    @IBAction func mealTapped(_ sender: Any) {
        
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        openDatePicker()
    }
}
