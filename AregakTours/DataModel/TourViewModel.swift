
//TODO add tests for this mapping
struct TourViewModel {
  
  let id: Int
  let name: String
  var transport: Price
  var guide: Price
  var meal: Price
  let description: String?
  let date: String
  
  init(tour: Tour) {
    self.id = tour.id
    self.name = tour.name.uppercased()
    self.transport = Price(value: tour.transport, state: Price.State.notSelected)
    self.guide = Price(value: tour.guide, state: Price.State.notSelected)
    self.meal = Price(value: tour.meal, state: Price.State.notSelected)
    self.description = tour.description
    self.date = ""
  }

  var tourTotalPrice: Double {
    let prices = [transport, guide, meal]
    return prices.filter{ $0.state != Price.State.notSelected }.reduce(0) { $0 + $1.value }
  }
  
}

extension TourViewModel: Equatable {
  static func == (lhd: TourViewModel, rhd: TourViewModel) -> Bool {
    return lhd.id == rhd.id
  }
}

struct Price {
  
  enum State {
    case selected
    case notSelected
  }
  
  var state: State
  let value: Double
  
  init(value: Double, state: State) {
    self.value = value
    self.state = state
  }
  
  static let defaultPrice = Price(value: 0.00, state: .notSelected)
  
}
