import UIKit

class TourTableViewCell: UITableViewCell {
  
  enum State {
    case regular
    case selected
  }
  
  @IBOutlet weak var titleLable: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var carButton: UIButton!
  @IBOutlet weak var guideButton: UIButton!
  @IBOutlet weak var mealButton: UIButton!
  @IBOutlet weak var dateField: UITextField!
  
  var state: State = .regular
  
  fileprivate lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    return datePicker
  }()
  
  var cellSelected: Bool {
    if case .selected = state {
      return true
    } else {
      return false
    }
  }
  
  // MARK: -  public methods
  func setupCell(viewModel: TourViewModel) {
    titleLable.text = viewModel.name
    descriptionLabel.text = viewModel.description
    carButton.setTitle("transport " + viewModel.transport, for: .normal)
    guideButton.setTitle("guide " + viewModel.guide, for: .normal)
    mealButton.setTitle("meal " + viewModel.meal, for: .normal)
    dateField.text = "Select the date"
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
  
    if selected == true {
      guard cellSelected == false else {
        containerView.backgroundColor = .green
        state = .regular
        return
      }
      containerView.backgroundColor = .red
      state = .selected
    }
  }

}

// MARK: -  private methods
fileprivate extension TourTableViewCell {
  
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
fileprivate extension TourTableViewCell {
  
  @IBAction func carTapped(_ sender: Any) {
    
  }
  
  @IBAction func guideTapped(_ sender: Any) {
    
  }
  
  @IBAction func mealTapped(_ sender: Any) {
    
  }
  
  @IBAction func dateTapped(_ sender: Any) {
    openDatePicker()
  }
}
