import Foundation

protocol ToursView: class {
  func startLoading()
  func finishLoading()
  func setTours(_ tours: [TourViewModel])
  func updateViewFor(emptyState: Bool)
  func displayBookView(_ viewModel: BookViewModeling)
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
  
  func didSelectTour(at indexPath: IndexPath) {
    let tour = toursViewModel[indexPath.row]
    
    if selectedTours.contains(tour) {
      tour.updateState(.regular)
      selectedTours.removeObject(obj: tour)
    } else {
      selectedTours.append(tour)
      tour.updateState(.selected)
    }
    
    updateBookView()
  }
  
  func updateBookView() {
    if selectedTours.count > 0 {
      let viewModel = BookViewModel()
      viewModel.inputs.selectedTours(selectedTours)
      toursView?.displayBookView(viewModel)
    } else {
      toursView?.hideBookView()
    }
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

