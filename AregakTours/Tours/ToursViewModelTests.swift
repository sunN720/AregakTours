import XCTest
@testable import AregakTours

class ToursViewModelTests: XCTestCase {
  
  let mockedTour1 = Tour(id: 0,
                        name: "Tour1",
                        transport: 1,
                        guide: 1,
                        meal: 1,
                        description: nil)
  
  let mockedTour2 = Tour(id: 1,
                        name: "Tour2",
                        transport: 1,
                        guide: 1,
                        meal: 1,
                        description: nil)
  var tourVM1: TourViewModel!
  var tourVM2: TourViewModel!
  var sut: ToursViewModel!
  
  override func setUp() {
    super.setUp()
    tourVM1 = TourViewModel(tour: mockedTour1)
    tourVM2 = TourViewModel(tour: mockedTour2)
    sut = ToursViewModel(toursProvider: ToursInteractor(service: NetworkService())) // TODO mocke ToursInteractor and NetworkService and use in tests
  }
  
  override func tearDown() {
    sut = nil
    tourVM1 = nil
    tourVM2 = nil
    super.tearDown()
  }
  
 /* func test_totalPrice_forSingleTour() {
    
    var transport = Price(value: tourVM1.transport.value, state: .selected)
    sut.calculateTotalPrice()
    XCTAssertEqual(sut.toursTotoal, 1)
    
    var meal = Price(value: tourVM1.meal.value, state: .selected)
    sut.calculateTotalPrice(meal)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    var guide = Price(value: tourVM1.guide.value, state: .selected)
    sut.calculateTotalPrice(guide)
    XCTAssertEqual(sut.toursTotoal, 3)
    
    transport = Price(value: tourVM1.transport.value, state: .notSelected)
    sut.calculateTotalPrice(transport)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    guide = Price(value: tourVM1.guide.value, state: .notSelected)
    sut.calculateTotalPrice(guide)
    XCTAssertEqual(sut.toursTotoal, 1)
    
    meal = Price(value: tourVM1.meal.value, state: .notSelected)
    sut.calculateTotalPrice(meal)
    XCTAssertEqual(sut.toursTotoal, 0)
  }
  
  func test_totalPrice_forMultipleTours_transportPrice() {
    var transport1 = Price(value: tourVM1.transport.value, state: .selected)
    sut.calculateTotalPrice(transport1)
    
    var transport2 = Price(value: tourVM2.transport.value, state: .selected)
    sut.calculateTotalPrice(transport2)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    transport1 = Price(value: tourVM1.transport.value, state: .notSelected)
    sut.calculateTotalPrice(transport1)
    XCTAssertEqual(sut.toursTotoal, 1)
    
    transport2 = Price(value: tourVM2.transport.value, state: .notSelected)
    sut.calculateTotalPrice(transport2)
    XCTAssertEqual(sut.toursTotoal, 0)
  }
  
  func test_totalPrice_forMultipleTours_guidePrice() {
    var guide1 = Price(value: tourVM1.guide.value, state: .selected)
    sut.calculateTotalPrice(guide1)
    
    var guide2 = Price(value: tourVM2.guide.value, state: .selected)
    sut.calculateTotalPrice(guide2)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    guide1 = Price(value: tourVM1.guide.value, state: .notSelected)
    sut.calculateTotalPrice(guide1)
    XCTAssertEqual(sut.toursTotoal, 1)
    
    guide2 = Price(value: tourVM2.guide.value, state: .notSelected)
    sut.calculateTotalPrice(guide2)
    XCTAssertEqual(sut.toursTotoal, 0)
  }
  
  func test_totalPrice_forMultipleTours_mealPrice() {
    var meal1 = Price(value: tourVM1.meal.value, state: .selected)
    sut.calculateTotalPrice(meal1)
    
    var meal2 = Price(value: tourVM2.meal.value, state: .selected)
    sut.calculateTotalPrice(meal2)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    meal1 = Price(value: tourVM1.meal.value, state: .notSelected)
    sut.calculateTotalPrice(meal1)
    XCTAssertEqual(sut.toursTotoal, 1)
    
    meal2 = Price(value: tourVM2.meal.value, state: .notSelected)
    sut.calculateTotalPrice(meal2)
    XCTAssertEqual(sut.toursTotoal, 0)
  }
  
  func test_totalPrice_forMultipleTours_mixedPrices() {
    var transport1 = Price(value: tourVM1.transport.value, state: .selected)
    sut.calculateTotalPrice(transport1)
    
    var meal2 = Price(value: tourVM2.meal.value, state: .selected)
    sut.calculateTotalPrice(meal2)
    XCTAssertEqual(sut.toursTotoal, 2)
    
    transport1 = Price(value: tourVM1.transport.value, state: .notSelected)
    sut.calculateTotalPrice(transport1)
    XCTAssertEqual(sut.toursTotoal, 1)
    
    meal2 = Price(value: tourVM2.meal.value, state: .notSelected)
    sut.calculateTotalPrice(meal2)
    XCTAssertEqual(sut.toursTotoal, 0)
  }*/
  
}
