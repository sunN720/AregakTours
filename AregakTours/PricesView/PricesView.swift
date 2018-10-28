import UIKit
import RxCocoa
import RxSwift

class PricesView: UIView {
  
  @IBOutlet var priceButtons: [UIButton]!
  private(set) var vm: PricesViewModeling = PricesViewModel(transport: .defaultPrice,
                                                            guide: .defaultPrice,
                                                            meal: .defaultPrice)
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
    priceButtons[0].setTitle("\(vm.outputs.transport.value)", for: .normal)
    priceButtons[1].setTitle("\(vm.outputs.guide.value)", for: .normal)
    priceButtons[2].setTitle("\(vm.outputs.meal.value)", for: .normal)
  }
  
  @IBAction func buttonCLicked(_ sender: UIButton) {
    vm.inputs.clickedButton(at: sender.tag)
  }
  
}
