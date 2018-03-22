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
        
        toursPresenter.attachView(self)
        toursPresenter.fetchTours()
    }
    
}

extension ToursViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toursToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TourCell")
        let tourViewData = toursToDisplay[indexPath.row]
        cell.textLabel?.text = tourViewData.name
        cell.detailTextLabel?.text = tourViewData.description
        return cell
    }
}

extension ToursViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

