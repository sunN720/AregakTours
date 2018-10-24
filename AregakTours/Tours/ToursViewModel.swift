protocol ToursViewModeling {
	func startLoading()
	func finishLoading()
	func setTours(_ tours: [TourViewModel])
	func updateViewFor(emptyState: Bool)
	func displayBookView(_ viewModel: BookViewModel)
	func hideBookView()
}


