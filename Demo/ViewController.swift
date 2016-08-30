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

class ViewController: SweetCollectionViewController {

    lazy var data: [String] = {
        return ["123", "321", "lol"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .magentaColor()

        self.collectionView.register(CollectionCell.self)
        self.collectionView.backgroundColor = .lightGrayColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCell.reuseIdentifier, forIndexPath: indexPath) as! CollectionCell
        cell.backgroundColor = .whiteColor()
        cell.label.text = self.data[indexPath.row]
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}

extension ViewController: UICollectionViewDelegate {

}