import UIKit
import RxSwift

final class TourCell: UITableViewCell {
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var pricesView: PricesView!
  
  func setupCell(viewModel: TourCellViewModeling) {
    titleLable.text = viewModel.outputs.name
    descriptionLabel.text = viewModel.outputs.description
    pricesView.setup(viewModel: viewModel.outputs.priceVM)
  }
}
