import RxSwift

protocol PricesViewModelInputs {
  func clickedButton(at index: Int)
}

protocol PricesViewModelOutputs {
  var transport: Price { get }
  var guide: Price { get }
  var meal: Price { get }
  var tourPriceUpdated: Observable<TourViewModel?> { get }
}

protocol PricesViewModeling {
  var inputs: PricesViewModelInputs { get }
  var outputs: PricesViewModelOutputs { get }
}


class PricesViewModel: PricesViewModeling, PricesViewModelInputs, PricesViewModelOutputs  {
  var inputs: PricesViewModelInputs { return self }
  var outputs: PricesViewModelOutputs { return self }
  
  var transport: Price {
    return vm.transport
  }
  var guide: Price {
    return vm.guide
  }
  var meal: Price {
    return vm.meal
  }
  
  private let tourPriceUpdatedInput = BehaviorSubject<TourViewModel?>(value: nil)
  var tourPriceUpdated: Observable<TourViewModel?> {
    return tourPriceUpdatedInput.asObservable()
  }
  
  private(set) var vm: TourViewModel
  
  init(tourVM: TourViewModel) {
    self.vm = tourVM
  }
  
  func clickedButton(at index: Int) {
    switch index {
    case 0:
      vm.transport.state = (vm.transport.state == .selected) ? .notSelected : .selected
    case 1:
      vm.guide.state = (vm.guide.state == .selected) ? .notSelected : .selected
    case 2:
      vm.meal.state = (vm.meal.state == .selected) ? .notSelected : .selected
    case 4:
      print("Date clicked")
    default:
      break
    }
    tourPriceUpdatedInput.onNext(vm)
  }
}
