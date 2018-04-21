import UIKit

class ToursViewController: UIViewController {
  
  @IBOutlet weak var emptyView: UIView?
  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  
  fileprivate let toursPresenter = ToursPresenter(toursService: ToursInteractor(service: NetworkService()))
  fileprivate var toursToDisplay = [TourViewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    activityIndicator?.hidesWhenStopped = true
    tableView?.register(UINib(nibName: "TourTableViewCell", bundle: nil), forCellReuseIdentifier: "TourTableViewCell")
    tableView?.estimatedRowHeight = UITableViewAutomaticDimension
    toursPresenter.toursView = self
    toursPresenter.notifyViewDidLoad()
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
}

