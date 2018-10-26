import RxSwift

protocol PricesViewModelInputs {
  func clickedButton(at index: Int)
}

protocol PricesViewModelOutputs {
  var transport: Price { get }
  var guide: Price { get }
  var meal: Price { get }
  
  var priceValueUpdated: Observable<Price> { get }
  
}

protocol PricesViewModeling {
  var inputs: PricesViewModelInputs { get }
  var outputs: PricesViewModelOutputs { get }
}


class PricesViewModel: PricesViewModeling, PricesViewModelInputs, PricesViewModelOutputs  {
  var inputs: PricesViewModelInputs { return self }
  var outputs: PricesViewModelOutputs { return self }
  
  private(set) var transport: Price
  private(set) var guide: Price
  private(set) var meal: Price
  
  private let priceValueUpdatedInput = BehaviorSubject<Price>(value: .defaultPrice)
  var priceValueUpdated: Observable<Price> {
    return priceValueUpdatedInput.asObservable()
  }
  
  
  init(transport: Price,
       guide: Price,
       meal: Price) {
    self.transport = transport
    self.guide = guide
    self.meal = meal
  }
  
  func clickedButton(at index: Int) {
    switch index {
    case 0:
      transportClicked()
    case 1:
      guideClicked()
    case 2:
      mealClicked()
    case 4:
      print("Date clicked")
    default:
      break
    }
  }
  
  func transportClicked() {
    switch transport.state { // TODO make state with Result e.g. Price(value: , state: !transport.state
    case .selected:
      transport = Price(value: transport.value, state: Price.State.notSelected)
    case .notSelected:
      transport = Price(value: transport.value, state: Price.State.selected)
    }
    
    priceValueUpdatedInput.onNext(transport)
  }
  
  func guideClicked() {
    switch guide.state { // TODO make state with Result e.g. Price(value: , state: !transport.state
    case .selected:
      guide = Price(value: guide.value, state: Price.State.notSelected)
    case .notSelected:
      guide = Price(value: guide.value, state: Price.State.selected)
    }
    
    priceValueUpdatedInput.onNext(guide)
  }
  
  func mealClicked() {
    switch meal.state { // TODO make state with Result e.g. Price(value: , state: !transport.state
    case .selected:
      meal = Price(value: meal.value, state: Price.State.notSelected)
    case .notSelected:
      meal = Price(value: meal.value, state: Price.State.selected)
    }
    
    priceValueUpdatedInput.onNext(meal)
  }
  
}
