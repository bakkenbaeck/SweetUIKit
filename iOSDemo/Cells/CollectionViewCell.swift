import UIKit
import SweetUIKit

class CollectionViewCell: UICollectionViewCell, Jiggly {
    lazy var label: UILabel = {
        let view = UILabel(withAutoLayout: true)
        view.textAlignment = .center

        return view
    }()

    fileprivate var isBouncing = false

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.toggleBouncing))
        contentView.addGestureRecognizer(longPress)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("The method `init?(coder)` is not implemented for this class.")
    }

    @objc func toggleBouncing() {
        if isBouncing {
            isBouncing = false
            stopBouncing()
        } else {
            isBouncing = true
            startBouncing()
        }
    }
}
