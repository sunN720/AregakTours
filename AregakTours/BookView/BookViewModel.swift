import RxSwift

protocol BookViewModelOutputs {
  var totalAmount: Observable<String> { get }
  var bookClicked: Observable<Bool> { get }
}

protocol BookViewModelInputs {
  func udpateView(with value: Double)
  func handleBookClick()
}


protocol BookViewModeling {
  var outputs: BookViewModelOutputs { get }
  var inputs: BookViewModelInputs { get }
}

struct BookViewModel: BookViewModeling, BookViewModelOutputs, BookViewModelInputs {
  var outputs: BookViewModelOutputs { return self }
  var inputs: BookViewModelInputs { return self }
  
  private let totalAmountInput = BehaviorSubject<String>(value: "")
  var totalAmount: Observable<String> {
    return totalAmountInput.asObservable()
  }
  
  private let bookClickedInput = BehaviorSubject<Bool>(value: false)
  var bookClicked: Observable<Bool> {
    return bookClickedInput
  }
  
  func udpateView(with value: Double) {
    totalAmountInput.onNext("TOTAL: \(value)")
  }
  
  func handleBookClick() {
    bookClickedInput.onNext(true)
  }
  
}
