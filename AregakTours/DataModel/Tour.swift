//
//  Tour.swift
//  AregakTours
//
//  Created by toxicsun on 2/10/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import Foundation

struct Tour: Codable {
  var id: Int
  var name: String
  var transport: String
  var guide: String
  var meal: String
  var description: String?
}

