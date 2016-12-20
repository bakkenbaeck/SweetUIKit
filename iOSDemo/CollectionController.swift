import UIKit
import SweetUIKit

class CollectionController: SweetCollectionController {
    let data = ["123", "321", "lol"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(CollectionViewCell.self)
        self.collectionView.backgroundColor = .lightGray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }

    func share() {
        let url = URL(string: "https://google.com")!
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: [OpenInSafariActivity()])
        self.present(activityController, animated: true)
    }
}

extension CollectionController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CollectionViewCell.self, for: indexPath)
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
        let viewController = indexPath.row % 2 == 0 ? TableController() : EditViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
