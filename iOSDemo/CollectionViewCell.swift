import UIKit
import SweetUIKit

class CollectionViewCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let view = UILabel(withAutoLayout: true)
        view.textAlignment = .center

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.contentView.addSubview(self.label)
        self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("The method `init?(coder)` is not implemented for this class.")
    }
}
