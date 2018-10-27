import XCTest
@testable import AregakTours

class TourCellViewModelTests: XCTestCase {
  
  var sut: TourCellViewModel!
  var tourTotal: Double = 0
  let mockedTour = Tour(id: 0,
                        name: "Tour",
                        transport: 1,
                        guide: 1,
                        meal: 1,
                        description: nil)
  var transport: Price!
  var guide: Price!
  var meal: Price!
  
  override func setUp() {
    super.setUp()
    
    let tourVM = TourViewModel(tour: mockedTour)
    transport = tourVM.transport
    meal = tourVM.meal
    guide = tourVM.guide
    
    sut = TourCellViewModel(tourViewModel: tourVM,
                            priceViewModel: PricesViewModel(transport: transport,
                                                            guide: guide,
                                                            meal: meal))
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testCalculateTotalPrice() {
    transport = Price(value: transport.value, state: .selected)
    sut.calculateTotalPrice(transport)
    XCTAssertEqual(sut.tourTotoal, transport.value)
    
    meal = Price(value: meal.value, state: .selected)
    sut.calculateTotalPrice(meal)
    XCTAssertEqual(sut.tourTotoal, transport.value + meal.value)
    
    guide = Price(value: guide.value, state: .selected)
    sut.calculateTotalPrice(guide)
    XCTAssertEqual(sut.tourTotoal, transport.value + guide.value + meal.value)
    
    transport = Price(value: transport.value, state: .notSelected)
    sut.calculateTotalPrice(transport)
    XCTAssertEqual(sut.tourTotoal, guide.value + meal.value)
    
    guide = Price(value: guide.value, state: .notSelected)
    sut.calculateTotalPrice(guide)
    XCTAssertEqual(sut.tourTotoal, meal.value)
    
    meal = Price(value: meal.value, state: .notSelected)
    sut.calculateTotalPrice(meal)
    XCTAssertEqual(sut.tourTotoal, 0)
  }
  
}
