import UIKit

class CollectionController: SweetCollectionController {
    let data = ["123", "321", "lol"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(CollectionViewCell.self)
        self.collectionView.backgroundColor = .lightGray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension CollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .white
        cell.label.text = self.data[indexPath.row]

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
}

extension CollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = TableController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
