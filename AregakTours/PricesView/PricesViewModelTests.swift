import XCTest
@testable import AregakTours

class PricesViewModelTests: XCTestCase {
  
  
  let mockedTour = Tour(id: 0,
                        name: "Tour",
                        transport: 1,
                        guide: 1,
                        meal: 1,
                        description: nil)
  var sut: PricesViewModel!
  
  override func setUp() {
    super.setUp()
    sut = PricesViewModel(tourVM: TourViewModel(tour: mockedTour))
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_clickedButton_transportState() {
    sut.clickedButton(at: 0)
    XCTAssertEqual(sut.transport.state, .selected)
    XCTAssertEqual(sut.transport.value, 1)
    
    sut.clickedButton(at: 0)
    XCTAssertEqual(sut.transport.state, .notSelected)
    XCTAssertEqual(sut.transport.value, 1)
  }
  
  func test_clickedButton_guideState() {
    sut.clickedButton(at: 1)
    XCTAssertEqual(sut.guide.state, .selected)
    XCTAssertEqual(sut.guide.value, 1)
    
    sut.clickedButton(at: 1)
    XCTAssertEqual(sut.guide.state, .notSelected)
    XCTAssertEqual(sut.guide.value, 1)
  }
  
  func test_clickedButton_mealState() {
    sut.clickedButton(at: 2)
    XCTAssertEqual(sut.meal.state, .selected)
    XCTAssertEqual(sut.meal.value, 1)
    
    sut.clickedButton(at: 2)
    XCTAssertEqual(sut.meal.state, .notSelected)
    XCTAssertEqual(sut.meal.value, 1)
  }
  
}
