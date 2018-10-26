import RxSwift

protocol BookViewModelOutputs {
  var totalAmount: Observable<String> { get }
}

protocol BookViewModelInputs {
  func udpateView(with value: String)
}


protocol BookViewModeling {
  var outputs: BookViewModelOutputs { get }
  var inputs: BookViewModelInputs { get }
}

struct BookViewModel: BookViewModeling, BookViewModelOutputs, BookViewModelInputs {
  var outputs: BookViewModelOutputs { return self }
  var inputs: BookViewModelInputs { return self }
  
  private let totalAmountInput = BehaviorSubject<String>(value:"")
  var totalAmount: Observable<String> {
    return totalAmountInput.asObservable()
  }
  
  func udpateView(with value: String) {
    totalAmountInput.onNext(value)
  }
  
}
