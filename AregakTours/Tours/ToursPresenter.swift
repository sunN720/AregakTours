//
//  ToursPresenter.swift
//  AregakTours
//
//  Created by toxicsun on 2/24/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//


import Foundation

protocol ToursView: class {
  func startLoading()
  func finishLoading()
  func setTours(_ tours: [TourViewModel])
  func updateViewFor(emptyState: Bool)
}

class ToursPresenter {
  fileprivate let toursService: ToursInteractorAdaptor!
  weak var toursView : ToursView?
  
  init(toursService: ToursInteractorAdaptor){
    self.toursService = toursService
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  
  func fetchTours() {
    self.toursView?.startLoading()
    
    toursService.fetchLocalTours{ [weak self] (tours, error) in
      
      self?.toursView?.finishLoading()
      
      if let error = error {
        self?.toursView?.updateViewFor(emptyState: true)
      }
      
      guard let tours = tours, tours.count > 0 else {
        self?.toursView?.updateViewFor(emptyState: true)
        return
      }
      let price = TourViewModel.Price.init(car: "15000", guide: "10000", meal: "5000")
      let tourViewModel1 = TourViewModel.init(id: 12, name: "YEREVAN - GORIS", price: price)
      let tourViewModel2 = TourViewModel.init(id: 12, name: "YEREVAN - MEGHRI", price: price)
      let tourViewModel3 = TourViewModel.init(id: 12, name: "YEREVAN - SISIAN", price: price)
      self?.toursView?.setTours([tourViewModel1, tourViewModel2, tourViewModel3])
      self?.toursView?.updateViewFor(emptyState: false)
    }
  }
}

