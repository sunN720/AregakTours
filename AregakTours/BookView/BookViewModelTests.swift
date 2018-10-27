import XCTest
import RxSwift
@testable import AregakTours

class BookViewModelTests: XCTestCase {
  let disposeBag = DisposeBag()
  var sut: BookViewModel!
  let mockedTour = Tour(id: 0,
                        name: "Tour",
                        transport: 1,
                        guide: 1,
                        meal: 1,
                        description: nil)
  
  override func setUp() {
    super.setUp()
    sut = BookViewModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testTotalAmount() {
    var value = ""
    let expectation = self.expectation(description: "wait")
    sut.udpateView(with: 3)
    sut.totalAmount
      .subscribe(onNext: {
        value = $0
        expectation.fulfill()
      })
      .disposed(by: disposeBag)
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(value, "TOTAL: 3.0")
  }
  
}
