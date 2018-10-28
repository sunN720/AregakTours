import XCTest
@testable import AregakTours

class PricesViewModelTests: XCTestCase {
  
  let transport = Price(value: 10, state: Price.State.notSelected)
  let guide = Price(value: 20, state: Price.State.notSelected)
  let meal = Price(value: 30, state: Price.State.notSelected)
  var sut: PricesViewModel!
  
  override func setUp() {
    super.setUp()
    sut = PricesViewModel(transport: transport, guide: guide, meal: meal)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_clickedButton_transportState() {
    sut.clickedButton(at: 0)
    XCTAssertEqual(sut.transport.state, .selected)
    XCTAssertEqual(sut.transport.value, 10)
    
    sut.clickedButton(at: 0)
    XCTAssertEqual(sut.transport.state, .notSelected)
    XCTAssertEqual(sut.transport.value, 10)
  }
  
  func test_clickedButton_guideState() {
    sut.clickedButton(at: 1)
    XCTAssertEqual(sut.guide.state, .selected)
    XCTAssertEqual(sut.guide.value, 20)
    
    sut.clickedButton(at: 1)
    XCTAssertEqual(sut.guide.state, .notSelected)
    XCTAssertEqual(sut.guide.value, 20)
  }
  
  func test_clickedButton_mealState() {
    sut.clickedButton(at: 2)
    XCTAssertEqual(sut.meal.state, .selected)
    XCTAssertEqual(sut.meal.value, 30)
    
    sut.clickedButton(at: 2)
    XCTAssertEqual(sut.meal.state, .notSelected)
    XCTAssertEqual(sut.meal.value, 30)
  }
  
}
