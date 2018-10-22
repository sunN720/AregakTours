import Foundation

class TourViewModel {
  
  enum State {
    case regular
    case selected
  }
  
  var id: Int
  var name: String
  var transport: String
  var guide: String
  var meal: String
  var description: String?
  var date: String
  
  var state: State = .regular
  
  init(tour: Tour) {
    self.id = tour.id
    self.name = tour.name.uppercased() + "\t\t\t\t" + tour.transport
    self.transport = tour.transport
    self.guide = tour.guide
    self.meal = tour.meal
    self.description = tour.description
    self.date = ""
  }
  
  func updateState(state: State) {
    self.state = state
  }
  
}

extension TourViewModel: Equatable {
  static func == (l: TourViewModel, r: TourViewModel) -> Bool {
    return true
  }
}
