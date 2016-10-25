import UIKit
import SweetUIKit

class TableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let view = UILabel(withAutoLayout: true)

        self.contentView.addSubview(view)
        let insets = UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20)
        view.fillSuperview(with: insets)

        return view
    }()
}
