import UIKit

class ViewController: SweetCollectionViewController {
    lazy var data: [String] = {
        return ["123", "321", "lol"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .magentaColor()

        self.collectionView.register(CollectionViewCell)
        self.collectionView.backgroundColor = .lightGrayColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.backgroundColor = .whiteColor()
        cell.label.text = self.data[indexPath.row]

        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewController = TableViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
