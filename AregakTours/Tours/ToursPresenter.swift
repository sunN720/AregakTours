import RxSwift
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
  
  private var disposeBag = DisposeBag()
  
  init(toursService: ToursInteractorAdaptor){
    self.toursService = toursService
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  func updateBookView(value: Double) {
    if value > 0 {
      let bookViewModel = BookViewModel()
      bookViewModel.inputs.udpateView(with: value)
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
      
      for tourVM in tourViewModels {
       let priceVM = PricesViewModel(transport: tourVM.transport,
                                     guide: tourVM.guide,
                                     meal: tourVM.meal)
        let cellViewModel = TourCellViewModel(tourViewModel: tourVM,
                                              priceViewModel: priceVM)
        cellViewModel.outputs.priceUpdate
          .subscribe( onNext: { [weak self] value in
            self?.updateBookView(value: value)
            })
          .disposed(by: self.disposeBag)
        self.cellViewModels.append(cellViewModel)
      }

      self.toursView?.setTours(self.cellViewModels)
      self.toursView?.updateViewFor(emptyState: false)
    }
  }
}

