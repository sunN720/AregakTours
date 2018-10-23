import UIKit

class ToursViewController: UIViewController {
  
  @IBOutlet weak var emptyView: UIView?
  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  @IBOutlet weak var totalView: BookView!
  
  @IBOutlet weak var totalViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var totalViewHeightConstraint: NSLayoutConstraint!
  
  let bookViewAnimationDuration = 0.5
  
  fileprivate let toursPresenter = ToursPresenter(toursService: ToursInteractor(service: NetworkService()))
  fileprivate var toursToDisplay = [TourViewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator?.hidesWhenStopped = true
    tableView?.register(UINib(nibName: "TourTableViewCell", bundle: nil), forCellReuseIdentifier: "TourTableViewCell")
    toursPresenter.toursView = self
    toursPresenter.notifyViewDidLoad()
    hideTotalViewWithAnimation(false)
  }
  
  fileprivate func hideTotalViewWithAnimation(_ animation: Bool) {
    if animation {
      UIView.animate(withDuration: bookViewAnimationDuration, animations: {
        self.totalViewBottomConstraint.constant = -1 * self.totalViewHeightConstraint.constant
      }, completion: { [weak self] (finished) -> () in
        self?.totalView?.alpha = 0.0
      })
    } else {
      totalView?.alpha = 0.0
    }
  }
  
  fileprivate func showTotalView(_ viewModel: BookViewModeling, animation: Bool) {
    if animation {
      UIView.animate(withDuration: bookViewAnimationDuration, animations: {
        self.totalView?.alpha = 1.0
        self.totalViewBottomConstraint?.constant = 0.0
        }, completion: { finished in
					self.totalView?.setup(with: viewModel)
			})
    } else {
      totalView?.alpha = 1.0
    }
  }
}

extension ToursViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toursToDisplay.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TourTableViewCell", for: indexPath) as! TourTableViewCell
    let tourViewModel = toursToDisplay[indexPath.row]
    cell.setupCell(viewModel: tourViewModel)
    return cell
  }
}

extension ToursViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 92.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    toursPresenter.didSelectTour(at: indexPath)
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    toursPresenter.didSelectTour(at: indexPath)
  }
}



extension ToursViewController: ToursView {
  
  func startLoading() {
    activityIndicator?.startAnimating()
  }
  
  func finishLoading() {
    activityIndicator?.stopAnimating()
  }
  
  func setTours(_ tours: [TourViewModel]) {
    toursToDisplay = tours
    tableView?.reloadData()
  }
  
  func updateViewFor(emptyState: Bool) {
    tableView?.isHidden = emptyState
    emptyView?.isHidden = !emptyState
  }
  
  func displayBookView(_ viewModel: BookViewModeling) {
    showTotalView(viewModel, animation: true)
  }
  
  func hideBookView() {
    hideTotalViewWithAnimation(true)
  }
}

