import RxSwift

enum State {
  case regular
  case selected
}

// SHOULD BE TourCellViewModel?

protocol TourCellViewModelOutputs {
  var name: String { get }
  var transport: String { get }
  var guide: String { get }
  var meal: String { get }
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
  let transport: String
  let guide: String
  let meal: String
  let description: String?
  let date: String
  
  init(tour: Tour) {
    self.id = tour.id
    self.name = tour.name.uppercased() + tour.transport
    self.transport = tour.transport
    self.guide = tour.guide
    self.meal = tour.meal
    self.description = tour.description
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
