import UIKit
import RxSwift

class TourCell: UITableViewCell {
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

// MARK: -  private methods
/*fileprivate extension TourCell {
 
 fileprivate lazy var datePicker: UIDatePicker = {
 let datePicker = UIDatePicker()
 datePicker.datePickerMode = .date
 return datePicker
 }()
  
  func openDatePicker() {
    
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
  
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
    toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
    
    dateField.inputAccessoryView = toolbar
    dateField.inputView = datePicker
  }
  
  @objc func doneAction() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    let stringFromDate = dateFormatter.string(from: datePicker.date)
    dateField.text = stringFromDate
    self.endEditing(true)
  }
  
  @objc func cancelAction() {
    self.endEditing(true)
  }
  
}*/
