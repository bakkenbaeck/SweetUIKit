import UIKit
import SweetUIKit

class CollectionController: SweetCollectionController {
    let data = ["123", "321", "lol"]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CollectionViewCell.self)
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }

    @objc func share() {
        let url = URL(string: "https://google.com")!
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: [OpenInSafariActivity()])
        present(activityController, animated: true)
    }
}

extension CollectionController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .white
        cell.label.text = data[indexPath.row]

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension CollectionController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = indexPath.row % 2 == 0 ? TableController() : EditViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
