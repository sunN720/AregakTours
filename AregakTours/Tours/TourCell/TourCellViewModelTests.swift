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
    
    sut = TourCellViewModel(tourViewModel: tourVM)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
}
