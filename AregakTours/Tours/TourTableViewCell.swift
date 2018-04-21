//
//  TourTableViewCell.swift
//  AregakTours
//
//  Created by toxicsun on 3/3/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import UIKit

class TourTableViewCell: UITableViewCell {
  
  @IBOutlet weak var carButton: UIButton!
  @IBOutlet weak var guideButton: UIButton!
  @IBOutlet weak var mealButton: UIButton!
  @IBOutlet weak var dateButton: UIButton!
  
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  // MARK: -  public methods
  func setupCell(viewModel: TourViewModel) {
    carButton.button(imageName: "", text: viewModel.price.car)
    guideButton.button(imageName: "", text: viewModel.price.guide)
    mealButton.button(imageName: "", text: viewModel.price.meal)
    
    titleLable.text = viewModel.description
  }
}

// MARK: -  private methods
fileprivate extension TourTableViewCell {
  func openDatePicker() {
    /**
     dateButton.text = from picker
     */
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
