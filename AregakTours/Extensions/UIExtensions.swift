//
//  UIExtensions.swift
//  AregakTours
//
//  Created by toxicsun on 3/8/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import UIKit


extension UIButton {
  
  func button(imageName: String, text: String) {
    
    guard let image = UIImage(named: imageName) else { return }
    let imageSize = image.size
    
    let button = self
    button.imageView?.image = image
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, self.frame.size.height - imageSize.height, 0)
    button.titleLabel?.text = text
    button.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + 5, 0, 0, 0)
  }
}


