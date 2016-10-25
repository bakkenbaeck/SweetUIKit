import UIKit

class TableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel(withAutoLayout: true)

        self.contentView.addSubview(view)
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.fillSuperview(insets)

        return view
    }()
}
