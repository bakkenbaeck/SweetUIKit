import UIKit

class TableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel(withAutoLayout: true)

        self.contentView.addSubview(view)
        view.fillSuperview()

        return view
    }()
}
