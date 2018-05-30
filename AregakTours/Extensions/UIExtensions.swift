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
    button.setImage(image, for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.imageEdgeInsets = UIEdgeInsetsMake(5,  25, 20, 0)
    button.setTitle(text, for: .normal)
    button.titleLabel?.textAlignment = .center
    button.titleEdgeInsets = UIEdgeInsetsMake(25, -20, 5, 0)
  }
}

extension Array {
  mutating func removeObject<T>(obj: T) where T : Equatable {
    self = self.filter({$0 as? T != obj})
  }
}


