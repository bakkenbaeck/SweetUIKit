import UIKit

public class SweetCollectionViewController: UIViewController {
    public lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false

        view.delegate = self
        view.dataSource = self

        return view
    }()

    public var data: [AnyObject] = [AnyObject]()

    public convenience init(withCollectionViewLayout collectionViewLayout: UICollectionViewLayout) {
        self.init()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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

extension SweetCollectionViewController: UICollectionViewDelegate {

}

extension SweetCollectionViewController: UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
