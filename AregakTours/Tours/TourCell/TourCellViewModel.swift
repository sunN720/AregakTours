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
  var priceUpdate: Observable<String?> { get }
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
  
  private let priceUpdateInput = BehaviorSubject<String?>(value: nil)
  var priceUpdate: Observable<String?> {
    return priceUpdateInput.asObservable()
  }
  
  let id: Int
  let name: String
  let description: String?
  let priceVM: PricesViewModel

  private let disposeBag = DisposeBag()
  
  init(tourViewModel: TourViewModel) {
    self.id = tourViewModel.id
    self.name = tourViewModel.name.uppercased()
    self.description = tourViewModel.description
    self.priceVM = PricesViewModel(transport: tourViewModel.transport,
                                   guide: tourViewModel.guide,
                                   meal: tourViewModel.meal)
    bindPriceVM()
  }
  
  private var tourTotoal: Double = 0
  func calculateTotalPrice(_ price: Price) {
    switch price.state {
    case .selected:
      tourTotoal += price.value
    case .notSelected:
      tourTotoal -= price.value
    }
    
    if tourTotoal > 0 {
      priceUpdateInput.onNext("\(tourTotoal)")
    } else {
      priceUpdateInput.onNext(nil)
    }
  }
  
  func bindPriceVM() {
    priceVM.priceValueUpdated
      .subscribe( onNext: { price in
        self.calculateTotalPrice(price)
      })
      .disposed(by: disposeBag)
  }
  
}

extension TourCellViewModel: Equatable {
  static func == (l: TourCellViewModel, r: TourCellViewModel) -> Bool {
    return l.id == r.id
  }
}
