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
  func displayBookView()
  func hideBookView()
}

class ToursPresenter {
  fileprivate let toursService: ToursInteractorAdaptor!
  weak var toursView : ToursView?
  var toursViewModel = [TourViewModel]()
  var selectedTours = [TourViewModel]()
  
  init(toursService: ToursInteractorAdaptor){
    self.toursService = toursService
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  func tourWasSelected(at indexPath: IndexPath) {
    let tour = toursViewModel[indexPath.row]
    if tour.state == .regular {
      selectedTours.append(tour)
      tour.state = .selected
    } else if let index = selectedTours.index(of: tour) {
        selectedTours.remove(at: index)
        tour.state = .regular
    }
    print("selected tours count: \(selectedTours.count)")
  }
  
  func createTotalViewModel(tour: TourViewModel) {

  }
  
  
  func fetchTours() {
    self.toursView?.startLoading()
    
    toursService.fetchLocalTours { [weak self] (tours, error) in
      
      guard let `self` = self else { return }
      
      self.toursView?.finishLoading()
      
      if let error = error {
        self.toursView?.updateViewFor(emptyState: true)
      }
      
      guard let tours = tours, tours.count > 0 else {
        self.toursView?.updateViewFor(emptyState: true)
        return
      }
      
      for tour in tours {
        let tourViewModel = TourViewModel(tour: tour)
        self.toursViewModel.append(tourViewModel)
      }

      self.toursView?.setTours(self.toursViewModel)
      self.toursView?.updateViewFor(emptyState: false)
    }
  }
}

