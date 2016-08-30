import UIKit

class CollectionCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let view = UILabel(withAutoLayout: true)
        view.textAlignment = .Center

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(self.label)
        self.label.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor).active = true
        self.label.leftAnchor.constraintEqualToAnchor(self.contentView.leftAnchor).active = true
        self.label.rightAnchor.constraintEqualToAnchor(self.contentView.rightAnchor).active = true
        self.label.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("The method `init?(coder)` is not implemented for this class.")
    }
}
