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
    
    toursService.fetchLocalTours { [weak self] (tours, error) in
      
      self?.toursView?.finishLoading()
      
      if let error = error {
        self?.toursView?.updateViewFor(emptyState: true)
      }
      
      guard let tours = tours, tours.count > 0 else {
        self?.toursView?.updateViewFor(emptyState: true)
        return
      }
      
      var toursViewModel = [TourViewModel]()
      for tour in tours {
        let tourViewModel = TourViewModel.init(tour: tour)
        toursViewModel.append(tourViewModel)
      }
      self?.toursView?.setTours(toursViewModel)
      self?.toursView?.updateViewFor(emptyState: false)
    }
  }
}

