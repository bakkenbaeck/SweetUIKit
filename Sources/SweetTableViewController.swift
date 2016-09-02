#if os(iOS) || os(tvOS)
import UIKit

public class SweetTableController: UIViewController {
    public var tableView: UITableView

    public init(with tableViewStyle: UITableViewStyle = .Plain) {
        let view = UITableView(frame: .zero, style: tableViewStyle)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.tableView = view

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("The method `init?(coder)` is not implemented for this class.")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)

        self.addConstraints()
    }

    func addConstraints() {
        let anchors = [self.tableView.topAnchor.constraintEqualToAnchor(self.view.topAnchor), self.tableView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor), self.tableView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor), self.tableView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor)]
        for anchor in anchors {
            anchor.priority = UILayoutPriorityDefaultLow
            anchor.active = true
        }
    }
}
#endif
