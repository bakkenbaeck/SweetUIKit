import UIKit

public class SweetCollectionViewController: UIViewController {
    let collectionView: UICollectionView

    public var data: [AnyObject] = [AnyObject]()

    public init(withCollectionViewLayout collectionViewLayout: UICollectionViewLayout? = nil) {
        let layout = collectionViewLayout ?? UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = view

        super.init(nibName: nil, bundle: nil)

        self.collectionView.dataSource = self
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Interface Builder support not implemented")
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

extension SweetCollectionViewController: UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}