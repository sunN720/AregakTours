//
//  TourViewModel.swift
//  AregakTours
//
//  Created by toxicsun on 4/19/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import Foundation


struct TourViewModel {
  var id: Int
  var name: String
  var transport: String
  var guide: String
  var meal: String
  var description: String?
  
  init(tour: Tour) {
    self.id = tour.id
    self.name = tour.name.uppercased()
    self.transport = tour.transport
    self.guide = tour.guide
    self.meal = tour.meal
    self.description = tour.description
  }
}
