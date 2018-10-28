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
  private(set) var selectedTours = [TourViewModel]()
  
  private let disposeBag = DisposeBag()
  
  init(toursService: ToursInteractorAdaptor){
    self.toursService = toursService
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  func calculateTotalPrice() {
    let toursTotoal = selectedTours.reduce(0) { $0 + $1.tourTotalPrice }
    updateBookView(value: toursTotoal)
  }
  
  func updateBookView(value: Double) {
    if value > 0 {
      let bookViewModel = BookViewModel()
      bookViewModel.inputs.udpateView(with: value)
      toursView?.displayBookView(bookViewModel)
      
      bookViewModel.outputs.bookClicked
        .subscribe(onNext: { [weak self] clicked in
          if clicked {
            dump(self?.selectedTours)
          }
        })
        .disposed(by: disposeBag)
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
      self.toursView?.setTours(self.createCellViewModels(tourViewModels))
      self.toursView?.updateViewFor(emptyState: false)
    }
  }
  
  
  func createCellViewModels(_ viewModels: [TourViewModel]) -> [TourCellViewModel] {
    var cellViewModels = [TourCellViewModel]()
    for vm in viewModels {
      let cellVM = TourCellViewModel(tourVM: vm)
      cellVM.outputs.priceUpdate
        .subscribe( onNext: { [weak self] tourVM in
          guard let tourVM = tourVM else { return }
          self?.updateSelectedTours(tourVM)
        })
        .disposed(by: self.disposeBag)
      cellViewModels.append(cellVM)
    }
    
    return cellViewModels
  }
  
  func updateSelectedTours(_ tourViewModel: TourViewModel) {
    if let vmIndex = selectedTours.index(of: tourViewModel) {
      selectedTours[vmIndex] = tourViewModel
    } else {
      selectedTours.append(tourViewModel)
    }
    
    calculateTotalPrice()
  }
  
}
