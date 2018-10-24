import Foundation

protocol ToursView: class {
  func startLoading()
  func finishLoading()
  func setTours(_ tours: [TourCellViewModel])
  func updateViewFor(emptyState: Bool)
  func displayBookView(_ viewModel: BookViewModeling)
  func hideBookView()
}

class ToursPresenter {
  fileprivate let toursService: ToursInteractorAdaptor!
  weak var toursView : ToursView?
  var cellViewModels = [TourCellViewModel]()
  var selectedTours = [TourCellViewModel]()
  
  init(toursService: ToursInteractorAdaptor){
    self.toursService = toursService
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  func didSelectTour(at indexPath: IndexPath) {
    let tour = cellViewModels[indexPath.row]
    
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
      let bookViewModel = BookViewModel()
      bookViewModel.inputs.selectedTours(selectedTours)
      toursView?.displayBookView(bookViewModel)
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
      
      let tourViewModels = tours.map { TourViewModel(tour: $0) }
      
      for vm in tourViewModels {
        let cellViewModel = TourCellViewModel(tourViewModel: vm)
        self.cellViewModels.append(cellViewModel)
      }

      self.toursView?.setTours(self.cellViewModels)
      self.toursView?.updateViewFor(emptyState: false)
    }
  }
}

