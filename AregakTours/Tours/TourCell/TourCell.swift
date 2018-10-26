import UIKit
import RxSwift

class TourCell: UITableViewCell {
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var carButton: UIButton!
  @IBOutlet weak var guideButton: UIButton!
  @IBOutlet weak var mealButton: UIButton!
  @IBOutlet weak var dateField: UITextField!
  
  let disposeBag = DisposeBag()
  
  fileprivate lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    return datePicker
  }()
  
  private var vm: TourCellViewModeling?
  
  // MARK: -  public methods
  func setupCell(viewModel: TourCellViewModeling) {
    vm = viewModel
    titleLable.text = viewModel.outputs.name
    descriptionLabel.text = viewModel.outputs.description
    carButton.setTitle("transport \(viewModel.outputs.transport.value)", for: .normal)
    guideButton.setTitle("guide \(viewModel.outputs.guide.value)", for: .normal)
    mealButton.setTitle("meal \(viewModel.outputs.meal.value)", for: .normal)
    dateField.text = "Select the date"
    
    viewModel.outputs.selected
      .subscribe( onNext: { [weak self] selected in
        DispatchQueue.main.async {
          self?.updateView(state: selected)
        }
      })
      .disposed(by: disposeBag)
  }
  
  func updateView(state: State) {
    switch state {
    case .regular:
      containerView.backgroundColor = .green
    case .selected:
      containerView.backgroundColor = .red
    }
  }

}

// MARK: -  private methods
fileprivate extension TourCell {
  
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
  
}

// MARK: -  IBActions
fileprivate extension TourCell {
  
  @IBAction func carTapped(_ sender: Any) {
    vm?.inputs.transportClicked()
  }
  
  @IBAction func guideTapped(_ sender: Any) {
    
  }
  
  @IBAction func mealTapped(_ sender: Any) {
    
  }
  
  @IBAction func dateTapped(_ sender: Any) {
    openDatePicker()
  }
}