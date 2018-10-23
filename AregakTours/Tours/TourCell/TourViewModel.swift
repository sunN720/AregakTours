import RxSwift

enum State {
  case regular
  case selected
}

protocol TourViewModeling {
  var selected: Observable<State> { get }
  func updateState(_ state: State)
}


struct TourViewModel: TourViewModeling {
  
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
