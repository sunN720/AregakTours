
struct TourViewModel {
  
  let id: Int
  let name: String
  let transport: Price
  let guide: Price
  let meal: Price
  let description: String?
  let date: String
  
  init(tour: Tour) {
    self.id = tour.id
    self.name = tour.name.uppercased() + tour.transport
    self.transport = Price(value: Double(tour.transport)!, state: Price.State.notSelected)
    self.guide = Price(value: Double(tour.guide)!, state: Price.State.notSelected)
    self.meal = Price(value: Double(tour.meal)!, state: Price.State.notSelected)
    self.description = tour.description
    self.date = ""
  }
  
}

struct Price {
  
  enum State {
    case selected
    case notSelected
  }
  
  let state: State
  let value: Double
  
  init(value: Double, state: State) {
    self.value = value
    self.state = state
  }
  
  static let defaultPrice = Price(value: 0.00, state: .notSelected)
  
}
