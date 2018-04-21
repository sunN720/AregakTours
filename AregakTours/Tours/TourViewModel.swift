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
  var description: String? {
    set {}
    get {
      return "Dummy description"
    }
  }
  var price: Price
  
  
  struct Price {
    var car: String
    var guide: String
    var meal: String
  }
  
  func textSepearatedByDot(_ text: String) -> NSAttributedString {
    /**
     text separate by dot
     */
    return NSAttributedString(string: text)
  }
  
  
}
