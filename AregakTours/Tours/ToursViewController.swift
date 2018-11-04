import UIKit
import RxSwift

final class ToursViewController: UIViewController {
  
  @IBOutlet weak var emptyView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var totalView: BookView!
  
  @IBOutlet weak var totalViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var totalViewHeightConstraint: NSLayoutConstraint!
  
  let bookViewAnimationDuration = 0.5
  
  // TODO inject viewModel
  let vm: ToursViewModeling = ToursViewModel(toursProvider: ToursInteractor(service: NetworkService()))
  let disposeBag = DisposeBag()
  private(set) var toursToDisplay = [TourCellViewModel]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView?.register(UINib(nibName: "TourCell", bundle: nil), forCellReuseIdentifier: "TourCell")
    bindViewModel()
    vm.inputs.notifyViewDidLoad()
  }
  
  func bindViewModel() {
    vm.outputs.tours
      .observeOn(MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] tours in
          //TODO hanle empty state
          self?.toursToDisplay = tours
          self?.tableView?.reloadData()
        },
        onError: { error in
          //TODO hanle error state
          print(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
    
    vm.outputs.displayBookView
      .observeOn(MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] bookVM in
          guard let vm = bookVM else {
            self?.hideTotalViewWithAnimation(true)
            return
          }
          self?.showTotalView(vm, animation: true)
        }
      )
      .disposed(by: disposeBag)
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
        }
      )
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell", for: indexPath) as! TourCell
    let cellViewModel = toursToDisplay[indexPath.row]
    cell.setupCell(viewModel: cellViewModel)
    return cell
  }
}

extension ToursViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

