import RxSwift

protocol ToursViewModelOutputs {
  var tours: Observable<[TourCellViewModel]> { get }
  var displayBookView: Observable<BookViewModel?> { get }
}

protocol ToursViewModelInputs {
  func notifyViewDidLoad()
}

protocol ToursViewModeling {
  var inputs: ToursViewModelInputs { get }
  var outputs: ToursViewModelOutputs { get }
}

final class ToursViewModel: ToursViewModeling, ToursViewModelOutputs, ToursViewModelInputs {
  
  var inputs: ToursViewModelInputs { return self }
  var outputs: ToursViewModelOutputs { return self }
  
  fileprivate var toursInput = BehaviorSubject<[TourCellViewModel]>(value: [])
  var tours: Observable<[TourCellViewModel]> {
    return toursInput.asObservable()
  }
  
  fileprivate var displayBookViewInput = BehaviorSubject<BookViewModel?>(value: nil)
  var displayBookView: Observable<BookViewModel?> {
    return displayBookViewInput.asObservable()
  }
  
  let disposeBag: DisposeBag
  let toursProvider: ToursInteractorAdaptor
  private(set) var selectedTours = [TourViewModel]()
  
  init(toursProvider: ToursInteractorAdaptor){
    self.toursProvider = toursProvider
    self.disposeBag = DisposeBag()
  }
  
  func notifyViewDidLoad() {
    fetchTours()
  }
  
  func fetchTours() {
    
    toursProvider.fetchLocalTours { (tours, error) in
      if let error = error {
        print(error.localizedDescription)
      }
      guard let tours = tours, tours.count > 0 else {
        // empty state
        return
      }
      
      let tourViewModels = tours.map { TourViewModel(tour: $0) }
      self.toursInput.onNext(self.createCellViewModels(tourViewModels))
    }
  }
  
  func createCellViewModels(_ viewModels: [TourViewModel]) -> [TourCellViewModel] {
    var cellViewModels = [TourCellViewModel]()
    for vm in viewModels {
      let cellVM = TourCellViewModel(tourVM: vm)
      cellVM.outputs.priceUpdate
        .subscribe( onNext: { tourVM in
          guard let tourVM = tourVM else { return }
          self.updateSelectedTours(tourVM)
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
  
  func calculateTotalPrice() {
    let toursTotoal = selectedTours.reduce(0) { $0 + $1.tourTotalPrice }
    updateBookView(value: toursTotoal)
  }
  
  func updateBookView(value: Double) {
    if value > 0 {
      let bookViewModel = BookViewModel()
      bookViewModel.inputs.udpateView(with: value)
      displayBookViewInput.onNext(bookViewModel)
      
      bookViewModel.outputs.bookClicked
        .subscribe(onNext: { [weak self] clicked in
          if clicked {
            dump(self?.selectedTours)
          }
        })
        .disposed(by: disposeBag)
    } else {
      displayBookViewInput.onNext(nil)
    }
  }
  
  
}

