import XCTest
import RxSwift
@testable import AregakTours

class BookViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    var sut: BookViewModel!
    var mockedTours = [TourViewModel]()
    
    override func setUp() {
        super.setUp()
        sut = BookViewModel()
        createMockedTours()
        sut.selectedTours(mockedTours)
    }
    
    func createMockedTours() {
        let mockedTour1 = Tour(id: 0,
                         name: "Tour1",
                         transport: "1",
                         guide: "2",
                         meal: "3",
                         description: nil)
        let mockedTour2 = Tour(id: 1,
                         name: "Tour2",
                         transport: "1",
                         guide: "2",
                         meal: "3",
                         description: nil)
        mockedTours.append(TourViewModel(tour: mockedTour1))
        mockedTours.append(TourViewModel(tour: mockedTour2))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTotalAmount() {
        var value = ""
        let expectation = self.expectation(description: "wait")
        sut.totalAmount
            .subscribe(onNext: {
                value = $0
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(value, "Total: 2")
    }

}
