import RxSwift
import UIKit

class BookView: UIView {

	@IBOutlet weak var totalLabel: UILabel!

	private let disposeBag = DisposeBag()

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}

	func setup(with viewModel: BookViewModeling) {
		viewModel.outputs.totalAmount
			.subscribe(
				onNext: {[weak self] total in
					self?.totalLabel.text = total
				}
			).disposed(by: disposeBag)
	}
	
}
