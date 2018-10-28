import RxSwift

protocol PricesViewModelInputs {
  func clickedButton(at index: Int)
}

protocol PricesViewModelOutputs {
  var transport: Price { get }
  var guide: Price { get }
  var meal: Price { get }
  var updateButtonState: Observable<Bool> { get }
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
  
  private let updateButtonStateInput = BehaviorSubject<Bool>(value: false)
  var updateButtonState: Observable<Bool> {
    return updateButtonStateInput.asObservable()
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
      transport = Price(value: transport.value, state: Price.stateFromBool(!Price.boolFromState(transport.state)))
      priceValueUpdatedInput.onNext(transport)
      updateButtonStateInput.onNext(transport.boolFormState())
    case 1:
      guide = Price(value: guide.value, state: Price.stateFromBool(!Price.boolFromState(guide.state)))
      priceValueUpdatedInput.onNext(guide)
      updateButtonStateInput.onNext(guide.boolFormState())
    case 2:
      meal = Price(value: meal.value, state: Price.stateFromBool(!Price.boolFromState(meal.state)))
      priceValueUpdatedInput.onNext(meal)
      updateButtonStateInput.onNext(meal.boolFormState())
    case 4:
      print("Date clicked")
    default:
      break
    }
    
  }
}
