import UIKit

extension UIButton {
  override open var isSelected: Bool {
    didSet {
      self.backgroundColor = isSelected ? .red : UIColor(red: 0.28519701959999999,
                                                         green: 0.5652202368,
                                                         blue: 0.27250269059999999,
                                                         alpha: 1)
    }
  }
}
