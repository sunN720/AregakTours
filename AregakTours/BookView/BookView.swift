import RxSwift
import UIKit

class BookView: UIView {
  
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var bookButton: UIButton!
  
  
  private let disposeBag = DisposeBag()
  private(set) var vm: BookViewModeling?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func setup(with viewModel: BookViewModeling) {
    vm = viewModel
    viewModel.outputs.totalAmount
      .subscribe(
        onNext: {[weak self] total in
          self?.totalLabel.text = total
        }
      ).disposed(by: disposeBag)
  }
  
  @IBAction func bookClicked() {
    vm?.inputs.handleBookClick()
  }
  
}
