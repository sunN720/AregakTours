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
	func displayBookView(_ viewModel: BookViewModel)
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
    
    if selectedTours.count > 0 {
      let totalAmount = calculateTotalAmount(tours: selectedTours)
			let viewModel = BookViewModel()
      toursView?.displayBookView(viewModel)
    } else {
      toursView?.hideBookView()
    }
  }
  
  func calculateTotalAmount(tours: [TourViewModel]) -> String {
    let totalAmount = tours.reduce(0, { Int($0) + Int($1.transport)! })
    return String(totalAmount)
  }
  
  func fetchTours() {
    self.toursView?.startLoading()
    
    toursService.fetchLocalTours { [weak self] (tours, error) in
      
      guard let `self` = self else { return }
      
      self.toursView?.finishLoading()
      
      if let error = error {
				print(error.localizedDescription)
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

