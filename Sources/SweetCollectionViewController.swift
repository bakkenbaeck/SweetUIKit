import UIKit

public class SweetCollectionViewController: UIViewController {
    public lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false

        view.delegate = self
        view.dataSource = self

        self.view.addSubview(view)

        return view
    }()

    public var data: [AnyObject] = [AnyObject]()

    public convenience init(withCollectionViewLayout collectionViewLayout: UICollectionViewLayout) {
        self.init()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.view.addSubview(self.collectionView)
    }

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("!")
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
