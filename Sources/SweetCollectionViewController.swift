import UIKit

public class SweetCollectionViewController: UIViewController {
    public var collectionView: UICollectionView

    public init(withCollectionViewLayout collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = view

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("The method `init?(coder)` is not implemented for this class.")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        
        self.addConstraints()
    }

    func addConstraints() {
        let anchors = [self.collectionView.topAnchor.constraintEqualToAnchor(self.view.topAnchor), self.collectionView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor), self.collectionView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor), self.collectionView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor)]
        for anchor in anchors {
            anchor.priority = UILayoutPriorityDefaultLow
            anchor.active = true
        }
    }
}
