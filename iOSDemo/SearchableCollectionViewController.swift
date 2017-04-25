import Foundation
import UIKit
import SweetUIKit

class SearchableCollectionViewController: SearchableCollectionController {

    static let cellIdentifier = String(describing: UICollectionViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UICollectionViewCell.self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.navigationBar.barTintColor = nil
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

extension SearchableCollectionViewController {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemsNumber = 0

        switch section {
        case 0:
            itemsNumber = 5
        case 1:
            itemsNumber = 10
        default:
            break
        }

        return itemsNumber
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchableCollectionViewController.cellIdentifier, for: indexPath)

        switch indexPath.section {
        case 0:
            cell.backgroundColor = .yellow
        case 1:
            cell.backgroundColor = .purple
        default:
            break
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2 - 25

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

