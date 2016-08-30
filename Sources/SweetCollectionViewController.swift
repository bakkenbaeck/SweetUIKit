import UIKit

public class SweetCollectionViewController: UIViewController {
    public lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public convenience init(withCollectionViewLayout collectionViewLayout: UICollectionViewLayout) {
        self.init()
        /*
         If we want to have a collection view with a specific layout, we have to overrided the lazy-loaded one.
         Because of that, we have to reconfigure it to use auto-layout.
         This extra "complication" is probably the main reason the UICollectionViewController has an optional collection view.
         I prefer the approach of having a default collection view that covers most cases and an option to 
         configure it further.
         */
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    public init() {
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
