import RxSwift

enum State {
  case regular
  case selected
}

// SHOULD BE TourCellViewModel?

protocol TourViewModelOutputs {
  var name: String { get }
  var transport: String { get }
  var guide: String { get }
  var meal: String { get }
  var description: String? { get }
  var date: String { get }
  
  var selected: Observable<State> { get }
}

protocol TourViewModelInputs {
  func updateState(_ state: State)
}

protocol TourViewModeling {
  var inputs: TourViewModelInputs { get }
  var outputs: TourViewModelOutputs { get }
}


struct TourViewModel: TourViewModeling, TourViewModelInputs, TourViewModelOutputs {
  
  var inputs: TourViewModelInputs { return self }
  var outputs: TourViewModelOutputs { return self }
  
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

extension TourViewModel: Equatable {
  static func == (l: TourViewModel, r: TourViewModel) -> Bool {
    return l.id == r.id
  }
}
