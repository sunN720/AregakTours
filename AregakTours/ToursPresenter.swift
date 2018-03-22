//
//  ToursPresenter.swift
//  AregakTours
//
//  Created by toxicsun on 2/24/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//


import Foundation

struct TourViewModel {
    var id: Int
    var name: String
    var description: String?
    var price: String
}

protocol ToursView: class {
    func startLoading()
    func finishLoading()
    func setTours(_ tours: [TourViewModel])
    func updateViewFor(emptyState: Bool)
}

class ToursPresenter {
    fileprivate let toursService: ToursInteractorAdaptor!
    weak fileprivate var toursView : ToursView?
    
    init(toursService: ToursInteractorAdaptor){
        self.toursService = toursService
    }
    
    func attachView(_ view: ToursView){
         toursView = view
    }
    
    func detachView() {
        toursView = nil
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
            let mappedTours = tours.flatMap( {
                return TourViewModel(
                    id: ($0.id),
                    name: "\($0.name)",
                    description: "\($0.description)",
                    price: "\($0.price)")
            })
            self?.toursView?.setTours(mappedTours)
            self?.toursView?.updateViewFor(emptyState: false)
        }
    }
}

