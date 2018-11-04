import RxSwift

protocol TourCellViewModelOutputs {
  var name: String { get }
  var description: String? { get }
  var priceVM: PricesViewModel { get }
  var priceUpdate: Observable<TourViewModel?> { get }
}

protocol TourCellViewModeling {
  var outputs: TourCellViewModelOutputs { get }
}


struct TourCellViewModel: TourCellViewModeling, TourCellViewModelOutputs {

  var outputs: TourCellViewModelOutputs { return self }
  
  private let priceUpdateInput = BehaviorSubject<TourViewModel?>(value: nil)
  var priceUpdate: Observable<TourViewModel?> {
    return priceUpdateInput.asObservable()
  }
  
  let id: Int
  let name: String
  let description: String?
  let priceVM: PricesViewModel

  private let disposeBag = DisposeBag()
  
  init(tourVM: TourViewModel) {
    self.id = tourVM.id
    self.name = tourVM.name.uppercased()
    self.description = tourVM.description
    self.priceVM = PricesViewModel(tourVM: tourVM)
    bindPriceVM()
  }
  
  func bindPriceVM() {
    priceVM.tourPriceUpdated
      .subscribe(onNext: { tourVM in
        self.priceUpdateInput.onNext(tourVM)
      })
      .disposed(by: disposeBag)
  }
  
}
