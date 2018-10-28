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
  var priceUpdate: Observable<Price> { get }
}

protocol TourCellViewModeling {
  var outputs: TourCellViewModelOutputs { get }
}


class TourCellViewModel: TourCellViewModeling, TourCellViewModelOutputs {

  var outputs: TourCellViewModelOutputs { return self }
  
  private let selectedInput = BehaviorSubject<State>(value: .regular)
  var selected: Observable<State> {
    return selectedInput.asObservable()
  }
  
  private let priceUpdateInput = BehaviorSubject<Price>(value: .defaultPrice)
  var priceUpdate: Observable<Price> {
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
  
  func bindPriceVM() {
    priceVM.priceValueUpdated
      .subscribe( onNext: { [weak self] price in
        self?.priceUpdateInput.onNext(price)
      })
      .disposed(by: disposeBag)
  }
  
}
