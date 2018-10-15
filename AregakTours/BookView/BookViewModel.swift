protocol BookViewModelOutputs {
	var totalAmount: String { get }
}


protocol BookViewModeling {
	var outputs: BookViewModelOutputs { get }
}

struct BookViewModel: BookViewModeling, BookViewModelOutputs {
	var outputs: BookViewModelOutputs { return self }
	var totalAmount: String {
		return "5000"
	}
}
