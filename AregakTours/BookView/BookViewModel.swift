import RxSwift

protocol BookViewModelOutputs {
	var totalAmount: Observable<String> { get }
}

protocol BookViewModelInputs {
	func selectedTours(_ tours: [TourCellViewModel])
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

	func selectedTours(_ tours: [TourCellViewModel]) {
		let total = "Total: \(tours.reduce(0, { Int($0) + Int($1.transport)! }))"
		totalAmountInput.onNext(total)
	}
}
