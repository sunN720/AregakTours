import UIKit
import RxCocoa
import RxSwift

final class PricesView: UIView {
  
  @IBOutlet var priceButtons: [UIButton]!
  private(set) var vm: PricesViewModeling?
  let disposeBag = DisposeBag()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }
  
  func setup(viewModel: PricesViewModeling) {
    vm = viewModel
    bindViewModel()
  }
  
  private func bindViewModel() {

    priceButtons[0].setTitle("\(vm?.outputs.transport.value ?? 0.0)", for: .normal)
    priceButtons[1].setTitle("\(vm?.outputs.guide.value ?? 0.0)", for: .normal)
    priceButtons[2].setTitle("\(vm?.outputs.meal.value ?? 0.0)", for: .normal)
  }
  
  @IBAction func buttonCLicked(_ sender: UIButton) {
    let selected = priceButtons[sender.tag].isSelected
    priceButtons[sender.tag].isSelected = !selected
    vm?.inputs.clickedButton(at: sender.tag)
  }

}
