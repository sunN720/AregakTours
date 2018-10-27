import RxSwift

enum State {
  case regular
  case selected
}

// SHOULD BE TourCellViewModel?

protocol TourCellViewModelOutputs {
  var name: String { get }
  var description: String? { get }
  var priceVM: PricesViewModel { get }
  var priceUpdate: Observable<Double> { get }
}

protocol TourCellViewModelInputs {
}

protocol TourCellViewModeling {
  var inputs: TourCellViewModelInputs { get }
  var outputs: TourCellViewModelOutputs { get }
}


class TourCellViewModel: TourCellViewModeling, TourCellViewModelInputs, TourCellViewModelOutputs {
  
  var inputs: TourCellViewModelInputs { return self }
  var outputs: TourCellViewModelOutputs { return self }
  
  private let selectedInput = BehaviorSubject<State>(value: .regular)
  var selected: Observable<State> {
    return selectedInput.asObservable()
  }
  
  private let priceUpdateInput = BehaviorSubject<Double>(value: 0)
  var priceUpdate: Observable<Double> {
    return priceUpdateInput.asObservable()
  }
  
  let id: Int
  let name: String
  let description: String?
  let priceVM: PricesViewModel

  private let disposeBag = DisposeBag()
  
  init(tourViewModel: TourViewModel, priceViewModel: PricesViewModel) {
    self.id = tourViewModel.id
    self.name = tourViewModel.name.uppercased()
    self.description = tourViewModel.description
    self.priceVM = priceViewModel
    bindPriceVM()
  }
  
  private(set) var tourTotoal: Double = 0
  
  func calculateTotalPrice(_ price: Price) {
    switch price.state {
    case .selected:
      tourTotoal += price.value
    case .notSelected:
      tourTotoal -= price.value
    }
    
    priceUpdateInput.onNext(tourTotoal)
  }
  
  func bindPriceVM() {
    priceVM.priceValueUpdated
      .subscribe( onNext: { price in
        self.calculateTotalPrice(price)
      })
      .disposed(by: disposeBag)
  }
  
}
