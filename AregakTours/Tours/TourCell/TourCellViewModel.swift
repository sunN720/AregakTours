import RxSwift

enum State {
  case regular
  case selected
}

// SHOULD BE TourCellViewModel?

protocol TourCellViewModelOutputs {
  var name: String { get }
  var transport: Price { get }
  var guide: Price { get }
  var meal: Price { get }
  var description: String? { get }
  var date: String { get }
  
  var selected: Observable<State> { get }
}

protocol TourCellViewModelInputs {
  func updateState(_ state: State)
}

protocol TourCellViewModeling {
  var inputs: TourCellViewModelInputs { get }
  var outputs: TourCellViewModelOutputs { get }
}


struct TourCellViewModel: TourCellViewModeling, TourCellViewModelInputs, TourCellViewModelOutputs {
  
  var inputs: TourCellViewModelInputs { return self }
  var outputs: TourCellViewModelOutputs { return self }
  
  private let selectedInput = BehaviorSubject<State>(value: .regular)
  var selected: Observable<State> {
    return selectedInput.asObservable()
  }
  
  let id: Int
  let name: String
  let transport: Price
  let guide: Price
  let meal: Price
  let description: String?
  let date: String
  
  init(tourViewModel: TourViewModel) {
    self.id = tourViewModel.id
    self.name = tourViewModel.name.uppercased()
    self.transport = tourViewModel.transport
    self.guide = tourViewModel.guide
    self.meal = tourViewModel.meal
    self.description = tourViewModel.description
    self.date = ""
  }
  
  func updateState(_ state: State) {
    selectedInput.onNext(state)
  }
  
  
  
}

extension TourCellViewModel: Equatable {
  static func == (l: TourCellViewModel, r: TourCellViewModel) -> Bool {
    return l.id == r.id
  }
}
